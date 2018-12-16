import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cipher2/cipher2.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _plainText = 'Unknown';
  String _encryptedString = '';
  String _decryptedString = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String encryptedString;
    String plainText = '我是shyandsy，never give up man';
    String key = 'xxxxxxxxxxxxxxxx';
    String iv = 'yyyyyyyyyyyyyyyy';
    String decryptedString;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {

      // encrytion
      encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
      
      // decrytion
      decryptedString = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
    
    } on PlatformException {
      plainText = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _plainText = plainText;
      _encryptedString = encryptedString;
      _decryptedString = decryptedString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child:new ListView(
            children: <Widget>[
              new Container(
                child: Text('Orignal Text:', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),),
                decoration: new BoxDecoration(color: Colors.purple),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              new Container(
                child: Text(_plainText, style: TextStyle(fontSize: 20.0, color: Colors.black),),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              new Container(
                child: Text('AES Encrytion Result:', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),),
                decoration: new BoxDecoration(color: Colors.purple),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              new Container(
                child: Text(_encryptedString, style: TextStyle(fontSize: 20.0, color: Colors.black),),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              new Container(
                child: Text('AES Decrytion Result:', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),),
                decoration: new BoxDecoration(color: Colors.purple),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              new Container(
                child: Text(_decryptedString, style: TextStyle(fontSize: 20.0, color: Colors.black)),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
