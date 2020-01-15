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

import CryptoKit
import Foundation

@available(iOS 13, OSX 10.15, *)
class Crypto: NSObject {
    
    // MARK: - Typealias
    public typealias CryptoReturnType = (encryptedData: Any?, key: SymmetricKey?)
    
    // MARK: - Enum
    public enum CryptoType: String {
        case AES = "AES"
        case ChaChaPoly = "ChaChaPoly"
    }
    
    // MARK: - Object Propertse
    internal static let shared: Crypto = Crypto()
    
    // MARK: - Init
    private override init() { super.init() }
    
    // MARK: - Cipher Method
    internal func encryptCipher(message: String, keySize: SymmetricKeySize, type: CryptoType) -> CryptoReturnType {
        
        let cipherKey = SymmetricKey(size: keySize)
        
        guard let data = message.data(using: .utf8) else { return CryptoReturnType(nil, nil) }
        
        do {
            var encryptedData: Any?
            let cipherData = NSData(data: data)
            
            switch type {
            case .AES:
                encryptedData = try AES.GCM.seal(cipherData, using: cipherKey)
            case .ChaChaPoly:
                encryptedData = try ChaChaPoly.seal(cipherData, using: cipherKey)
            }
            
            return CryptoReturnType(encryptedData, cipherKey)
        } catch let error {
            print("❌ Error, Failly encrypt cipher message. - \(error.localizedDescription)")
        }
        
        return CryptoReturnType(nil, nil)
    }
    internal func decryptCipher(encryptedMessage: Any, key: SymmetricKey, type: CryptoType) -> Data? {
                
        do {
            switch type {
            case .AES:
                guard let sealed = encryptedMessage as? AES.GCM.SealedBox else { return nil }
                return try AES.GCM.open(sealed, using: key)
            case .ChaChaPoly:
                guard let sealed = encryptedMessage as? ChaChaPoly.SealedBox else { return nil }
                return try ChaChaPoly.open(sealed, using: key)
            }
            
        } catch let error {
            print("❌ Error, Failly decrypt cipher message. - \(error.localizedDescription)")
        }
        
        return nil
    }
}
