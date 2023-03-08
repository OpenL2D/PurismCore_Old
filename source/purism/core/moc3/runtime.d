/**
 * Runtime Data Structures
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

module purism.core.moc3.runtime;
import purism.core.moc3.header;
import purism.core.moc3.canvas;
import purism.core.moc3.sections;

private immutable uint runtimeMagic = 0x09E712D0; // 'OPENL2D0'

struct RuntimeSectionMap {
    CountInfoTable* countInfo;
    CanvasInfo* canvasInfo;
}

struct RuntimeMap {
	uint _magic = runtimeMagic;

    union {
        /** MOC3 base pointer. */
        ubyte* moc3Base;

        /** MOC3 header. */
        Header* header;
    }

    /** MOC3 data size in bytes. */
    uint moc3Size;

    RuntimeSectionMap sections;

	/*
        To remain compatible with Cubism Core (see purism.core.moc3.legacy),
        we use the reserved runtimeAddressMap space (after SectionOffsetTable).
        Because this involves a lot of pointer-filled hacks, we preface our
        RuntimeMap fields with a magic number to detect if an uninitialized
        MOC3 has been passed to us.

        Please note this is intended to prevent mistakes in API usage, not
        malicious attacks. Do not intentionally pass uninitialized MOC3 data
        to any legacy APIs unless otherwise stated.

        If you're using the modern API, we don't use runtimeAddressMap, and
        the sign() and check() functions will never be called, as this
        structure will be stored outside of the MOC3 data.
    */

    /** "Sign" structure with the runtimeMagic value. */
    void sign() @safe {
        this._magic = runtimeMagic;
    }

    /** Check validity of RuntimeMap structure. */
	bool check() @trusted {
		return this._magic == runtimeMagic;
	}

    /** Relocate RuntimeMap into MOC3 data's runtimeAddressMap space. */
    RuntimeMap* relocate() {
        RuntimeMap* dest = this.object!RuntimeMap(0x2c0);
        *dest = this;

        dest.sign();
        return dest;
    }

    /**
     * Safely slice MOC3 data.
     * Returns: a slice of MOC3 data, or null if out of bounds.
     */
    ubyte[] slice(uint offset, uint size) @trusted {
        if ((offset + size) > this.moc3Size) {
            return null;
        }

        return this.moc3Base[offset..size];
    }

    /**
     * Safely slice MOC3 data and cast to structure/object.
     * Returns: T*, or null if out of bounds.
     */
    T* object(T)(uint offset) @trusted {
        ubyte[] rawData = this.slice(offset, T.sizeof);
        return cast(T*)rawData;
    }
};

/* For compatibility with Cubism Core, RuntimeMap can only be at most
   1152 (0x480) bytes. */
static assert (RuntimeMap.sizeof <= 0x480);
