"use strict";
// https://www.gnu.org/software/bash/manual/html_node/Reserved-Word-Index.html
Object.defineProperty(exports, "__esModule", { value: true });
exports.LIST = void 0;
exports.isReservedWord = isReservedWord;
exports.LIST = [
    '!',
    '[[',
    ']]',
    '{',
    '}',
    'case',
    'do',
    'done',
    'elif',
    'else',
    'esac',
    'fi',
    'for',
    'function',
    'if',
    'in',
    'select',
    'then',
    'time',
    'until',
    'while',
];
const SET = new Set(exports.LIST);
function isReservedWord(word) {
    return SET.has(word);
}
//# sourceMappingURL=reserved-words.js.map