const std = @import("std");
usingnamespace std.os.windows;
extern "kernel32" fn LoadLibraryA(lpLibFileName: [*:0]const u8) callconv(.Stdcall) ?HMODULE;
pub fn main() !void {
    const getXKCD = @ptrCast(
        fn(i64) extern struct {title: [*:0]const u8, url: [*:0]const u8},
        kernel32.GetProcAddress(
            LoadLibraryA("main.dll") orelse return error.LoadLibraryAFailure,
            "GetXKCD"
        ) orelse return error.ProcNotFound
    );

    const my_xkcd = getXKCD(100);

    std.debug.warn("title: {}, url: {}\n", .{
        std.mem.toSliceConst(u8, my_xkcd.title),
        std.mem.toSliceConst(u8, my_xkcd.url)
    });
}
