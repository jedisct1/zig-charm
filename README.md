# charm

A tiny, self-contained cryptography library, implementing authenticated encryption and keyed hashing.

Charm was especially designed for memory-constrained devices, but can also be used to add encryption support to WebAssembly modules with minimal overhead.

Hashing and authenticated encryption operations can be freely chained using a unique rolling state.
In this mode, each authentication tag authenticates the whole transcript since the beginning of the session.

The [original implementation](https://github.com/jedisct1/charm) was written in C and is used by the [dsvpn](https://github.com/jedisct1/dsvpn) VPN software.

This is a port to the [Zig](https://ziglang.org) language.
