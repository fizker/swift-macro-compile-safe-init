//===----------------------------------------------------------------------===//
//
// This source file was originally part of the Swift.org open source project
//
// The original contained more expression macros, that have been removed for inclusion in this package.
//
// The original can be found at https://github.com/swiftlang/swift-syntax/blob/2da6a366aeb1d525bc654dec3e493acb60eeb4f3/Examples/Sources/MacroExamples/Interface/ExpressionMacros.swift
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

/// Check if provided string literal is a valid URL and produce a non-optional
/// URL value. Emit error otherwise.
@freestanding(expression)
public macro URL(_ stringLiteral: String) -> URL =
  #externalMacro(module: "CompileSafeInitMacroImplementation", type: "URLMacro")
