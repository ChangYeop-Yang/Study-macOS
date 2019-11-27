# ■ Study - MacOS

* macOS(맥오에스, 이전 이름: OS X, 맥 OS X / Mac OS X)는 기업 애플이 제작한 운영 체제이다. 2002년 4월부터 모든 매킨토시 컴퓨터에 적용되고 있다. 이 운영 체제는 1984년 1월부터 애플 컴퓨터를 이끌어 왔던 맥 OS의 마지막 고전 버전인 맥 오에스 9의 뒤를 잇는다. OS X이라는 이 운영 체제의 예전 이름에 들어있는 "X"라는 글자는 알파벳 "X"을 뜻하는 것이 아니라, 매킨토시의 10번째 운영 체제를 뜻하는 것이기 때문에, 로마 숫자 "10"을 뜻하는 것이다. 이 운영 체제는 애플이 1996년 12월에 인수한 NeXT의 기술력으로 만들어졌으며 유닉스에 기반을 하고 있다. 2011년 7월 20일에 OS X 라이언이 출시되었다. 기존에도 줄여서 OS X이라고 많이 표현했으나, OS X 마운틴 라이언 공개와 함께 기존 맥 OS X (Mac OS X)에서 맥 (Mac)이라는 단어가 공식적으로 제거되었다.

###### [🌎 Study - iOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-iOS/blob/master/README.md)
 
###### [🌎 Study - MacOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-macOS/blob/master/README.md)

## 🧐 [MacOS SQLite](https://dev-dream-world.tistory.com/95)

* SQLite는 MySQL나 PostgreSQL와 같은 데이터베이스 관리 시스템이지만, 서버가 아니라 응용 프로그램에 넣어 사용하는 비교적 가벼운 데이터베이스이다. 영어권에서는 '에스큐엘라이트(ˌɛskjuːɛlˈlaɪt)' 또는 '시퀄라이트(ˈsiːkwəl.laɪt)'라고 읽는다. 일반적인 RDBMS에 비해 대규모 작업에는 적합하지 않지만, 중소 규모라면 속도에 손색이 없다.

#### 📔 SQLite Error Code

```C++
#define SQLITE_OK           0   /* Successful result */
/* beginning-of-error-codes */
#define SQLITE_ERROR        1   /* Generic error */
#define SQLITE_INTERNAL     2   /* Internal logic error in SQLite */
#define SQLITE_PERM         3   /* Access permission denied */
#define SQLITE_ABORT        4   /* Callback routine requested an abort */
#define SQLITE_BUSY         5   /* The database file is locked */
#define SQLITE_LOCKED       6   /* A table in the database is locked */
#define SQLITE_NOMEM        7   /* A malloc() failed */
#define SQLITE_READONLY     8   /* Attempt to write a readonly database */
#define SQLITE_INTERRUPT    9   /* Operation terminated by sqlite3_interrupt()*/
#define SQLITE_IOERR       10   /* Some kind of disk I/O error occurred */
#define SQLITE_CORRUPT     11   /* The database disk image is malformed */
#define SQLITE_NOTFOUND    12   /* Unknown opcode in sqlite3_file_control() */
#define SQLITE_FULL        13   /* Insertion failed because database is full */
#define SQLITE_CANTOPEN    14   /* Unable to open the database file */
#define SQLITE_PROTOCOL    15   /* Database lock protocol error */
#define SQLITE_EMPTY       16   /* Internal use only */
#define SQLITE_SCHEMA      17   /* The database schema changed */
#define SQLITE_TOOBIG      18   /* String or BLOB exceeds size limit */
#define SQLITE_CONSTRAINT  19   /* Abort due to constraint violation */
#define SQLITE_MISMATCH    20   /* Data type mismatch */
#define SQLITE_MISUSE      21   /* Library used incorrectly */
#define SQLITE_NOLFS       22   /* Uses OS features not supported on host */
#define SQLITE_AUTH        23   /* Authorization denied */
#define SQLITE_FORMAT      24   /* Not used */
#define SQLITE_RANGE       25   /* 2nd parameter to sqlite3_bind out of range */
#define SQLITE_NOTADB      26   /* File opened that is not a database file */
#define SQLITE_NOTICE      27   /* Notifications from sqlite3_log() */
#define SQLITE_WARNING     28   /* Warnings from sqlite3_log() */
#define SQLITE_ROW         100  /* sqlite3_step() has another row ready */
#define SQLITE_DONE        101  /* sqlite3_step() has finished executing */
/* end-of-error-codes */
```

#### 📔 SQLite Create Table Source Code

