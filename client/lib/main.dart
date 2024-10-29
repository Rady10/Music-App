import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music/core/providers/current_user_notifier.dart';
import 'package:music/core/theme/theme.dart';
import 'package:music/features/auth/view/pages/signup_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music/features/home/view/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('songs');
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPrefernces();
  await container.read(authViewmodelProvider.notifier).getData();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    )
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
@override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      theme: AppTheme.darkTheme,
      home: currentUser == null ? const SignupPage() : const HomePage(),
    );
  }
}
