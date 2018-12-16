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

      val charset = Charsets.UTF_8
      val dataArray = Base64.getDecoder().decode(data)
      val keyArray = key?.toByteArray(charset)
      val ivArray = iv?.toByteArray(charset)

      val cipher = Cipher.getInstance("AES/CBC/PKCS7Padding")
      val keySpec = SecretKeySpec(keyArray, "AES")
      val ivSpec = IvParameterSpec(ivArray)

      cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec)

      print("xxxx")
      print(dataArray)
      val ciphertext = cipher.doFinal(dataArray)

      val text = ciphertext.toString(charset)
      
      result.success(text) 
    } else {
      result.notImplemented()
    }
  }
}
