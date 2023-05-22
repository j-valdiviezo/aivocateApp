import 'package:ai_vocate/navigation/app_router.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:ai_vocate/providers/chats_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00658B),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFC4E7FF),
  onPrimaryContainer: Color(0xFF001E2C),
  secondary: Color(0xFF4E616D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD1E5F4),
  onSecondaryContainer: Color(0xFF0A1E28),
  tertiary: Color(0xFF615A7D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE7DEFF),
  onTertiaryContainer: Color(0xFF1D1736),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFBFCFF),
  onBackground: Color(0xFF191C1E),
  surface: Color(0xFFFBFCFF),
  onSurface: Color(0xFF191C1E),
  surfaceVariant: Color(0xFFDDE3EA),
  onSurfaceVariant: Color(0xFF41484D),
  outline: Color(0xFF71787E),
  onInverseSurface: Color(0xFFF0F1F3),
  inverseSurface: Color(0xFF2E3133),
  inversePrimary: Color(0xFF7DD0FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00658B),
  outlineVariant: Color(0xFFC0C7CD),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7DD0FF),
  onPrimary: Color(0xFF00344A),
  primaryContainer: Color(0xFF004C69),
  onPrimaryContainer: Color(0xFFC4E7FF),
  secondary: Color(0xFFB6C9D7),
  onSecondary: Color(0xFF20333E),
  secondaryContainer: Color(0xFF374955),
  onSecondaryContainer: Color(0xFFD1E5F4),
  tertiary: Color(0xFFCAC1E9),
  onTertiary: Color(0xFF322C4C),
  tertiaryContainer: Color(0xFF494264),
  onTertiaryContainer: Color(0xFFE7DEFF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1E),
  onBackground: Color(0xFFE1E2E5),
  surface: Color(0xFF191C1E),
  onSurface: Color(0xFFE1E2E5),
  surfaceVariant: Color(0xFF41484D),
  onSurfaceVariant: Color(0xFFC0C7CD),
  outline: Color(0xFF8B9297),
  onInverseSurface: Color(0xFF191C1E),
  inverseSurface: Color(0xFFE1E2E5),
  inversePrimary: Color(0xFF00658B),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF7DD0FF),
  outlineVariant: Color(0xFF41484D),
  scrim: Color(0xFF000000),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();
  final _chatsManager = ChatsManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      chatsManager: _chatsManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _appStateManager),
        ChangeNotifierProvider.value(value: _chatsManager),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI.Vocate',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
