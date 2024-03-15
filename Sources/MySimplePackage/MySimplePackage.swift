import Foundation

public struct MySimplePackage {
    
    private static let apiKeys = ["private_key_1", "private_key_2"]
    private static var isApiKeyValid = false
    
    // configure key
    public static func configure(key: String) {
        isApiKeyValid = apiKeys.contains(key)
    }

    private static func validateApiKeys() -> Bool {
        if !isApiKeyValid {
            print("Please provide a valid API key")
        }
        return isApiKeyValid
    }

    public static func logTime() {
//        guard if key belongs to apiKeys return
        guard validateApiKeys() else { return }
        print("MySimplePackage: The time is \(Date())")
    }
}
