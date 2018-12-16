# cipher2_example

Demonstrates how to use the cipher2 plugin.

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

