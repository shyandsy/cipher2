[![Build Status](https://travis-ci.org/Daegalus/dart-uuid.svg?branch=master)](https://travis-ci.org/Daegalus/dart-uuid)

# cipher2

A flutter plugin project for AES encryption and decrytion which support both ios and android.

本插件帮助开发者在自己的应用内使用AES加密解密。

This package contains a set of high-level functions for the encryption and decryption. For now, this package only support AES algorithm. Also, there are two modes support right now. The first one is `CBC 128 bit padding 7`, and second is `GCM 128 bit`. I will continue working on this project to make it sopport other mode of AES, and the other algorithms like DES, MD5, SHA1 and so on.

**all strings in this plugin use UTF8 encoding**

**本插件所有字符串都使用utf8编码**

Features:

- AES CBC mode 128bit pkcs padding 7 (works for both ios and android)
- AES GCM mode 128bit (works for android only now)

**I will update this plugin if anyone require other encrytion method.**

**如果有需要，我会更新插件代码以支持其他加密模式，以及其他加密算法。**

## Getting Started

### Instructions

1. Open a command line and cd to your projects root folder. (打开命令行，cd进入到项目根目录)
2. In your pubspec, add an entry for cipher2 to your dependencies. The example shows below(打开pubspec.yaml, 加入cipher2依赖项，下面有例子)
3. execute **pub install** in cmd (命令行执行**pub install**命令) 
4. If you wish to run tests, just run the example project example\lib\main.dart, and the test case will be running on the  app start. (如果你想看单元测试，请执行example项目example\lib\main.dart, 测试用例会在app启动时候自动执行)

### Pubspec

you can use 'any' instead of a version if you just want the latest always

```yaml
dependencies:
  cipher2: 0.3.0
```

### Usage

Define plain text to be encrypted, key, iv and generate a nonce for GCM mode

```dart
String plainText = '我是shyandsy，never give up man';
String key = 'xxxxxxxxxxxxxxxx';
String iv = 'yyyyyyyyyyyyyyyy';
String nonce = await Cipher2.generateNonce();   // generate a nonce for gcm mode we use later
```

#### AES CBC mode 128bit pkcs padding 7

Encryption: this method will return a based 64 encoded ciphertext

```dart
/*
Cipher2.encryptAesCbc128Padding7

Parameters:
    plainText: the string to be encrypted
        plainText: 被加密字符串
    key: a string with 128bit length.
        key:128 bit字符串
    iv: string with 128bit length.
        iv: 128 bit字符串

Return:
    String, the base64 encoded encrypted data
*/
String encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
```

Decryption

```dart
/*
Cipher2.decryptAesCbc128Padding7

Parameters:
    encryptedString: the base64 encoded encrypted data
        encryptedString: base64编码的密文字符串
    key: a string with 128bit length.
        key:128 bit字符串
    iv: string with 128bit length.
        iv: 128 bit字符串

Return:
    String, the plainText
*/
decryptedString = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
```

### AES GCM mode 128bit

Encrytion

```dart
/*
Cipher2.encryptAesGcm128

Parameters:
    plainText: the string to be encrypted
        plainText: 被加密字符串
    key: a string with 128bit length.
        key:128 bit字符串
    nonce: based4 encoded 92bit nonce, can be generate by the method Cipher2.generateNonce()
        nonce: based4编码的92bit nonce，可以用Cipher2.generateNonce()生成

Return:
    String, the base64 encoded encrypted data
*/
encryptedString = await Cipher2.encryptAesGcm128(plaintext, key, nonce);
```

### Decryption

```dart
/*
Cipher2.decryptAesGcm128

Parameters:
    encryptedString: the base64 encoded encrypted data
        encryptedString: base64编码的密文字符串
    key: a string with 128bit length.
        key:128 bit字符串
    nonce: based4 encoded 92bit nonce, can be generate by the method Cipher2.generateNonce()
        nonce: based4编码的92bit nonce，可以用Cipher2.generateNonce()生成

Return:
    String, the plainText
*/
result = await Cipher2.decryptAesGcm128(encryptedString, key, nonce);
```

## API

### static Future<String> encryptAesCbc128Padding7(String data, String key, String iv) async

Encryption method for the AES CBC mode 128bit pkcs padding 7

- `data`:(String) the string to be encrypted (被加密字符串)
- `key`:(String) a string with 128bit length. (128 bit字符串)
- `iv`:(String) string with 128bit length. (128 bit字符串)

`Cipher2.encryptAesCbc128Padding7()` return a String, which is a base64 encoded encrypted data

### static Future<String> decryptAesCbc128Padding7(String data, String key, String iv) async

Decryption method for the AES CBC mode 128bit pkcs padding 7

- `data`:(String) the base64 encoded encrypted data (base64编码的密文字符串)
- `key`:(String) a string with 128bit length. (128 bit字符串)
- `iv`:(String) string with 128bit length. (128 bit字符串)

`Cipher2.encryptAesCbc128Padding7()` return the plain text


### static Future<String> generateNonce() async

`Cipher2.generateNonce()` return a string of base64 encoded nonce, the nonce is 92 bit(12 byte)

### static Future<String> encryptAesGcm128(String data, String key, String nonce) async

Encryption method for the AES GCM mode 128bit

- `data`:(String) the string to be encrypted (被加密字符串)
- `key`:(String) a string with 128bit length. (128 bit字符串)
- `nonce`:(String) based4 encoded 92bit nonce, can be generate by the method Cipher2.generateNonce(). (based4编码的92bit nonce，可以用Cipher2.generateNonce()生成)

`Cipher2.encryptAesGcm128()` return a String, which is a base64 encoded encrypted data

### static Future<String> decryptAesGcm128(String data, String key, String nonce) async

Dncryption method for the AES GCM mode 128bit

- `data`:(String) the base64 encoded encrypted data (base64编码的密文字符串)
- `key`:(String) a string with 128bit length. (128 bit字符串)
- `nonce`:(String) based4 encoded 92bit nonce, can be generate by the method Cipher2.generateNonce(). (based4编码的92bit nonce，可以用Cipher2.generateNonce()生成)

`Cipher2.decryptAesGcm128()` return a return the plain text

## Unit test

First, I havent find a way in the unit test document to test the method provided by the native code. I will appreciate if you teach me how to do that!

Instead, I do that in the example code. Look the code in example\lib\main.dart.

```dart
String encryptedString;
String plainText = '我是shyandsy，never give up man';
String key = 'xxxxxxxxxxxxxxxx';
String iv = 'yyyyyyyyyyyyyyyy';
String decryptedString;

// test
await testEncryptAesCbc128Padding7();

await testDecryptAesCbc128Padding7();

await testEncryptAesGcm128(); // GenerateNonce();
```

## Exception handle
there are three types of exceptions in this plugin

- ERROR_INVALID_KEY_OR_IV_LENGTH

    the length of key or iv is invalid

- ERROR_INVALID_PARAMETER_TYPE
    
    all parameters must be string

- ERROR_INVALID_ENCRYPTED_DATA

    the string to be descrytion must be a valid base64 string with the length at multiple of 128 bits

```dart
String encryptedString = '我是shyandsy，never give up man';
String key = 'xxxxxxxxxxxxxxxx';
String iv = 'yyyyyyyyyyyyyyyy';

try {
    // encrytion
    plainText = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
    print("testDecrytion case6: failed");
} on PlatformException catch(e) {
    encryptedString = "";
    if(e.code == "ERROR_INVALID_ENCRYPTED_DATA"){
        print("testDecrytion: pass");
    }else{
        print("testDecrytion: failed");
    }
}
```