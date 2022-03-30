const std = @import("std");
const debug = std.debug;
const mem = std.mem;
const random = std.crypto.random;
const Charm = @import("main.zig").Charm;

test "encrypt and hash in a session" {
    var key: [Charm.key_length]u8 = undefined;
    var nonce: [Charm.nonce_length]u8 = undefined;

    random.bytes(&key);
    random.bytes(&nonce);

    const msg1_0 = "message 1";
    const msg2_0 = "message 2";
    var msg1 = msg1_0.*;
    var msg2 = msg2_0.*;

    var charm = Charm.new(key, nonce);
    const tag1 = charm.encrypt(msg1[0..]);
    const tag2 = charm.encrypt(msg2[0..]);
    const h = charm.hash(msg1_0);

    charm = Charm.new(key, nonce);
    try charm.decrypt(msg1[0..], tag1);
    try charm.decrypt(msg2[0..], tag2);
    const hx = charm.hash(msg1_0);

    debug.assert(mem.eql(u8, msg1[0..], msg1_0[0..]));
    debug.assert(mem.eql(u8, msg2[0..], msg2_0[0..]));
    debug.assert(mem.eql(u8, h[0..], hx[0..]));
}
