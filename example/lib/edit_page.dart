import 'dart:io';
import 'package:example/controller/controllerprofile.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class EditPhotoPage extends StatefulWidget {
  final File image;

  const EditPhotoPage({@required this.image});

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  File imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.image;

    if (imageFile != null) _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            hideBottomControls: true,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      Provider.of<ControllerProfile>(context, listen: false).image =
          croppedFile;
      // context.bloc<PhotoBloc>().add(GetPhoto(imageFile));
      Navigator.pop(context);
      setState(() {});
    }
  }
}
