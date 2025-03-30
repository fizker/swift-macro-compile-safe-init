import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

enum ParseStrategy: String {
	case iso8601

	var formatStyle: Date.ISO8601FormatStyle {
		switch self {
		case .iso8601: .iso8601
		}
	}
}

public enum DateMacro: ExpressionMacro {
	public static func expansion(
		of node: some FreestandingMacroExpansionSyntax,
		in context: some MacroExpansionContext
	) throws -> ExprSyntax {
		guard
			let argument = node.arguments.first?.expression,
			let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
			segments.count == 1,
			case .stringSegment(let literalSegment)? = segments.first
		else {
			throw CustomError.message("#Date requires a static string literal")
		}

		let strategy = find("strategy", in: node.arguments) ?? .iso8601

		guard let _ = try? Date(literalSegment.content.text, strategy: strategy.formatStyle)
		else { throw CustomError.message("malformed date: \(argument)") }

		return "try! Date(\(argument), strategy: .\(raw: strategy.rawValue))"
	}

	private static func find(_ label: String, in arguments: LabeledExprListSyntax) -> ParseStrategy? {
		guard
			let arg = arguments.first(where: { $0.label?.text == label }),
			let memberAccess = arg.expression.as(MemberAccessExprSyntax.self)
		else { return nil }

		let strategy = ParseStrategy(rawValue: memberAccess.declName.baseName.text)
		return strategy
	}
}
