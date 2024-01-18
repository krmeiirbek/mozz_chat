import 'package:flutter/material.dart';
import 'package:mozz_chat/common/widgets/appbar/appbar_search.dart';
import 'package:mozz_chat/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithSearch(title: 'Чаты'),
      body: Container(
        padding: const EdgeInsets.all(TSizes.md),
        child: ListView.separated(
          itemBuilder: (_, index) => Container(
            height: 40,
            color: Colors.yellow,
          ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: 5,
        ),
      ),
    );
  }
}