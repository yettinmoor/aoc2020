const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const ans = solve(input);
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{ans});
}

fn solve(map: []const u8) u16 {
    var trees: u16 = 0;
    var x: usize = 0;
    var it = std.mem.split(map, "\n");
    // Skip first
    _ = it.next();
    while (it.next()) |row| {
        x = (x + 3) % row.len;
        trees += @boolToInt(row[x] == '#');
    }
    return trees;
}

test "test input" {
    const test_input =
        \\..##.......
        \\#...#...#..
        \\.#....#..#.
        \\..#.#...#.#
        \\.#...##..#.
        \\..#.##.....
        \\.#.#.#....#
        \\.#........#
        \\#.##...#...
        \\#...##....#
        \\.#..#...#.#
    ;
    const ans = solve(test_input);
    std.testing.expect(ans == 7);
}

const input =
    \\.##......#.##..#..#..##....#...
    \\...##.....#...###........###...
    \\#....##....#.....#.....#..##.##
    \\.......#.###.#......#..#..#..#.
    \\##..........#....#.#...#.......
    \\###.#.#.#......##...#..........
    \\.#.##........#..............#..
    \\..#..........#...##..#.......##
    \\.........##...#...#....###.#...
    \\#.......#.....#.#.#...###.##.#.
    \\...#...#...#......#........#.##
    \\....#..........#.....#..#....##
    \\.#.#.##....#.#...#.............
    \\#....#..#.....#.#..............
    \\........#....#....#..#........#
    \\..#.......#...#....##.#........
    \\......#.........##.......#.#...
    \\............#.......#..........
    \\.....#..#.#..#........##...#...
    \\....#.....................###..
    \\..#.......#.........#..##....##
    \\..#........#..#...#........#...
    \\..............#....##..##....#.
    \\....#..#.#.......#....#..#...##
    \\.#........##......#.#..#.#.....
    \\............#.##...##...#...##.
    \\.......#........#.........##...
    \\...#...........#.#...#..#......
    \\#...#............#..####.......
    \\..#..#..#..#.....#...#.#.#.....
    \\....#.#..............#.....##..
    \\#.....##........#......#.......
    \\.....#..#................##.#..
    \\.###.#...................#.....
    \\....#....#...#.##..........#...
    \\.#.....#....#.......#...#......
    \\.....#...#.##.##............#..
    \\..........#..#....#...#.#..#...
    \\#...#..#..............###.#...#
    \\......#....#.#....##....#......
    \\............#......#......##...
    \\.#....#...#........#.#.#..#....
    \\..#.....#.......#.....#.#......
    \\#....#......#.......#......#...
    \\....#..##.....#...#........#...
    \\.#..#......#..#................
    \\.#...#...#....#.#...#.....#...#
    \\......#..#...#...#..#.......##.
    \\...#..#...#.#.......#.......#..
    \\..#...#.........#......#......#
    \\......#...#..#..........#......
    \\.#..#......#....#.#.#...#....#.
    \\.#.#....#.#.#..#..#..#........#
    \\....###.#...##..#.#..#....#....
    \\...#.#.#................#......
    \\.#.....#..#..........##..#....#
    \\..........#..#......#.........#
    \\.....#....#...#.#..##....#.#.#.
    \\........#.##......###..........
    \\##......#.#..#.....#..##.#.....
    \\.#.......#..#....##.....##.....
    \\.....##....#...................
    \\##......#....##........#.....#.
    \\..##...#...........##........#.
    \\...#....#..##.#....#......##...
    \\#....#...##....#..........#....
    \\......##....#...............#..
    \\...#.#.#...#...#...#...........
    \\....#..#...#.#....#.#......#...
    \\.......#...#...............#...
    \\.##..#....#...#....#.#........#
    \\.....#..##............#......#.
    \\...##...#.....#..........#.#..#
    \\..#..##.............#....#.....
    \\.....#.#.....#.........#......#
    \\........#..........#.#.#...#..#
    \\#........#.#...................
    \\......#......##..............#.
    \\......#..#.#.....#...#.#...#...
    \\.#..##.....#...##.......#......
    \\#.......#....#..##....#..#.#...
    \\#..#..#....#...........#.##....
    \\..##....#....##.....#...#...##.
    \\.#.......#.......#....#.......#
    \\.#..#..#...#...#...............
    \\.#..............#.....#........
    \\..........##...#....#.#......##
    \\..........#..........#.......#.
    \\..#..##....##...#.......#......
    \\.#......#.#........##.#........
    \\...#......#..#....#...#....#...
    \\...............#....#..#.##...#
    \\....#.......................#..
    \\#....##.#......#....#..........
    \\.......#.#......#........#..##.
    \\..#.....#...#...........##..#..
    \\#........#.#....#............#.
    \\.........##..................#.
    \\........#...#..#...#......#...#
    \\...#.......#...####.#...#......
    \\....#..###......###..#.........
    \\.....#...........#......#......
    \\.#.....#......#.....#.....##.##
    \\.#.#...##..........#........#.#
    \\..#....#.....##...............#
    \\.....##.....#...##..#..........
    \\.#......##.......#..##.##.#...#
    \\.#..#...#.##.....#.#...........
    \\.........#....##...#.....##....
    \\#..........#.............#..#.#
    \\...........#........#.#...#....
    \\........#..###...#...........#.
    \\#.........#...#....#..##.##....
    \\........#....##.......#.#....#.
    \\..........#..............#.....
    \\....##...#...##..........#.....
    \\...#..##.#...###..#............
    \\...##..#####....#.............#
    \\.#..#.......##.......#........#
    \\....##..........#.......#.#....
    \\......#.........####.......#...
    \\...............#......#..#.....
    \\...#...##...#.#.#.....##.#.#...
    \\..#....#..#..............#....#
    \\#..............#............#..
    \\.#.#..#....#.....#.#.#...#.....
    \\......#......#..#..#.....#.....
    \\.#.#..#.##.#........#..........
    \\..##.#......#..#.......#.......
    \\.##...##....#..#.#.........#.##
    \\.........#........#.#..###....#
    \\.....#...............#.........
    \\......##..........#.....#......
    \\.#.....#.#.#..#.#.....#..#.####
    \\.......###.##......#.....#.#..#
    \\..#.....#....#.#.##......#....#
    \\.....##..#................#..##
    \\.#......#.....#..#.....#..#####
    \\.........#.#.......#..##...#...
    \\.#.#..#.......##.....#....#....
    \\.....#...###.#...#......#....#.
    \\.#....#....#...#..#.#........#.
    \\......##........##.#...#..#..#.
    \\.##.##.###..#.....#........###.
    \\.....#..#.#.......#..#.#.......
    \\##.#.#..............#..##......
    \\....#.........#.......#.#......
    \\.....#..#.....#...#.#....#.#...
    \\...#..#.#.#..................#.
    \\........##.#.###...............
    \\..#...#.#.......#......#.......
    \\.......#.##....#...#....#......
    \\......#.#.............#........
    \\........#......#........##.##..
    \\.....#...#......##.............
    \\...#.#..#.....#.#...#..........
    \\.#.#..#.....#............#.....
    \\.#.#..#.#.##.#...#.##..##...#..
    \\.........##........#.##..#.....
    \\##.#.#......###..#.##.#........
    \\.##...#..#...#.#..#....##.....#
    \\#......#..........#.#...#.....#
    \\..........#......#...#.......#.
    \\.............#..........#......
    \\#.#....#.......##..#.....#.#...
    \\##......#..#......#.#..#.#....#
    \\..#.#..#.....#.#......#....#..#
    \\...#......#......##.....#..#.#.
    \\....#......#.....#....#.#.#..#.
    \\.....#..#..#.....#...........##
    \\....#.....#...#........##.#.#.#
    \\..#......#.......#........#....
    \\#.......##..##......#...####..#
    \\#..........#......#.#..#..#....
    \\.................##............
    \\...#..#..#.#.....#.##.#.....#.#
    \\...#....###....................
    \\....#.......#..#.#.............
    \\#......#................#......
    \\..........#........#..#........
    \\.....#......##..#......#..###..
    \\...#....#.......#..............
    \\.#....#.#.#........#.....#...#.
    \\.......#.....##.#.....#....#...
    \\.........#.#.........##..#...#.
    \\......#......#....#.....##.#.#.
    \\####...#.........#.....#......#
    \\...#.#..#..#.............#.....
    \\......#.........#....#.#..##..#
    \\.........#.....#.#..##..##..#..
    \\.#......##.............#.......
    \\....#...#......#...#.....#.#.##
    \\......#..##....#..#.....#......
    \\......#..............#....##...
    \\.........#.###..........#.##...
    \\#....#..........#..#.......#...
    \\...........#...#.....#.......#.
    \\..#..#........#................
    \\...###.........#...............
    \\.....#.##...#.................#
    \\..#.#..#...###......#........#.
    \\#......#......#.#.............#
    \\.........#.#.....#..#........#.
    \\........#..#......#......##....
    \\.....#......#...#.....##...#.##
    \\.##...#..#....##..........###..
    \\.......#............#........##
    \\.##.....#.......#...#..........
    \\..###..........#.............##
    \\#....#....#.#....#............#
    \\#...#......................#...
    \\....#..#..#..#.......###....#..
    \\#..###.#..#.....#.............#
    \\..........#.##.....#.........##
    \\...#.............#....#....##..
    \\#........................#..#..
    \\........#...#.....#.....#..##..
    \\#........#......#....#..#....#.
    \\.....#.#.#....#.#..#....#......
    \\.....#....#....................
    \\.........#..#..#....#......#...
    \\..........#.#.#.......#........
    \\.......#.#.....#..#.....##.....
    \\.....#....#.#.....#.......#..#.
    \\.#..###.......#......#..#..#...
    \\..##.#.....#.........##.#......
    \\.....#.......###.......##......
    \\#...#.......##.#.#......#.....#
    \\.##........##.#...#...#........
    \\....#.......#....#..#.......#..
    \\.#..#.......#..####..##........
    \\..#..#..#..#..#..#.............
    \\...#......#...#...#.#......##.#
    \\........#.#..#.#.#......#...#..
    \\#.......#..##.......##........#
    \\..##...#...............#.#....#
    \\.####........##..........#..#..
    \\..#........#...##...#........#.
    \\.#.#..........#...#...#........
    \\....###..........#....#........
    \\.#.#.#.###.#.##..#.#........#..
    \\..........#....##.#..##........
    \\.......#..#..##.......#........
    \\..#........#....#..####.#..#...
    \\....#.......#..##..#..........#
    \\.....#...........#....#....#...
    \\.#.##..#......##.........#.#...
    \\...#......##..##......#.....#..
    \\#........#..........#.#...#....
    \\.#.#........###........#..#....
    \\....#####.................##...
    \\.........##...#......#.........
    \\.......#....#....#.#....#...#..
    \\......#................#...#.#.
    \\....#.....#.....#.#.....#.....#
    \\#.........#..#........#.....#..
    \\....#...........#.....#.#......
    \\##..#....................#.#...
    \\#.#.##....#.....##....#.......#
    \\..#..#....###.......#..##......
    \\......##.....#.##...#....#..#..
    \\........#..#.#..#..#.#.........
    \\#...#.....##..........##.......
    \\....#.....#...#.###.......#....
    \\..........#..#...#........##..#
    \\##..#...#.#.####.#..#..#...#...
    \\................#......#..#....
    \\.......#...###...#........#....
    \\....#..##..#.#......#...#.#..##
    \\.##......#...........#.......##
    \\....#.#...#..#.#.......##......
    \\....#..##..#.....#........##...
    \\...#...#..#.#.#....#.........#.
    \\#....##.#....#..##.............
    \\.#......##......#.#.##.......#.
    \\.......#...#....#.##......#....
    \\..##..........#.....#.#......#.
    \\#..##.....#..........##..#.#...
    \\....#.#.......#.#.....#.....#..
    \\##.....#..#.....##...#.....#..#
    \\...#.#..#...#..............#...
    \\...............#..#............
    \\.#.......#......#........##....
    \\..#......#..##..####.....#...#.
    \\.#.##.#.#..#..##..##...........
    \\...##.............#.....#..#...
    \\.##.....#..#.#......##........#
    \\##....#.............#...#......
    \\......#.....###...........##...
    \\.#.#...#.............##..#..###
    \\..#.##.##...#.....#...........#
    \\.....#.....##...#...#........#.
    \\........#..##.......##.....#...
    \\.#........####.......#.#...#...
    \\...#..........#......##........
    \\.......#......#..##..#...#.....
    \\..#...........#.#.#..#.#.#.....
    \\#..........#....#....###.#.....
    \\....#.................#...##...
    \\#....#.###......#..#.....#...##
    \\.#.......##.....###.....#...#..
    \\....##............#...........#
    \\...#.#.#.........#...#..#..#..#
    \\.....#..###.................#..
    \\.#.....#.....#....###.#..#...#.
    \\................#...#..........
    \\..#....#..##....#.##........#..
    \\....##....#...........#..#.....
    \\...##......###.......#...#.....
    \\.......##............#......#.#
    \\#####.....#..#.###..#.#........
    \\#.##.##..#.......#....#........
    \\....###..#.#.#......###.#......
    \\....#....#.....##.#..#....#...#
    \\....#.....#.#...##.##.#.#....#.
    \\.........#.#.###.#.....#.......
    \\.#....#.......#..##...#....#...
    \\...####...##.#.....#...........
    \\#.....#.....#..........##..#...
    \\................#.#.#......#...
    \\.#...#.......#..#............#.
    \\.##.#.......#..#....#.....#....
    \\.#...#..#.....#..............#.
;
