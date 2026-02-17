@echo off
set "JAVA_HOME=C:\Java17"
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo JAVA_HOME is set to: %JAVA_HOME%
echo Testing Java version:
java -version
echo.
echo Running Flutter app...
flutter clean
flutter run