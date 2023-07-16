# sinov8_tech_assignment

After Cloning This project, before you run make sure your enviroment align with the following.
[✓] Flutter (Channel stable, 3.10.2, on macOS 11.6 20G165 darwin-arm64, locale en-ZA)
[✓] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 13.2.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.1)
[✓] VS Code (version 1.80.0)
[✓] Connected device (3 available)
[✓] Network resources

Run: flutter doctor 


I utilized Hive's local memory functionality for storing the Spotify token and the artist list. In order to generate your Adapter, please execute the following command: 
flutter pub run build_runner build


flutter pub run build_runner build --delete-conflicting-outputs --build-filter=lib/Features/models/spotify/artist_model.dart


To regards with genre selection 

Due to the chosen UI architecture approach, it would require additional time and effort to refactor the UI in order to enable the population of the list of genres within the modal pop-up for user to select. As a result, in order to provide a quick solution, I have implemented a text field where users can manually input the desired genre instead of selecting from a pre-populated list. This alternative approach allows me to obtain the genre value as an argument based on the user's input, without the need for extensive UI changes at the moment.


