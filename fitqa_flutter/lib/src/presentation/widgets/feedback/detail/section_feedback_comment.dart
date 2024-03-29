import 'package:fitqa/src/application/feedback/feedback_detail.dart';
import 'package:fitqa/src/application/storage/user_token_facade.dart';
import 'package:fitqa/src/application/user/user_profile.dart';
import 'package:fitqa/src/common/time_utils.dart';
import 'package:fitqa/src/domain/entities/feedback/feedback_comment/feedback_comment.dart';
import 'package:fitqa/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SectionFeedbackComment extends ConsumerWidget {
  SectionFeedbackComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedback = ref.watch(feedbackDetailProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          feedback.maybeWhen(
              success: (feedback) {
                return Column(
                    children: feedback.comments
                        .map((comment) =>
                            _SectionFeedbackComment(comment: comment))
                        .toList());
              },
              orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  )),
          _SectionFeedbackWrite(),
        ],
      ),
    );
  }
}

class _SectionFeedbackComment extends StatelessWidget {
  _SectionFeedbackComment({Key? key, required this.comment}) : super(key: key);

  FeedbackComment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.writer.name,
            style: TextStyle(
                fontSize: 14,
                color: FColors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.comment,
                style: TextStyle(fontSize: 14, color: FColors.black),
              ),
              Row(
                children: [
                  Text(
                    TimeUtils.timeAgo(comment.createdAt),
                    style: TextStyle(fontSize: 10, color: FColors.black),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "좋아요 1개",
                    style: TextStyle(fontSize: 10, color: FColors.black),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _SectionFeedbackWrite extends ConsumerWidget {
  _SectionFeedbackWrite({Key? key}) : super(key: key);

  final _commentProvider = StateProvider<String>((ref) => "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackController = ref.watch(feedbackDetailProvider.notifier);
    final commentContentController = ref.watch(_commentProvider.notifier);

    final userToken = ref.watch(userTokenProvider);
    final userProfile = ref.watch(userProfileProvider);

    return Container(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userProfile.maybeWhen(
            success: (user) {
              return CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(user.photoURL),
              );
            },
            orElse: () => const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              onChanged: (value) => {commentContentController.state = value},
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), hintText: "댓글쓰기"),
            ),
          ),
          TextButton(
              onPressed: () {
                feedbackController.addComment(
                  userToken,
                  commentContentController.state,
                );
              },
              child: Text(
                "게시",
                style: TextStyle(fontSize: 14, color: FColors.grey_3),
              ))
        ],
      ),
    );
  }
}
