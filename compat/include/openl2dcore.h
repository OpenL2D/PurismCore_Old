/*
 * Copyright (C) 2023 The OpenL2D Project Developers
 *
 * This software is free software: you can redistribute and/or modify it
 * under the terms of the Free Development Public License version 1.0-US
 * as published at <https://freedevproject.org/fdpl-1.0-us>.
 *
 * This software is provided as is, without any warranty. See the license
 * for more details.
 */

/**
 * This file contains definitions compatible with Live2D Cubism Core, for
 * backward-compatibility purposes. This contents of this file are not copied
 * or edited from the official header provided by Live2D Inc.
 */

#ifndef OPENL2DCORE_H
#define OPENL2DCORE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

#if !defined(csmApi)
#  if defined(psmApi)
#    define csmApi psmApi
#  else
#    define csmApi
#  endif
#endif

#if !defined(psmApi) && defined(csmApi)
#  define psmApi csmApi
#endif

#if !defined(csmCallingConvention)
#  if defined(psmCallingConvention)
#    define csmCallingConvention psmCallingConvention
#  else
#    define csmCallingConvention
#  endif
#endif

#if !defined(psmCallingConvention) && defined(csmCallingConvention)
#  define psmCallingConvention csmCallingConvention
#endif

/** MOC3 data. */
typedef struct csmMoc csmMoc;

/** Model. */
typedef struct csmModel csmModel;

/** OpenL2D Core version identifier. */
typedef uint32_t csmVersion;

/** Required alignment for MOC3 data. */
#define csmAlignofMoc 0x40

/** Required alignment for models. */
#define csmAlignofModel 0x10

/** Blend modes specified in drawable flags. */
enum {
  /*** Normal blend mode. */
  csmBlendNormal         = 0x0,

  /*** Additive blend mode. */
  csmBlendAdditive       = 0x1,

  /*** Multiplicative blend mode. */
  csmBlendMultiplicative = 0x2
};

/** Bit masks for drawable flags. */

/** Double-sided mask. */
#define csmIsDoubleSided        0x4

/** Inverted clipping mask. */
#define csmIsInvertedMask       0x8

/** Bitfield for flags. */
typedef uint8_t csmFlags;

/** MOC3 file format version. */
enum {
  /** Unknown/invalid version. */
  csmMocVersion_Unknown = 0,
  /** MOC3 File Version 3.0.00 */
  csmMocVersion_30      = 1,
  /** MOC3 File Version 3.3.00 */
  csmMocVersion_33      = 2,
  /** MOC3 File Version 4.0.00 */
  csmMocVersion_40      = 3,
  /** MOC3 File Version 4.2.00 */
  csmMocVersion_42      = 4
};

/** MOC3 version identifier. */
typedef uint8_t csmMocVersion;

/** Parameter types. */
enum {
  csmParameterType_Normal     = 0,
  csmParameterType_BlendShape = 1
};

/** Parameter type. */
typedef int32_t csmParameterType;

/** Two component vector. */
typedef struct {
  float X, Y;
} csmVector2;

/** Four component vector. */
typedef struct {
  float X, Y, Z, W;
} csmVector4;

/**
 * Log handler.
 *
 * @param message NUL-terminated string containing the message to log.
 */
typedef void (*csmLogFunction)(const char* msg);

/**
 * Retrieve OpenL2D Core version.
 *
 * @return  OpenL2D Core version.
 */
csmApi csmVersion csmCallingConvention csmGetVersion();

/**
 * Retrieve latest MOC3 version supported.
 *
 * @return  Latest supported MOC3 version.
 */
csmApi csmMocVersion csmCallingConvention csmGetLatestMocVersion();

/**
 * Retrieve MOC3 file format version.
 *
 * @param data  Pointer to MOC3 data.
 * @param size  Size of MOC3 data.
 *
 * @return MOC3 version.
 */
csmApi csmMocVersion csmCallingConvention csmGetMocVersion(const void* data, const uint32_t size);

/**
 * Retrieves registered log handler.
 *
 * @return Log handler.
 */
csmApi csmLogFunction csmCallingConvention csmGetLogFunction();

/**
 * Registers log handler.
 *
 * @param handler  Log handler.
 */
