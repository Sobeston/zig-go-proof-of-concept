const std = @import("std");
usingnamespace std.os.windows;

extern "kernel32" fn LoadLibraryA(lpLibFileName: [*:0]const u8) callconv(.Stdcall) ?HMODULE;

pub fn main() !void {
    const new_module = LoadLibraryA("main.dll") orelse
        return error.LoadLibraryAFailure;

    const num_proc = kernel32.GetProcAddress(new_module, "GetXKCD") orelse
        return error.ProcNotFound;

    const myXKCD = @ptrCast(
        fn(i64) extern struct {title: [*:0]const u8, url: [*:0]const u8},
        num_proc
    )(600);

    std.debug.warn("title: {}, url: {}\n", .{
        std.mem.toSliceConst(u8, myXKCD.title),
        std.mem.toSliceConst(u8, myXKCD.url)
    });
}
