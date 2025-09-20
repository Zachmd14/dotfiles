"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getShebang = getShebang;
exports.getShellDialect = getShellDialect;
exports.getShellDialectFromShellDirective = getShellDialectFromShellDirective;
exports.analyzeShebang = analyzeShebang;
const SHEBANG_REGEXP = /^#!(.*)/;
const SHELL_REGEXP = /bin[/](?:env )?(\w+)/;
// Non exhaustive list of bash dialects that we potentially could support and try to analyze.
const BASH_DIALECTS = ['sh', 'bash', 'dash', 'ksh', 'zsh', 'csh', 'ash'];
const SHELL_DIRECTIVE_REGEXP = new RegExp(`^\\s*#\\s*shellcheck.*shell=(${BASH_DIALECTS.join('|')}).*$|^\\s*#.*$|^\\s*$`);
function getShebang(fileContent) {
    const match = SHEBANG_REGEXP.exec(fileContent);
    if (!match || !match[1]) {
        return null;
    }
    return match[1].trim();
}
function getShellDialect(shebang) {
    const match = SHELL_REGEXP.exec(shebang);
    if (match && match[1]) {
        const bashDialect = match[1].trim();
        if (BASH_DIALECTS.includes(bashDialect)) {
            return bashDialect;
        }
    }
    return null;
}
function getShellDialectFromShellDirective(fileContent) {
    const contentLines = fileContent.split('\n');
    for (const line of contentLines) {
        const match = SHELL_DIRECTIVE_REGEXP.exec(line);
        if (match === null) {
            break;
        }
        if (match[1]) {
            const bashDialect = match[1].trim();
            if (BASH_DIALECTS.includes(bashDialect)) {
                return bashDialect;
            }
        }
    }
    return null;
}
function analyzeShebang(fileContent) {
    var _a;
    const shebang = getShebang(fileContent);
    return {
        shebang,
        shellDialect: (_a = getShellDialectFromShellDirective(fileContent)) !== null && _a !== void 0 ? _a : (shebang ? getShellDialect(shebang) : null),
    };
}
//# sourceMappingURL=shebang.js.map