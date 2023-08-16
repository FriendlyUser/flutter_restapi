class RelatedTopic {
  String firstUrl;
  AvailableImage icon;
  String result;
  String text;

  RelatedTopic({
    required this.firstUrl,
    required this.icon,
    required this.result,
    required this.text,
  });

  factory RelatedTopic.fromJson(Map<String, dynamic> json) {
    return RelatedTopic(
      firstUrl: json['FirstURL'] as String,
      icon: AvailableImage.fromJson(json['Icon'] as Map<String, dynamic>),
      result: json['Result'] as String,
      text: json['Text'] as String,
    );
  }
}

class AvailableImage {
  String height;
  String url;
  String width;

  AvailableImage({
    required this.height,
    required this.url,
    required this.width,
  });
  
  factory AvailableImage.fromJson(Map<String, dynamic> json) {
    return AvailableImage(
      height: json['Height'] as String,
      url: json['URL'] as String,
      width: json['Width'] as String,
    );
  }
}