csmApi void csmCallingConvention csmSetLogFunction(csmLogFunction handler);

/**
 * Attempt to revive a MOC3 file in place.
 *
 * @param data  Pointer to data of unrevived MOC3. The MOC3 data must be aligned to `csmAlignofMoc` bytes.
 * @param size  Size of MOC3 data.
 *
 * @return Valid pointer if successful; else NULL.
 */
csmApi csmMoc* csmCallingConvention csmReviveMocInPlace(void* data, const uint32_t size);

/**
 * Retrieve size of a model in bytes.
 *
 * @param moc  Revived MOC3.
 *
 * @return Non-zero size if successful; else 0.
 */
csmApi uint32_t csmCallingConvention csmGetSizeofModel(const csmMoc* moc);

/**
 * Attempt to initialize a model in place.
 *
 * @param moc   Revived MOC3.
 * @param buf   Buffer to store initialized model data. Must be aligned to `csmAlignofModel` bytes.
 * @param size  Size of the buffer.
 *
 * @return  Pointer to initialized model if successful; else NULL.
 */
csmApi csmModel* csmCallingConvention csmInitializeModelInPlace(const csmMoc* moc,
                                                                void* buf,
                                                                const uint32_t size);

/**
 * Updates a model's state.
 *
 * @param model  Model to update.
 */
csmApi void csmCallingConvention csmUpdateModel(csmModel* model);

/**
 * Retrieve info about a model's canvas.
 *
 * @param model              Model.
 * @param outSizeInPixels    Canvas dimensions.
 * @param outOriginInPixels  Origin of model on canvas.
 * @param outPixelsPerUnit   Aspect used for scaling pixels to units.
 */
csmApi void csmCallingConvention csmReadCanvasInfo(const csmModel* model,
                                                   csmVector2* outSizeInPixels,
                                                   csmVector2* outOriginInPixels,
                                                   float* outPixelsPerUnit);

/**
 * Retrieve number of parameters.
 *
 * @param model Model to retrieve parameters from.
 *
 * @return  Non-negative count if successful; else -1.
 */
csmApi int32_t csmCallingConvention csmGetParameterCount(const csmModel* model);

/**
 * Retrieve parameter IDs.
 * All IDs are NUL-terminated UTF-8 strings.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array of NUL-terminated ID strings if successful; else NULL.
 */
csmApi const char** csmCallingConvention csmGetParameterIds(const csmModel* model);

/**
 * Retrieve parameter types.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array of parameter types if successful; else NULL.
csmApi const csmParameterType* csmCallingConvention csmGetParameterTypes(const csmModel* model);

/**
 * Retrieve parameter minimum values.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array of parameter minimum values if successful; else NULL.
 */
csmApi const float* csmCallingConvention csmGetParameterMinimumValues(const csmModel* model);

/**
 * Retrieve parameter maximum values.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array of parameter maximum values if successful; else NULL.
 */
csmApi const float* csmCallingConvention csmGetParameterMaximumValues(const csmModel* model);

/**
 * Retrieve parameter default values.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array of parameter default values if successful; else NULL.
 */
csmApi const float* csmCallingConvention csmGetParameterDefaultValues(const csmModel* model);

/**
 * Retrieve pointer to mutable parameter values.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array of current parameter values if successful; else NULL.
 */
csmApi float* csmCallingConvention csmGetParameterValues(csmModel* model);

/**
 * Retrieve number of key values of each parameter.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array with the number of key values of each parameter if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetParameterKeyCounts(const csmModel* model);

/**
 * Retrieve key values of each parameter.
 *
 * @param model  Model to retrieve parameters from.
 *
 * @return  Pointer to array with the key values of each parameter if successful; else NULL.
 */
csmApi const float** csmCallingConvention csmGetParameterKeyValues(const csmModel* model);

/**
 * Retrieve number of parts.
 *
 * @param model  Model to retrieve parts from.
 *
 * @return  Non-negative count if successful; else -1.
 */
csmApi int32_t csmCallingConvention csmGetPartCount(const csmModel* model);

/**
 * Retrieve part IDs.
 * All part IDs are NUL-terminated UTF-8 strings.
 *
 * @param model  Model to retrieve parts from.
 *
 * @return  Pointer to array of part IDs if successful; else NULL.
 */
