

import 'package:flutter/material.dart';

import '../../shared_widgets/shared_app_bar.dart';
import '../task_history_view_model.dart';

class TaskHistoryScreen extends StatelessWidget {
  const TaskHistoryScreen({super.key,
    required this.viewModel
  });

  final TaskHistoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: SafeArea(
          child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SharedAppBar(),
                    SliverList.builder(
                        itemCount: viewModel.taskHistoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title:Text(viewModel.taskHistoryList[index].taskId.toString() + ' ' + viewModel.taskHistoryList[index].description + ' ' + viewModel.taskHistoryList[index].lastCompletedDate.toString()),
                          );
                        }
                    ),
                  ],
                );
              }
          ),
        )
    );
  }
}