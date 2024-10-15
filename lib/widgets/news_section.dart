import "package:flutter/material.dart";

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'News',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              NewsItem(
                title:
                    'Equality In The Workplace: Is There "Equal Employment Opportunity" In Australia?',
                imageUrl: 'https://via.placeholder.com/150',
              ),
              const SizedBox(width: 16.0),
              NewsItem(
                title:
                    '10 Inspiring Women Making Waves For Equality To Follow, Like, Support',
                imageUrl: 'https://via.placeholder.com/150',
              ),
              // Add more NewsItem widgets as needed
            ],
          ),
        ),
      ],
    );
  }
}

class NewsItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const NewsItem({required this.title, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 100.0, fit: BoxFit.cover),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(fontSize: 14.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
