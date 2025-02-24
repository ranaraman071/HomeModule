import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_pic_selector/bloc/bloc.dart';
import 'package:profile_pic_selector/bloc/event.dart';
import 'package:profile_pic_selector/bloc/state.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileImageBloc()..add(LoadProfileImageEvent()),
      child: MyHomeScreenView(),
    );
  }
}


class MyHomeScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.width * 0.25),
            BlocBuilder<ProfileImageBloc, ProfileImageState>(
              builder: (context, state) {
                if (state is ProfileImageLoaded) {
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(state.image),
                  );
                }
                return Container(
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                );
              },
            ),
            SizedBox(height: size.width * 0.1),
            BlocBuilder<ProfileImageBloc, ProfileImageState>(
              builder: (context, state) {
                if (state is ProfileImageLoaded) {
                  return SizedBox(
                      height: size.width*0.3,
                      width: size.width*0.85,
                      child: Text("path :- ${state.pathName}"));
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: size.width * 0.1),
            GestureDetector(
              onTap: () {
                context.read<ProfileImageBloc>().add(PickImageEvent(ImageSource.gallery));
              },
              child: Container(
                alignment: Alignment.center,
                height: size.width * 0.1,
                width: size.width * 0.5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black87),
                child: const Text("Upload Picture", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedFile;

  // Pick Image
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _image = File(image.path);
      _cropImage(context);
    }
  }

  Future<void> _cropImage(BuildContext context) async {
    if (_image != null) {
      final croppedFilee = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(title: 'Cropper'),
        ],
      );
      if (croppedFilee != null) {
        deleteImage();
        croppedFile = croppedFilee;
        File savedFile = await _saveImageLocally(File(croppedFile!.path));
        setState(() {
          _image = savedFile;
        });
        // saveImageToSandbox(croppedFile!.path);
      }
    }
  }

  // delete from local
  Future<void> deleteImage() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final File imageFile = File('${appDir.path}/profilepic.png');
    if (await imageFile.exists()) {
      await imageFile.delete();
      print(";-;-;-deleted successfully");
    } else {
      print("No image found to delete");
    }
  }

  // save to local
  Future<File> _saveImageLocally(File imageFile) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    String randomFileName = const Uuid().v4();
    final String savedImagePath = '${appDir.path}/$randomFileName.png';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('filePath', randomFileName);
    print(';-;-;-Saved ${savedImagePath}');
    return imageFile.copy(savedImagePath); // Copy image to local storage
  }

  // fetch from local
  Future<void> _loadProfileImage() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final prefs = await SharedPreferences.getInstance();
    String path = await prefs.getString('filePath') ?? "";
    final File imageFile = File('${appDir.path}/$path.png');
    print(";-;-;-fetch ${imageFile}");
    if (await imageFile.exists()) {
      setState(() {_image = imageFile;});
    }
  }

  @override
  void initState() {
    _loadProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.width * 0.25),
            Container(
              height: size.width * 0.3,
              width: size.width * 0.3,
              decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              // child: croppedFile != null ? ClipOval(child: Image.file(File(croppedFile!.path), fit: BoxFit.cover)) : const Text(""),
              child: _image != null ? CircleAvatar(radius: 60, backgroundImage: FileImage(_image!)) : const Text(""),
            ),
            SizedBox(height: size.width * 0.4),
            GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery);
                // _pickImage(ImageSource.camera)
                // ChooseFileBottomSheet();
              },
              child: Container(
                  alignment: Alignment.center,
                  height: size.width * 0.1,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black87),
                  child: const Text("Uplode Picture", style: TextStyle(fontSize: 18, color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}*/