```Swift
/// Open SQLite Database
private func openSQLite(path: String) -> OpaquePointer? {
    
    var database: OpaquePointer? = nil
    
    // Many of the SQLite functions return an Int32 result code. Most of these codes are defined as constants in the SQLite library. For example, SQLITE_OK represents the result code 0.
    guard sqlite3_open(path, &database) == SQLITE_OK else {
        print("‼️ Unable to open database.")
        return nil
    }
    
    // Success Open SQLite Database
    print("✅ Successfully opened connection to database at \(path)")
    return database
}

/// Create SQLite Database Table
private func createSQLiteTable(database: OpaquePointer, statement: String) -> Bool {
    
    var createStatement: OpaquePointer? = nil
    
    // You must always call sqlite3_finalize() on your compiled statement to delete it and avoid resource leaks.
    defer { sqlite3_finalize(createStatement) }
        
    guard sqlite3_prepare_v2(database, statement, EOF, &createStatement, nil) == SQLITE_OK else {
        print("‼️ CREATE TABLE statement could not be prepared.")
        return false
    }
    
    // sqlite3_step() runs the compiled statement.
    if sqlite3_step(createStatement) == SQLITE_DONE {
        print("✅ Success, Contact table created.")
    } else {
        print("‼️ Fail, Contact table could not be created.")
    }
    
    return true
}
```

#### 📔 SQLite Insert Source Code

```Swift
/// Insert Data into SQLite Database Table
private func insertSQLiteTable(database: OpaquePointer, statement: String) -> Bool {
    
    var insertStatement: OpaquePointer? = nil
    
    // You must always call sqlite3_finalize() on your compiled statement to delete it and avoid resource leaks.
    defer { sqlite3_finalize(insertStatement) }
    
    guard sqlite3_prepare_v2(database, statement, EOF, &insertStatement, nil) == SQLITE_OK else {
        print("‼️ Insert TABLE statement could not be prepared.")
        return false
    }
    
    // Use the sqlite3_step() function to execute the statement and verify that it finished.
    if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("✅ Success, Insert Data.")
    } else {
        print("‼️ Fail, Insert Data.")
    }
    
    return true
}
```

#### 📔 SQLite Query Source Code

```Swift
/// Implement Query SQLite
private func qeurySQLite(database: OpaquePointer, statment: String) -> Bool {
    
    var queryStatment: OpaquePointer? = nil
    
    // You must always call sqlite3_finalize() on your compiled statement to delete it and avoid resource leaks.
    defer { sqlite3_finalize(queryStatment) }
    
    guard sqlite3_prepare_v2(database, statment, EOF, &queryStatment, nil) == SQLITE_OK else {
        print("‼️ Query statement could not be prepared.")
        return false
    }
    
    while sqlite3_step(queryStatment) == SQLITE_ROW {
        
        let id = sqlite3_column_int(queryStatment, 0)
        let name = sqlite3_column_text(queryStatment, 1)
        
        print("→ \(id) | \(String(describing: name))")
    }
    
    return true
}
```

## 🧐 MacOS Major Broswer (Safari, Opera, Firefox, Chrome) User History File Path

#### 🔎 Google Chrome History File Path [`History`]

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Google/Chrome`

* 🔗 COMMAND - `~/Library/Application\ Support/Google/Chrome/`

#### 🔎 Google Chromium History File Path [`History`]

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Chromium`

* 🔗 COMMAND - `~/Library/Application\ Support/Chromium/`

#### 🔎 Google Canary History File Path [`History`]

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Google/Chrome Canar`

* 🔗 COMMAND - `~/Library/Application\ Support/Google/Chrome Canar/`
 
#### 🔎 Apple Safari History File Path [`History.db`]

* `/Users/[COMPUTER_USER_NAME]/Library/Safari`

* 🔗 COMMAND - `cd ~/Library/Safari/`

#### 🔎 NAVER Whale History File Path [`History`]

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Naver/Whale/Profile 2`

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Naver/Whale/Default`

* 🔗 COMMAND - `cd ~/Library/Application\ Support/Naver/Whale/Profile\ 2/`

#### 🔎 Mozilla Firefox History File Path [`places.sqlite`]

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Firefox/Profiles/<profile folder>`

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Firefox/Profiles/fnhhibct.default-release`
 
#### 🔎 Opera History File Path [`History`]
 
* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/com.operasoftware.Opera`

* 🔗 COMMAND - `cd ~/Library/Application\ Support/com.operasoftware.Opera`

## 🧐 MacOS Major Broswer (Safari, Opera, Firefox, Chrome) History Database SQLite Query


## 🧐 [MacOS X WEB Browser Time Format 변환](https://gist.github.com/dropmeaword/9372cbeb29e8390521c2)

#### 📔 Convert WEB Browser Time format to Unix Time format Source Code

```Swift
/**
    각 브라우저 (WEB Browser) TimeStamp에 대한 Enumulation
    - Chrominum: Chrominum 기반 브라우저에 대한 TimeStamp (Naver Whale, Opera, Microsoft Edge)
    - Safari: Apple Safari 브라우저에 대한 TimeStamp
    - Firefox: Mozlira Firefox 브라우저에 대한 TimeStamp
 */
private enum BrowserTimeStamp {
    case Chromium (time: Int)
    case Safari (time: Double)
    case Firefox (time: Int)
}

/**
    각 브라우저 (WEB Browser) TimeStamp를 Unix TimeStamp로 변경하는 함수입니다.
    
    - Parameters:
        - clock: Enum BrowserTimeStamp 형식에 맞는 시간 값
    - Returns: Date
 */
private func convertUnixTime(clock: BrowserTimeStamp) -> Date {

    switch clock {
    case .Chromium(let time):
        let convertClock = Double(time) / Double(1000000) - Double(11644473600)
        return Date(timeIntervalSince1970: TimeInterval(convertClock))
    case .Safari(let time):
        let convertClock = time + 978307200
        return Date(timeIntervalSince1970: convertClock)
    case .Firefox(let time):
        let convertClock = Double(time) / 1000000
        return Date(timeIntervalSince1970: convertClock)
    }
}
```

