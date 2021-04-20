import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Wallpaper extends StatefulWidget {
  @override
  _Wallpaper createState() => _Wallpaper();
}

class _Wallpaper extends State<Wallpaper> {
  var dio = Dio();
  FToast fToast;
  @override
  void initState(){
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  var filepath;
  Future download2(Dio dio, String url, String savePath) async {
    final externalDir = await getExternalStorageDirectory();

    try {
      Response response = await dio.get(
        url,
    //    onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      print(response.headers);
      File file = File(savePath);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image saved'),
        ),
      );
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddkk:mm').format(now);
    // TODO: implement build
    final String _url = ModalRoute.of(context).settings.arguments;
    print(_url);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wego',
          style: GoogleFonts.fredokaOne(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 12,
      ),
      body: Center(

          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(_url, width: 600, height:400, fit: BoxFit.cover,),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                var tempDir = await getTemporaryDirectory();
                String fullPath = tempDir.path + '/'+formattedDate+".jpg";
                print('full path ${fullPath}');

                download2(dio, _url, fullPath);



          /*      GallerySaver.saveImage(_url, albumName: 'DemoImage').then((bool success) {
                  setState(() {
                    print('Image is saved at ');
                  });
                });*/


              },
              label: Text('Download'),
              icon: Icon(Icons.file_download),
            )
          ],
        ),
      )),
    );
  }
}
