"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.flattenArray = flattenArray;
exports.uniq = uniq;
exports.uniqueBasedOnHash = uniqueBasedOnHash;
/**
 * Flatten a 2-dimensional array into a 1-dimensional one.
 */
function flattenArray(nestedArray) {
    return nestedArray.reduce((acc, array) => [...acc, ...array], []);
}
/**
 * Remove all duplicates from the list.
 * Doesn't preserve ordering.
 */
function uniq(a) {
    return Array.from(new Set(a));
}
/**
 * Removed all duplicates from the list based on the hash function.
 * First element matching the hash function wins.
 */
function uniqueBasedOnHash(list, elementToHash, __result = []) {
    const result = [];
    const hashSet = new Set();
    list.forEach((element) => {
        const hash = elementToHash(element);
        if (hashSet.has(hash)) {
            return;
        }
        hashSet.add(hash);
        result.push(element);
    });
    return result;
}
//# sourceMappingURL=array.js.map