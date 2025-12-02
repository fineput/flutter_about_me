import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:about_me_app/viewmodels/theme_viewmodel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeViewModel tests', () {
    test('default theme should be light (isDark = false)', () async {
      // Порожні дані в SharedPreferences
      SharedPreferences.setMockInitialValues({});

      final vm = ThemeViewModel();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(vm.isDark, false);
    });

    test('toggleTheme should switch theme and save it', () async {
      SharedPreferences.setMockInitialValues({});

      final vm = ThemeViewModel();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(vm.isDark, false);

      await vm.toggleTheme();
      expect(vm.isDark, true);

      // Перевірка факту збереження
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(ThemeViewModel.themeKey), true);
    });

    test('should load saved theme on startup', () async {
      SharedPreferences.setMockInitialValues({
        ThemeViewModel.themeKey: true,
      });

      final vm = ThemeViewModel();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(vm.isDark, true);
    });
  });
}
