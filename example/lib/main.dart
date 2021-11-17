import 'dart:io';

import 'package:example/controller/controllerprofile.dart';
import 'package:example/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ControllerProfile>(
            create: (_) => ControllerProfile()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ControllerProfile>(
        builder: (context, value, child) => UserProfileAvatar(
          avatarUrl: 'https://picsum.photos/id/237/5000/5000',
          image: value.image,
          onAvatarTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tapped on avatar'),
              ),
            );
            _showSelectionDialog();
          },
          notificationCount: 10,
          notificationBubbleTextStyle: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          avatarSplashColor: Colors.purple,
          radius: 100,
          isActivityIndicatorSmall: false,
          avatarBorderData: AvatarBorderData(
            borderColor: Colors.black54,
            borderWidth: 5.0,
          ),
        ),
      ),
    );
  }

  /// Method for sending a selected or taken photo to the EditPage
  Future selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPhotoPage(image: _image),
            ));
      } else
        print('No photo was selected or taken');
    });
  }

  Future _showSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select photo'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('From gallery'),
            onPressed: () {
              selectOrTakePhoto(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Text('Take a photo'),
            onPressed: () {
              selectOrTakePhoto(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
