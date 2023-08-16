class RelatedTopic {
  final String firstUrl;
  final AvailableImage icon;
  final String result;
  final String fullName;
  final String text;

  RelatedTopic({required this.firstUrl, required this.fullName, required this.icon, required this.result, required this.text});
}

class AvailableImage {
  final String url;

  AvailableImage({required this.url});

  factory AvailableImage.fromJson(Map<String, dynamic> json) {
    return AvailableImage(
      url: json['URL'] as String,
    );
  }
}