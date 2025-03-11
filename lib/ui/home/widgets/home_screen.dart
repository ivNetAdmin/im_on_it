import 'package:flutter/material.dart';
import '../home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key
    , required this.viewModel
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListenableBuilder(
            listenable: viewModel.loadCmd,
        builder: (context, _) {
          return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(),
                ),
                SliverList.builder(
                  itemCount: viewModel.tasks.length,
                    itemBuilder: (_, index) => Text('${viewModel.tasks[index].timeSpan} ${viewModel.tasks[index].lastCompletedDate} ${viewModel.tasks[index].displayTimeLapsed()} ${viewModel.tasks[index].description}'),
                ),
              ],
          );
        }
          ),
      ),
    );
  }
}

