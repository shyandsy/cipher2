package com.shyandsy.cipher2

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec
import java.util.Base64

class Cipher2Plugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "cipher2")
      channel.setMethodCallHandler(Cipher2Plugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "Encrypt_AesCbc128Padding7") {
      val data = call.argument<String>("data")
      val key = call.argument<String>("key")
      val iv = call.argument<String>("iv")

      if(data == null || key == null || iv == null){
        result.error(
          "ERROR_INVALID_PARAMETER_TYPE",
          "the parameters data, key and iv must be all strings",
          null
        )
      }

      if(key?.length != 16 || iv?.length != 16){
        result.error(
          "ERROR_INVALID_KEY_OR_IV_LENGTH",
          "the length of key and iv must be all 128 bits",
          null
        )
        return
      }

      val charset = Charsets.UTF_8
      val dataArray = data?.toByteArray(charset)
      val keyArray = key?.toByteArray(charset)
      val ivArray = iv?.toByteArray(charset)

      val cipher = Cipher.getInstance("AES/CBC/PKCS7Padding")
      val keySpec = SecretKeySpec(keyArray, "AES")
      val ivSpec = IvParameterSpec(ivArray)

      cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec)

      val ciphertext = cipher.doFinal(dataArray)

      val text = Base64.getEncoder().encodeToString(ciphertext)

      print(text)

      result.success(text) 
    } else if (call.method == "Decrypt_AesCbc128Padding7") {
      val data = call.argument<String>("data")
      val key = call.argument<String>("key")
      val iv = call.argument<String>("iv")

      if(data == null || key == null || iv == null){
        result.error(
          "ERROR_INVALID_PARAMETER_TYPE",
          "the parameters data, key and iv must be all strings",
          null
        )
      }

      if(key?.length != 16 || iv?.length != 16){
        result.error(
          "ERROR_INVALID_KEY_OR_IV_LENGTH",
          "the length of key and iv must be all 128 bits",
          null
        )
        return
      }

      val charset = Charsets.UTF_8

      //val dataArray = Base64.getDecoder().decode(data)
      var dataArray:ByteArray = ByteArray(0)
    
      try{

          //val charset = Charsets.UTF_8
          dataArray = Base64.getDecoder().decode(data?.toByteArray(Charsets.UTF_8))

          if(dataArray.size % 4 != 0){
            throw IllegalArgumentException("")
          }

      }catch (e: IllegalArgumentException) {
        result.error(
          "ERROR_INVALID_ENCRYPTED_DATA",
          "the data should be a valid base64 string with length at multiple of 128 bits",
          null
        )
        return
      }

      val keyArray = key?.toByteArray(charset)
      val ivArray = iv?.toByteArray(charset)

      val cipher = Cipher.getInstance("AES/CBC/PKCS7Padding")
      val keySpec = SecretKeySpec(keyArray, "AES")
      val ivSpec = IvParameterSpec(ivArray)

      cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec)

      val ciphertext = cipher.doFinal(dataArray)

      val text = ciphertext.toString(charset)
      
      result.success(text) 
    } else {
      result.notImplemented()
    }
  }
}
