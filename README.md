# ■ Study - MacOS

* macOS(맥오에스, 이전 이름: OS X, 맥 OS X / Mac OS X)는 기업 애플이 제작한 운영 체제이다. 2002년 4월부터 모든 매킨토시 컴퓨터에 적용되고 있다. 이 운영 체제는 1984년 1월부터 애플 컴퓨터를 이끌어 왔던 맥 OS의 마지막 고전 버전인 맥 오에스 9의 뒤를 잇는다. OS X이라는 이 운영 체제의 예전 이름에 들어있는 "X"라는 글자는 알파벳 "X"을 뜻하는 것이 아니라, 매킨토시의 10번째 운영 체제를 뜻하는 것이기 때문에, 로마 숫자 "10"을 뜻하는 것이다. 이 운영 체제는 애플이 1996년 12월에 인수한 NeXT의 기술력으로 만들어졌으며 유닉스에 기반을 하고 있다. 2011년 7월 20일에 OS X 라이언이 출시되었다. 기존에도 줄여서 OS X이라고 많이 표현했으나, OS X 마운틴 라이언 공개와 함께 기존 맥 OS X (Mac OS X)에서 맥 (Mac)이라는 단어가 공식적으로 제거되었다.

###### [🌎 Study - iOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-iOS/blob/master/README.md)
 
###### [🌎 Study - MacOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-macOS/blob/master/README.md)

## 🧐 MacOS Apple T2

<p align="center">
   <img src="https://user-images.githubusercontent.com/20036523/66991819-bbd4eb80-f103-11e9-9c69-0bd0f909e62f.png" width=512 height=384 />
</p>

* Apple T2 보안 칩은 Apple의 Mac용 2세대 맞춤형 실리콘 칩입니다. 다른 Mac 컴퓨터에서 찾을 수 있는 시스템 관리 컨트롤러, 이미지 신호 프로세서, 오디오 컨트롤러, SSD 컨트롤러 등의 다양한 컨트롤러들을 새롭게 디자인하여 하나로 통합한 T2 칩은 Mac에 새로운 기능을 제공합니다. </br></br>예를 들어 T2 칩에는 Touch ID 데이터를 보호하고 새로운 암호화된 저장 장치와 보안 시동 기능의 기반이 되는 Secure Enclave 보조 프로세서가 내장되어 있어 새로운 차원의 보안이 가능합니다. 또한 T2 칩의 이미지 신호 프로세서는 FaceTime HD 카메라와 연동하여 색조 매핑과 노출 조절 기능을 개선하고 안면 인식 기술을 바탕으로 한 자동 노출 및 자동 화이트 밸런스가 가능합니다.

## 🧐 MacOS SQLite

## 🧐 MacOS Major Broswer (Safari, Opera, Firefox, Chrome) History File Path

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
