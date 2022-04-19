import 'package:fitqa/src/application/storage/trainer_token_facade.dart';
import 'package:fitqa/src/application/trainer/trainer_detail.dart';
import 'package:fitqa/src/common/fitqa_icon.dart';
import 'package:fitqa/src/presentation/screens/screen_edit_trainer_detail.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_career_list.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_career_summary.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_feedback_tab.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_flexible_space.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_introduce.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_license_list.dart';
import 'package:fitqa/src/presentation/widgets/trainer/detail/trainer_sns.dart';
import 'package:fitqa/src/theme/color.dart';
import 'package:fitqa/src/theme/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenTrainerDetail extends ConsumerWidget {
  const ScreenTrainerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainerDetail = ref.watch(trainerDetailProvider);
    final ownerTrainerToken = ref.watch(trainerTokenProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: trainerDetail.maybeWhen(
            orElse: () => [_buildLoading()],
            success: (_) => [
                  buildAppBar(context, ownerTrainerToken),
                  buildContext(),
                  buildFeedbackListView()
                ]),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, String trainerToken) {
    return SliverAppBar(
      backgroundColor: FColors.black,
      expandedHeight: FDimen.trainerDetailExpandedHeight,
      title: Transform(
        transform: Matrix4.translationValues(-20, 0, 0),
        child: const Text('목록'),
      ),
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(FitQaIcon.back),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: trainerToken.isEmpty
                ? _buildFavoriteAction()
                : _buildModifyAction(context))
      ],
      centerTitle: false,
      flexibleSpace: const TrainerFlexibleSpace(),
    );
  }

  Widget buildContext() => SliverToBoxAdapter(
          child: Container(
        color: FColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TrainerIntroduce(),
            TrainerSns(),
            TrainerCareerSummary(),
            TrainerCareerList(),
            TrainerLicenseList(),
          ],
        ),
      ));

  Widget _buildLoading() => const SliverToBoxAdapter(
      child: Center(child: CircularProgressIndicator()));

  Widget _buildModifyAction(BuildContext context) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ScreenEditTrainerDetail())),
        child: const Icon(FitQaIcon.modification),
      );

  Widget _buildFavoriteAction() => InkWell(
        onTap: () => {},
        child: const Icon(FitQaIcon.star),
      );

  Widget buildFeedbackListView() => const SliverFillRemaining(
      hasScrollBody: true, child: TrainerFeedbackTab());
}
