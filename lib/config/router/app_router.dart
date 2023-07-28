import 'package:bloc_exercises/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
  GoRoute(path: "/cubits", builder: (context, state) => const CubitCounterScreen()),
  GoRoute(path: "/bloc", builder: (context, state) => const BlocCounterScreen()),
  GoRoute(path: "/new-user", builder: (context, state) => const RegisterScreen()),
  GoRoute(path: "/notifications", builder: (context, state) => const NotificationsScreen()),
  GoRoute(path: "/notifications/:messageId", builder: (context, state) => NotificationDetailScreen(pushMessageId: state.pathParameters["messageId"] ?? "")),
]);
