/*
 * Copyright (c) 2019 양창엽. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/**
        macOS System에서 전체 디스크 접근 권한 (Full Disk Access)이 설정되어 있는지 확인하는 함수입니다.
     
        - Returns: Bool
*/
func checkFullDiskAccess() -> Bool {

        let user = "HERE YOUR USER NAME"

        // MARK: Library/Application Support/com.apple.TCC/TCC.db 파일을 기준으로 권한 확인을 수행합니다.
        if let homePath = NSHomeDirectoryForUser(user) {
            let path = URL(fileURLWithPath: homePath, isDirectory: true)
                        .appendingPathComponent("Library/Application Support/com.apple.TCC", isDirectory: true)
                        .appendingPathComponent("TCC.db", isDirectory: false)

            // MARK: FileManager를 통하여 TCC.db을 읽어들이지 못한 경우를 비교하여 전체 디스크 접근 권한 (Full Disk Access)을 확인합니다.
            if FileManager.default.contents(atPath: path.path) == nil {
                return false
            }
        }

        return true
}
