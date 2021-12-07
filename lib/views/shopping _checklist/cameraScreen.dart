import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:savenote/views/shopping%20_checklist/display_img.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late List cameras;

  int selectedCameraIdx = 0;
  String imagePath="";
  @override
  void initState() {
    super.initState();
    // 1
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          // 2
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );

    controller.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    /* var camera = controller.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(controller),
      ),
    );*/
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(controller))
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
          title: const Text('Scan a receipt'),
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
          elevation: 0.0,
          brightness: Brightness.dark),
      bottomSheet: Container(
          color: Colors.black,
          height: 100,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            FloatingActionButton(
              onPressed: () {
                controller.resumePreview();
                setState(() {
                  imagePath="";
                });
              },
              backgroundColor: Colors.white,
              mini: true,
              child: Center(
                  child: Icon(
                Icons.refresh,
                color: Colors.black,
              )),
            ),
            FloatingActionButton(
              onPressed: () async {
                controller.setFlashMode(FlashMode.off);
                var image = await controller.takePicture();
                controller.pausePreview();
                setState(() {
                  imagePath=image.path;
                });

              },
              backgroundColor: Colors.white,
              mini: false,
              child: Center(
                  child: Icon(
                Icons.circle_outlined,
                size: 57,
                color: Colors.black,
              )),
            ),
            FloatingActionButton(
              onPressed: () async {
                if(imagePath!="")
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      // Pass the automatically generated path to
                      // the DisplayPictureScreen widget.
                      imagePath: imagePath,
                    ),
                  ),
                );
              },
              backgroundColor: Colors.white,
              mini: true,
              child: Center(
                  child: Icon(
                Icons.check,
                color: Colors.black,
              )),
            )
          ])),

      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: _cameraPreviewWidget(),
    );
  }
}
