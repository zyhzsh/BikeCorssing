import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(
      {Key? key, required this.onSelectImage, this.width, this.height, required this.onRemoveImage, this.currentImage})
      : super(key: key);

  final void Function(File pickedImage) onSelectImage;
  final double? width;
  final double? height;
  final void Function(File pickedImage) onRemoveImage;
  final File? currentImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  @override
  void initState() {
    _selectedImage = widget.currentImage;
    super.initState();
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final image =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (image == null) {
      return;
    }
    setState(() {
      _selectedImage = File(image.path);
    });
    widget.onSelectImage(_selectedImage!);
  }

  void _removePicture () async {
    widget.onRemoveImage(_selectedImage!);
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton(
      onPressed: _takePicture,
      child: const Icon(
        Icons.add_a_photo,
        size: 30,
      ),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
          onTap: _takePicture,
          child: Stack(
            children: [
              Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
             Positioned(
                top: -10,
               right: -10,
               child: IconButton(
                  onPressed: _removePicture,
                  icon: Icon(Icons.remove_circle_outline,
                      size: 20, color: Colors.red.withOpacity(0.6)),
                ),
             )
            ],
          ));
    }

    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        height: widget.height ?? 200,
        width: widget.width ?? double.infinity,
        //alignment: Alignment.center,
        child: content);
  }
}
