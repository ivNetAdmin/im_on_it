import 'package:flutter/material.dart';
import '../../shared_widgets/shared_app_bar.dart';
import '../task_history_edit_view_model.dart';

class TaskHistoryEditScreen extends StatelessWidget {
  const TaskHistoryEditScreen({super.key,
    required this.viewModel,
    required this.taskId
  });

  final String taskId;
  final TaskHistoryEditViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SharedAppBar(),
              SliverToBoxAdapter(
                child: Text(taskId),
              ),
            ],
          ),
        )
    );
  }
}