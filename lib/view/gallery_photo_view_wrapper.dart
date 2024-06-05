
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  const GalleryPhotoViewWrapper({
    super.key,
    required this.galleryItems,
    required this.backgroundDecoration,
    this.initialIndex = 0,
  });

  final List<String> galleryItems;
  final BoxDecoration backgroundDecoration;
  final int initialIndex;

  @override
  GalleryPhotoViewWrapperState createState() => GalleryPhotoViewWrapperState();
}

class GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoViewGallery.builder(
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.galleryItems[index]),
            heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
          );
        },
        itemCount: widget.galleryItems.length,
        pageController: pageController,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundDecoration: widget.backgroundDecoration,
      ),
    );
  }
}
