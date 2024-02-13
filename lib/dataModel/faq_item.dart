class FaqItem {
  String header;
  String description;

  FaqItem({
    required this.header,
    required this.description,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      header: json['header'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'header': header,
      'description': description,
    };
  }

  factory FaqItem.fromMap(Map<String, dynamic> map) {
    return FaqItem(
      header: map['header'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return 'FaqItem{header: $header, description: $description}';
  }
}
