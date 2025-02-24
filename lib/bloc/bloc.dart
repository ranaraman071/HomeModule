import 'dart:io';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile_pic_selector/bloc/event.dart';
import 'package:profile_pic_selector/bloc/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// Bloc

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final ImagePicker _picker = ImagePicker();

  ProfileImageBloc() : super(ProfileImageInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<LoadProfileImageEvent>(_onLoadProfileImage);
  }

  String savedImagePath ="";
  Future<void> _onPickImage(PickImageEvent event, Emitter<ProfileImageState> emit) async {
    final XFile? image = await _picker.pickImage(source: event.source);
    if (image != null) {
      File imageFile = File(image.path);
      final croppedFile = await _cropImage(imageFile);
      if (croppedFile != null) {
        await _deletePreviousImage();
        File savedFile = await _saveImageLocally(File(croppedFile.path));
        emit(ProfileImageLoaded(savedFile,savedImagePath));
      }
    }
  }

  Future<void> _onLoadProfileImage(LoadProfileImageEvent event, Emitter<ProfileImageState> emit) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final prefs = await SharedPreferences.getInstance();
    String path = prefs.getString('filePath') ?? "";
    final File imageFile = File('${appDir.path}/$path.png');
    if (await imageFile.exists()) {
      // emit(ProfileImageLoaded(imageFile,"${appDir.path}/$path.png"));
    }
  }

  Future<CroppedFile?> _cropImage(File image) async {
    return await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: ''),
      ],
    );
  }

  Future<void> _deletePreviousImage() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final File imageFile = File('${appDir.path}/profilepic.png');
    if (await imageFile.exists()) {
      await imageFile.delete();
    }
  }

  Future<File> _saveImageLocally(File imageFile) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    // String randomFileName = const Uuid().v4();
    String randomFileName = generateRandomFileName();
    savedImagePath = '${appDir.path}/$randomFileName.png';
    print(";-;-;-$savedImagePath");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('filePath', randomFileName);
    return imageFile.copy(savedImagePath);
  }

  String generateRandomFileName() {
    final wordPair = generateWordPairs().take(1).first;
    return '${wordPair.first}_${wordPair.second}';
  }

}