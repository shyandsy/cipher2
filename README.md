# cipher2

A flutter plugin project for AES encryption and decrytion which support both ios and android.

本插件帮助开发者在自己的应用内使用AES加密解密。

For now, it supports AES CBC pkcspadding7 only. I will update this plugin if anyone require other encrytion method.

目前，本插件只支持AES CBC pkcspadding7模式加密解密, 如果你需要其他加密方式或者AES加密其他模式，请给我留言。我会升级这个插件。

## Getting Started

This project is a plugin package for flutter which implements AES encrytion and decryption.

```dart
String plainText = '我是shyandsy，never give up man';
String key = 'xxxxxxxxxxxxxxxx';
String iv = 'yyyyyyyyyyyyyyyy';
```

## Encrytion

this method will return a based 64 encoded ciphertext

```dart
// encrytion
String encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
```

## Decryption

```dart
// decrytion
decryptedString = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
```

### Exception handle
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