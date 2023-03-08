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

module purism.core.moc3.header;

immutable ubyte[4] moc3Magic = ['M', 'O', 'C', '3'];

enum Version : ubyte {
    Unknown,  /** Unknown or invalid version. */
    V3_00_00, /** Version 3.0.00+ */
    V3_03_00, /** Version 3.3.00+ */
    V4_00_00, /** Version 4.0.00+ */
    V4_02_00, /** Version 4.2.00+ */
};

struct Header {
    /** MOC3 magic: 'MOC3' */
    ubyte[4] magic = moc3Magic;

    /** MOC3 version. */
    Version version_;

    /** MOC3 endianness */
    bool isBigEndian;

    /** Check header magic. */
    bool checkMagic() {
        return this.magic == moc3Magic;
    }

    /** Check header version. */
    bool checkVersion() {
        return this.version_ > 0 && this.version_ <= Version.V4_02_00;
    }
}

union PaddedHeader {
    ubyte[0x40] _padding;
    Header _header;

    alias _header this;
}

static assert (PaddedHeader.sizeof == 0x40);
