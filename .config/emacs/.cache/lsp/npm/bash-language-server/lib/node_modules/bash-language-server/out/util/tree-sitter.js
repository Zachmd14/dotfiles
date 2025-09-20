"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.forEach = forEach;
exports.range = range;
exports.isDefinition = isDefinition;
exports.isReference = isReference;
exports.isVariableInReadCommand = isVariableInReadCommand;
exports.isExpansion = isExpansion;
exports.findParent = findParent;
exports.findParentOfType = findParentOfType;
exports.resolveStaticString = resolveStaticString;
const LSP = require("vscode-languageserver/node");
/**
 * Recursively iterate over all nodes in a tree.
 *
 * @param node The node to start iterating from
 * @param callback The callback to call for each node. Return false to stop following children.
 */
function forEach(node, callback) {
    const followChildren = callback(node) !== false;
    if (followChildren && node.children.length) {
        node.children.forEach((n) => forEach(n, callback));
    }
}
function range(n) {
    return LSP.Range.create(n.startPosition.row, n.startPosition.column, n.endPosition.row, n.endPosition.column);
}
function isDefinition(n) {
    switch (n.type) {
        case 'variable_assignment':
        case 'function_definition':
            return true;
        default:
            return false;
    }
}
function isReference(n) {
    switch (n.type) {
        case 'variable_name':
        case 'command_name':
            return true;
        default:
            return false;
    }
}
function isVariableInReadCommand(n) {
    var _a, _b, _c, _d;
    if (n.type === 'word' &&
        ((_a = n.parent) === null || _a === void 0 ? void 0 : _a.type) === 'command' &&
        ((_b = n.parent.firstChild) === null || _b === void 0 ? void 0 : _b.text) === 'read' &&
        !n.text.startsWith('-') &&
        !/^-.*[dinNptu]$/.test((_d = (_c = n.previousSibling) === null || _c === void 0 ? void 0 : _c.text) !== null && _d !== void 0 ? _d : '')) {
        return true;
    }
    return false;
}
function isExpansion(n) {
    switch (n.type) {
        case 'expansion':
        case 'simple_expansion':
            return true;
        default:
            return false;
    }
}
function findParent(start, predicate) {
    let node = start.parent;
    while (node !== null) {
        if (predicate(node)) {
            return node;
        }
        node = node.parent;
    }
    return null;
}
function findParentOfType(start, type) {
    if (typeof type === 'string') {
        return findParent(start, (n) => n.type === type);
    }
    return findParent(start, (n) => type.includes(n.type));
}
/**
 * Resolves the full string value of a node
 * Returns null if the value can't be statically determined (ie, it contains a variable or command substition).
 * Supports: word, string, raw_string, and concatenation
 */
function resolveStaticString(node) {
    if (node.type === 'concatenation') {
        const values = [];
        for (const child of node.namedChildren) {
            const value = resolveStaticString(child);
            if (value === null)
                return null;
            values.push(value);
        }
        return values.join('');
    }
    if (node.type === 'word')
        return node.text;
    if (node.type === 'string' || node.type === 'raw_string') {
        if (node.namedChildCount === 0)
            return node.text.slice(1, -1);
        const children = node.namedChildren;
        if (children.length === 1 && children[0].type === 'string_content')
            return children[0].text;
        return null;
    }
    return null;
}
//# sourceMappingURL=tree-sitter.js.map