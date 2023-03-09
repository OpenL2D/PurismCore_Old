/**
 * MOC3 errors
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

module purism.fmt.moc3.errors;

enum MOC3Error : uint {
    success,
    unknown,
    invalidMagic,
    invalidVersion,
    unsupportedVersion,
}

immutable string[MOC3Error.max + 1] moc3ErrorStrings = [
    "Success",
    "Unknown error",
    "Invalid MOC3 magic",
    "Invalid MOC3 version",
    "Unsupported MOC3 version"
];

string toString(MOC3Error error) {
    return error < moc3ErrorStrings.length ? moc3ErrorStrings[error]
                                           : "Unknown error(?)";
}

class MOC3Exception : Exception {
    this(string msg, string file = __FILE__, size_t line = __LINE__) {
        super("MOC3: Error: " ~ msg, file, line);
    }

    this(MOC3Error error, string file = __FILE__, size_t line = __LINE__) {
        this(error.toString(), file, line);
    }
}
