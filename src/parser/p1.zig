const std = @import("std");
const TokenTypeID = enum {
    IDENTIFIER, // variable name
    //seperators
    LEFT_PAREN, // (
    RIGHT_PAREN, // )
    LEFT_BRACE, // {
    RIGHT_BRACE, // }
    LEFT_BRACKET, // [
    RIGHT_BRACKET, // ]
    COMMA,
    DOT,
    SEMICOLON,
    //operators
    BANG,
    BANG_EQUAL,
    EQUAL,
    EQUAL_EQUAL,
    GREATER,
    GREATER_EQUAL,
    LESS,
    LESS_EQUAL,
    MINUS,
    PLUS,
    SLASH,
    STAR,
    //literals
    STRING,
    NUMBER,
    BOOLEAN,
    //keywords
    AND,
    CLASS,
    ELSE,
    FALSE,
    FUN,
    FOR,
    IF,
    NIL,
    OR,
    PRINT,
    RETURN,
    SUPER,
    THIS,
    TRUE,
    VAR,
    WHILE,

    EOF,
};
const TokenType = enum {
    SEPERATOR,
    KEYWORD,
    LITERAL,
    OPERATOR,
};
const TokenSymbol = struct {
    symbol: []const u8,
    tokenID: TokenTypeID,
    tokenType: TokenType,
    string: ?[]const u8 = null,
};
pub fn parse(file: []const u8) void {
    var buffer = std.ArrayList(u8).init(std.heap.page_allocator);
    defer buffer.deinit();
    _ = file;

    // for (file) |chr| {
    //     if (!isAlphaNumOrUnderScore(chr)) {
    //         if (buffer.items.len == 0) continue;
    //         std.debug.print("{s}\n", .{buffer.items});
    //         buffer.resize(0) catch {
    //             std.debug.print("failed to resize just to make you misrable", .{});
    //             return;
    //         };
    //     } else {
    //         buffer.append(chr) catch return;
    //     }
    // }
    // const token = Constants();
    // _ = token;
    std.debug.print("EOF  null", .{});
}
pub fn lineParse(code: []const u8) []u8 {
    return code;
}
fn isAlphaNumOrUnderScore(chr: u8) bool {
    if (chr >= 97 and chr <= 122) {
        //lowercase
        return true;
    }
    if (chr >= 65 and chr <= 90) {
        //uppercase
        return true;
    }
    if (chr >= 47 and chr <= 58) {
        //digit
        return true;
    }
    if (chr == 95) {
        //underscore
        return true;
    }
    return false;
}
// pub fn Constants() []TokenSymbol {
//     return [41]TokenSymbol{
//         TokenSymbol{ .symbol = "(", .tokenID = TokenTypeID.LEFT_PAREN, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = ")", .tokenID = TokenTypeID.RIGHT_PAREN, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = "{", .tokenID = TokenTypeID.LEFT_BRACE, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = "}", .tokenID = TokenTypeID.RIGHT_BRACE, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = "[", .tokenID = TokenTypeID.LEFT_BRACKET, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = "]", .tokenID = TokenTypeID.RIGHT_BRACKET, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = ",", .tokenID = TokenTypeID.COMMA, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = ".", .tokenID = TokenTypeID.DOT, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = ";", .tokenID = TokenTypeID.SEMICOLON, .tokenType = TokenType.SEPERATOR },
//         TokenSymbol{ .symbol = "!", .tokenID = TokenTypeID.BANG, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "!=", .tokenID = TokenTypeID.BANG_EQUAL, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "=", .tokenID = TokenTypeID.EQUAL, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "==", .tokenID = TokenTypeID.EQUAL_EQUAL, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = ">", .tokenID = TokenTypeID.GREATER, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = ">=", .tokenID = TokenTypeID.GREATER_EQUAL, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "<", .tokenID = TokenTypeID.LESS, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "<=", .tokenID = TokenTypeID.LESS_EQUAL, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "-", .tokenID = TokenTypeID.MINUS, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "+", .tokenID = TokenTypeID.PLUS, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "/", .tokenID = TokenTypeID.SLASH, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "*", .tokenID = TokenTypeID.STAR, .tokenType = TokenType.OPERATOR },
//         TokenSymbol{ .symbol = "string", .tokenID = TokenTypeID.STRING, .tokenType = TokenType.LITERAL },
//         TokenSymbol{ .symbol = "number", .tokenID = TokenTypeID.NUMBER, .tokenType = TokenType.LITERAL },
//         TokenSymbol{ .symbol = "boolean", .tokenID = TokenTypeID.BOOLEAN, .tokenType = TokenType.LITERAL },
//         TokenSymbol{ .symbol = "and", .tokenID = TokenTypeID.AND, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "class", .tokenID = TokenTypeID.CLASS, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "else", .tokenID = TokenTypeID.ELSE, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "false", .tokenID = TokenTypeID.FALSE, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "fun", .tokenID = TokenTypeID.FUN, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "for", .tokenID = TokenTypeID.FOR, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "if", .tokenID = TokenTypeID.IF, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "nil", .tokenID = TokenTypeID.NIL, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "or", .tokenID = TokenTypeID.OR, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "print", .tokenID = TokenTypeID.PRINT, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "return", .tokenID = TokenTypeID.RETURN, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "super", .tokenID = TokenTypeID.SUPER, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "this", .tokenID = TokenTypeID.THIS, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "true", .tokenID = TokenTypeID.TRUE, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "var", .tokenID = TokenTypeID.VAR, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "while", .tokenID = TokenTypeID.WHILE, .tokenType = TokenType.KEYWORD },
//         TokenSymbol{ .symbol = "EOF", .tokenID = TokenTypeID.EOF, .tokenType = TokenType.KEYWORD, .string = "EOF" },
//     };
// }
