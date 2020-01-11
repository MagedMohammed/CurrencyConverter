import Foundation

func areStringsAnagram(firstString: String, secondString: String) -> Bool {
    return sortStringAndRemoveWhiteSpaces(firstString) == sortStringAndRemoveWhiteSpaces(secondString)
}

func sortStringAndRemoveWhiteSpaces(_ string: String) -> [Character] {
    return string.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "").lowercased().sorted(by: <)
}


areStringsAnagram(firstString: "Debit Card", secondString: "Bad Credit")
areStringsAnagram(firstString: "Test", secondString: "Invalid")
areStringsAnagram(firstString: "listen", secondString: "silent")
