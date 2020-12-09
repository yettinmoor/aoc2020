const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const ans = try run(program);
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{ans});
}

/// Return value of `acc` before first rerun op
fn run(comptime code: []const u8) !isize {
    const op_count = comptime blk: {
        @setEvalBranchQuota(5 * code.len / 2);
        var op_count: usize = 1;
        for (code) |c| {
            if (c == '\n') {
                op_count += 1;
            }
        }
        break :blk op_count;
    };

    var ops = [_]Operation{undefined} ** op_count;
    {
        var i: usize = 0;
        var it = std.mem.split(code, "\n");
        while (it.next()) |code_line| : (i += 1) {
            const op = try Operation.read(code_line);
            ops[i] = op;
        }
    }

    const OpFlags = std.meta.Int(.unsigned, op_count);
    const OpIndex = std.math.Log2Int(OpFlags);

    outer: for (ops) |op_to_change, index| {
        // Switch NOP <-> JMP
        switch (op_to_change.operator) {
            .nop => ops[index].operator = .jmp,
            .jmp => ops[index].operator = .nop,
            .acc => continue,
        }
        defer switch (op_to_change.operator) {
            .nop => ops[index].operator = .nop,
            .jmp => ops[index].operator = .jmp,
            .acc => unreachable,
        };
        var i: usize = 0;
        var acc: isize = 0;
        var ops_run: OpFlags = 0;
        while (i < op_count) {
            const op_flag = @as(OpFlags, 1) << @intCast(OpIndex, i);
            if (ops_run & op_flag != 0) {
                continue :outer;
            }
            ops_run |= op_flag;
            const op = ops[i];
            switch (op.operator) {
                .nop => {},
                .acc => acc += op.arg,
                .jmp => {
                    i = if (op.arg >= 0) i + @intCast(usize, op.arg) else (i - @intCast(usize, -op.arg));
                    continue;
                },
            }
            i += 1;
        }
        return acc;
    } else unreachable;
}

const Operation = struct {
    operator: Operator,
    arg: isize,

    const Operator = enum {
        nop,
        acc,
        jmp,
    };

    fn read(code: []const u8) !Operation {
        var it = std.mem.split(code, " ");
        const operator_txt = it.next().?;
        const arg_txt = it.next().?;
        const operator = inline for (std.meta.fields(Operator)) |field| {
            if (std.mem.eql(u8, field.name, operator_txt)) {
                break @field(Operator, field.name);
            }
        } else unreachable;
        return Operation{
            .operator = operator,
            .arg = try std.fmt.parseInt(isize, arg_txt, 10),
        };
    }
};

test "test program" {
    const test_program =
        \\nop +0
        \\acc +1
        \\jmp +4
        \\acc +3
        \\jmp -3
        \\acc -99
        \\acc +1
        \\jmp -4
        \\acc +6
    ;
    const ans = try run(test_program);
    std.testing.expect(ans == 8);
}

