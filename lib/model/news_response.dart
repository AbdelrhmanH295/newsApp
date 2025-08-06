import 'package:news_app/model/source_response.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<News>? articles;
  String? code;
  String? message;

  NewsResponse(
      {this.status, this.totalResults, this.articles, this.code, this.message});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    status = json["status"];
    totalResults = json["totalResults"];
    articles = json["articles"] == null
        ? null
        : (json["articles"] as List).map((e) => News.fromJson(e)).toList();
  }

  static List<NewsResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(NewsResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["totalResults"] = totalResults;
    if (News != null) {
      _data["News"] = articles?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class News {
  Sources? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  News(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  News.fromJson(Map<String, dynamic> json) {
    source = json["source"] == null ? null : Sources.fromJson(json["source"]);
    author = json["author"];
    title = json["title"];
    description = json["description"];
    url = json["url"];
    urlToImage = json["urlToImage"];
    publishedAt = json["publishedAt"];
    content = json["content"];
  }

  static List<News> fromList(List<Map<String, dynamic>> list) {
    return list.map(News.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (source != null) {
      _data["source"] = source?.toJson();
    }
    _data["author"] = author;
    _data["title"] = title;
    _data["description"] = description;
    _data["url"] = url;
    _data["urlToImage"] = urlToImage;
    _data["publishedAt"] = publishedAt;
    _data["content"] = content;
    return _data;
  }
}
