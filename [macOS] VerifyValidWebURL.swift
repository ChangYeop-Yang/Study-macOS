func checkValidWebURL(url: String) -> Bool {
     
     let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
     let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
     if urlTest.evaluate(with: url) {
         return true
     }
             
     let range = NSRange(location: 0, length: url.utf16.count)
     guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue),
         let match: NSTextCheckingResult = detector.firstMatch(in: url, options: [], range: range) else {
         return false
     }
     
     return match.range.length == url.utf16.count
 }
