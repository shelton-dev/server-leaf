/**
    A paremeter is created from a leaf as a placeholder that will be converted
    into an Argument at render time.
*/
public enum Parameter {
    /**
        represents a named variable that will be accessed from context
        - parameter path: . names are forbidden and are used to indicate paths.
    */
    case variable(path: [String])

    /**
        represents a constant value passed into a tag
        - parameter value: the value found
     */
    case constant(value: String)
}

extension Parameter: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .variable(v):
            return ".variable(\(v))"
        case let .constant(c):
            return ".constant(\(c))"
        }
    }
}

extension Parameter: Equatable {}
public func == (lhs: Parameter, rhs: Parameter) -> Bool {
    switch (lhs, rhs) {
    case let (.variable(l), .variable(r)):
        return l == r
    case let (.constant(l), .constant(r)):
        return l == r
    default:
        return false
    }
}

extension Parameter {
    internal init<S: Sequence where S.Iterator.Element == Byte>(_ bytes: S) throws {
        let bytes = bytes.array.trimmed(.whitespace)
        guard !bytes.isEmpty else { throw "invalid argument: empty" }
        if bytes.count > 1, bytes.first == .quotationMark, bytes.last == .quotationMark {
            self = .constant(value: bytes.dropFirst().dropLast().string)
        } else {
            let path = bytes.split(separator: .period, omittingEmptySubsequences: true)
                .map { $0.string }
            self = .variable(path: path)
        }
    }
}
