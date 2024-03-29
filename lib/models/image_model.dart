class Image {
  final String url;
  final String imgName;

  Image({required this.url, required this.imgName});

  factory Image.toMap(Map<String, dynamic> img) {
    return Image(url: img['url'], imgName: img['image']);
  }
}
