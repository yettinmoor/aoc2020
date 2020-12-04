const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const ans = solve(input);
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{ans});
}

fn solve(map: []const u8) u32 {
    var ans: u32 = 1;

    // Down 1, right `dx`
    const dxs = [_]usize{
        1, 3, 5, 7,
    };
    for (dxs) |dx| {
        var trees: u32 = 0;
        var it = std.mem.split(map, "\n");
        var x: usize = 0;
        // Skip first
        _ = it.next();
        while (it.next()) |row| {
            x = (x + dx) % row.len;
            trees += @boolToInt(row[x] == '#');
        }
        ans *= trees;
    }

    // Down 2, right 1
    {
        var trees: u32 = 0;
        var it = std.mem.split(map, "\n");
        var x: usize = 0;
        // Skip first two
        _ = it.next();
        _ = it.next();
        while (it.next()) |row| {
            x = (x + 1) % row.len;
            trees += @boolToInt(row[x] == '#');
            _ = it.next();
        }
        ans *= trees;
    }

    return ans;
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
    std.testing.expect(ans == 336);
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
