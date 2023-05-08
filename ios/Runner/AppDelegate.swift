import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let secretsPath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
       let secrets = NSDictionary(contentsOfFile: secretsPath),
       let googleMapsAPIKey = secrets["GOOGLE_MAPS_API_KEY"] as? String {
      GMSServices.provideAPIKey(googleMapsAPIKey)
    } else {
      fatalError("Unable to read Google Maps API key from Secrets.plist")
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
