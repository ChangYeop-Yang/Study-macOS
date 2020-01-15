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
class Auth: NSObject {
    // MARK: - Enum
    public enum AuthHashType: String {
        case MD5 = "MD5"
        case SHA1 = "SHA1"
        case SHA256 = "SHA256"
        case SHA384 = "SHA384"
        case SHA512 = "SHA512"
    }
    
    // MARK: - Object Propertise
    internal static let shared: Auth = Auth()
    private let privateKey: P256.Signing.PrivateKey = P256.Signing.PrivateKey()
    
    // MARK: - Init
    private override init() { super.init() }
    
    // MARK: - Authentication Method
    internal func createSignature(message: Data) -> P256.Signing.ECDSASignature? {
                
        do {
            let authData: NSData = NSData(data: message)
            return try self.privateKey.signature(for: authData)
        } catch let error {
            print("❌ Error, Faily Signature to Data. - \(error.localizedDescription)")
        }
        
        return nil
    }
    internal func createPublicKey() -> P256.Signing.PublicKey {
        return self.privateKey.publicKey
    }
    internal func authenticatingDataWithHMAC(resource: Data, key: SymmetricKey, type: AuthHashType) -> Data {
                
        switch type {
        case .MD5:
            let authenticationCode = HMAC<Insecure.MD5>.authenticationCode(for: NSData(data: resource), using: key)
            return Data(authenticationCode)
        case .SHA1:
            let authenticationCode = HMAC<Insecure.SHA1>.authenticationCode(for: NSData(data: resource), using: key)
            return Data(authenticationCode)
        case .SHA256:
            let authenticationCode = HMAC<SHA256>.authenticationCode(for: NSData(data: resource), using: key)
            return Data(authenticationCode)
        case .SHA384:
            let authenticationCode = HMAC<SHA384>.authenticationCode(for: NSData(data: resource), using: key)
            return Data(authenticationCode)
        case .SHA512:
            let authenticationCode = HMAC<SHA512>.authenticationCode(for: NSData(data: resource), using: key)
            return Data(authenticationCode)
        }
    }
    internal func checkVaildAuthenticationDataWithHMAC(authCode: Data, resource: Data, key: SymmetricKey, type: AuthHashType) -> Bool {
                
        switch type {
        case .MD5:
            return HMAC<Insecure.MD5>.isValidAuthenticationCode(authCode, authenticating: NSData(data: resource), using: key)
        case .SHA1:
            return HMAC<Insecure.SHA1>.isValidAuthenticationCode(authCode, authenticating: NSData(data: resource), using: key)
        case .SHA256:
            return HMAC<SHA256>.isValidAuthenticationCode(authCode, authenticating: NSData(data: resource), using: key)
        case .SHA384:
            return HMAC<SHA384>.isValidAuthenticationCode(authCode, authenticating: NSData(data: resource), using: key)
        case .SHA512:
            return HMAC<SHA512>.isValidAuthenticationCode(authCode, authenticating: NSData(data: resource), using: key)
        }
    }
}
