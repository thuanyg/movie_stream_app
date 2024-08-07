import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_strings.dart';
import 'package:movie_stream/configs/app_styles.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const String routeName = '/DetailPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Detail Screen", style: AppStyles.heading2),
      ),
    );
  }
}
