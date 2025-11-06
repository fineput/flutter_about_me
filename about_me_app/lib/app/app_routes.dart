import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/about_view.dart';
import '../views/user_form_view.dart';
import '../models/user_model.dart';

class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String form = '/form'; // ✅ Додали цей маршрут

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: about,
        builder: (context, state) {
          final user = state.extra as UserModel;
          return AboutView(
            name: user.name,
            description: user.description,
          );
        },
      ),
      GoRoute(
        path: form,
        builder: (context, state) => const UserFormView(), // ✅ для створення резюме
      ),
    ],
  );
}
