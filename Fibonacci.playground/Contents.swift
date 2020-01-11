import Foundation

func fibnoacciIterative(for number: Int) -> [Int] {
    guard number > 1 else { return [1, 1] }
    var initialSequence = [1, 1]
    for i in 2...number {
        initialSequence.append(initialSequence[i - 1] + initialSequence[i - 2])
    }
    return initialSequence
}

func fibnoacciRecursive(for number: Int) -> [Int] {
    guard number != 1 else { return [1, 1] }
    var sequence = fibnoacciRecursive(for: number - 1)
    sequence.append(sequence[sequence.count - 1] + sequence[sequence.count - 2])
    return sequence
}

fibnoacciIterative(for: 9)
fibnoacciRecursive(for: 9)

