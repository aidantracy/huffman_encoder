const std = @import("std");
const Encoder = @import("encoder.zig");
const testing = std.testing;

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}

test "updateFrequencies function" {
    const allocator = std.testing.allocator; // Use Zig's test allocator
    const input = "aabc";

    var result = try Encoder.updateFrequencies(input, allocator);
    defer result.deinit(); // Deallocate the map

    const a_count = result.get('a') orelse unreachable;
    const b_count = result.get('b') orelse unreachable;
    const c_count = result.get('c') orelse unreachable;

    try std.testing.expectEqual(@as(usize, 2), a_count);
    try std.testing.expectEqual(@as(usize, 1), b_count);
    try std.testing.expectEqual(@as(usize, 1), c_count);
}

test "empty input" {
    const allocator = std.testing.allocator;
    const input = "";

    var result = try Encoder.updateFrequencies(input, allocator);
    defer result.deinit();

    try std.testing.expectEqual(@as(usize, 0), result.count());
}

test "updateFrequencies with special characters" {
    const allocator = std.testing.allocator;
    const input = "!@#$%^&*()_+";

    var result = try Encoder.updateFrequencies(input, allocator);
    defer result.deinit();

    const exclamation_count = result.get('!') orelse unreachable;
    const at_count = result.get('@') orelse unreachable;
    const hash_count = result.get('#') orelse unreachable;
    const dollar_count = result.get('$') orelse unreachable;
    const percent_count = result.get('%') orelse unreachable;
    const caret_count = result.get('^') orelse unreachable;
    const ampersand_count = result.get('&') orelse unreachable;
    const asterisk_count = result.get('*') orelse unreachable;
    const left_paren_count = result.get('(') orelse unreachable;
    const right_paren_count = result.get(')') orelse unreachable;
    const underscore_count = result.get('_') orelse unreachable;
    const plus_count = result.get('+') orelse unreachable;

    try std.testing.expectEqual(@as(usize, 1), exclamation_count);
    try std.testing.expectEqual(@as(usize, 1), at_count);
    try std.testing.expectEqual(@as(usize, 1), hash_count);
    try std.testing.expectEqual(@as(usize, 1), dollar_count);
    try std.testing.expectEqual(@as(usize, 1), percent_count);
    try std.testing.expectEqual(@as(usize, 1), caret_count);
    try std.testing.expectEqual(@as(usize, 1), ampersand_count);
    try std.testing.expectEqual(@as(usize, 1), asterisk_count);
    try std.testing.expectEqual(@as(usize, 1), left_paren_count);
    try std.testing.expectEqual(@as(usize, 1), right_paren_count);
    try std.testing.expectEqual(@as(usize, 1), underscore_count);
    try std.testing.expectEqual(@as(usize, 1), plus_count);

    // Validate the total number of unique keys
    try std.testing.expectEqual(@as(usize, 12), result.count());
}

test "HuffmanNode creation" {
    const allocator = std.testing.allocator;
    const node_ptr = allocator.create(Encoder.HuffmanNode) catch {
        std.debug.panic("Failed to allocate memory for HuffmanNode", .{});
        return;
    };

    defer allocator.destroy(node_ptr);

    node_ptr.* = Encoder.HuffmanNode.init(10, 'a', null, null);

    
    try std.testing.expectEqual(@as(usize, 10), node_ptr.frequency);
    try std.testing.expectEqual(@as(u8, 'a'), node_ptr.character);
    try std.testing.expectEqual(null, node_ptr.left);
    try std.testing.expectEqual(null, node_ptr.right);
}
