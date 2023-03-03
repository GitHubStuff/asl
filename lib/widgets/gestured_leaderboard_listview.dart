import 'package:asl_quiz/classes/gesture_leader_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cubit/gesture_cubit.dart';

final GestureCubit gestureCubit = Modular.get<GestureCubit>();

class GestureLeaderBoardListView extends StatelessWidget {
  const GestureLeaderBoardListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeaderBoardItem> list = gestureCubit.leaderBoardList;
    return SingleChildScrollView(
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            LeaderBoardItem leaderBoardItem = list[index];
            String title = (leaderBoardItem.leaderBoardItemEnum == LeaderBoardItemEnum.missed) ? 'Times missed: ${leaderBoardItem.count}' : 'You passed on this';
            return ListTile(
              title: Text(title),
              leading: Icon(
                Icons.error_outline,
                color: (leaderBoardItem.leaderBoardItemEnum == LeaderBoardItemEnum.missed) ? Colors.redAccent : Colors.blueAccent,
              ),
              trailing: SizedBox(
                height: 60.0,
                child: leaderBoardItem.aslImage.answerImage,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: list.length),
    );
  }
}
