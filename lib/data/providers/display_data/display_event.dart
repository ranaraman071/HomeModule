// Events
import 'package:equatable/equatable.dart';

abstract class DisplayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DisplayedDataEvent extends DisplayEvent {
  final bool announcement;
  final bool contact;
  final bool email;
  final bool website;
  final bool insta;
  final bool tiktok;
  final bool twitter;
  final bool facebook;

  DisplayedDataEvent({
    required this.announcement,
    required this.contact,
    required this.email,
    required this.website,
    required this.insta,
    required this.tiktok,
    required this.twitter,
    required this.facebook,
  });

  @override
  List<Object?> get props => [
        announcement,
        contact,
        email,
        website,
        insta,
        tiktok,
        twitter,
        facebook,
      ];
}
