v0.0.1

- Support AES 128 bit CBC with Padding 7 encrytion and descryption for android system.
- method Cipher2.encryptAesCbc128Padding7(plaintext, key, iv);
- method Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);

v0.1.0

- AES CBC PKCSPADDING7 for both ios and android

v0.2.0

- Add exception handle for the invalid parameter

v0.2.1

- [bugfix], Add return statement after result.error in kotlin code to avoid the error message in console.

v0.3.0

- Support AES 128 bit GCM encrytion and descryption (for android now)
- method Cipher2.encryptAesGcm128(plaintext, key, iv);
- method Cipher2.decryptAesGcm128(encryptedString, key, iv);

v0.3.1

- update the CHANGELOG.md
- update the README.md
- update the widget test for example project
- format the lib/cipher2.dart

v0.3.2

- update the CHANGELOG.md

v0.3.3

- update the CHANGELOG.md

v0.3.4

- add dart doc for cipher2.dart