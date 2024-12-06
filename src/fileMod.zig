const std = @import("std");

pub fn readFile(filePath: []const u8) ![]u8 {
    const allocator = std.heap.page_allocator;
    const file = try std.fs.cwd().openFile(filePath, .{});
    const reader = file.reader();
    const max_size = 10 * 1024 * 1024; // 10 MB
    return try reader.readAllAlloc(allocator, max_size);
}
