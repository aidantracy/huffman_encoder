
/// args is responsible for handling command-line arguments for the application.
/// Returns the arguments provided by the user, or an error if the arguments are invalid.

const std = @import("std");

pub const Args = struct {
    program_name: []const u8,
    input_file: []const u8,
    output_file: []const u8,

    /// Static method to parse arguments
    pub fn parse_args() !Args {
        var proc_args = std.process.args();
        var args = Args{
            .program_name = "",
            .input_file = "",
            .output_file = "",
        };
        args.program_name = proc_args.next().?;
        while (proc_args.next()) |arg| {
            if (std.mem.eql(u8, arg, "--compress")) {
                args.input_file = proc_args.next().?;
                args.output_file = proc_args.next().?;
            } else {
                std.debug.print("Usage: --compress <input> <output>\n", .{});
                return error.FailedParse;
            }
        }
        return args;
    }
};
