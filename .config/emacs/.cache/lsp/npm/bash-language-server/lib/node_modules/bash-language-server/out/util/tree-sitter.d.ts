import * as LSP from 'vscode-languageserver/node';
import { SyntaxNode } from 'web-tree-sitter';
/**
 * Recursively iterate over all nodes in a tree.
 *
 * @param node The node to start iterating from
 * @param callback The callback to call for each node. Return false to stop following children.
 */
export declare function forEach(node: SyntaxNode, callback: (n: SyntaxNode) => void | boolean): void;
export declare function range(n: SyntaxNode): LSP.Range;
export declare function isDefinition(n: SyntaxNode): boolean;
export declare function isReference(n: SyntaxNode): boolean;
export declare function isVariableInReadCommand(n: SyntaxNode): boolean;
export declare function isExpansion(n: SyntaxNode): boolean;
export declare function findParent(start: SyntaxNode, predicate: (n: SyntaxNode) => boolean): SyntaxNode | null;
export declare function findParentOfType(start: SyntaxNode, type: string | string[]): SyntaxNode | null;
/**
 * Resolves the full string value of a node
 * Returns null if the value can't be statically determined (ie, it contains a variable or command substition).
 * Supports: word, string, raw_string, and concatenation
 */
export declare function resolveStaticString(node: SyntaxNode): string | null;
