/**
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

module purism.core.moc3.canvas;

struct CanvasInfo {
    float pixelsPerUnit; /** Pixels per unit. */
    float originX; /** X Origin. */
    float originY; /** Y Origin. */
    float canvasWidth; /** Canvas Width. */
    float canvasHeight; /** Canvas Height. */
    ubyte canvasFlags; /** Canvas flags. */
}
