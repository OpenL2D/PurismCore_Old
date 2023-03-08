/**
 * MOC3 Section Table Structures
 *
 * Copyright: (C) 2023 The OpenL2D Project Developers
 * License: FDPL-1.0-US
 *
 * This software is free software: you can redistribute and/or modify it
 * under the terms of the Free Development Public License version 1.0-US
 * as published at .
 *
 * This software is provided as is, without any warranty. See the license
 * for more details.
 */

module purism.core.moc3.sections;
import std.bitmanip;
import purism.core.moc3.header;
import purism.core.moc3.canvas;
import purism.core.moc3.misc;

template offset(T) {
    alias offset = uint;
}

/* All versions */
struct CountInfoTableV1 {
    uint parts;
    uint deformers;
    uint warpDeformers;
    uint rotationDeformers;
    uint artMeshes;
    uint parameters;
    uint partKeyforms;
    uint warpDeformerKeyforms;
    uint rotationDeformerKeyforms;
    uint artMeshKeyforms;
    uint keyformPositions;
    uint parameterBindingIndices;
    uint keyformBindings;
    uint parameterBindings;
    uint keys;
    uint uvs;
    uint positionIndices;
    uint drawableMasks;
    uint drawOrderGroups;
    uint drawOrderGroupObjects;
    uint glue;
    uint glueInfo;
    uint glueKeyforms;
}

/* Version 4.2.00+ only */
struct CountInfoTableV4 {
    CountInfoTableV1 _v1;

    uint keyformMultiplyColors;
    uint keyformScreenColors;
    uint blendShapeParameterBindings;
    uint blendShapeKeyformBindings;
    uint blendShapesWarpDeformers;
    uint blendShapesArtMeshes;
    uint blendShapeConstraintIndices;
    uint blendShapeConstraints;
    uint blendShapeConstraintValues;

    alias _v1 this;
}

alias CountInfoTable = CountInfoTableV4;

struct PartOffsets {
    offset!ubyte[] runtimeSpace0;
    offset!ID[] ids;
    offset!int[] keyformBindingSourcesIndices;
    offset!int[] keyformSourcesBeginIndices;
    offset!int[] keyformSourcesCounts;
    offset!bool32[] isVisible;
    offset!bool32[] isEnabled;
    offset!int[] parentPartIndices;
}

struct DeformerOffsets {
    offset!ubyte[] runtimeSpace0;
    offset!ID[] ids;
    offset!int[] keyformBindingSourcesIndices;
    offset!bool32[] isVisible;
    offset!bool32[] isEnabled;
    offset!int[] parentPartIndices;
    offset!int[] parentDeformerIndices;
    offset!uint[] types;
    offset!int[] specificSourcesIndices;
}

struct WarpDeformerOffsets {
    offset!int[] keyformBindingSourcesIndices;
    offset!int[] keyformSourcesBeginIndices;
    offset!int[] keyformSourcesCounts;
    offset!int[] vertexCounts;
    offset!uint[] rows;
    offset!uint[] columns;
}

struct RotationDeformerOffsets {
    offset!int[] keyformBindingSourcesIndices;
    offset!int[] keyformSourcesBeginIndices;
    offset!int[] keyformSourcesCounts;
    offset!float[] baseAngles;    
}

enum BlendMode : uint {
    Normal,
    Additive,
    Multiplicative
}

align(1) union DrawableFlags {
    struct {
        mixin(bitfields!(
            BlendMode, "blendMode", 2,
            bool, "isDoubleSided", 1,
            bool, "isInverted", 1,
            uint, "unknown", 4
        ));
    }
    ubyte rawValue;
}

static assert(DrawableFlags.sizeof == 1);

struct ArtMeshOffsets {
    offset!ubyte[] runtimeSpace0;
    offset!ubyte[] runtimeSpace1;
    offset!ubyte[] runtimeSpace2;
    offset!ubyte[] runtimeSpace3;
    offset!ID[] ids;
    offset!int[] keyformBindingSourcesIndices;
    offset!int[] keyformSourcesBeginIndices;
    offset!int[] keyformSourcesCounts;
    offset!bool32[] isVisible;
    offset!bool32[] isEnabled;
    offset!int[] parentPartIndices;
    offset!int[] parentDeformerIndices;
    offset!uint[] textureNos;
    offset!DrawableFlags[] drawableFlags;
    offset!int[] vertexCounts;
    offset!int[] uvSourcesBeginIndices;
    offset!int[] positionSourcesBeginIndices;
    offset!int[] positionSourcesCounts;
    offset!int[] drawableMaskSourcesBeginIndices;
    offset!int[] drawableMaskSourcesCounts;
}

