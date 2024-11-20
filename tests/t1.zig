const std = @import("std");
const parser = @import("parser1");
// test "test_eof" {
//     const file_contents = "EOF";
//     const result = parser.parse(file_contents);
//     const expected = "EOF  null\n";
//     try std.testing.expectEqualStrings(expected, result);
// }
test "get_keywords" {
    const a = parser.t() orelse 1;
    const keywords = try parser.Keywords();
    _ = a;
    try std.testing.expect(keywords.items.len > 0);
}
