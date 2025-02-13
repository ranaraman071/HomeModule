import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_bar_project/data/providers/language_cubit/language_cubit.dart';
import 'package:score_bar_project/localization/l10n/app_localization.dart';
import 'package:score_bar_project/presentation/screens/slider_UI.dart';
import 'package:score_bar_project/utils/bloc_providers.dart';
import 'package:score_bar_project/utils/navigator_services.dart';

Future<void>  main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final languageCubit = LanguageCubit();
  await languageCubit.loadSavedLanguage();
  runApp(MyApp(languageCubit: languageCubit));
}

class MyApp extends StatelessWidget {
  final LanguageCubit languageCubit;
  MyApp({super.key,required this.languageCubit});
  final NavigatorService navigatorService = NavigatorService();
  Locale? _locale;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.getAllProviders(),
      child:  BlocBuilder<LanguageCubit, String>(builder: (context, languageCode){return MaterialApp(
        locale: Locale(languageCode),
        supportedLocales: const [
          Locale('en'), // English
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],

        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorService.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SliderBlocUI(),
      );}),
    );
  }
}

