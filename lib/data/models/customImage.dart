class CustomImage {
  int? height;
  int? width;
  String? url;

  CustomImage({
    this.height,
    this.width,
    this.url,
  });

  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      height: json['height'],
      width: json['width'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'width': width,
      'url': url,
    };
  }
}