// state
import 'package:equatable/equatable.dart';

class DisplayState extends Equatable {
  final bool available;
  final bool announcement;
  final bool contact;
  final bool email;
  final bool website;

  final bool insta;
  final bool tiktok;
  final bool twitter;
  final bool facebook;

  DisplayState({
    this.available = true,
    this.announcement = true,
    this.contact = true,
    this.email = true,
    this.website = true,

    this.insta = true,
    this.tiktok = true,
    this.twitter = true,
    this.facebook = true,
  });

  DisplayState copyWith({
    bool? available,
    bool? announcement,
    bool? contact,
    bool? email,
    bool? website,

    bool? insta,
    bool? tiktok,
    bool? twitter,
    bool? facebook,
  }) {
    return DisplayState(
      available: available ?? this.available,
      announcement: announcement ?? this.announcement,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      website: website ?? this.website,
      insta: insta ?? this.insta,
      tiktok: tiktok ?? this.tiktok,
      twitter: twitter ?? this.twitter,
      facebook: facebook ?? this.facebook,

    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [available,announcement,contact,email,website];
}
