/**
 * MOC3 legacy API functions
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

module purism.core.legacy.moc3;
import purism.core.legacy.logging;
import purism.core.legacy.runtime;
import purism.fmt.moc3.errors : MOC3Error, toString;
import purism.fmt.moc3.header : MOC3Header, MOC3Version;
import purism.util.safety;

private immutable moc3RuntimeMapMagic = 0x0C34A13E;

extern(C):

struct csmMoc;

export MOC3Version csmGetMocVersion(const(ubyte)* ptr, uint size) {
    auto data = ptr[0..size];
    auto header = data.safeBitCast!MOC3Header;

    auto err = header.verify();
    if (err != MOC3Error.success) {
        psmLog(err.toString());
        return MOC3Version.unknown;
    }

    return header.version_;
}

export csmMoc* csmReviveMocInPlace(ubyte* ptr, uint size) {
    psmInitDRuntime();
    auto data = ptr[0..size];

    // TODO: revive stuff

    return cast(csmMoc*)ptr;
}
