import Foundation

/// A subset of ``Date.ParseStrategy`` that this macro supports.
public enum ParseStrategy: String {
	case iso8601
}

@freestanding(expression)
public macro Date(_ value: any StringProtocol, strategy: ParseStrategy = .iso8601) -> Date =
	#externalMacro(module: "CompileSafeInitMacroImplementation", type: "DateMacro")
