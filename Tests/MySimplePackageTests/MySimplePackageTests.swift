import XCTest
@testable import MySimplePackage

final class MySimplePackageTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MySimplePackage().text, "Hello, World!")
    }
}
