const std = @import("std");
const builtin = @import("builtin");
const native_os = builtin.os.tag;
const windows = std.os.windows;
const Id = switch (native_os) {
    .linux,
    .dragonfly,
    .netbsd,
    .freebsd,
    .openbsd,
    .haiku,
    .wasi,
    => u32,
    .macos, .ios, .watchos, .tvos, .visionos => u64,
    .windows => windows.DWORD,
    else => usize,
};
const linux = std.os.linux;

const ThreadHandle = i32;

var tls_thread_id: ?Id = null;
fn getCurrentId() Id {
    return tls_thread_id orelse {
        const tid = @as(u32, @bitCast(linux.gettid()));
        tls_thread_id = tid;
        return tid;
    };
}

pub fn main() !void {
    const a = getCurrentId();
    _ = a;
}
