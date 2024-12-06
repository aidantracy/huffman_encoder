# Project 5: Zig - Huffman Encoding

* Authors: Aidan Tracy, Michael Dunn 
* Class: CS354 Section 002 
* Semester: Fall 2024  

## Overview

This program implements a file compression tool using the Zig programming language. It utilizes efficient memory management and data handling techniques, with features including hashmaps, bit manipulation, and Huffman encoding. The goal is to learn more about the Zig programming language while learning how to build a Huffman encoder to compress files.

## Reflection 

Working on this project has been a challenge. Choosing Zig as the programming language provided an opportunity to explore its memory safety features, and implementing concepts such as hashmaps and bit manipulation required a deeper understanding of its standard library. One of the highlights was successfully integrating custom memory allocators, which was interesting to do and that you don't have to worry about hidden memory allocations. However, working with Zig's unique grammar and learning how to debug errors within this framework was initially a hurdle that took time to overcome.

Another challenge was implementing the Huffman encoding process, particularly calculating the encoding size and optimizing data structures for performance. Resources such as Zig's documentation and community articles were invaluable in tackling these issues. Overall, I feel more confident in using Zig for future projects.

## Compiling and Using

To compile and run the program, use the following commands:

### Running Instructions
To run the program, use the following command format:

```bash
zig build run -- /** args **/
```
example:

```bash
zig build run -- compress input.txt output.txt
```


### Testing

```bash
zig test src/root.zig 
```
or

```bash
zig build test
```

## works cited

1. Hashmaps in zig - https://devlog.hexops.com/2022/zig-hashmaps-explained/
2. Hashmaps 0.13.0 - https://zig.guide/standard-library/hashmaps/
3. Allocators and Scope - https://pedropark99.github.io/zig-book/Chapters/01-memory.html
4. Grammar file - https://ziglang.org/documentation/master/#Grammar
5. Bit Writer - https://github.com/ziglang/zig/blob/master/lib/std/io/bit_writer.zig
6. Calculating Encoding Size - https://stackoverflow.com/questions/759707/efficient-way-of-storing-huffman-tree


## Presentation:
https://docs.google.com/presentation/d/1shdaibec4tbZ9ixzjnOqTbshvQADUxWD4PUHS8CpdF4/edit#slide=id.g251622d556_0_29