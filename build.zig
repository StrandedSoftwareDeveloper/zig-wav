const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Make module available as dependency.
    _ = b.addModule("wav", .{ .root_source_file = .{ .src_path = .{.owner = b, .sub_path = "src/wav.zig"} } });

    const test_step = b.step("test", "Run library tests");
    inline for ([_][]const u8{ "src/sample.zig", "src/wav.zig" }) |test_file| {
        const t = b.addTest(.{
            .root_source_file = .{ .cwd_relative = test_file },
            .target = target,
            .optimize = optimize,
        });
        test_step.dependOn(&t.step);
    }
}
