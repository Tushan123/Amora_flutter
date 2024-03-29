// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names
import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class ImageContainer extends StatelessWidget {
  final String? imgUrl;
  const ImageContainer({super.key, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            bottom: BorderSide(color: Colors.black),
            top: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
          ),
        ),
        child: (imgUrl == null)
            ? Center(
                child: IconButton(
                onPressed: () async {
                  ImagePicker _picker = ImagePicker();
                  final XFile? _image = await _picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 50);
                  if (_image == null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No image found")));
                  }
                  if (_image != null) {
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<OnboardingBloc>(context)
                        .add(UpdateImages(img: _image));
                  }
                },
                icon: const Icon(Ionicons.add),
              ))
            : Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(imgUrl!), fit: BoxFit.cover)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                // context.read<ProfileBloc>().add(
                                //     DeleteImageFromProfile(
                                //         user: state.user,
                                //         img: state.user.imageUrls[index]));
                              },
                              iconSize: 15,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
