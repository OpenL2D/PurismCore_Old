/**
 * Utility functions for safe memory access
 *
 * Copyright: (C) 2023 The OpenL2D Project Developers
 * License: FDPL-1.0-US
 *
 * This software is free software: you can redistribute and/or modify it
 * under the terms of the Free Development Public License version 1.0-US
 * as published at <https://freedevproject.org/fdpl-1.0-us>.
 *
 * This software is provided as is, without any warranty. See the license
 * for more details.
 */

module purism.util.safety;

/**
 * Safely slice an array. 
 * From D specification: "A program may not rely on array bounds checking
 * happening"; therefore, this function must be used.
 * Returns: T[], or null if out of bounds.
 */
T[] safeSlice(T)(T[] array, size_t bottom, size_t top) @trusted {
    if (bottom > array.length || top > array.length) {
        return null;
    }

    return array[bottom..top];
}

T[] safeSlice(T)(T[] array, size_t bottom) @trusted {
    return safeSlice(array, bottom, array.length);
}

const(T)[] safeSlice(T)(const(T)[] array, size_t bottom, size_t top) @trusted {
    if (bottom > array.length || top > array.length) {
        return null;
    }

    return array[bottom..top];
}

const(T)[] safeSlice(T)(const(T)[] array, size_t bottom) @trusted {
    return safeSlice(array, bottom, array.length);
}

/**
 * Safely reinterpret a ubyte[]'s data as T.
 * Returns: T*, or null if T is too big.
 */
T* safeBitCast(T)(ubyte[] array) @trusted {
    if (T.sizeof > array.length) {
        return null;
    }

    return cast(T*)&array.ptr;
}

const(T)* safeBitCast(T)(const(ubyte)[] array) @trusted {
    if (T.sizeof > array.length) {
        return null;
    }

    return cast(const(T)*)array.ptr;
}

/**
 * Safely store arbitrary data using a magic signature.
 */
struct Signed(T, uint magic) {
    uint _magic = magic;
    T _value;

    this(T value) {
        this._magic = magic;
        this._value = value;
    }

    void set(T value) { this._value = value; }
    T* get() { return this._value; }
    invariant { assert(this._magic == magic); }

    alias set this;

    static uint magic() { return magic; }
}
