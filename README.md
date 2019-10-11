# ■ Study - MacOS

###### [🌎 Study - iOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-iOS/blob/master/README.md)
 
###### [🌎 Study - MacOS MARKDOWN](https://github.com/ChangYeop-Yang/Study-iOS/blob/master/%5BMacOS%5D%20README.md)

## 🧐 MacOS Major Broswer (Safari, Opera, Firefox, Chrome) History Path

## 🧐 MacOS Serial Number

<p align="center">
         <img src="https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macos/Mojave/macos-mojave-about-this-mac-overview-version-build.jpg" />
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
