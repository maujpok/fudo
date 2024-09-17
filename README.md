# Fudo App

An user-friendly app that allows users to read posts from jsonplaceholder.com, see any post in detail, create a new one, and interactive searching of posts.
Also, includes a low authentication, simulated following all the necessary flow like in a real case.

## Getting Started

To build an APK to testing, you need to follow the next steps:
 - Create a file named ".env" in the root of project and write it with the required credentials (USER and PASS)
 - Execute the following command: flutter build apk --release --dart-define-from-file=.env
 - When build finish, you can get the apk from: build/app/outputs/flutter-apk/app-release.apk
