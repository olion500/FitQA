import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:fitqa/src/presentation/screens/screen_mypage_feedback.dart';
import 'package:fitqa/src/presentation/screens/screen_mypage_gallery.dart';
import 'package:fitqa/src/presentation/screens/screen_mypage_history.dart';
import 'package:fitqa/src/presentation/screens/screen_mypage_trainer.dart';
import 'package:fitqa/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenMyPageDetail extends ConsumerWidget {
  const ScreenMyPageDetail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ContainedTabBarView(
        tabs: const [
          Text('내가 쓴 글'),
          Text('찜한 트레이너'),
          Text('갤러리'),
          Text('이용내역'),
        ],
        tabBarProperties: const TabBarProperties(
          height: 50.0,
          indicatorColor: FColors.grey_0,
          indicatorWeight: 5.0,
          labelColor: FColors.blue,
          unselectedLabelColor: FColors.black,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
        views: const [
          ScreenMyPageFeedback(),
          ScreenMyPageTrainer(),
          ScreenMyPageGalley(),
          ScreenMyPageHistory(),
        ],
        onChange: (index) => print(index),
      ),
    );
  }
}