csmApi const char** csmCallingConvention csmGetPartIds(const csmModel* model);

/**
 * Retrieve pointer to mutable part opacities.
 *
 * @param model  Model to retrieve parts from.
 *
 * @return  Pointer to array of current part opacities if successful; else NULL.
 */
csmApi float* csmCallingConvention csmGetPartOpacities(csmModel* model);

/**
 * Retrieve parent part index of each part.
 *
 * @param model  Model to retrieve parts from.
 *
 * @return  Pointer to array of parent part indices if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetPartParentPartIndices(const csmModel* model);

/**
 * Retrieve number of drawables.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Non-negative count if successful; else -1.
 */
csmApi int32_t csmCallingConvention csmGetDrawableCount(const csmModel* model);

/**
 * Retrieve drawable IDs.
 * All IDs are NUL-terminated UTF-8 strings.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of drawable IDs if successful; else NULL.
 */
csmApi const char** csmCallingConvention csmGetDrawableIds(const csmModel* model);

/**
 * Retrieve constant drawable flags.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of drawable flags if successful; else NULL.
 */
csmApi const csmFlags* csmCallingConvention csmGetDrawableConstantFlags(const csmModel* model);

/**
 * Retrieve dynamic drawable flags.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of dynamic drawable flags if successful; else NULL.
 */
csmApi const csmFlags* csmCallingConvention csmGetDrawableDynamicFlags(const csmModel* model);

/**
 * Retrieve drawable texture indices.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of drawable texture indices if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetDrawableTextureIndices(const csmModel* model);

/**
 * Retrieve draw orders for each drawable.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of draw orders if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetDrawableDrawOrders(const csmModel* model);

/**
 * Retrieve drawable render orders.
 * Higher values are closer to the front, and lower values are closer to the back.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of render orders if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetDrawableRenderOrders(const csmModel* model);

/**
 * Retrieve drawable opacities.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of drawable opacities if successful; else NULL.
 */
csmApi const float* csmCallingConvention csmGetDrawableOpacities(const csmModel* model);

/**
 * Retrieve number of masks of each drawable.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array with the number of masks of each drawable if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetDrawableMaskCounts(const csmModel* model);

/**
 * Retrieve mask indices of each drawable.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of arrays containing the mask indices of each drawable if successful; else NULL.
 */
csmApi const int32_t** csmCallingConvention csmGetDrawableMasks(const csmModel* model);

/**
 * Retrieve number of vertices of each drawable.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array with the number of verticies of each drawable if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetDrawableVertexCounts(const csmModel* model);

/**
 * Retrieve vertex position data of each drawable.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of arrays of vectors containing vertex positions if successful; else NULL.
 */
csmApi const csmVector2** csmCallingConvention csmGetDrawableVertexPositions(const csmModel* model);

/**
 * Retrieve texture UV coordinates of each drawable.
 *
 * @param model  Model to retrieve drawables from.
 *
 * @return  Pointer to array of arrays of vectors containing UV coordinates if successful; else NULL.
 */
csmApi const csmVector2** csmCallingConvention csmGetDrawableVertexUvs(const csmModel* model);

/**
 * Retrieve number of triangle indices for each drawable.
 *
 * @param model  Model to retrieve drawable from.
 *
 * @return  Pointer to array containing number of indices if successful; else NULL.
 */
csmApi const int32_t* csmCallingConvention csmGetDrawableIndexCounts(const csmModel* model);

/**
 * Retrieve triangle index data for each drawable.
 *
 * @param model  Model to retrieve drawable from.
 *
 * @return  Pointer to array of arrays containing triangle indices if successful; else NULL.
 */
csmApi const uint16_t** csmCallingConvention csmGetDrawableIndices(const csmModel* model);

#ifndef STRICT_CUBISM_COMPAT
#define OPENL2DCORE 1

/**
 * Fully check if MOC3 data is valid.
 *
 * @param data  Pointer to MOC3 data.
 * @param size  MOC3 data size.
 *
 * @return  1 if the MOC3 is valid; else 0.
 */
psmApi int psmCallingConvention psmCheckMocConsistency(const void* data, const uint32_t size);
#endif

#ifdef __cplusplus
}
#endif

#endif
