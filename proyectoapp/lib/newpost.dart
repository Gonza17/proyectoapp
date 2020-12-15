import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Newpost extends StatefulWidget {
  _Newpost createState() => new _Newpost();
}

class _Newpost extends State<Newpost> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Future getCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future getGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 300.0,
          child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                        elevation: 4.0,
                        onPressed: () {
                          getGallery();
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFf7418c),
                                    Color(0xFFfbab66),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0))),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('Picture From Gallery',
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ))),
                    RaisedButton(
                      elevation: 4.0,
                      onPressed: () {
                        getCamera();
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFFf7418c),
                                  Color(0xFFfbab66),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0))),
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Take Picture',
                                  style: TextStyle(fontSize: 15)),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
