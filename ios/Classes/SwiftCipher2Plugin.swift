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
        result(
          FlutterError(
            code: "ERROR_INVALID_PARAMETER_TYPE",
            message: "the parameters data, key and iv must be all strings",
            details: nil
          )
        )
        return
      }

      if(args["data"] == nil || args["key"] == nil || args["iv"] == nil){
        result(
          FlutterError(
            code: "ERROR_INVALID_PARAMETER_TYPE",
            message: "the parameters data, key and iv must be all strings",
            details: nil
          )
        )
        return
      }

      let data = args["data"]!
      let key = args["key"]!
      let iv = args["iv"]!

      let dataArray = Array(data.utf8)
      let keyArray = Array(key.utf8)
      let ivArray = Array(iv.utf8)

      if(key.count != 16 || iv.count != 16){
        result(
          FlutterError(
            code: "ERROR_INVALID_KEY_OR_IV_LENGTH",
            message: "the length of key and iv must be all 128 bits",
            details: nil
          )
        )
        return
      }

      var encryptedBase64 = "";

      do {

        let encrypted = try AES(
          key: keyArray, 
          blockMode: CBC(iv: ivArray), 
          padding: .pkcs7
        ).encrypt(dataArray)
        
        let encryptedNSData = NSData(bytes: encrypted, length: encrypted.count)

        encryptedBase64 = encryptedNSData.base64EncodedString(options:[])

      } catch {
        
      }

      result(encryptedBase64)

    case "Decrypt_AesCbc128Padding7":

      guard let args = call.arguments as? [String: String] else {
        result(
          FlutterError(
            code: "ERROR_INVALID_PARAMETER_TYPE",
            message: "the parameters data, key and iv must be all strings",
            details: nil
          )
        )
        return
      }

      if(args["data"] == nil || args["key"] == nil || args["iv"] == nil){
        result(
          FlutterError(
            code: "ERROR_INVALID_PARAMETER_TYPE",
            message: "the parameters data, key and iv must be all strings",
            details: nil
          )
        )
        return
      }

      let data = args["data"]!
      let key = args["key"]!
      let iv = args["iv"]!

      //let dataArray = Array(data.utf8)
      let keyArray = Array(key.utf8)
      let ivArray = Array(iv.utf8)

      if(key.count != 16 || iv.count != 16){
        result(
          FlutterError(
            code: "ERROR_INVALID_KEY_OR_IV_LENGTH",
            message: "the length of key and iv must be all 128 bits",
            details: nil
          )
        )
        return
      }

      //解码得到Array<Int32>
      let encryptedData = NSData(base64Encoded: data, options:[]) ?? nil

      if(encryptedData == nil || encryptedData!.length % 4 != 0){
        result(
          FlutterError(
            code: "ERROR_INVALID_ENCRYPTED_DATA",
            message: "the data should be a valid base64 string with length at multiple of 128 bits",
            details: nil
          )
        )
        return
      }

      let encrypted = [UInt8](encryptedData! as Data)

      var plaintext = "";

      do {
        let decryptedData = try AES(
          key: keyArray, 
          blockMode: CBC(iv: ivArray), 
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
