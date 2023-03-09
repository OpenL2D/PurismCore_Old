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

module purism.fmt.moc3.layout;
import purism.fmt.moc3.header;
import purism.fmt.moc3.sections;

struct MOC3Layout {
    MOC3Header header;
    MOC3SectionOffsets sections;
    ubyte[1152] runtimeMap;
}
