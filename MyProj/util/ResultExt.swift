import Foundation

extension Result {
    func getOrNil() -> Success? {
        try? get()
    }
}