## 🧐 MacOS 일련번호 (Serial Number) 가져오기

<p align="center">
         <img src="https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macos/Mojave/macos-mojave-about-this-mac-overview-version-build.jpg" width=512 height=300 />
</p>

#### 📔 Read MacOS Serial Number Source Code

```Swift
func deviceSerialNumber() -> String? {
         
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
         
        guard platformExpert > 0,
                let serial = (IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
            return nil
        }
         
        IOObjectRelease(platformExpert)
         
        return serial
    }
```

## 🧐 프로퍼티 리스트 (plist, Property List)

* 프로퍼티 리스트(property list)는 OS X, iOS, NeXTSTEP, GNUstep 프로그래밍 소프트웨어 프레임워크 등에 이용되는 객체 직렬화를 위한 파일입니다. 또한 .plist라는 확장자를 가지므로, 보통 plist 파일이라고 하는 경우가 많습니다.

#### 📔 (READ) 프로퍼티 리스트 (plist, Property List) Source Code

```Swift
func readPlist(fileName: String) -> Any? {
        
        var result: Any
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let data = FileManager.default.contents(atPath: path) else {
                fatalError("Error, Read plist file.")
        }
        
        do {
            result = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)
            
            // Here Processing PropertyListSerialization Data.
        } catch {
            fatalError("Error, Serialization plist file.")
        }
        
        return result
    }
    
    func readPlistByCodable(fileName: String) -> Any? {
        
        var result: Any
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let xml = FileManager.default.contents(atPath: path)  else {
                fatalError("Error, Read plist file.")
        }
        
        do {
            result = try PropertyListDecoder().decode(Property.self, from: xml)
            
            // Here Processing PropertyListSerialization Data.
        } catch {
            fatalError("Error, Serialization plist file.")
        }
        
        return result
    }
```

#### 📔 (WRITE) 프로퍼티 리스트 (plist, Property List) Write Source Code

```Swift
func writePlistByCodable(fileName: String) {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
            fatalError("Error, Get plist file path.")
        }
        
        /// Write Plist By Codable Test Data.
        let data: Property = Property(name: "Ahn", zip: 13495)
        do {
            let data = try? encoder.encode(data)
            try data?.write(to: path)
        } catch {
            fatalError("Error, Write Serialization plist file.")
        }
    }
```

## 🧐 [MacOS Process](https://developer.apple.com/documentation/foundation/process)

* An object representing a subprocess of the current process. Using the Process class, your program can run another program as a subprocess and can monitor that program’s execution.

* 현재 프로세스에서 자식 프로세스를 만듬으로써 새로운 프로그램을 실행할 수 있습니다.

#### 📔 Process Syntax

```swift
class Process : NSObject
```

#### 📔 Process Example Source Code

```swift
private func killProcess(pid: [Int32]) {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = ["kill"] + pid.compactMap { String($0) }
    task.launch()
}
```

## 🧐 [MacOS 프로세스 시간 측정 (Measure Performance Time)](https://stackoverflow.com/questions/25006235/how-to-benchmark-swift-code-execution)

#### 📔 CFAbsoluteTimeGetCurrent Syntax

```swift
func CFAbsoluteTimeGetCurrent() -> CFAbsoluteTime
```

#### 📔 Measure Performance Time Source Code

```swift
/// MARK: https://stackoverflow.com/questions/25006235/how-to-benchmark-swift-code-execution
private func measurePerformanceTime() {
    let startTime = CFAbsoluteTimeGetCurrent()
    // 이 곳에 시간을 측정하고자 하는 함수를 불러옵니다.
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("🕐 Measure Function Performance Time - \(timeElapsed)")
}
```

## 🧐 [MacOS 앱 설치 확인 (Check Installed Application)](https://developer.apple.com/documentation/appkit/nsworkspace/1531434-launchapplication)

#### 📔 launchApplication Syntax

* Launches the specified app.

```swift
func launchApplication(_ appName: String) -> Bool
```

#### 📔 Check Installed Application Source Code

```swift
NSWorkspace.shared.launchApplication('APP NAME')

// EXAMPLE
NSWorkspace.shared.launchApplication("Safari")
```

## 🌍 MacOS Development Education Reference

* [iOS에서 TDD(Test-Driven Development)하기 - Realm](https://academy.realm.io/kr/posts/ios-tdd-test-driven-development/)

* [Swift가 제공하는 여러 포인터 타입들과 동작 방식 - Realm](https://academy.realm.io/kr/posts/nate-cook-tryswift-tokyo-unsafe-swift-and-pointer-types/)
