import XCTest
@testable import FMNetwork

final class FMNetworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FMNetwork(type: .current).card.data, "-----")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
