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
    const timestamp = try std.fmt.parseInt(usize, it.next().?, 10);

    var buses = std.ArrayList(usize).init(allocator);
    var bus_it = std.mem.split(it.next().?, ",");
    while (bus_it.next()) |bus| {
        const id = std.fmt.parseInt(usize, bus, 10) catch continue;
        try buses.append(id);
    }

    var wait_time: usize = std.math.maxInt(usize);
    var bus_id: usize = 0;
    for (buses.items) |bus| {
        const this_wait_time = bus - timestamp % bus;
        if (this_wait_time < wait_time) {
            wait_time = this_wait_time;
            bus_id = bus;
        }
    }
    return bus_id * wait_time;
}

test "test input" {
    const test_input =
        \\939
        \\7,13,x,x,59,x,31,19
    ;
    const ans = try solve(test_input);
    std.testing.expect(ans == 295);
}

const input =
    \\1001171
    \\17,x,x,x,x,x,x,41,x,x,x,37,x,x,x,x,x,367,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,613,x,x,x,x,x,x,x,x,x,x,x,x,13
;
