import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
class Next extends StatefulWidget {
  const Next({Key? key}) : super(key: key);

  @override
  State<Next> createState() => _NextState();
}

class _NextState extends State<Next> {
  late Future<http.Response> imageFuture;
  late Widget plotImage;

  late Future<http.Response> imageFuture1;
  late Widget plotImage1;

  void initState(){
    super.initState();
    imageFuture=fetchImage();
    plotImage=CircularProgressIndicator();
    imageFuture1=fetchSpec();
    plotImage1=CircularProgressIndicator();
  }

  Future<http.Response> fetchImage(){
    return http.get(Uri.parse('http://16.171.145.225:80/plot'));
  }
  Future<http.Response> fetchSpec(){
    return http.get(Uri.parse('http://16.171.145.225:80/specplot'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.lightGreen,
        title: Text('Visualizations'),
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(
                height: 5,
              ),
              Align(alignment: Alignment.topCenter,
                  child: FractionalTranslation(
                      translation: Offset(0, -1),
                      child:Image.asset('assets/heart1.jpg',width:75,height: 75))),
              SizedBox(
                height: 5,
              ),
          SizedBox(
            height: 20,
          ),
              Text("Plot of the Input Audio", style: TextStyle(
                fontSize: 20,
                fontWeight:FontWeight.bold,
              ),),
              SizedBox(
                height: 20,
              ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.2,
                    child: Scaffold(
                      body: Center(
                        child: FutureBuilder<http.Response>(
                          future: imageFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done &&
                                snapshot.hasData &&
                                snapshot.data!.statusCode == 200) {
                              return Image.memory(snapshot.data!.bodyBytes);
                            } else if (snapshot.hasError) {
                              return Text('Failed to load images');
                            }
                            return plotImage;
                          },
                        ),
                      ),
                    ),
                  ),
              SizedBox(
                height: 20,
              ),
              Text("Spectrogram of the Input Audio",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:FontWeight.bold,
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2,
                child: Scaffold(
                  body: Center(
                    child: FutureBuilder<http.Response>(
                      future: imageFuture1,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data!.statusCode == 200) {
                          return Image.memory(snapshot.data!.bodyBytes);
                        } else if (snapshot.hasError) {
                          return Text('Failed to load image');
                        }
                        return plotImage1;
                      },
                    ),
                  ),
                ),
              )
          ],),),
      ),
    );
  }

}
