const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var highest_id: u10 = 0;
    var it = std.mem.split(input, "\n");
    while (it.next()) |code| {
        const id = decodeSeatId(code);
        highest_id = std.math.max(id, highest_id);
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{highest_id});
}

fn decodePosition(comptime T: type, code: []const u8, low_char: u8, high_char: u8) T {
    const bits = @bitSizeOf(T);
    std.debug.assert(bits == code.len);
    var pos: T = 0;
    for (code) |c| {
        pos <<= 1;
        pos += @as(T, if (c == high_char) 1 else 0);
    }
    return pos;
}

fn decodeSeatId(code: []const u8) u10 {
    std.debug.assert(code.len == 10);
    const row_code = code[0..7];
    const col_code = code[7..];
    const row = decodePosition(u7, row_code, 'F', 'B');
    const col = decodePosition(u3, col_code, 'L', 'R');
    return @intCast(u10, row) * 8 + col;
}

test "decodePosition" {
    std.testing.expect(decodePosition(u7, "FBFBBFF", 'F', 'B') == 44);
    std.testing.expect(decodePosition(u3, "RLR", 'L', 'R') == 5);
}

test "decodeSeatId" {
    std.testing.expect(decodeSeatId("FBFBBFFRLR") == 357);
}

const input =
    \\FFBBBFBLRL
    \\BFFFBFBRRR
    \\BFFFBFBLRL
    \\BFFBFBBLRR
    \\BBFFBFFRLL
    \\BFFFBFBRLR
    \\FFFFBBBRLR
    \\BBFFFBBRRR
    \\BBFBFBBRRR
    \\BFFBBBFLRR
    \\FFBBFBBRLR
    \\BBFFBFFLLL
    \\BFFFBFBLLR
    \\FBBFFBFLRR
    \\FBBFBBFRRL
    \\BFFBBBBRRR
    \\BFBBBBFLLL
    \\BFFBFBFLRR
    \\FBBFFBFRRR
    \\FFBFBFBLRL
    \\BFFFFBFLRR
    \\FBBFFFFLRR
    \\BFFFBBBLLL
    \\BFBFFFBRLL
    \\FFBBBBBRLL
    \\FFBBFFBLLR
    \\FBFFBBFLRL
    \\FFBFFBBRRL
    \\BFBBBBFLLR
    \\BFFFFBFRRL
    \\BFFBFFFLLL
    \\FBFFFBFLRL
    \\FBBBFFFLLL
    \\FFBFBBFRLR
    \\FBBBFBFRRL
    \\BFBBBFBLLL
    \\FBFFFBFLRR
    \\FBFBFFBLRR
    \\BFFFFBFLRL
    \\FBFBFFFRRL
    \\FBBFBFBLRL
    \\FBBFFBFLLL
    \\FBFBBBBRRR
    \\FBBBBBFLRR
    \\FBBBFBBLLR
    \\FFFBFBFRLL
    \\FFFBBFFLRR
    \\BFBBFFBRRL
    \\FFBFBFBRRL
    \\FBFBBBBLRR
    \\BFFBBFFLLL
    \\FFFBFBBRRL
    \\BFBBFFFLRR
    \\FBFBFBFLRL
    \\BFBFFBFLLL
    \\FBBBFBFRLR
    \\FBBBFBFLLL
    \\BFBFFFBLRR
    \\BFFBFBFLRL
    \\BFBBFFFRRR
    \\FFFBFFFRLR
    \\FFFBBBBRLL
    \\FFBBBBBLLL
    \\BFBBBFBRLL
    \\FFFBBBFLLR
    \\BBFFFFFRRL
    \\FBFBBFFRLL
    \\BFFBFBFRLR
    \\FBFBBFFRRL
    \\FBFBBFFLLL
    \\FBFBBBBRLL
    \\FBBFFBFLRL
    \\BFFBFBBRRL
    \\FBBFBFBRRL
    \\FFFBBFBLRR
    \\BFFBBBFRLL
    \\FBFFFFFRRR
    \\BFFFFBBLRR
    \\FBBFFFBRRL
    \\FBBBBBBRRR
    \\FFFBBFFLLR
    \\BBFBFFFRRL
    \\BBFFFFBRRL
    \\FBBBFBFLRL
    \\FFBFBBFRRR
    \\FFBBBFFLRL
    \\BFFBFFFLRL
    \\BFBFBFBRRR
    \\BFBBFFBRLL
    \\BFFFFBBLLR
    \\FBBBFBBLRR
    \\BFFBFFFLRR
    \\BFFFBFBLLL
    \\FBBBBBFRRR
    \\BFFBFBFLLL
    \\FBFFBFFRRL
    \\BFBBFBBRRR
    \\FBFFFBFRRL
    \\BFBBBFBLLR
    \\BFBBBBBRRR
    \\FFFBFBFRRL
    \\BFFFBFFLLL
    \\BFFFFFFLRR
    \\FFBBFFFRLL
    \\BFFBFFFRRR
    \\BBFFBBFLRL
    \\FBFBBBBLLR
    \\FFFBFFBLRL
    \\FFBBBBBRLR
    \\FBFFBFFRRR
    \\BFBBFBBRLR
    \\FBFBBBBLRL
    \\BFBBFFFLLR
    \\FBBBFBBLRL
    \\BFFBBBFLLR
    \\FFFBBBBRRR
    \\BBFBFFFLRL
    \\FBFBBFFLLR
    \\BBFFFFBLRR
    \\FFBBFFBRRR
    \\FFBBBFBRLL
    \\BFFFFBFLLL
    \\BBFFBFBRLR
    \\FBFBBFBRRL
    \\FFFBBBFRRR
    \\FBBBFBBRRL
    \\FFFBFBBRRR
    \\FBFFBBBRLL
    \\FFBFBBBRLR
    \\BFFFBBBRLL
    \\FBBFBBBRLL
    \\FBBBBBBLLR
    \\FBFBBFBLRR
    \\BFBFBFBLRL
    \\FFFBFFBRLR
    \\BFFFFFFRLL
    \\BFFBFBBLRL
    \\FBFFBFFLRR
    \\FBFBBBBRLR
    \\BBFFFBBLRL
    \\FBBBFBBRRR
    \\BBFBFBFRRR
    \\FBFBFFFLRR
    \\BBFBFFBLLL
    \\FBBBFFFLLR
    \\BFBFFBFRRL
    \\BFBBBBFRLL
    \\FFBFBFFLRL
    \\FBBBBFBLRR
    \\FBBBBFFLLR
    \\FFBBFFBLLL
    \\FBFFFBBRRR
    \\FFBBBBFLLR
    \\BFBFBFFRRL
    \\FFBBBBBLRR
    \\BFFFFFFRRL
    \\BBFBFFFLRR
    \\BFFBFBFRRL
    \\BBFFBBBRRR
    \\BBFFBFFLRL
    \\FFFBFFBRRR
    \\BFBFBBFRLR
    \\BBFBFBBLRR
    \\BFBBBBBRLL
    \\FBBBFFBRRL
    \\FBBBBBBRLL
    \\FBBFBBFRLR
    \\FBBFFFFRRL
    \\BFBFFBFRRR
    \\BFBBFFFLLL
    \\FBFFBFFLLR
    \\BFBBBFBLRR
    \\BFFBBBBRLL
    \\FBBBBBBLRR
    \\FFBFFBFRRL
    \\BBFFFBBRLL
    \\FBFFFBBRLL
    \\FFBBFFFLRL
    \\BFBBBBFRRL
    \\FFBFFBBRRR
    \\BFFBBFBRLL
    \\FFBFFFBLLR
    \\FFBFFFFLLL
    \\FBBBBBFLLR
    \\FBFBFBBLLR
    \\FBFBBFBRRR
    \\BFBFFFFLRR
    \\BFBBFFBRRR
    \\FBFBFFFRRR
    \\FFBFBBBRLL
    \\BFBBBFBRRL
    \\BFFBBBFLRL
    \\BBFBFFFRLR
    \\BBFBBFFLRR
    \\FBBFFBBRRL
    \\FBFBBBFLRL
    \\FFBFBBFRRL
    \\BFBFFBFLRL
    \\BFFFBFFRLR
    \\BBFBBFFRLR
    \\FFBFBFBLLL
    \\BFBFFBBRRR
    \\BBFFBBBRRL
    \\FBBBFBBLLL
    \\FFFBFFFLRL
    \\BBFFBFBLLL
    \\BFBBFFFRLR
    \\FBBBBFBLRL
    \\BFBFBBBLRL
    \\FFFBFBFRLR
    \\FBFFFFBRRL
    \\BFFBBFFLLR
    \\FBFFFFFRRL
    \\FBBFFBFRLR
    \\FBBBFBBRLL
    \\FBFFFFFLLR
    \\BFBFBBBLLR
    \\FFBBBBBRRR
    \\BFFFBBFLLR
    \\FBFBBFBLLL
    \\FBBFFFFLLR
    \\FBFFFFBLRL
    \\FBBBFBBRLR
    \\FBBFBBFLRR
    \\FBBBBBBRRL
    \\BBFBFBFLRL
    \\FFBBBBFRRL
    \\BFBBFBFLRL
    \\BFFFFFFRRR
    \\BBFBFBBLRL
    \\BFBFFFFRLL
    \\BBFFBFBRRR
    \\BFBFFBBLLR
    \\FBFBFFBRRL
    \\FFBBFBFLLL
    \\BFBFBBBRLR
    \\FFBBFBFLRL
    \\BBFFFFFRRR
    \\FBFFFFFLRL
    \\FFBFBFBRLL
    \\BBFFFFFLRR
    \\BBFFFBBRLR
    \\FBFBBFBRLR
    \\FBBBBBFLRL
    \\FBBFFFBLRR
    \\FFFBBFBLLL
    \\BBFBFFBRLL
    \\FFBFBFBLLR
    \\BFBBFBBRRL
    \\BFFBFFBLLL
    \\BBFFBFFRLR
    \\BBFFBBFLLR
    \\BFFFFFBLRL
    \\FBBFFFBLLL
    \\FBFFFFBLLR
    \\FBBFBFFRRL
    \\BFBBBFFRRL
    \\BBFFFBFLRL
    \\FBFBFBFLLR
    \\FBFFFBBRLR
    \\BBFFBFBRLL
    \\BBFFBFFRRL
    \\BBFFBBFRLR
    \\FBFFBFBRLL
    \\BFBFBBFRRR
    \\BFBBFBBLRL
    \\FFBBFFBRLL
    \\FBFFBFBRLR
    \\BBFBFBBLLR
    \\BFBBBFFRLL
    \\FFBFFBFLLL
    \\BFBFFBFRLR
    \\BFFFBBFLRL
    \\BFFFBBBLRL
    \\BFBBBFFLLR
    \\FBBFBBFRRR
    \\BFFBFFBRRL
    \\BFBFFBBRRL
    \\BFBBFBFRLL
    \\FBBFFBFRLL
    \\FFBBBBFRLL
    \\FBBBFFBRLL
    \\BBFFBFBLRL
    \\BBFFFFFLLL
    \\BBFFFFBRRR
    \\FBBBBFBRLR
    \\BFFBFFBRRR
    \\FFBFBFFRLL
    \\FFFFBBFRRR
    \\BBFBBFFLRL
    \\FFFBBBFLRR
    \\BFFBFBBLLL
    \\BFBBFFFLRL
    \\BFFBFFFRLL
    \\BFBFFBBRLL
    \\FFBBBBFLLL
    \\BFFBFBBRRR
    \\BFBBBBFRRR
    \\FFBFFFFRLR
    \\BFBFBFFRRR
    \\BFBFBBBLRR
    \\FBBBFFFLRR
    \\FFBFFFBRRL
    \\FBBFFFBRLR
    \\FFFBFFBRLL
    \\BFBBFFBLLR
    \\FFBBFBBLRL
    \\FFBFFFBRLR
    \\BFBBFFFRLL
    \\FBBFBBBLLL
    \\FBBFFFFLLL
    \\FFBFBBBRRR
    \\FFFBBBFLRL
    \\BBFFBBFLRR
    \\FFFBFFFRLL
    \\FFBBFBFRRR
    \\FBFFBFBRRR
    \\BFFBBFBLRL
    \\FFFBBBFRLL
    \\FBBBFFBRRR
    \\FFBBBBFLRL
    \\FFBFBBBRRL
    \\FBFBFFBRRR
    \\FBFFFBBLLL
    \\FBBFFFFLRL
    \\BFFFFBBRLR
    \\BFBBBBBRLR
    \\BBFFFBBRRL
    \\BBFBFBFRLR
    \\FBFFFFFLLL
    \\FBFBBBBRRL
    \\BFBFFFBLRL
    \\FFFFBBBLLR
    \\FFBBBFBRLR
    \\FBBFFFFRRR
    \\BBFBFFBLRL
    \\BBFFFFBLRL
    \\BFBFFBFLRR
    \\FFFBBBBLRR
    \\FBBBBBBLRL
    \\FBBFFBFRRL
    \\FBFFBBBRRL
    \\FBFFBBFRRL
    \\FFFBFBFLLR
    \\BBFFFFFRLL
    \\FFFBBBBLLR
    \\BBFFBBBLRR
    \\FBFBFFBLLR
    \\BFBBFBBRLL
    \\BFFFFFBRLR
    \\FFFBFBBLRR
    \\BFFBBBBLLL
    \\BFFBBFBLLR
    \\FBBBBBFRLR
    \\BBFBFFBRLR
    \\FBFFBFFLLL
    \\FBBFBBBLLR
    \\FFFFBBBRRL
    \\FBBFBBFRLL
    \\BFBFFFFRLR
    \\FFFFBBBRLL
    \\BFBBBFFLLL
    \\BFBFBFFRLR
    \\FBFBFFBRLL
    \\FBBBFFFRLL
    \\FBFBFFBRLR
    \\FBBBBFFRLR
    \\BBFBFFFRLL
    \\BFFBBBBRLR
    \\BFBFFFFRRL
    \\FBBBFFFRRR
    \\FFBFFBBRLR
    \\FFBBBBFLRR
    \\BBFBBFBRRL
    \\BFFBFFBLLR
    \\BBFBBFBRLL
    \\FBFFBFBLLR
    \\BBFBFBFLLR
    \\FBFBFBBRLR
    \\BBFBBFFRRL
    \\BFBFFFBLLR
    \\BFBFFBBLLL
    \\FBFFBFBLRR
    \\BFBBBBBLLL
    \\BFFFBFFRRL
    \\BFBBBFBRLR
    \\BBFFFBFRLL
    \\BFFBFFBRLL
    \\BBFBBFFLLL
    \\BFBBBBBLRR
    \\FFFBFFBLLL
    \\BBFFBBBRLL
    \\FFFBBBBLRL
    \\FFBBBFBLLR
    \\FFBBFFBLRL
    \\FFBBFFBLRR
    \\FBBBBBBRLR
    \\BFFFBBBLLR
    \\FBBFBFBLRR
    \\FBFBFBFRLR
    \\FFBFBBBLRR
    \\FFFFBBBLRL
    \\FFFBBFFRLL
    \\FFFBFFFLRR
    \\BBFFFFBLLR
    \\BFBFBFFLLL
    \\FFBBBFFRLR
    \\FBBFBFBRLL
    \\FFBBBFBLLL
    \\FBBFFFBLLR
    \\BBFBFFBLRR
    \\BFFFFBBLLL
    \\FBBBFBFLLR
    \\FFBBBFFLRR
    \\BFFBBBFRRR
    \\FFBFFFBLRR
    \\FBBFFBBRLR
    \\BFBBFBFLRR
    \\FFFBBFFRRR
    \\FFBFFFFRLL
    \\FFFBFBFRRR
    \\FFBFFFFRRR
    \\FBBFBBBLRL
    \\FFFBFBBRLR
    \\FBBFFFBRLL
    \\FFBFBFFRLR
    \\FBBBBFFRRR
    \\BFBFFBBLRR
    \\FBFFBBBLRL
    \\FBBFBBFLLR
    \\BBFFFFFLRL
    \\BFBBFBFRLR
    \\BFFBFFBLRR
    \\FFBFFFBRLL
    \\FBFBFFBLLL
    \\BFFFFFBLLL
    \\FBFFBBFLLL
    \\BFBFFBBRLR
    \\FBFBBFBRLL
    \\FFBBFBBRLL
    \\BFFFBBBRLR
    \\BFFFFFFLRL
    \\BBFFFBBLLR
    \\BFBFBBFLRL
    \\FFBBBFFRRL
    \\BBFFFBFLLL
    \\BBFFBBBLLL
    \\BBFFBFBLLR
    \\FBFBBBFRLL
    \\FFBBBBBRRL
    \\FFBBBFFLLR
    \\FFBFBBBLRL
    \\BFFBFFBLRL
    \\BFFFBFFRRR
    \\BFBFFFBRRR
    \\FFFBBBFRLR
    \\FFBBFBBLLR
    \\BFFFBBFLRR
    \\FFBBBBFRRR
    \\BFBFBBFLRR
    \\FFFBBBBRRL
    \\BFBFFBFRLL
    \\FBFFBFFRLR
    \\FBBFFFFRLR
    \\BFBBBBBLRL
    \\FFBBFBBLLL
    \\FFBFBBFLLR
    \\BFFBBBBLRL
    \\BFBFFFFLRL
    \\BBFFFBFRRL
    \\FFBFFBBLRR
    \\FBFBFBFRRR
    \\BBFFFBFRLR
    \\BFBBBFFLRR
    \\BBFBFFBLLR
    \\BBFBBFBLLR
    \\FBFFFBFRLL
    \\BFBFBBBLLL
    \\FBBFBFFLRL
    \\BFFFBBBLRR
    \\BBFBFFBRRR
    \\FBBFFFFRLL
    \\BFFFBBBRRL
    \\FBBFBBBRRR
    \\FBBFFBFLLR
    \\BFFFFFBRRL
    \\FBFFFFBRLR
    \\FBFBFBBRRR
    \\FBFBFBFRLL
    \\BFFBFFFRRL
    \\FFFBBFFRRL
    \\BFBFFFBRLR
    \\FBBFBFFLRR
    \\BFFFBFBRRL
    \\FBFBBBFLLR
    \\FBFBBBFRRR
    \\FBFFBFBLRL
    \\FFFFBBBRRR
    \\FFBBBFFRRR
    \\FFFBFBFLLL
    \\BFBBFFBLRR
    \\FBBFBFBRRR
    \\BBFFBBFRRL
    \\BBFFBFFRRR
    \\BBFFBFFLRR
    \\FBBFFBBLRR
    \\BFBFFFFRRR
    \\BFFBFBBRLR
    \\BFFFBBFRLL
    \\BFBFBBBRLL
    \\BBFFFBBLRR
    \\FFBBFBFLRR
    \\FBFBBBFLLL
    \\BBFFBBBLLR
    \\FFBBFFFLRR
    \\FBFFFBFRRR
    \\BFBBFBBLLR
    \\FFBBFBFRLR
    \\BFBFFFFLLR
    \\FBBBFBFRRR
    \\BFBBFBFRRR
    \\BFFBFBFRRR
    \\FFBFBBBLLR
    \\FBFBFFFRLR
    \\FBBFBFBLLL
    \\BFFBBFFRLL
    \\FBBBBFBLLR
    \\FFFBBBFLLL
    \\BFBFBBFRLL
    \\FFFBFBFLRR
    \\FBBBBFBLLL
    \\FFBBFBFRLL
    \\BBFFBBFRRR
    \\FFBFFBFRLL
    \\FBFBFBBLLL
    \\FBFFBBBLLR
    \\FFFBFBBLRL
    \\FFFBBFBRRR
    \\FBFFBFFLRL
    \\FBBFBFBLLR
    \\BFBBBBFRLR
    \\FBBFBFBRLR
    \\FFFBFFBRRL
    \\FBFBBFBLLR
    \\BFFBFFFRLR
    \\FFBFBFBLRR
    \\BFBFBBBRRL
    \\FBFFFFFLRR
    \\FFFBBFFLLL
    \\BFFFBBFRLR
    \\FFBFFBFRLR
    \\BBFFFFBRLR
    \\BFFBFFBRLR
    \\BFBFBFBRLR
    \\FFBFFBBRLL
    \\FBBBFFBLLL
    \\BFBBBBBLLR
    \\BFFFFBFRLL
    \\FBBFFFBRRR
    \\FFFFBBBLLL
    \\FBFBFBBRRL
    \\FBFFFFFRLR
    \\FBFFBBFRRR
    \\BFFBBFFLRL
    \\BFBFBBBRRR
    \\FBBFBFFRLR
    \\BFFBBFBRRL
    \\BFBBFBFRRL
    \\FBFFFBBRRL
    \\FBBFFBBLLL
    \\FBFBFBBRLL
    \\BFFFFBFRRR
    \\FBBBFFBLLR
    \\FBBFBBBLRR
    \\FFBFBFFLLR
    \\FBFFBFFRLL
    \\FBBBFFBRLR
    \\FBFFBBBLLL
    \\FBFBFBFRRL
    \\BBFBBFBLLL
    \\FFBFBFFRRL
    \\FBBBFFFRRL
    \\FBFFBBFLRR
    \\FBFBFFFLLR
    \\BFFFFBBLRL
    \\BFBFBFFLRL
    \\FBFFFFBLLL
    \\FBBBFFFLRL
    \\BFFBBBBLLR
    \\BFFBBBFLLL
    \\BFFBBFBRRR
    \\FBBBFBFRLL
    \\BBFBFFFRRR
    \\BFBBBFFRLR
    \\FFBFBFBRRR
    \\FBFFBBFRLL
    \\FFFBBBBLLL
    \\FBFFBFBRRL
    \\BFFFFFBLLR
    \\BFBFFFBLLL
    \\FBFBBBBLLL
    \\BFFBBFFRRL
    \\BBFFBFBRRL
    \\FBBFBFFRRR
    \\BFBBFFBLLL
    \\BFBFFBBLRL
    \\BBFFFFFLLR
    \\FFBFBBFRLL
    \\FFBFFBFLLR
    \\FBBFFBBLRL
    \\BBFFFFBLLL
    \\BFFFBFFLLR
    \\FBFFFBFLLL
    \\BBFBFBFLLL
    \\FFBFFBBLRL
    \\FBFFBBBRLR
    \\BFFFFBBRRL
    \\FFBBBBBLLR
    \\FFBBFBFRRL
    \\FFBFBBFLRL
    \\FFBFBFFLRR
    \\FFFBFFBLLR
    \\BBFBFBBRLL
    \\BFBBBBBRRL
    \\FBFBBBFRLR
    \\FBFBFFFRLL
    \\BFFFFFFLLR
    \\FBBBBFFLLL
    \\FBBBFFBLRR
    \\BFFFBFBLRR
    \\FBBBFFFRLR
    \\BFFFFFBRLL
    \\FBBBBFBRRL
    \\BFBBBFBLRL
    \\FFBBFBBLRR
    \\BFFBBFBLLL
    \\BFBBFFFRRL
    \\FBBBBFFRRL
    \\BFFFBBFRRR
    \\FFFBFFFRRR
    \\FBFBBFBLRL
    \\BFBBFFBLRL
    \\BBFBBFBRLR
    \\BBFBBFBLRL
    \\FFBFBFFRRR
    \\BBFFBBFLLL
    \\FBBBFFBLRL
    \\FBBFFBBRRR
    \\BFFBFBFLLR
    \\FBFBFBBLRR
    \\BFFFBBBRRR
    \\FBBFBFFLLL
    \\FBFBBFFLRR
    \\FFBBFFBRLR
    \\FFBBBBBLRL
    \\FFBBBFBRRL
    \\BFBFBFBLRR
    \\FBFFFFFRLL
    \\BFBFBBFLLL
    \\BBFBFBBRRL
    \\FBFBFBFLLL
    \\FFBFFBBLLR
    \\FFFBFFFLLR
    \\BFFFBFBRLL
    \\FBBFFBBRLL
    \\FBBFBFFLLR
    \\BFFFFBFLLR
    \\BFFFFFBLRR
    \\BBFFFBFLRR
    \\FBFBBFFRLR
    \\BFBBFBFLLL
    \\BFFBBBFRLR
    \\BBFBFBBRLR
    \\FFBBFBFLLR
    \\BBFBFBFRRL
    \\FBFBFBBLRL
    \\FBFFFBBLRR
    \\FBFBBFFRRR
    \\BFFFFBFRLR
    \\FBFFFBFLLR
    \\FFBBBFFRLL
    \\FBFBFFFLRL
    \\BFFFBBFLLL
    \\FFFBBFBRLL
    \\FFBBBFFLLL
    \\BFBBFBFLLR
    \\FFBFBBFLLL
    \\BFFBBBBRRL
    \\BBFFBBBLRL
    \\FBFFFFBLRR
    \\BFBBFBBLRR
    \\BFBBBFBRRR
    \\BBFBFFFLLL
    \\BFFBBFFRLR
    \\BFFFBFFLRL
    \\FBBBBFFRLL
    \\FBFFBBFLLR
    \\FBFBFFFLLL
    \\BFFBBFFLRR
    \\FFBBFBBRRL
    \\BFBFBBFLLR
    \\FFFBBFBLRL
    \\FFBBFFFRRR
    \\BBFFFBFRRR
    \\FBBBBFFLRL
    \\FFFBFBBLLL
    \\FFFBBFFRLR
    \\FBFFFBBLRL
    \\BBFBFBFRLL
    \\BBFFBBBRLR
    \\FFFBBFBRLR
    \\BBFBBFFRLL
    \\BBFFFFFRLR
    \\BFBFBFBLLL
    \\BBFBFFFLLR
    \\FBFFBFBLLL
    \\BBFFFBBLLL
    \\FBFFFFBRLL
    \\BBFFFFBRLL
    \\FFBFFFBRRR
    \\BFFFFFFRLR
    \\BBFFBBFRLL
    \\BFBFFFBRRL
    \\FFBBBBFRLR
    \\FFBFFBFRRR
    \\BBFBFBFLRR
    \\FFBFFBFLRL
    \\BFBFBFFLLR
    \\FBBBBBFLLL
    \\FFBFFFBLLL
    \\FFBBBFBLRR
    \\FFFFBBFRRL
    \\FBFBBBFLRR
    \\BFFBBFFRRR
    \\FBFBBBFRRL
    \\BFFFFFBRRR
    \\BFBFBBFRRL
    \\BFBFBFBRLL
    \\BFBFFFFLLL
    \\FBBBBBFRRL
    \\BFBBBBFLRR
    \\BBFBBFFRRR
    \\BFFBFFFLLR
    \\BFBBFBBLLL
    \\FBFFFFBRRR
    \\FBFFFBFRLR
    \\BFFBFBBRLL
    \\FFBBBFBRRR
    \\FFBBFFFLLR
    \\BBFBBFFLLR
    \\BFBBFFBRLR
    \\FFFBBFFLRL
    \\BFFFFFFLLL
    \\FFBBFFFRLR
    \\BFFBFBFRLL
    \\FFBFFBBLLL
    \\BFFFBFFLRR
    \\FFBFFFFLRR
    \\FBBBBFBRLL
    \\BFBFFBFLLR
    \\FFBBFFBRRL
    \\BFFBBFBLRR
    \\FFBFFBFLRR
    \\BFFBFBBLLR
    \\FBBFBBFLLL
    \\FBFFBBBLRR
    \\BBFFBFFLLR
    \\BFBBBFFRRR
    \\FFFBFFFRRL
    \\FBBFBBBRRL
    \\FFFBFBBLLR
    \\BFFFBFFRLL
    \\BBFBFFBRRL
    \\FFBFFFFRRL
    \\FFBFBFBRLR
    \\FBBFBFFRLL
    \\FFFBBFBLLR
    \\FFFBBBFRRL
    \\FBBBBBFRLL
    \\BFFFBBFRRL
    \\BFBFBFBRRL
    \\FBBBBFFLRR
    \\FFFBBFBRRL
    \\BFFBBFBRLR
    \\BBFBFBBLLL
    \\FFBFFFFLLR
    \\FFBFFFFLRL
    \\FFFFBBBLRR
    \\BBFBBFBLRR
    \\FBBBFBFLRR
    \\FFFBFBBRLL
    \\FBFFBBFRLR
    \\FFBFBBFLRR
    \\FFFBFBFLRL
    \\FFFBBBBRLR
    \\FBBFBBBRLR
    \\FBFBFFBLRL
    \\BFBBBBFLRL
    \\BFFFFBBRRR
    \\BFFBBBFRRL
    \\BFFFFBBRLL
    \\BFBFBFFLRR
    \\BBFFBFBLRR
    \\FBBFBBFLRL
    \\FFFBFFFLLL
    \\FBBBBFBRRR
    \\FBFFFBBLLR
    \\FBBFFBBLLR
    \\FFBBFFFLLL
    \\FFBFBFFLLL
    \\FBFBFBFLRR
    \\BBFFFBFLLR
    \\BFFBBBBLRR
    \\FBBFFFBLRL
    \\FFFBFFBLRR
    \\BFBFBFBLLR
    \\FBFBBFFLRL
    \\BFBFBFFRLL
    \\FFBFBBBLLL
    \\FBFFBBBRRR
    \\FFBBFFFRRL
    \\FFBBFBBRRR
    \\FFBFFFBLRL
    \\BFBBBFFLRL
;