/**
 * Runtime initialization for legacy core
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

module purism.core.legacy.runtime;
import core.runtime : Runtime;
import core.stdc.stdio : fprintf, stderr;
import core.stdc.stdlib : abort;
import purism.core.legacy.logging : psmLogf;
import purism.core.legacy.info : psmCompatVersion;

private struct RuntimeState {
    static bool initialized = false;

    static this() {
        RuntimeState.initialized = true;
    }
}

package void psmPanic(string msg) {
    fprintf(stderr, "[PurismCoreLegacy] panic: %.*s\n", cast(int) msg.length, msg.ptr);
    abort();
}

extern(C):

export void psmInitDRuntime() {
    if (RuntimeState.initialized) {
        return;
    }

    bool ok = Runtime.initialize();
    if (!ok) {
        psmPanic("failed to initialize D runtime");
    }

    if (!RuntimeState.initialized) {
        psmPanic("entered invalid state");
    }

    psmLogf("[PurismCoreLegacy] ready: compatible with %d.%d.%02d",
        (psmCompatVersion & 0xFF_00_0000) >> 24, (psmCompatVersion & 0x00_FF_0000) >> 16,
        (psmCompatVersion & 0x00_00_FFFF));
}
