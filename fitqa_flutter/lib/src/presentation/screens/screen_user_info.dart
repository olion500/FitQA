import 'package:fitqa/src/application/user/user_info.dart';
import 'package:fitqa/src/presentation/home.dart';
import 'package:fitqa/src/presentation/widgets/common/fitqa_appbar_sub.dart';
import 'package:fitqa/src/presentation/widgets/common/form/fitqa_big_button.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_birth.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_name.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_optional.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_physical.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_title.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_workout_level.dart';
import 'package:fitqa/src/presentation/widgets/user_info/section_user_info_workout_style.dart';
import 'package:fitqa/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenUserInfo extends ConsumerWidget {
  const ScreenUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: FColors.white,
        appBar: FitqaAppbarSub(
          title: '운동정보 입력',
          centerTitle: true,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
            // Navigator.pop(context);
          },
          foregroundColor: FColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: ListView(
            children: [
              const SizedBox(
                height: 32,
              ),
              SectionUserInfoTitle(),
              const SizedBox(
                height: 26,
              ),
              SectionUserName(),
              const SizedBox(
                height: 26,
              ),
              SectionUserInfoBirth(),
              const SizedBox(height: 38),
              SectionUserInfoWorkoutLevel(),
              const SizedBox(
                height: 38,
              ),
              SectionUserInfoWorkoutStyle(),
              const SizedBox(
                height: 38,
              ),
              SectionUserInfoPhysical(),
              const SizedBox(
                height: 60,
              ),
              SectionUserInfoOptional(),
              const SizedBox(
                height: 60,
              ),
              FitqaBigButton(
                text: "완료",
                filled: true,
                onPressed: () {
                  _sendUserInfo(ref);
                },
              ),
              const SizedBox(
                height: 33,
              ),
            ],
          ),
        ));
  }

  void _sendUserInfo(WidgetRef ref) {
    final userName = ref.read(userInfoNameProvider);
    final userBirth = ref.read(userInfoBirthProvider);
    final workoutLevel = ref.read(userInfoWorkoutLevelProvider);
    final workoutStyle = ref.read(userInfoWorkoutStyleProvider);
    final height = ref.read(userInfoHeightProvider);
    final weight = ref.read(userInfoWeightProvider);
    final fat = ref.read(userInfoFatProvider);
    final muscle = ref.read(userInfoMuscleMassProvider);
    print(userName);
    print(userBirth);
    print(workoutLevel);
    print(workoutStyle);
    print(height);
    print(weight);
    print(fat);
    print(muscle);
  }
}
