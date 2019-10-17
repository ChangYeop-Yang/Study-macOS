/// MARK: https://stackoverflow.com/questions/25006235/how-to-benchmark-swift-code-execution
private func measurePerformanceTime() {
    let startTime = CFAbsoluteTimeGetCurrent()
    // 이 곳에 시간을 측정하고자 하는 함수를 불러옵니다.
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("🕐 Measure Function Performance Time - \(timeElapsed)")
}
