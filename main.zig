const std = @import("std");
const warn = std.debug.warn;
usingnamespace std.os.windows;

extern "kernel32" fn LoadLibraryA(
    lpLibFileName: [*:0]const u8
) callconv(.Stdcall) ?HMODULE;

pub fn main() !void {
    const new_module = LoadLibraryA("main.dll");
    if (new_module == null) return error.LoadLibraryAFailure;

    const num_proc = kernel32.GetProcAddress(new_module.?, "GetXKCD");
    if (num_proc == null) return error.ProcNotFound;

    const myXKCD = @ptrCast(
        fn(i64) struct {
            title: [*:0]const u8,
            url: [*:0]const u8,
            success: bool
        },
        num_proc
    )(600);

    if (!myXKCD.success) return error.GoFuncFailed;

    warn("title: {}, url: {}\n", .{
        std.mem.toSliceConst(u8, myXKCD.title),
        std.mem.toSliceConst(u8, myXKCD.url)
    });
}