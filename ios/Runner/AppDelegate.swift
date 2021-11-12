import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    var config: [String: String]?
            
    if let infoPlistPath = Bundle.main.url(forResource: "key", withExtension: "plist") {
        do {
            let infoPlistData = try Data(contentsOf: infoPlistPath)
            
            if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: String] {
                config = dict
            }
        } catch {
            print(error)
        }
    }

    let google_map_key = config?["google_map_key"] ?? ""
    GMSServices.provideAPIKey(google_map_key)

    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
