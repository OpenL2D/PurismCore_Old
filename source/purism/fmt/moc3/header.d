/**
 * MOC3 Header Structures
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

module purism.fmt.moc3.header;
import purism.fmt.moc3.errors;

/** MOC3 magic: 'MOC3' */
immutable ubyte[4] moc3Magic = ['M', 'O', 'C', '3'];

enum MOC3Version : ubyte {
    unknown,  /** Unknown or invalid version. */
    V3_00_00, /** Version 3.0.00+ */
    V3_03_00, /** Version 3.3.00+ */
    V4_00_00, /** Version 4.0.00+ */
    V4_02_00, /** Version 4.2.00+ */
};

immutable MOC3Version
    minMOC3Version = MOC3Version.V3_00_00,
    maxMOC3Version = MOC3Version.V4_02_00;

union MOC3Header {
    struct {
        /** MOC3 magic */
        ubyte[4] magic = moc3Magic;

        /** MOC3 version. */
        MOC3Version version_;

        /** MOC3 endianness */
        bool isBigEndian;
    }
    ubyte[64] rawData;

    const MOC3Error verify() @safe {
        if (this.magic != moc3Magic)
            return MOC3Error.invalidMagic;

        if (this.version_ == MOC3Version.unknown)
            return MOC3Error.invalidVersion;

        if (this.version_ > maxMOC3Version)
            return MOC3Error.unsupportedVersion;

        return MOC3Error.success;
    }
}

static assert (MOC3Header.sizeof == 64);