struct ParameterOffsets {
    offset!void[] runtimeSpace0;
    offset!ID[] ids;
    offset!float[] maxValues;
    offset!float[] minValues;
    offset!float[] defaultValues;
    offset!bool32[] isRepeat;
    offset!uint[] decimalPlaces;
    offset!int[] parameterBindingSourcesBeginIndices;
    offset!int[] parameterBindingSourcesCounts;
}

struct PartKeyformOffsets {
    offset!float[] drawOrders;
}

struct WarpDeformerKeyformOffsets {
    offset!float[] opacities;
    offset!int[] keyformPositionSourcesBeginIndices;
}

struct RotationDeformerKeyformOffsets {
    offset!float[] opacities;
    offset!float[] angles;
    offset!float[] originX;
    offset!float[] originY;
    offset!float[] scales;
    offset!bool32[] isReflectX;
    offset!bool32[] isReflectY;
}

struct ArtMeshKeyformOffsets {
    offset!float[] opacities;
    offset!float[] drawOrders;
    offset!int[] keyformPositionSourcesBeginIndices;
}

struct KeyformPositionOffsets {
    offset!XY[] xys;
}

struct ParameterBindingIndicesOffsets {
    offset!int[] bindingSourcesIndices;
}

struct KeyformBindingOffsets {
    offset!int[] parameterBindingIndexSourcesBeginIndices;
    offset!int[] parameterBindingIndexSourcesCounts;
}

struct ParameterBindingOffsets {
    offset!int[] keysSourcesBeginIndices;
    offset!int[] keysSourcesCounts;
}

struct KeyOffsets {
    offset!float[] values;
}

struct UVOffsets {
    offset!UV[] uvs;
}

struct PositionIndicesOffsets {
    offset!short[] indices;
}

struct DrawableMaskOffsets {
    offset!int[] artMeshSourcesIndices;
}

struct DrawOrderGroupOffsets {
    offset!int[] objectSourcesBeginIndices;
    offset!int[] objectSourcesCounts;
    offset!int[] objectSourcesTotalCounts;
    offset!uint[] maximumDrawOrders;
    offset!uint[] minimumDrawOrders;
}

enum DrawOrderGroupObjectType : uint {
    ArtMesh,
    Part,
}

struct DrawOrderGroupObjectOffsets {
    offset!DrawOrderGroupObjectType[] types;
    offset!int[] indices;
    offset!int[] selfIndices;
}

struct GlueOffsets {
    offset!void[] runtimeSpace0;
    offset!ID[] IDs;
    offset!int[] keyformBindingSourcesIndices;
    offset!int[] keyformSourcesBeginIndices;
    offset!int[] keyformSourcesCounts;
    offset!int[] artMeshIndicesA;
    offset!int[] artMeshIndicesB;
    offset!int[] glueInfoSourcesBeginIndices;
    offset!int[] glueInfoSourcesCounts;
}

struct GlueInfoOffsets {
    offset!float[] weights;
    offset!short[] positionIndices;
}

struct GlueKeyformOffsets {
    offset!float[] intensities;
}

struct WarpDeformerKeyformOffsetsV3_3 {
    offset!bool32[] isQuadSource;
}

struct ParameterExtensionOffsets {
    offset!void[] runtimeSpace0;
    offset!int[] keysSourcesBeginIndices;
    offset!int[] keysSourcesCounts;
}

struct WarpDeformerKeyformOffsetsV4_2 {
    offset!int[] keyformColorSourcesBeginIndices;
}

struct RotationDeformerOffsetsV4_2 {
    offset!int[] keyformColorSourcesBeginIndices;
}

struct ArtMeshOffsetsV4_2 {
    offset!int[] keyformColorSourcesBeginIndices;
}