const program =
    \\acc +22
    \\acc +34
    \\jmp +167
    \\acc +46
    \\acc +25
    \\acc -10
    \\acc +11
    \\jmp +540
    \\acc +0
    \\jmp +242
    \\acc +26
    \\acc +46
    \\jmp +242
    \\jmp +287
    \\acc -8
    \\acc +30
    \\acc +3
    \\nop +350
    \\jmp +471
    \\acc +2
    \\acc +0
    \\acc +14
    \\jmp +207
    \\jmp +1
    \\acc -10
    \\acc +12
    \\jmp +281
    \\acc +18
    \\jmp +515
    \\acc -18
    \\acc +33
    \\jmp +379
    \\acc +48
    \\acc +38
    \\jmp +220
    \\acc +44
    \\nop +546
    \\acc +21
    \\jmp +537
    \\acc +33
    \\nop +224
    \\nop +379
    \\jmp +2
    \\jmp -30
    \\jmp +246
    \\acc -14
    \\acc -3
    \\jmp +410
    \\acc +50
    \\nop +323
    \\acc +2
    \\acc +24
    \\jmp +25
    \\jmp +372
    \\acc +29
    \\acc +15
    \\nop +34
    \\jmp +531
    \\acc +48
    \\acc -3
    \\acc -18
    \\acc -13
    \\jmp -30
    \\acc +7
    \\jmp +444
    \\acc +47
    \\jmp -3
    \\jmp +1
    \\nop +514
    \\jmp +39
    \\jmp +434
    \\acc +0
    \\acc +11
    \\acc +12
    \\acc -17
    \\jmp +142
    \\jmp +367
    \\acc -18
    \\nop +69
    \\acc -12
    \\jmp +16
    \\jmp +39
    \\nop +486
    \\acc +16
    \\jmp +1
    \\jmp -72
    \\jmp +1
    \\jmp +1
    \\nop +355
    \\jmp -7
    \\acc +1
    \\acc -12
    \\acc +12
    \\jmp +131
    \\acc +35
    \\jmp +74
    \\acc +9
    \\acc +26
    \\acc -14
    \\jmp -60
    \\acc +20
    \\acc +40
    \\acc +22
    \\acc +24
    \\jmp +209
    \\acc +43
    \\jmp +347
    \\jmp +346
    \\acc +0
    \\jmp +348
    \\acc +18
    \\jmp -79
    \\acc -11
    \\acc -16
    \\acc +7
    \\jmp +192
    \\acc +40
    \\acc +20
    \\nop -6
    \\jmp -7
    \\acc -18
    \\jmp +395
    \\nop +219
    \\acc -18
    \\jmp -53
    \\acc +22
    \\nop -1
    \\nop +29
    \\jmp +468
    \\acc +42
    \\acc +7
    \\acc +3
    \\acc +46
    \\jmp -8
    \\acc +29
    \\acc -18
    \\acc +17
    \\acc +41
    \\jmp +272
    \\jmp +222
    \\acc -10
    \\acc +32
    \\acc -14
    \\jmp -38
    \\acc +49
    \\acc +40
    \\jmp +97
    \\nop +375
    \\acc +19
    \\acc +45
    \\jmp -45
    \\jmp +195
    \\acc +19
    \\jmp +330
    \\acc +38
    \\jmp +7
    \\acc +40
    \\nop +150
    \\acc +19
    \\jmp +406
    \\acc +9
    \\jmp -49
    \\acc -3
    \\jmp +176
    \\acc +2
    \\nop +20
    \\acc +25
    \\nop +349
    \\jmp -129
    \\acc +27
    \\nop +301
    \\acc +37
    \\jmp +271
    \\acc +3
    \\acc +10
    \\acc +26
    \\acc +49
    \\jmp +58
    \\nop +151
    \\jmp +72
    \\acc -1
    \\acc +32
    \\acc -11
    \\acc -7
    \\jmp +155
    \\jmp +1
    \\acc +44
    \\acc +2
    \\jmp -140
    \\acc +13
    \\acc +46
    \\acc -3
    \\jmp -58
    \\jmp +174
    \\acc +0
    \\acc -18
    \\acc +25
    \\jmp -178
    \\acc -19
    \\acc +37
    \\acc +0
    \\acc +49
    \\jmp +366
    \\acc +17
    \\acc +9
    \\acc +25
    \\jmp -37
    \\jmp +328
    \\acc +50
    \\jmp +81
    \\acc +1
    \\acc +43
    \\acc +30
    \\jmp +80
    \\acc +17
    \\acc +43
    \\jmp +234
    \\acc +43
    \\nop +271
    \\acc -11
    \\jmp +331
    \\nop +335
    \\acc +43
    \\jmp -160
    \\acc +27
    \\acc +34
    \\jmp -74
    \\nop +73
    \\jmp -11
    \\acc -18
    \\jmp -118
    \\acc +23
    \\acc +19
    \\nop -108
    \\jmp +73
    \\acc +25
    \\acc -19
    \\acc +23
    \\acc -7
    \\jmp -77
    \\acc +0
    \\acc +1
    \\jmp +233
    \\jmp +1
    \\jmp +1
    \\acc +7
    \\jmp +248
    \\acc +0
    \\acc -17
    \\acc +19
    \\jmp -15
    \\acc +10
    \\jmp +273
    \\jmp +88
    \\acc +40
    \\acc +35
    \\jmp +1
    \\acc +38
    \\jmp +241
    \\acc -2
    \\acc +36
    \\acc -1
    \\acc +18
    \\jmp +78
    \\nop +58
    \\acc -9
    \\acc +38
    \\acc +44
    \\jmp +307
    \\acc +10
    \\acc +30
    \\jmp -163
    \\acc -16
    \\acc +29
    \\acc -19
    \\jmp -185
    \\jmp +167
    \\nop +52
    \\jmp -251
    \\acc +31
    \\acc -14
    \\jmp +186
    \\nop +1
    \\acc +42
    \\acc +9
    \\jmp -160
    \\acc +10
    \\acc +43
    \\acc +14
    \\jmp -177
    \\acc -16
    \\jmp +265
    \\jmp -158
    \\acc -15
    \\jmp +152
    \\acc +22
    \\acc +1
    \\acc +40
    \\jmp +1
    \\jmp +252
    \\acc -19
    \\acc -1
    \\jmp -109
    \\acc +11
    \\acc -3
    \\acc +8
    \\jmp +16
    \\acc +39
    \\acc +12
    \\acc +24
    \\jmp -154
    \\acc +6
    \\jmp -156
    \\jmp +119
    \\acc +18
    \\jmp +1
    \\jmp -44
    \\acc -13
    \\jmp +79
    \\acc +9
    \\nop +262
    \\jmp +56
    \\nop +50
    \\acc -4
    \\acc +36
    \\acc +12
    \\jmp -54
    \\acc -2
    \\jmp -77
    \\acc +11
    \\acc +3
    \\acc +38
    \\jmp -185
    \\acc +28
    \\jmp -44
    \\jmp +54
    \\acc +39
    \\nop +18
    \\jmp -84
    \\jmp +132
    \\jmp -301
    \\acc +12
    \\jmp -334
    \\acc -19
    \\acc -10
    \\jmp -55
    \\acc +24
    \\acc +40
    \\acc -18
    \\jmp +212
    \\jmp +70
    \\acc -4
    \\nop +173
    \\jmp +67
    \\jmp +66
    \\acc +44
    \\acc +8
    \\jmp +236
    \\acc +47
    \\acc +29
    \\jmp -21
    \\jmp +143
    \\acc +22
    \\acc +37
    \\acc +37
    \\acc +25
    \\jmp -339
    \\jmp +1
    \\nop +200
    \\acc +25
    \\jmp +208
    \\jmp +93
    \\acc -1
    \\acc -13
    \\acc +30
    \\jmp -321
    \\jmp -268
    \\acc +14
    \\jmp -311
    \\acc +1
    \\acc +20
    \\acc +41
    \\jmp -128
    \\jmp -173
    \\acc -10
    \\acc +41
    \\acc +25
    \\acc +38
    \\jmp +137
    \\nop -99
    \\acc +47
    \\acc -3
    \\acc -9
    \\jmp -259
    \\acc +0
    \\acc +40
    \\jmp +126
    \\acc +48
    \\acc -4
    \\acc +23
    \\jmp -136
    \\nop +103
    \\acc +27
    \\jmp -149
    \\acc +39
    \\jmp -323
    \\acc -13
    \\jmp +1
    \\nop -79
    \\jmp -342
    \\acc +36
    \\nop +9
    \\acc -15
    \\acc -19
    \\jmp -216
    \\acc +27
    \\acc -17
    \\nop +72
    \\acc +3
    \\jmp -142
    \\jmp -357
    \\acc +39
    \\acc -18
    \\acc -2
    \\jmp -361
    \\acc +26
    \\acc -15
    \\acc +21
    \\jmp +1
    \\jmp +21
    \\nop +20
    \\jmp +77
    \\acc +36
    \\acc +6
    \\acc +32
    \\jmp -295
    \\jmp +63
    \\acc -15
    \\nop -371
    \\jmp -196
    \\acc +27
    \\acc +36
    \\jmp -152
    \\acc +43
    \\jmp +149
    \\jmp +85
    \\nop -57
    \\acc +8
    \\jmp -241
    \\jmp -206
    \\acc +5
    \\jmp -282
    \\jmp -344
    \\acc +24
    \\acc +12
    \\jmp -138
    \\jmp -31
    \\acc +4
    \\acc +27
    \\jmp -224
    \\acc +16
    \\acc +42
    \\acc +24
    \\jmp -316
    \\acc +41
    \\jmp +10
    \\jmp -403
    \\jmp -90
    \\nop -79
    \\acc +2
    \\jmp +19
    \\acc +42
    \\acc +12
    \\jmp -9
    \\jmp +104
    \\acc -9
    \\acc -11
    \\jmp -299
    \\acc +19
    \\acc +7
    \\acc -11
    \\acc -7
    \\jmp -335
    \\acc +24
    \\jmp -80
    \\acc +45
    \\acc +39
    \\acc +18
    \\jmp -348
    \\acc +5
    \\acc -5
    \\jmp -94
    \\acc +35
    \\jmp -221
    \\acc -3
    \\jmp -112
    \\acc +10
    \\acc +23
    \\jmp +18
    \\nop -53
    \\jmp -315
    \\acc +12
    \\acc +19
    \\jmp -426
    \\jmp -175
    \\acc +40
    \\acc +25
    \\jmp +23
    \\nop -14
    \\nop +79
    \\acc +21
    \\jmp -301
    \\acc +22
    \\acc -10
    \\jmp +1
    \\jmp +15
    \\acc +27
    \\jmp -409
    \\acc +45
    \\nop -341
    \\acc +22
    \\jmp -89
    \\jmp +60
    \\acc +11
    \\jmp -461
    \\acc +39
    \\acc -11
    \\acc +10
    \\jmp -173
    \\jmp -447
    \\nop +38
    \\acc +5
    \\jmp -65
    \\acc +45
    \\jmp -217
    \\acc +1
    \\acc -7
    \\nop -460
    \\acc +45
    \\jmp -468
    \\nop -477
    \\acc +0
    \\jmp -270
    \\jmp -230
    \\acc +36
    \\acc +21
    \\jmp -21
    \\jmp -225
    \\acc -11
    \\jmp +1
    \\jmp -511
    \\jmp -4
    \\acc -5
    \\acc -4
    \\acc -15
    \\jmp -204
    \\jmp -62
    \\acc +50
    \\acc +34
    \\acc +32
    \\jmp -489
    \\nop -108
    \\jmp -125
    \\acc -2
    \\jmp -187
    \\nop +1
    \\jmp -284
    \\jmp -285
    \\acc +43
    \\acc -1
    \\jmp -293
    \\nop -49
    \\acc -14
    \\acc +25
    \\jmp -233
    \\nop -53
    \\jmp -456
    \\jmp -226
    \\acc +39
    \\jmp -244
    \\acc +16
    \\jmp -82
    \\acc +17
    \\acc +47
    \\acc +16
    \\jmp -244
    \\nop -87
    \\jmp -150
    \\jmp -99
    \\jmp +1
    \\acc -9
    \\acc +48
    \\jmp -515
    \\acc -1
    \\jmp -546
    \\jmp -191
    \\acc -16
    \\acc +27
    \\nop -369
    \\acc -7
    \\jmp +1
;
