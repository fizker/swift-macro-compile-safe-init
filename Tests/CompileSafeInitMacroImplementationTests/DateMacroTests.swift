import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(CompileSafeInitMacroImplementation)
import CompileSafeInitMacroImplementation

let macros: [String: Macro.Type] = [
	"Date": DateMacro.self,
]

final class DateMacroTests: XCTestCase {
	func test__date__strategyIsISO8601_valueIsValid_valueContainsDateAndTime__expandsCorrectly() async throws {
		assertMacroExpansion(
			"""
			#Date("2017-01-03T12:34:56Z", strategy: .iso8601)
			""",
			expandedSource: """
			try! Date("2017-01-03T12:34:56Z", strategy: .iso8601)
			""",
			macros: macros
		)
	}

	func test__date__strategyIsISO8601_valueIsInvalid__emitError() async throws {
		assertMacroExpansion(
			"""
			#Date("foo", strategy: .iso8601)
			""",
			expandedSource: """
			#Date("foo", strategy: .iso8601)
			""",
			diagnostics: [
				DiagnosticSpec(
					message: #"malformed date: "foo""#,
					line: 1,
					column: 1,
					severity: .error
				),
			],
			macros: macros
		)
	}
}
#else
final class DateMacroTests: XCTestCase {
	func testMacro() throws {
		throw XCTSkip("macros are only supported when running tests for the host platform")
	}
}
#endif
