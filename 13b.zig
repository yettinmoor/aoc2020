const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const ans = solve(input);
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{ans});
}

fn solve(data: []const u8) !usize {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = &gpa.allocator;

    var it = std.mem.split(data, "\n");
    _ = it.next().?;

    const buses = blk: {
        var buses = std.ArrayList(?usize).init(allocator);
        var bus_it = std.mem.split(it.next().?, ",");
        while (bus_it.next()) |bus| {
            const id = std.fmt.parseInt(usize, bus, 10) catch null;
            try buses.append(id);
        }
        break :blk buses.toOwnedSlice();
    };

    var timestamp: usize = 0;
    var increase: usize = 1;
    var i: usize = 0;

    // https://en.wikipedia.org/wiki/Chinese_remainder_theorem
    while (true) : (timestamp += increase) {
        const bus = buses[i].?;
        const wait_time = timestamp % bus;
        const wanted_wait_time = (bus - i % bus) % bus;
        if (wait_time == wanted_wait_time) {
            i += for (buses[i + 1 ..]) |next_bus, j| {
                if (next_bus) |_| break j + 1;
            } else return timestamp;
            increase *= bus;
        }
    }
}

test "my test" {
    const test_input =
        \\xxx
        \\7,13,15
    ;
    const ans = try solve(test_input);
    std.testing.expect(ans == 1078);
}

test "test input" {
    const test_input =
        \\939
        \\7,13,x,x,59,x,31,19
    ;
    const ans = try solve(test_input);
    std.testing.expect(ans == 1068781);
}

const input =
    \\1001171
    \\17,x,x,x,x,x,x,41,x,x,x,37,x,x,x,x,x,367,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,613,x,x,x,x,x,x,x,x,x,x,x,x,13
;
