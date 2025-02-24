import 'dart:io';

// States
abstract class ProfileImageState {}

class ProfileImageInitial extends ProfileImageState {}

class ProfileImageLoaded extends ProfileImageState {
  final File image;
  final String pathName;
  ProfileImageLoaded(this.image,this.pathName);
}