/**
 * Logging functions for legacy core
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

module purism.core.legacy.logging;
import core.stdc.stdio : printf;
import std.format : format;
import std.string : toStringz;

alias LogFn = extern(C) void function(const(char)*);
__gshared private LogFn logFn = &psmiDefaultLogFunction;

void psmLog(string msg) {
    logFn(toStringz(msg));
}

void psmLogf(Char, Args...)(in Char[] fmt, Args args) {
    psmLog(format(fmt, args));
}

extern(C):

void psmiDefaultLogFunction(const(char)* msg) {
    printf("[PurismCoreLegacy] %s\n", msg);
}

export LogFn csmGetLogFunction() {
    return logFn;
}

export void csmSetLogFunction(LogFn fn) {
    logFn = fn;
}
