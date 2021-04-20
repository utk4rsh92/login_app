import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'User.dart';
import 'Wallpaper.dart';
import 'Services.dart';

void main() => runApp(LokyApp());

class LokyApp extends StatefulWidget {
  LokyApp():super();
  @override
  _LokyApp createState() => _LokyApp();
}

class _LokyApp extends State<LokyApp> {
  List<User> _users;
  bool _loading;
  String value;
  String stDescription = "";
  String _stDesc="";

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });

        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(
              'Wego',
              style:
                  GoogleFonts.fredokaOne(color: Colors.white, fontSize: 19.0),
            ),

            elevation: 12.0,
          ),
          body: Center(

            child:

                ListView.builder(
                    itemCount : null == _users ? 0 : _users.length,
                    itemBuilder: (context, i) {
                      User user = _users[i];
                      stDescription = user.description;
                      if(stDescription!=null) {
                        stDescription = _stDesc;
                      }
                      else{

                      }
                      return new GestureDetector(
                        onTap: (){
                          if(user!=null){

                            value = user.urls.regular;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Wallpaper(),settings: RouteSettings(
                                  arguments: value,
                                )
                                ));

                           // print(user.description[i]);
                             }

                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(user.urls.thumb,width: 150,height: 100,),
                              Text(_stDesc,
                                style: GoogleFonts.varelaRound(
                                    color: Colors.green,
                                    fontSize: 14.0
                                ),),
                              Row(

                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[

                                  IconButton(
                                    icon: Image.asset('assets/heart.png',width: 15,height: 15,),),
                                  Text(user.likes.toString(),
                                    //textAlign: TextAlign.start,
                                  ),


                                ],
                              ),

                              // Image.network(
                              // user.sponsorship.sponsor.profileImage.small,width: 50,height: 50,),


                            ],
                          ),
                        ),
                      );




                    }),




          )),
    );
  }
}
