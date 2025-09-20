"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isPositionIncludedInRange = isPositionIncludedInRange;
/**
 * Determine if a position is included in a range.
 */
function isPositionIncludedInRange(position, range) {
    return (range.start.line <= position.line &&
        range.end.line >= position.line &&
        range.start.character <= position.character &&
        range.end.character >= position.character);
}
//# sourceMappingURL=lsp.js.map