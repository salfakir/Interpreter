const std = @import("std");
const print = std.debug.print;
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
const TokenContext = struct {
    pub fn hash(self: TokenContext, num: u8) u64 {
        _ = self;
        const h: u64 = 1231 + num;
        return h;
    }
    pub fn eql(self: TokenContext, num1: u64, num2: u64) bool {
        _ = self;
        return num1 == num2;
    }
};
const TokenAppearance = struct {
    location: u32,
    tokenSymbol: *TokenSymbol, //refrence the token
};
pub fn parse(file: []const u8) void {
    var buffer = std.ArrayList(u8).init(std.heap.page_allocator);
    defer buffer.deinit();
    const map = Keywords();
    defer map.deinit();
    const singleKeywordsLoc = keywordSinglePars(file, map);
    for (singleKeywordsLoc) |tkna| {
        const token = tkna.tokenSymbol;
        const tokType = @tagName(token.tokenType);
        const lex = token.symbol;
        print("{s} {s} null", .{ tokType, lex });
    }
    // const v: u8 = toParse[0];
    // _ = v;

    // while (toParse.len > 0) {
    //     toParse = lineParse(toParse);
    // }
    // for (file) |chr| {
    // }
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
fn keywordSinglePars(line: []const u8, symbolsMap: type) []TokenAppearance {
    var openPraBuffer = std.ArrayList(TokenAppearance).init(std.heap.page_allocator);
    defer openPraBuffer.deinit();
    var count = 0;
    for (line) |chr| {
        if (symbolsMap.contains(chr)) {
            openPraBuffer.append(TokenAppearance{ .location = count, .tokenSymbol = symbolsMap.getPtr(chr) });
        }
        count += 1;
    }
    return openPraBuffer.items;
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
pub fn Constants() []TokenSymbol {
    return [41]TokenSymbol{
        TokenSymbol{ .symbol = "(", .tokenID = TokenTypeID.LEFT_PAREN, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = ")", .tokenID = TokenTypeID.RIGHT_PAREN, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = "{", .tokenID = TokenTypeID.LEFT_BRACE, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = "}", .tokenID = TokenTypeID.RIGHT_BRACE, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = "[", .tokenID = TokenTypeID.LEFT_BRACKET, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = "]", .tokenID = TokenTypeID.RIGHT_BRACKET, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = ",", .tokenID = TokenTypeID.COMMA, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = ".", .tokenID = TokenTypeID.DOT, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = ";", .tokenID = TokenTypeID.SEMICOLON, .tokenType = TokenType.SEPERATOR },
        TokenSymbol{ .symbol = "!", .tokenID = TokenTypeID.BANG, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "!=", .tokenID = TokenTypeID.BANG_EQUAL, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "=", .tokenID = TokenTypeID.EQUAL, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "==", .tokenID = TokenTypeID.EQUAL_EQUAL, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = ">", .tokenID = TokenTypeID.GREATER, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = ">=", .tokenID = TokenTypeID.GREATER_EQUAL, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "<", .tokenID = TokenTypeID.LESS, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "<=", .tokenID = TokenTypeID.LESS_EQUAL, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "-", .tokenID = TokenTypeID.MINUS, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "+", .tokenID = TokenTypeID.PLUS, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "/", .tokenID = TokenTypeID.SLASH, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "*", .tokenID = TokenTypeID.STAR, .tokenType = TokenType.OPERATOR },
        TokenSymbol{ .symbol = "string", .tokenID = TokenTypeID.STRING, .tokenType = TokenType.LITERAL },
        TokenSymbol{ .symbol = "number", .tokenID = TokenTypeID.NUMBER, .tokenType = TokenType.LITERAL },
        TokenSymbol{ .symbol = "boolean", .tokenID = TokenTypeID.BOOLEAN, .tokenType = TokenType.LITERAL },
        TokenSymbol{ .symbol = "and", .tokenID = TokenTypeID.AND, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "class", .tokenID = TokenTypeID.CLASS, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "else", .tokenID = TokenTypeID.ELSE, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "false", .tokenID = TokenTypeID.FALSE, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "fun", .tokenID = TokenTypeID.FUN, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "for", .tokenID = TokenTypeID.FOR, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "if", .tokenID = TokenTypeID.IF, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "nil", .tokenID = TokenTypeID.NIL, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "or", .tokenID = TokenTypeID.OR, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "print", .tokenID = TokenTypeID.PRINT, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "return", .tokenID = TokenTypeID.RETURN, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "super", .tokenID = TokenTypeID.SUPER, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "this", .tokenID = TokenTypeID.THIS, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "true", .tokenID = TokenTypeID.TRUE, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "var", .tokenID = TokenTypeID.VAR, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "while", .tokenID = TokenTypeID.WHILE, .tokenType = TokenType.KEYWORD },
        TokenSymbol{ .symbol = "EOF", .tokenID = TokenTypeID.EOF, .tokenType = TokenType.KEYWORD, .string = "EOF" },
    };
}
pub fn t() ?u8 {
    return 0;
}
pub fn Keywords() !type {
    var gdp = std.heap.GeneralPurposeAllocator(.{}){};
    const all = gdp.allocator();
    _ = t() orelse 5;
    // var map = std.HashMap(u8, TokenSymbol, TokenContext, 80).initContext(all, TokenContext{});
    var map = std.AutoHashMap(u8, TokenSymbol).init(all);
    var sym: u8 = '(';
    const tok = TokenSymbol{
        .symbol = "(",
        .tokenID = TokenTypeID.LEFT_PAREN,
        .tokenType = TokenType.SEPERATOR,
    };
    try map.put(sym, tok);
    sym = ')';
    try map.put(sym, TokenSymbol{
        .symbol = ")",
        .tokenID = TokenTypeID.RIGHT_PAREN,
        .tokenType = TokenType.SEPERATOR,
    });
    // map.put("{", TokenSymbol{ .symbol = "{", .tokenID = TokenTypeID.LEFT_BRACE, .tokenType = TokenType.SEPERATOR });
    // map.put("}", TokenSymbol{ .symbol = "}", .tokenID = TokenTypeID.RIGHT_BRACE, .tokenType = TokenType.SEPERATOR });
    // map.put("[", TokenSymbol{ .symbol = "[", .tokenID = TokenTypeID.LEFT_BRACKET, .tokenType = TokenType.SEPERATOR });
    // map.put("]", TokenSymbol{ .symbol = "]", .tokenID = TokenTypeID.RIGHT_BRACKET, .tokenType = TokenType.SEPERATOR });
    // map.put(",", TokenSymbol{ .symbol = ",", .tokenID = TokenTypeID.COMMA, .tokenType = TokenType.SEPERATOR });
    // map.put(".", TokenSymbol{ .symbol = ".", .tokenID = TokenTypeID.DOT, .tokenType = TokenType.SEPERATOR });
    // map.put(";", TokenSymbol{ .symbol = ";", .tokenID = TokenTypeID.SEMICOLON, .tokenType = TokenType.SEPERATOR });
    // map.put("!", TokenSymbol{ .symbol = "!", .tokenID = TokenTypeID.BANG, .tokenType = TokenType.OPERATOR });
    // map.put("!=",TokenSymbol{ .symbol = "!=", .tokenID = TokenTypeID.BANG_EQUAL, .tokenType = TokenType.OPERATOR });
    // map.put("=", TokenSymbol{ .symbol = "=", .tokenID = TokenTypeID.EQUAL, .tokenType = TokenType.OPERATOR });
    // map.put("==",TokenSymbol{ .symbol = "==", .tokenID = TokenTypeID.EQUAL_EQUAL, .tokenType = TokenType.OPERATOR });
    // map.put(">", TokenSymbol{ .symbol = ">", .tokenID = TokenTypeID.GREATER, .tokenType = TokenType.OPERATOR });
    // map.put(">=",TokenSymbol{ .symbol = ">=", .tokenID = TokenTypeID.GREATER_EQUAL, .tokenType = TokenType.OPERATOR });
    // map.put("<", TokenSymbol{ .symbol = "<", .tokenID = TokenTypeID.LESS, .tokenType = TokenType.OPERATOR });
    // map.put("<=",TokenSymbol{ .symbol = "<=", .tokenID = TokenTypeID.LESS_EQUAL, .tokenType = TokenType.OPERATOR });
    // map.put("-", TokenSymbol{ .symbol = "-", .tokenID = TokenTypeID.MINUS, .tokenType = TokenType.OPERATOR });
    // map.put("+", TokenSymbol{ .symbol = "+", .tokenID = TokenTypeID.PLUS, .tokenType = TokenType.OPERATOR });
    // map.put("/", TokenSymbol{ .symbol = "/", .tokenID = TokenTypeID.SLASH, .tokenType = TokenType.OPERATOR });
    // map.put("*", TokenSymbol{ .symbol = "*", .tokenID = TokenTypeID.STAR, .tokenType = TokenType.OPERATOR });
    // map.put("and",TokenSymbol{ .symbol = "and", .tokenID = TokenTypeID.AND, .tokenType = TokenType.KEYWORD });
    // map.put("class",TokenSymbol{ .symbol = "class", .tokenID = TokenTypeID.CLASS, .tokenType = TokenType.KEYWORD });
    // map.put("else",TokenSymbol{ .symbol = "else", .tokenID = TokenTypeID.ELSE, .tokenType = TokenType.KEYWORD });
    // map.put("false",TokenSymbol{ .symbol = "false", .tokenID = TokenTypeID.FALSE, .tokenType = TokenType.KEYWORD });
    // map.put("fun",TokenSymbol{ .symbol = "fun", .tokenID = TokenTypeID.FUN, .tokenType = TokenType.KEYWORD });
    // map.put("for",TokenSymbol{ .symbol = "for", .tokenID = TokenTypeID.FOR, .tokenType = TokenType.KEYWORD });
    // map.put("if",TokenSymbol{ .symbol = "if", .tokenID = TokenTypeID.IF, .tokenType = TokenType.KEYWORD });
    // map.put("nil",TokenSymbol{ .symbol = "nil", .tokenID = TokenTypeID.NIL, .tokenType = TokenType.KEYWORD });
    // map.put("or",TokenSymbol{ .symbol = "or", .tokenID = TokenTypeID.OR, .tokenType = TokenType.KEYWORD });
    // map.put("print",TokenSymbol{ .symbol = "print", .tokenID = TokenTypeID.PRINT, .tokenType = TokenType.KEYWORD });
    // map.put("return",TokenSymbol{ .symbol = "return", .tokenID = TokenTypeID.RETURN, .tokenType = TokenType.KEYWORD });
    // map.put("super",TokenSymbol{ .symbol = "super", .tokenID = TokenTypeID.SUPER, .tokenType = TokenType.KEYWORD });
    // map.put("this",TokenSymbol{ .symbol = "this", .tokenID = TokenTypeID.THIS, .tokenType = TokenType.KEYWORD });
    // map.put("true",TokenSymbol{ .symbol = "true", .tokenID = TokenTypeID.TRUE, .tokenType = TokenType.KEYWORD });
    // map.put("var",TokenSymbol{ .symbol = "var", .tokenID = TokenTypeID.VAR, .tokenType = TokenType.KEYWORD });
    // map.put("while",TokenSymbol{ .symbol = "while", .tokenID = TokenTypeID.WHILE, .tokenType = TokenType.KEYWORD });
    return map;
}
