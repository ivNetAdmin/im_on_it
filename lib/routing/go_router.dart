import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/home/home_view_model.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/settings/widgets/settings_screen.dart';
import '../ui/task_history/task_history_view_model.dart';
import '../ui/task_history/widgets/task_history_screen.dart';

GoRouter appRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path:'/',
        builder: (context, state) {
          final viewModel = HomeViewModel(taskRepository: context.read());
          return HomeScreen(viewModel: viewModel);
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'completed-tasks',
            builder: (context, state) {
              final viewModel = TaskHistoryViewModel(taskRepository: context.read());
              return TaskHistoryScreen(viewModel: viewModel);
            },
          ),GoRoute(
            path: 'settings',
            builder: (context, state) {
              //final viewModel = HomeViewModel(taskRepository: context.read());
              //return HomeScreen(viewModel: viewModel);
              return SettingsScreen();
            },
          ),
        ]
      )
    ]
);
