// import "dart:io";
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
//
// class LoggedIn extends StatefulWidget {
//   const LoggedIn({Key? key}) : super(key: key);
//
//   @override
//   State<LoggedIn> createState() => _LoggedInState();
// }
//
// class _LoggedInState extends State<LoggedIn> {
//   // FilePickerResult? result;
//   // String? _fileName;
//   // PlatformFile? pickedfile;
//   // bool isLoading=false;
//   // File? fileToDisplay;
//   String? _filePath;
//   String? predicted;
//   String prediction='';
//
//   Future<void> uploadAudio(File audioFile) async {
//     final url = 'http://10.0.2.2:5000/predict'; // Change this to your Flask back-end URL
//     var request = await http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));
//     var response = await request.send();
//     var responseData = await response.stream.bytesToString();
//     setState(() {
//       prediction = responseData;
//     });
//     debugPrint(responseData);
//   }
//   Future<void> pickFile() async {
//     FilePickerResult? result=await FilePicker.platform.pickFiles(
//       type: FileType.any,
//     );
//
//     if(result!=null){
//       PlatformFile file=result.files.first;
//       setState(() {
//         _filePath=file.path;
//       });
//       // _fileName=result!.files.first.name;
//       // pickedfile=result!.files.first;
//       //fileToDisplay=File(pickedfile!.path.toString() as List<Object>);
//       //print('File name $_fileName');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Predictor'),
//         ),
//         body: Center(
//           child:SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children:<Widget>[
//               ElevatedButton(
//                 child: Text('Pick File'),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)
//                     )
//                 ), onPressed: pickFile,
//               ),
//               SizedBox(height: 10,),
//               _filePath != null
//                   ? Text('Selected file: $_filePath')
//                   : Text('No file selected'),
//               SizedBox(height: 10,),
//               ElevatedButton(onPressed: ()async{
//                 await uploadAudio(File(_filePath??""));
//               }, child: Text('Predict'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                 ),
//               ),
//               prediction!=''?Text('Prediction : $prediction'):Text('')
//             ],
//           ),),
//           // child: SizedBox(
//           //     height: 50,
//           //     width: 300,
//           //     child: ElevatedButton(
//           //       child: Text('Pick File'),
//           //       style: ElevatedButton.styleFrom(
//           //           backgroundColor: Colors.green,
//           //           shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(10)
//           //           )
//           //       ), onPressed: pickFile,
//           //     ),
//           // ),
//         )
//     );
//   }
// }
// import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'next.dart';
class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final player=AudioPlayer();
  final player1=AudioPlayer();
  bool isPlaying=false;
  bool isPlaying1=false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  Duration duration1=Duration.zero;
  Duration position1=Duration.zero;
  int flag=0;
  // late Future<http.Response> imageFuture;
  // late Widget plotImage;

  String? _filePath;
  String? predicted;
  String prediction = '';

  void initState(){
    super.initState();

    player.onPlayerStateChanged.listen((state){
      setState(() {
        isPlaying=state==PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration=newDuration;
      });
    });
    player.onDurationChanged.listen((newPosition) {
      setState(() {
        duration=newPosition;
      });
    });

    player1.onPlayerStateChanged.listen((state){
      setState(() {
        isPlaying1=state==PlayerState.playing;
      });
    });

    player1.onDurationChanged.listen((newDuration) {
      setState(() {
        duration1=newDuration;
      });
    });
    player1.onDurationChanged.listen((newPosition) {
      setState(() {
        duration1=newPosition;
      });
    });
  }
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> uploadAudio(File audioFile) async {
    // final url = 'http://10.0.2.2:5000/process_audio'; // Change this to your Flask back-end URL
    //final url = 'http://127.0.0.1:5000/process_audio'; // Change this to your Flask back-end URL
    // final url='http://13.53.205.203:80/process_audio';
    final url='http://16.171.145.225:80/process_audio';
    var request = await http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        await http.MultipartFile.fromPath('audio_file', audioFile.path));
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    setState(() {
      prediction = responseData;
    });
    // debugPrint(responseData);
    print(responseData);
  }
  Future<void> pickWavFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _filePath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.lightGreen,
        title: Text('Heart Disease Predictor'),
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Align(alignment: Alignment.topCenter,
              child: FractionalTranslation(
                  translation: Offset(0, -0.75),
              child:Image.asset('assets/heart1.jpg',width:75,height: 75))),
              // SizedBox(
              //   height: 5,
              // ),
              ElevatedButton(
                onPressed: pickWavFile,
                child: Text('Input Audio File', style:TextStyle(color:Colors.white),), style:ElevatedButton.styleFrom(
                backgroundColor: Colors.green,),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration)),
                  ],
                ),
              ),

              CircleAvatar(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                radius:20,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause:Icons.play_arrow,
                  ),
                  iconSize: 25,
                  onPressed: () async {
                    File audioFile=File(_filePath ?? "");
                    await player.play(UrlSource(audioFile.path));
                  },
                ),
              ),
              TextButton(onPressed:(){},
                  child: const Text("Play Input Audio", style: TextStyle(color: Colors.black),)),
              SizedBox(
                height: 5,
              ),
              SizedBox(height: 20),
              _filePath != null
                  ? Text('Selected file: $_filePath')
                  : Text('No file selected'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () async {
                await uploadAudio(File(_filePath ?? ""));
                flag=1;

              }, child: Text('Predict'),style:ElevatedButton.styleFrom(
                backgroundColor: Colors.green,),),
              prediction != '' ? Text('Prediction : $prediction',style: TextStyle(fontSize: 20)) : Text(''),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position1)),
                    Text(formatTime(duration1)),
                  ],
                ),
              ),

              CircleAvatar(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                radius:20,
                child: IconButton(
                  icon: Icon(
                    isPlaying1 ? Icons.pause:Icons.play_arrow,
                  ),
                  iconSize: 25,
                  onPressed: () async {
                    await player1.play(AssetSource('$prediction.wav'));
                  },
                ),
              ),
              TextButton(onPressed:(){},
                  child: const Text("Play Reference Audio", style: TextStyle(color: Colors.black),)),
              SizedBox(
                height: 30,
              ),
              TextButton(style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed:(){
                Navigator.pushNamed(context, "next");
              },
                  child: const Text("Visualizations", style: TextStyle(color: Colors.white),)),
            ],
          ),),
      ),
    );
  }
}
