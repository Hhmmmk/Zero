import 'package:zero_app/main.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new RealDrawer(),
      appBar: AppBar(
        title: Text('Review Page'),
      ),
      body: (Text('This Review Page')),
    );
  }
}
