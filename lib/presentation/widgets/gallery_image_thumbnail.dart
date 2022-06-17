import 'dart:io';

import 'package:flutter/material.dart';

class GalleryImageThumbnail extends StatefulWidget {
  final File photo;
  final VoidCallback onSelectPhoto;
  const GalleryImageThumbnail({
    Key? key,
    required this.photo,
    required this.onSelectPhoto,
  }) : super(key: key);

  @override
  State<GalleryImageThumbnail> createState() => _GalleryImageThumbnailState();
}

class _GalleryImageThumbnailState extends State<GalleryImageThumbnail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(FileImage(widget.photo), context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onSelectPhoto,
      child: FadeInImage(
        fit: BoxFit.cover,
        image: FileImage(widget.photo),
        placeholder: const AssetImage("assets/images/white.jpg"),
      ),
    );
  }
}
