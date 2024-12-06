const std = @import("std");

/// Update the frequency of each character from the input string and update the hashmap.
// this does not work with allocator: *std.mem.Allocator
pub fn updateFrequencies(input: []const u8, allocator: std.mem.Allocator) !std.hash_map.AutoHashMap(u8, usize) {
    var map = std.hash_map.AutoHashMap(u8, usize).init(allocator);

    for (input) |byte| {
        const current = map.get(byte) orelse 0;
        try map.put(byte, current + 1);
    }

    return map; // The caller is responsible for deallocation
}


/// A node struct for the Huffman tree.
pub const HuffmanNode = struct {
    frequency: usize,
    character: ?u8, //will be null for internal nodes
    left: ?*HuffmanNode,
    right: ?*HuffmanNode,

    pub fn init(frequency: usize, character: ?u8, left: ?*HuffmanNode, right: ?*HuffmanNode) HuffmanNode {
        return HuffmanNode{
            .frequency = frequency,
            .character = character,
            .left = left,
            .right = right,
        };
    }
};


// buildHuffmanTree builds a Huffman tree from a hashmap of character frequencies.
pub fn buildHuffmanTree(frequencies: std.hash_map.AutoHashMap(u8, usize), allocator: std.mem.Allocator) !*HuffmanNode {
    const NodeHeap = std.PriorityQueue(*HuffmanNode, void, (struct {
        pub fn compare(_: void, a: *HuffmanNode, b: *HuffmanNode) std.math.Order {
            if (a.frequency < b.frequency) return .lt;
            if (a.frequency > b.frequency) return .gt;
            return .eq;
        }
    }).compare);

    var heap = NodeHeap.init(allocator, {});
    defer heap.deinit();

    // Create nodes for each character and frequency
    var iter = frequencies.iterator();
    while (iter.next()) |entry| {
        const char = entry.key_ptr.*;
        const frequency = entry.value_ptr.*;
        const node = try allocator.create(HuffmanNode);
        node.* = HuffmanNode.init(frequency, char, null, null);
        try heap.add(node);
    }

    // Build the tree by combining two smallest nodes until one remains
    while (heap.count() > 1) {
        const left = heap.remove();
        const right = heap.remove();

        const combined_node = try allocator.create(HuffmanNode);
        combined_node.* = HuffmanNode.init(left.frequency + right.frequency, null, left, right);
        try heap.add(combined_node);
    }

    return heap.remove();
}
