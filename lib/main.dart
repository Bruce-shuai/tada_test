import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_video/generated/l10n.dart';
import 'package:tada_video/views/screens/home/creator_screen.dart';
import 'package:tada_video/views/screens/profile/profile_feedback.dart';
import 'api/token_manager.dart';
import 'l10n/l10n.dart';
import 'constants/color_constants.dart';
import 'views/screens/home/home_screen.dart';
import 'views/screens/upload/upload_screen.dart';
import 'views/screens/profile/profile_screen.dart';
import 'views/screens/profile/profile_setting_screen.dart';
import 'views/screens/auth/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'constants/route_constants.dart';

void main() async {
  // 应用打开初始化加载页面
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 初始化 TokenManager
  await TokenManager.init();

  // 运行应用
  runApp(const MyApp());
}

// 路由
class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Route'), //在导航栏中设置页面标题
      ),
      body: const Center(
        child: Text('404, Page Not Found!'), //在页面中心显示错误信息
      ),
    );
  }
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.upload,
      page: () => const UploadScreen(),
    ),
    GetPage(name: Routes.profile, page: () => const ProfileScreen()),
    GetPage(
      name: Routes.profileSettings,
      page: () => const ProfileSettingScreen(),
    ),
    GetPage(name: Routes.profileFeedback, page: () => const ProfileFeedback()),
    GetPage(name: Routes.creator, page: () => const CreatorScreen()),
    GetPage(name: Routes.notFound, page: () => const UnknownRoutePage())
  ];
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // whenever your initialization is completed, remove the splash
    Future.delayed(const Duration(seconds: 5))
        .then((value) => FlutterNativeSplash.remove());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaDa',
      theme: ThemeData.dark(),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: AppColor.bgBlack,
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: [
        const Locale('en', ''),
        ...S.delegate.supportedLocales,
      ],
      unknownRoute: AppPages.routes[AppPages.routes.length - 1],
      initialRoute: Routes.login,
      getPages: AppPages.routes,
    );
  }
}
