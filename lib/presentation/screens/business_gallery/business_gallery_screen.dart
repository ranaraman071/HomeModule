import 'package:flutter/material.dart';
import '../../themes/images.dart';

class BusinessGalleryScreen extends StatefulWidget {
  const BusinessGalleryScreen({super.key,});

  @override
  State<BusinessGalleryScreen> createState() => _BusinessGalleryScreenState();
}

class _BusinessGalleryScreenState extends State<BusinessGalleryScreen> {

  final List<String> imageList = [
    AssetsPics.cyb,
    AssetsPics.img1,
    AssetsPics.img2,
    AssetsPics.img3,
    AssetsPics.img4,
    AssetsPics.img5,
    AssetsPics.img5,
    AssetsPics.cyb,
    AssetsPics.img3,


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buisiness Gallery"), centerTitle: true),
      body: Center(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisSpacing: 10,
                      crossAxisSpacing: 10, childAspectRatio: 1),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(8)),
                        child: Image(image: AssetImage(imageList[index]),fit: BoxFit.cover,),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}