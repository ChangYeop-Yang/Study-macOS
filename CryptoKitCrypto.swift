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
