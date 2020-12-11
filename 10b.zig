const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const ans = solve(input);
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{ans});
}

fn solve(adapters_txt: []const u8) !u128 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = &gpa.allocator;

    var adapters = std.ArrayList(u16).init(allocator);
    try adapters.append(0);

    var it = std.mem.split(adapters_txt, "\n");
    while (it.next()) |adapter_txt| {
        const adapter = try std.fmt.parseInt(u16, adapter_txt, 10);
        try adapters.append(adapter);
    }

    std.sort.sort(u16, adapters.items, {}, comptime std.sort.asc(u16));

    var steps = try allocator.alloc(u128, adapters.items.len);
    steps[0] = 1;
    for (steps[1..]) |step, i_off| {
        const i = i_off + 1;
        const adapter = adapters.items[i];
        steps[i] = steps[i - 1];
        if (i >= 2 and adapter - adapters.items[i - 2] <= 3) {
            steps[i] += steps[i - 2];
        }
        if (i >= 3 and adapter - adapters.items[i - 3] <= 3) {
            steps[i] += steps[i - 3];
        }
    }
    return steps[steps.len - 1];
}

test "test input" {
    const test_input =
        \\28
        \\33
        \\18
        \\42
        \\31
        \\14
        \\46
        \\20
        \\48
        \\47
        \\24
        \\23
        \\49
        \\45
        \\19
        \\38
        \\39
        \\11
        \\1
        \\32
        \\25
        \\35
        \\8
        \\17
        \\7
        \\9
        \\4
        \\2
        \\34
        \\10
        \\3
    ;
    const ans = try solve(test_input);
    print("{}\n", .{ans});
    std.testing.expect(ans == 19208);
}

const input =
    \\2
    \\49
    \\78
    \\116
    \\143
    \\42
    \\142
    \\87
    \\132
    \\86
    \\67
    \\44
    \\136
    \\82
    \\125
    \\1
    \\108
    \\123
    \\46
    \\37
    \\137
    \\148
    \\106
    \\121
    \\10
    \\64
    \\165
    \\17
    \\102
    \\156
    \\22
    \\117
    \\31
    \\38
    \\24
    \\69
    \\131
    \\144
    \\162
    \\63
    \\171
    \\153
    \\90
    \\9
    \\107
    \\79
    \\7
    \\55
    \\138
    \\34
    \\52
    \\77
    \\152
    \\3
    \\158
    \\100
    \\45
    \\129
    \\130
    \\135
    \\23
    \\93
    \\96
    \\103
    \\124
    \\95
    \\8
    \\62
    \\39
    \\118
    \\164
    \\172
    \\75
    \\122
    \\20
    \\145
    \\14
    \\112
    \\61
    \\43
    \\141
    \\30
    \\85
    \\101
    \\151
    \\29
    \\113
    \\94
    \\68
    \\58
    \\76
    \\97
    \\28
    \\111
    \\128
    \\21
    \\11
    \\163
    \\161
    \\4
    \\168
    \\157
    \\27
    \\72
;
