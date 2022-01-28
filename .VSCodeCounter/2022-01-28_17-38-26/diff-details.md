# Diff Details

Date : 2022-01-28 17:38:26

Directory c:\Programovanie\Flutter\Projects\GiulioTranslator

Total : 57 files,  3855 codes, 386 comments, 322 blanks, all 4563 lines

[summary](results.md) / [details](details.md) / [diff summary](diff.md) / diff details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [README.md](/README.md) | Markdown | 10 | 0 | 7 | 17 |
| [android/app/build.gradle](/android/app/build.gradle) | Groovy | 49 | 3 | 11 | 63 |
| [android/app/google-services.json](/android/app/google-services.json) | JSON | 55 | 0 | 0 | 55 |
| [android/app/src/debug/AndroidManifest.xml](/android/app/src/debug/AndroidManifest.xml) | XML | 4 | 3 | 1 | 8 |
| [android/app/src/main/AndroidManifest.xml](/android/app/src/main/AndroidManifest.xml) | XML | 34 | 11 | 4 | 49 |
| [android/app/src/main/res/drawable-v21/launch_background.xml](/android/app/src/main/res/drawable-v21/launch_background.xml) | XML | 4 | 7 | 2 | 13 |
| [android/app/src/main/res/drawable/launch_background.xml](/android/app/src/main/res/drawable/launch_background.xml) | XML | 4 | 7 | 2 | 13 |
| [android/app/src/main/res/values-night/styles.xml](/android/app/src/main/res/values-night/styles.xml) | XML | 9 | 9 | 1 | 19 |
| [android/app/src/main/res/values/styles.xml](/android/app/src/main/res/values/styles.xml) | XML | 9 | 9 | 1 | 19 |
| [android/app/src/profile/AndroidManifest.xml](/android/app/src/profile/AndroidManifest.xml) | XML | 4 | 3 | 1 | 8 |
| [android/build.gradle](/android/build.gradle) | Groovy | 28 | 0 | 5 | 33 |
| [android/gradle.properties](/android/gradle.properties) | Properties | 4 | 0 | 1 | 5 |
| [android/gradle/wrapper/gradle-wrapper.properties](/android/gradle/wrapper/gradle-wrapper.properties) | Properties | 5 | 1 | 1 | 7 |
| [android/settings.gradle](/android/settings.gradle) | Groovy | 8 | 0 | 4 | 12 |
| [assets/icons/thumbs-up.svg](/assets/icons/thumbs-up.svg) | XML | 5 | 0 | 1 | 6 |
| [ios/Runner/AppDelegate.swift](/ios/Runner/AppDelegate.swift) | Swift | 12 | 0 | 2 | 14 |
| [ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json](/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | JSON | 122 | 0 | 1 | 123 |
| [ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json](/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json) | JSON | 23 | 0 | 1 | 24 |
| [ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md](/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md) | Markdown | 3 | 0 | 2 | 5 |
| [ios/Runner/Base.lproj/LaunchScreen.storyboard](/ios/Runner/Base.lproj/LaunchScreen.storyboard) | XML | 36 | 1 | 1 | 38 |
| [ios/Runner/Base.lproj/Main.storyboard](/ios/Runner/Base.lproj/Main.storyboard) | XML | 25 | 1 | 1 | 27 |
| [ios/Runner/Runner-Bridging-Header.h](/ios/Runner/Runner-Bridging-Header.h) | C++ | 1 | 0 | 1 | 2 |
| [lib/authentication_service.dart](/lib/authentication_service.dart) | Dart | 99 | 1 | 9 | 109 |
| [lib/main.dart](/lib/main.dart) | Dart | 70 | 0 | 8 | 78 |
| [lib/providers/language_selector_provider.dart](/lib/providers/language_selector_provider.dart) | Dart | 75 | 0 | 24 | 99 |
| [lib/providers/translate_text_provider.dart](/lib/providers/translate_text_provider.dart) | Dart | 51 | 1 | 11 | 63 |
| [lib/screens/ChatScreen.dart](/lib/screens/ChatScreen.dart) | Dart | 78 | 84 | 5 | 167 |
| [lib/screens/HomeScreen.dart](/lib/screens/HomeScreen.dart) | Dart | 71 | 39 | 7 | 117 |
| [lib/screens/RegisterScreen.dart](/lib/screens/RegisterScreen.dart) | Dart | 319 | 3 | 9 | 331 |
| [lib/screens/ScannerScreen.dart](/lib/screens/ScannerScreen.dart) | Dart | 62 | 17 | 9 | 88 |
| [lib/screens/SignInScreen.dart](/lib/screens/SignInScreen.dart) | Dart | 213 | 2 | 10 | 225 |
| [lib/widgets/Chat/ChatBodyWidget.dart](/lib/widgets/Chat/ChatBodyWidget.dart) | Dart | 102 | 1 | 7 | 110 |
| [lib/widgets/Chat/ChatHeadeWidget.dart](/lib/widgets/Chat/ChatHeadeWidget.dart) | Dart | 135 | 0 | 6 | 141 |
| [lib/widgets/Chat/MessageWidget.dart](/lib/widgets/Chat/MessageWidget.dart) | Dart | 48 | 0 | 7 | 55 |
| [lib/widgets/Chat/MessagesWidget.dart](/lib/widgets/Chat/MessagesWidget.dart) | Dart | 48 | 0 | 8 | 56 |
| [lib/widgets/Chat/Model/Message.dart](/lib/widgets/Chat/Model/Message.dart) | Dart | 33 | 0 | 7 | 40 |
| [lib/widgets/Chat/Model/User.dart](/lib/widgets/Chat/Model/User.dart) | Dart | 52 | 0 | 8 | 60 |
| [lib/widgets/Chat/NewMessageWidget.dart](/lib/widgets/Chat/NewMessageWidget.dart) | Dart | 62 | 0 | 7 | 69 |
| [lib/widgets/Chat/Page/ChatPage.dart](/lib/widgets/Chat/Page/ChatPage.dart) | Dart | 44 | 0 | 5 | 49 |
| [lib/widgets/Chat/Page/ChatsPage.dart](/lib/widgets/Chat/Page/ChatsPage.dart) | Dart | 47 | 0 | 5 | 52 |
| [lib/widgets/Chat/ProfieHeaderWIdget.dart](/lib/widgets/Chat/ProfieHeaderWIdget.dart) | Dart | 51 | 0 | 5 | 56 |
| [lib/widgets/Chat/SearchUsers.dart](/lib/widgets/Chat/SearchUsers.dart) | Dart | 103 | 1 | 5 | 109 |
| [lib/widgets/Chat/data.dart](/lib/widgets/Chat/data.dart) | Dart | 5 | 6 | 3 | 14 |
| [lib/widgets/Chat/firebase_api.dart](/lib/widgets/Chat/firebase_api.dart) | Dart | 103 | 11 | 20 | 134 |
| [lib/widgets/Chat/users.dart](/lib/widgets/Chat/users.dart) | Dart | 0 | 71 | 2 | 73 |
| [lib/widgets/Chat/utils.dart](/lib/widgets/Chat/utils.dart) | Dart | 21 | 0 | 8 | 29 |
| [lib/widgets/CustomDrawer.dart](/lib/widgets/CustomDrawer.dart) | Dart | 99 | 1 | 4 | 104 |
| [lib/widgets/Languages/LaguageSelector.dart](/lib/widgets/Languages/LaguageSelector.dart) | Dart | 292 | 6 | 13 | 311 |
| [lib/widgets/Languages/LanguagesList.dart](/lib/widgets/Languages/LanguagesList.dart) | Dart | 637 | 0 | 1 | 638 |
| [lib/widgets/OrDIvider.dart](/lib/widgets/OrDIvider.dart) | Dart | 39 | 0 | 4 | 43 |
| [lib/widgets/ProfileInfo.dart](/lib/widgets/ProfileInfo.dart) | Dart | 101 | 8 | 6 | 115 |
| [lib/widgets/Translator.dart](/lib/widgets/Translator.dart) | Dart | 262 | 2 | 15 | 279 |
| [lib/widgets/microsoft_translate_request.dart](/lib/widgets/microsoft_translate_request.dart) | Dart | 0 | 22 | 4 | 26 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 30 | 40 | 21 | 91 |
| [test/widget_test.dart](/test/widget_test.dart) | Dart | 0 | 0 | 2 | 2 |
| [web/index.html](/web/index.html) | HTML | 26 | 15 | 5 | 46 |
| [web/manifest.json](/web/manifest.json) | JSON | 23 | 0 | 1 | 24 |

[summary](results.md) / [details](details.md) / [diff summary](diff.md) / diff details