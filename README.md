# charm

A tiny, self-contained cryptography library, implementing authenticated encryption and keyed hashing.

Charm was especially designed for memory-constrained devices, but can also be used to add encryption support to WebAssembly modules with minimal overhead.

Hashing and authenticated encryption operations can be freely chained using a unique rolling state.
In this mode, each authentication tag authenticates the whole transcript since the beginning of the session.

The [original implementation](https://github.com/jedisct1/charm) was written in C and is used by the [dsvpn](https://github.com/jedisct1/dsvpn) VPN software.

This is a port to the [Zig](https://ziglang.org) language.

## Usage

### Setting up a session

Charm requires a 256-bit key, and, if the key is reused for different sessions, a unique session identifier (`nonce`):

```zig
var key: [Charm.key_length]u8 = undefined;
try std.crypto.randomBytes(&key);

var charm = Charm.new(key, null);
```

### Hashing

```zig
const h = charm.hash("data");
```

### Authenticated encryption

#### Encryption

```zig
const tag = charm.encrypt(msg[0..]);
```

Encrypts `msg` in-place and returns a 128-bit authentication tag.

#### Decryption

Starting from the same state as the one used for encryption:

```zig
try charm.decrypt(msg[0..], tag);
```

Returns `error.AuthenticationFailed` if the authentication tag is invalid for the given message and the previous transcript.

## Security guarantees

128-bit security, no practical limits on the size and length of messages.
