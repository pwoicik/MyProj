import Foundation

extension String {
    func contains(_ other: String, ignoreCase: Bool = false) -> Bool {
        ignoreCase
            ? localizedCaseInsensitiveContains(other)
            : contains(other)
    }

    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func take(_ n: Int) -> String {
        String(prefix(n))
    }

    func isBlank() -> Bool {
        first { char in
            char.isWhitespace || char.isNewline
        } != nil
    }

    func nilIfBlank() -> String? {
        isBlank() ? nil : self
    }

    func nilIfEmpty() -> String? {
        isEmpty ? nil : self
    }
}
