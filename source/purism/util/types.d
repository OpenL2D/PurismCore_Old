/**
 * Misc types
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

module purism.util.types;

alias bool32 = uint;

align(4) union XY {
    struct {
        float x, y;
    }
    float[2] raw;
}

align(4) union UV {
    struct {
        float u, v;
    }
    float[2] raw;
}
