"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.discriminate = discriminate;
function discriminate(discriminantKey, discriminantValue) {
    return (obj) => obj[discriminantKey] === discriminantValue;
}
//# sourceMappingURL=discriminate.js.map