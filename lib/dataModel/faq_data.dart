import 'faq_item.dart';

class FaqData {
  String result;
  String status;
  String message;
  List<FaqItem> faqList;

  FaqData({
    required this.result,
    required this.status,
    required this.message,
    required this.faqList,
  });

  static FaqData fromJson(Map<String, dynamic> json) {
    return FaqData(
      result: json['result'],
      status: json['status'],
      message: json['Message'],
      faqList: List<FaqItem>.from(json['JSONData']['faqList']
          .map((faqItemJson) => FaqItem.fromJson(faqItemJson))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'status': status,
      'Message': message,
      'JSONData': {
        'faqList': faqList.map((faqItem) => faqItem.toJson()).toList()
      },
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'status': status,
      'Message': message,
      'faqList': faqList.map((faqItem) => faqItem.toMap()).toList(),
    };
  }

  static FaqData fromMap(Map<String, dynamic> map) {
    return FaqData(
      result: map['result'],
      status: map['status'],
      message: map['Message'],
      faqList: List<FaqItem>.from(
          map['faqList'].map((faqItemMap) => FaqItem.fromMap(faqItemMap))),
    );
  }

  @override
  String toString() {
    return 'FaqData{result: $result, status: $status, message: $message, faqList: $faqList}';
  }
}
