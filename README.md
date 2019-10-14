# ■ Study - MacOS

* macOS(맥오에스, 이전 이름: OS X, 맥 OS X / Mac OS X)는 기업 애플이 제작한 운영 체제이다. 2002년 4월부터 모든 매킨토시 컴퓨터에 적용되고 있다. 이 운영 체제는 1984년 1월부터 애플 컴퓨터를 이끌어 왔던 맥 OS의 마지막 고전 버전인 맥 오에스 9의 뒤를 잇는다. OS X이라는 이 운영 체제의 예전 이름에 들어있는 "X"라는 글자는 알파벳 "X"을 뜻하는 것이 아니라, 매킨토시의 10번째 운영 체제를 뜻하는 것이기 때문에, 로마 숫자 "10"을 뜻하는 것이다. 이 운영 체제는 애플이 1996년 12월에 인수한 NeXT의 기술력으로 만들어졌으며 유닉스에 기반을 하고 있다. 2011년 7월 20일에 OS X 라이언이 출시되었다. 기존에도 줄여서 OS X이라고 많이 표현했으나, OS X 마운틴 라이언 공개와 함께 기존 맥 OS X (Mac OS X)에서 맥 (Mac)이라는 단어가 공식적으로 제거되었다.

###### [🌎 Study - iOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-iOS/blob/master/README.md)
 
###### [🌎 Study - MacOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-macOS/blob/master/README.md)

## 🧐 MacOS SQLite

## 🧐 MacOS Major Broswer (Safari, Opera, Firefox, Chrome) History File Path

#### 🔎 Google Chrome History File Path

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Google/Chrome`

* 🔗 COMMAND - `~/Library/Application\ Support/Google/Chrome/`

#### 🔎 Google Chromium History File Path

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/Chromium`

* 🔗 COMMAND - `~/Library/Application\ Support/Chromium/`

#### 🔎 Google Canary History File Path

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
 
#### 🔎 Opera History File Path

* `/Users/[COMPUTER_USER_NAME]/Library/Application Support/com.operasoftware.Opera`

* 🔗 COMMAND - `cd ~/Library/Application\ Support/com.operasoftware.Opera`

## 🧐 MacOS X 일련번호 (Serial Number) 가져오기

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
