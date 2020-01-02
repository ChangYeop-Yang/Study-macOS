// com.apple.LSSharedFileList.RecentDocuments.sfl2
if let data = FileManager.default.contents(atPath: "/Users/[USER_NAME]/Documents/com.apple.LSSharedFileList.RecentDocuments.sfl2") {
    if let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSDictionary {
        if let processing = result["items"] as? NSArray {
            //print(result.allKeys)
            //print(result.allValues)
            
            for item in processing {
                if let dict = item as? NSDictionary, let res = dict["Bookmark"] as? Data {
                    let path = try NSURL(resolvingBookmarkData: res, options: [], relativeTo: nil, bookmarkDataIsStale: nil)
                    print(path.path)
                }
            }
        }
    }
}
 
// com.apple.LSSharedFileList.RecentApplications.sfl2
if let dataTwo = FileManager.default.contents(atPath: "/Users/[USER_NAME]/Documents/com.apple.LSSharedFileList.RecentApplications.sfl2") {
    if let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataTwo) as? NSDictionary {
        if let processing = result["items"] as? NSArray {
            
            for item in processing {
                if let dict = item as? NSDictionary, let res = dict["Bookmark"] as? Data {
                    let path = try NSURL(resolvingBookmarkData: res, options: [], relativeTo: nil, bookmarkDataIsStale: nil)
                    print(path.path)
                }
            }
        }
    }
}