struct KeyformColorOffsets {
    offset!float[] R;
    offset!float[] G;
    offset!float[] B;
}

enum ParameterType : uint {
    Normal,
    BlendShape
}

struct ParameterOffsetsV4_2 {
    offset!ParameterType[] parameterTypes;
    offset!int[] blendShapeParameterBindingSourcesBeginIndices;
    offset!int[] blendShapeParameterBindingSourcesCounts;
}

struct BlendShapeParameterBindingOffsets {
    offset!int[] keysSourcesBeginIndices;
    offset!int[] keysSourcesCounts;
    offset!int[] baseKeyIndices;
}

struct BlendShapeKeyformBindingOffsets {
    offset!int[] parameterBindingSourcesIndices;
    offset!int[] blendShapeConstraintIndexSourcesBeginIndices;
    offset!int[] blendShapeConstraintIndexSourcesCounts;
    offset!int[] keyformSourcesBlendShapeIndices;
    offset!int[] keyformSourcesBlendShapeCounts;
}

struct BlendShapeOffsets {
    offset!int[] targetIndices;
    offset!int[] blendShapeKeyformBindingSourcesBeginIndices;
    offset!int[] blendShapeKeyformBindingSourcesCounts;
}

struct BlendShapeConstraintIndicesOffsets {
    offset!int[] blendShapeConstraintSourcesIndices;
}

struct BlendShapeConstraintOffsets {
    offset!int[] parameterIndices;
    offset!int[] blendShapeConstraintValueSourcesBeginIndices;
    offset!int[] blendShapeConstraintValueSourcesCounts;
}

struct BlendShapeConstraintValueOffsets {
    offset!float[] keys;
    offset!float[] weights;
}

struct SectionOffsetTable {
    offset!CountInfoTable countInfo;
    offset!CanvasInfo canvasInfo;

    PartOffsets parts;
    DeformerOffsets deformers;
    WarpDeformerOffsets warpDeformers;
    RotationDeformerOffsets rotationDeformers;
    ArtMeshOffsets artMeshes;
    ParameterOffsets parameters;
    PartKeyformOffsets partKeyforms;
    WarpDeformerKeyformOffsets warpDeformerKeyforms;
    RotationDeformerKeyformOffsets rotationDeformerKeyforms;
    ArtMeshKeyformOffsets artMeshKeyforms;
    KeyformPositionOffsets keyformPositions;
    ParameterBindingIndicesOffsets parameterBindingIndices;
    KeyformBindingOffsets keyformBindings;
    ParameterBindingOffsets parameterBindings;
    KeyOffsets keys;
    UVOffsets UVs;
    PositionIndicesOffsets positionIndices;
    DrawableMaskOffsets drawableMasks;
    DrawOrderGroupOffsets drawOrderGroups;
    DrawOrderGroupObjectOffsets drawOrderGroupObjects;
    GlueOffsets glue;
    GlueInfoOffsets glueInfo;
    GlueKeyformOffsets glueKeyforms;

    // Version 3.3.00+ only
    WarpDeformerKeyformOffsetsV3_3 warpDeformersV3_3;

    // Version 4.2.00+ only
    ParameterExtensionOffsets parameterExtensions;
    WarpDeformerKeyformOffsetsV4_2 warpDeformersV4_2;
    RotationDeformerOffsetsV4_2 rotationDeformersV4_2;
    ArtMeshOffsetsV4_2 artMeshesV4_2;
    KeyformColorOffsets keyformMultiplyColors;
    KeyformColorOffsets keyformScreenColors;
    ParameterOffsetsV4_2 parameterOffsetsV4_2;
    BlendShapeParameterBindingOffsets blendShapeParameterBindings;
    BlendShapeKeyformBindingOffsets blendShapeKeyformBindings;
    BlendShapeOffsets blendShapesWarpDeformers;
    BlendShapeOffsets blendShapesArtMeshes;
    BlendShapeConstraintIndicesOffsets blendShapeConstraintIndices;
    BlendShapeConstraintOffsets blendShapeConstraints;
    BlendShapeConstraintValueOffsets blendShapeConstraintValues;
}
