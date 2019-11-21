/**
        macOS 환경에서의 로그인 된 실 사용자의 이름을 구하여 반환합니다.
        
        - Returns: String? (Optional)
     */
    func getCurrentUserName() -> String? {
        // Creates a new session used to interact with the dynamic store maintained by the System Configuration server.
        let store = SCDynamicStoreCreate(nil, "GetConsoleUser" as CFString, nil, nil)

        // Returns information about the user currently logged into the system.
        guard let result = SCDynamicStoreCopyConsoleUser(store, nil, nil) else {
            // MARK: https://developer.apple.com/library/archive/qa/qa1133/_index.html
            return nil
        }

        return result as String?
    }
