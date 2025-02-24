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
