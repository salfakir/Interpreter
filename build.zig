const std = @import("std");
const testing = std.testing;

// Learn more about this file here: https://ziglang.org/learn/build-system
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const mod: std.Build.Module.CreateOptions = .{
        .root_source_file = b.path("src/parser/p1.zig"),
        .target = target,
        .optimize = optimize,
    };
    const module = b.addModule("parser1", mod);
    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("parser1", module);

    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(exe);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_cmd = b.addRunArtifact(exe);

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    //my config
    const test_op: std.Build.TestOptions = std.Build.TestOptions{
        .root_source_file = b.path("./tests/t1.zig"),
    };

    const tester = b.addTest(test_op);
    tester.root_module.addImport("parser1", module);
    const build_test = b.addInstallArtifact(tester, .{});
    const test_step = b.step("test", "Build tests");
    test_step.dependOn(&build_test.step);
}
