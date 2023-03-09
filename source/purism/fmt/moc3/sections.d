/**
 * MOC3 Section Offset Table structures
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

module purism.fmt.moc3.sections;
import std.bitmanip;
import purism.fmt.moc3.canvas;
import purism.fmt.moc3.header;
import purism.fmt.moc3.types;
import purism.util.types;

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

alias MOC3CountInfo = CountInfoTableV4;

struct DeformerOffsets {
    uint runtimeSpace0;
    uint ids;
    uint keyformBindingSourcesIndices;
    uint isVisible;
    uint isEnabled;
    uint parentPartIndices;
    uint parentDeformerIndices;
    uint types;
    uint specificSourcesIndices;
}

struct WarpDeformerOffsets {
    uint keyformBindingSourcesIndices;
    uint keyformSourcesBeginIndices;
    uint keyformSourcesCounts;
    uint vertexCounts;
    uint rows;
    uint columns;
}

struct RotationDeformerOffsets {
    uint keyformBindingSourcesIndices;
    uint keyformSourcesBeginIndices;
    uint keyformSourcesCounts;
    uint baseAngles;    
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
    uint runtimeSpace0;
    uint runtimeSpace1;
    uint runtimeSpace2;
    uint runtimeSpace3;
    uint ids;
    uint keyformBindingSourcesIndices;
    uint keyformSourcesBeginIndices;
    uint keyformSourcesCounts;
    uint isVisible;
    uint isEnabled;
    uint parentPartIndices;
    uint parentDeformerIndices;
    uint textureNos;
    uint drawableFlags;
    uint vertexCounts;
    uint uvSourcesBeginIndices;
    uint positionSourcesBeginIndices;
    uint positionSourcesCounts;
    uint drawableMaskSourcesBeginIndices;
    uint drawableMaskSourcesCounts;
}

struct ParameterOffsets {
    uint runtimeSpace0;
    uint ids;
    uint maxValues;
    uint minValues;
    uint defaultValues;
    uint isRepeat;
    uint decimalPlaces;
    uint parameterBindingSourcesBeginIndices;
    uint parameterBindingSourcesCounts;
}

struct PartKeyformOffsets {
    uint drawOrders;
}

struct WarpDeformerKeyformOffsets {
    uint opacities;
    uint keyformPositionSourcesBeginIndices;
}

struct RotationDeformerKeyformOffsets {
    uint opacities;
    uint angles;
    uint originX;
    uint originY;
    uint scales;
    uint isReflectX;
    uint isReflectY;
}

struct ArtMeshKeyformOffsets {
    uint opacities;
    uint drawOrders;
    uint keyformPositionSourcesBeginIndices;
}

struct KeyformPositionOffsets {
    uint xys;
}

struct ParameterBindingIndicesOffsets {
    uint bindingSourcesIndices;
}

struct KeyformBindingOffsets {
    uint parameterBindingIndexSourcesBeginIndices;
    uint parameterBindingIndexSourcesCounts;
}

struct ParameterBindingOffsets {
    uint keysSourcesBeginIndices;
    uint keysSourcesCounts;
}

struct KeyOffsets {
    uint values;
}

struct UVOffsets {
    uint uvs;
}

struct PositionIndicesOffsets {
    uint indices;
}

struct DrawableMaskOffsets {
    uint artMeshSourcesIndices;
}

struct DrawOrderGroupOffsets {
    uint objectSourcesBeginIndices;
    uint objectSourcesCounts;
    uint objectSourcesTotalCounts;
    uint maximumDrawOrders;
    uint minimumDrawOrders;
}

enum DrawOrderGroupObjectType : uint {
    ArtMesh,
    Part,
}

struct DrawOrderGroupObjectOffsets {
    uint types;
    uint indices;
    uint selfIndices;
}

struct GlueOffsets {
    uint runtimeSpace0;
    uint ids;
    uint keyformBindingSourcesIndices;
    uint keyformSourcesBeginIndices;
    uint keyformSourcesCounts;
    uint artMeshIndicesA;
    uint artMeshIndicesB;
    uint glueInfoSourcesBeginIndices;
    uint glueInfoSourcesCounts;
}

struct GlueInfoOffsets {
    uint weights;
    uint positionIndices;
}

struct GlueKeyformOffsets {
    uint intensities;
}

struct WarpDeformerKeyformOffsetsV3_3 {
    uint isQuadSource;
}

struct ParameterExtensionOffsets {
    uint runtimeSpace0;
    uint keysSourcesBeginIndices;
    uint keysSourcesCounts;
}

struct WarpDeformerKeyformOffsetsV4_2 {
    uint keyformColorSourcesBeginIndices;
}

struct RotationDeformerOffsetsV4_2 {
    uint keyformColorSourcesBeginIndices;
}

struct ArtMeshOffsetsV4_2 {
    uint keyformColorSourcesBeginIndices;
}

struct KeyformColorOffsets {
    uint R;
    uint G;
    uint B;
}

enum ParameterType : uint {
    Normal,
    BlendShape
}

struct ParameterOffsetsV4_2 {
    uint parameterTypes;
    uint blendShapeParameterBindingSourcesBeginIndices;
    uint blendShapeParameterBindingSourcesCounts;
}

struct BlendShapeParameterBindingOffsets {
    uint keysSourcesBeginIndices;
    uint keysSourcesCounts;
    uint baseKeyIndices;
}

struct BlendShapeKeyformBindingOffsets {
    uint parameterBindingSourcesIndices;
    uint blendShapeConstraintIndexSourcesBeginIndices;
    uint blendShapeConstraintIndexSourcesCounts;
    uint keyformSourcesBlendShapeIndices;
    uint keyformSourcesBlendShapeCounts;
}

struct BlendShapeOffsets {
    uint targetIndices;
    uint blendShapeKeyformBindingSourcesBeginIndices;
    uint blendShapeKeyformBindingSourcesCounts;
}

struct BlendShapeConstraintIndicesOffsets {
    uint blendShapeConstraintSourcesIndices;
}

struct BlendShapeConstraintOffsets {
    uint parameterIndices;
    uint blendShapeConstraintValueSourcesBeginIndices;
    uint blendShapeConstraintValueSourcesCounts;
}

struct BlendShapeConstraintValueOffsets {
    uint keys;
    uint weights;
}

union MOC3SectionOffsets {
    struct Parts {
        @(ubyte[]) uint runtimeSpace0;
        @(MOC3ID) uint ids;
        @(int[]) uint keyformBindingSourcesIndices;
        @(int[]) uint keyformSourcesBeginIndices;
        @(int[]) uint keyformSourcesCounts;
        @(bool32[]) uint isVisible;
        @(bool32[]) uint isEnabled;
        @(int[]) uint parentPartIndices;
    }

    struct {
        @(MOC3CountInfo) uint countInfo;
        @(MOC3CanvasInfo) uint canvasInfo;

        Parts parts;
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
    ubyte[640] rawBytes;
    uint[160] rawOffsets;
}

static assert (MOC3SectionOffsets.sizeof == 640);
