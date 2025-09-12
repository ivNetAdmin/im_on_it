

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        backgroundColor: Colors.blueGrey.shade50,
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
                            shape: Border(
                              bottom: BorderSide(
                                  color: Colors.grey
                              ),
                            ),
                            leading: CircleAvatar(
                                backgroundColor: viewModel.taskHistoryList[index].repeat == true ? Colors.blueGrey[200] : Colors.blueGrey[50],
                                child: Icon(viewModel.getTypeIcon(
                                viewModel.taskHistoryList[index].type))),
                            title: Text(viewModel.taskHistoryList[index].description),
                              subtitle:  Text(viewModel.taskHistoryList[index].lastCompletedDateFormatted()
                                  + viewModel.taskHistoryList[index].timeSpanText()
                                  + viewModel.taskHistoryList[index].timePeriodText()
                              ),
                            trailing: Icon(Icons.keyboard_double_arrow_right),
                            onTap: (){
                              context.go('/completed-tasks-edit/${viewModel.taskHistoryList[index].taskId}');
                            },
                            onLongPress: () {
                              viewModel.rescheduleTask(context, viewModel.taskHistoryList[index]);
                            },
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