import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/theme.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      url: json['link'],
      imageUrl: json['image_url'] ?? '',
    );
  }
}

class NewsService {
  final String apiKey = 'pub_58273c1dae960e733494f61d685e7dcb35506';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsdata.io/api/1/latest?apikey=$apiKey&q=mental%20health'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<NewsArticle> articles = (data['results'] as List)
          .map((article) => NewsArticle.fromJson(article))
          .toList();
      return articles;
    } else {
      print('Ошибка: ${response.statusCode} - ${response.body}');
      throw Exception('Не удалось загрузить новости: ${response.statusCode}');
    }
  }
}

class MentalHealthNewsScreen extends StatefulWidget {
  const MentalHealthNewsScreen({Key? key}) : super(key: key);

  @override
  _MentalHealthNewsScreenState createState() => _MentalHealthNewsScreenState();
}

class _MentalHealthNewsScreenState extends State<MentalHealthNewsScreen> {
  late Future<List<NewsArticle>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darktheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Новости'),
        ),
        body: FutureBuilder<List<NewsArticle>>(
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            } else {
              final articles = snapshot.data!;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    color: const Color.fromARGB(66, 114, 114, 114),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: article.imageUrl,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            article.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            article.description,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextButton(
                            onPressed: () {
                              launch(article.url);
                            },
                            child: const Text(
                              'Читать далее...',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 248, 236, 128)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
