import 'package:image_picker/image_picker.dart';

// Events
abstract class ProfileImageEvent {}

class PickImageEvent extends ProfileImageEvent {
  final ImageSource source;
  PickImageEvent(this.source);
}

class LoadProfileImageEvent extends ProfileImageEvent {}