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

import Foundation
 
let path = URL(fileURLWithPath: "/Users/changyeop-yang/.trash/.DS_Store", isDirectory: false)
 
guard let contents = FileManager.default.contents(atPath: path.path) else { fatalError() }
 
public func splitD(start: UInt32, length: UInt32, data: NSData) -> NSData {
    let range = NSRange(start..<start + length)
    return data.subdata(with: range) as NSData
}
 
public func readBlock(data: NSData, offset: UInt32) -> UInt32 {
    
    //let p: NSData = data as NSData
    var o: UInt32 = offset
    
    if o + 8 >= data.count { return 0 }
    
    let cnt = splitD(start: o + 8, length: 4, data: data).bytes.load(as: UInt32.self).bigEndian
    //let cnt = data.subdata(with: cntRange).withUnsafeBytes { $0.load(as: UInt32.self).bigEndian }
    o += 12
    
    for _ in stride(from: cnt, to: 0, by: -1) {
        let nameLen = (splitD(start: o, length: 4, data: data).bytes.load(as: UInt32.self).bigEndian) * 2
        //let name = str(data: p, start: o + 4, length: nameLen)
        let nameRange = NSRange(o + 4..<o + 4 + nameLen)
        let name = NSString(data: data.subdata(with: nameRange), encoding: String.Encoding.utf16BigEndian.rawValue)
        
        let tagRange = NSRange(o + 4 + nameLen..<o + 4 + nameLen + 4)
        let tag = NSString(data: data.subdata(with: tagRange), encoding: String.Encoding.utf8.rawValue)
        //let tag = str(data: p, start: o + 4 + nameLen, length: 4)
        
        let typeRange = NSRange(o + 8 + nameLen..<o + 8 + nameLen + 4)
        let type = NSString(data: data.subdata(with: typeRange), encoding: String.Encoding.utf8.rawValue)
        //let type = str(data: p, start: o + 8 + nameLen, length: 4)
        
        o += nameLen + 12
        if type == "bool" { o += 1 }
        else if type == "shor" || type == "long" || type == "type" { o += 4 }
        else if type == "comp" || type == "dutc" { o += 8 }
        else if type == "ustr" {
            let n = (splitD(start: o, length: 4, data: data).bytes.load(as: UInt32.self).bigEndian) * 2
            
            if tag == "ptbL" {
                let pathRange = NSRange(o + 4..<o + 4 + n)
                let path = NSString(data: data.subdata(with: pathRange), encoding: String.Encoding.utf16BigEndian.rawValue)
                print("🚗 -> \(name) | 🚕 -> \(path)")
            } else if tag == "ptbN" {
                print("🗺 -> \(name)")
            }
            
            o += n + 4
        }
        else if type == "blob" { o += (splitD(start: o, length: 4, data: data).bytes.load(as: UInt32.self).bigEndian) + 4 }
        else { break }
    }
    
    return cnt
}
 
var off = splitD(start: 0x14, length: 4, data: contents as NSData).bytes.load(as: UInt32.self).bigEndian & ~15
print("🗿 FILE SIZE - \(contents.count)")
 
while true {
    if readBlock(data: contents as NSData, offset: off) == 0 { break }
    off = (off & 0xfffff000) + 0x1000
}
