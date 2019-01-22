import Flutter
import UIKit
import CryptoSwift

extension String {
  func fromBase64() -> String? {
    guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
        return nil
    }
    return String(data: data as Data, encoding: String.Encoding.utf8)
  }

  func toBase64() -> String? {
    guard let data = self.data(using: String.Encoding.utf8) else {
        return nil
    }
    return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
  }
}

public class SwiftCipher2Plugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cipher2", binaryMessenger: registrar.messenger())
    let instance = SwiftCipher2Plugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "Encrypt_AesCbc128Padding7":
      guard let args = call.arguments as? [String: String] else {
        fatalError("args are formatted badly")
      }

      let data = args["data"]!
      let key = args["key"]!
      let iv = args["iv"]!

      var encryptedBase64 = "";

      do {

        let encrypted = try AES(
          key: Array(key.utf8), 
          blockMode: CBC(iv: Array(iv.utf8)), 
          padding: .pkcs7
        ).encrypt(Array(data.utf8))
        
        let encryptedNSData = NSData(bytes: encrypted, length: encrypted.count)

        encryptedBase64 = encryptedNSData.base64EncodedString(options:[])

      } catch {
        
      }

      result(encryptedBase64)

    case "Decrypt_AesCbc128Padding7":

      guard let args = call.arguments as? [String: String] else {
        fatalError("args are formatted badly")
      }

      let data = args["data"]!
      let key = args["key"]!
      let iv = args["iv"]!

      let encryptedData = NSData(base64Encoded: data, options:[])!

      let encrypted = [UInt8](encryptedData as Data)

      var plaintext = "";

      do {
        let decryptedData = try AES(
          key: Array(key.utf8), 
          blockMode: CBC(iv: Array(iv.utf8)), 
          padding: .pkcs7
        ).decrypt(encrypted)
        
        plaintext = String(bytes: decryptedData, encoding: String.Encoding.utf8)!
      } catch {
        
      }

      result(plaintext)

    default: result(FlutterMethodNotImplemented)
    }
  }
}
