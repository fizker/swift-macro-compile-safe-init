import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct Macros: CompilerPlugin {
	var providingMacros: [Macro.Type] = [
		URLMacro.self,
	]
}
