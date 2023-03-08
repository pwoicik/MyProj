import Foundation

/// apply
infix operator <<: AdditionPrecedence

func << <T>(subject: T, block: (T) -> Void) -> T {
    block(subject)
    return subject
}

infix operator ?<<: AdditionPrecedence

func ?<< <T>(subject: T?, block: (T) -> Void) -> T? {
    if subject == nil {
        return nil
    }
    block(subject!)
    return subject
}

/// let
infix operator <>: AdditionPrecedence

func <> <T, U>(subject: T, block: (T) -> U) -> U {
    block(subject)
}

infix operator ?<>: AdditionPrecedence

func ?<> <T, U>(subject: T?, block: (T) -> U) -> U? {
    if subject == nil {
        return nil
    }
    return block(subject!)
}
