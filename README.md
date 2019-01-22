# cipher2

A flutter plugin project for AES encryption and decrytion which support both ios and android.

For now, it supports AES CBC pkcspadding7 only. I will update this plugin if anyone require other encrytion method.

## Getting Started

This project is a plugin package for flutter which implements AES encrytion and decryption.

```dart
String plainText = '我是shyandsy，never give up man';
String key = 'xxxxxxxxxxxxxxxx';
String iv = 'yyyyyyyyyyyyyyyy';
```

## encrytion

this method will return a based 64 encoded ciphertext

```dart
// encrytion
String encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
```

## decryption

```dart
// decrytion
decryptedString = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
```