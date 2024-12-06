const std = @import("std");
const Args = @import("args.zig").Args;
const fileMod = @import("fileMod.zig");
const Encoder = @import("encoder.zig");

/// Main function for the application that compresses a file using Huffman coding. 
pub fn main() !void {

    // Step 1: process command line arguments
    const args = try Args.parse_args();

    // Step 2: read input file
    const input = try fileMod.readFile(args.input_file);
    std.debug.print("Input file content: {s}\n", .{input});

    // Step 3: calculate frequency of each character
    const allocator = std.heap.page_allocator;
    var my_hash_map = try Encoder.updateFrequencies(input, allocator);
    var iter = my_hash_map.iterator();

    while (iter.next()) |entry| {
        const key = entry.key_ptr.*;   // Dereference the key pointer
        const value = entry.value_ptr.*; // Dereference the value pointer
        std.debug.print("{c}: {d}\n", .{key, value}); 
    }
    
    defer my_hash_map.deinit();

    // Step 4: Build Huffman Tree
    const huffmanTree = try Encoder.buildHuffmanTree(my_hash_map, allocator);
    printHuffmanTree(huffmanTree, 0);
    defer freeHuffmanTree(huffmanTree, allocator);    



    // Step 5: Encode Data (To Be Implemented)

    // Step 6: Write to Output File (To Be Implemented)
}

fn freeHuffmanTree(node: ?*Encoder.HuffmanNode, allocator: std.mem.Allocator) void {
    if (node) |n| {
        freeHuffmanTree(n.left, allocator);
        freeHuffmanTree(n.right, allocator);
        allocator.destroy(n);
    }
}

fn printHuffmanTree(node: ?*Encoder.HuffmanNode, level: usize) void {
    if (node) |n| {
        // Indentation for the current node level
        for (0..level) |_| {
            std.debug.print("  ", .{});
        }
        // Print character and frequency if it is a leaf node, otherwise indicate internal node
        if (n.character != null) {
            std.debug.print("Char: {c}, Freq: {d}\n", .{n.character.?, n.frequency});
        } else {
            std.debug.print("Internal Node, Freq: {d}\n", .{n.frequency});
        }
        // Recursively print left and right subtrees
        printHuffmanTree(n.left, level + 1);
        printHuffmanTree(n.right, level + 1);
    }
}
