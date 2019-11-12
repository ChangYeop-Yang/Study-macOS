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
