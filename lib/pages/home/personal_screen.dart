import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_styles.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PersonalScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Personal Screen", style: AppStyles.heading2,),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}