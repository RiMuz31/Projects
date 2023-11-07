import XCTest
@testable import TransportForRickAndMorty

final class TransportForRickAndMortyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TransportForRickAndMorty().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
