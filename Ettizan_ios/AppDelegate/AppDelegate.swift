//
//  AppDelegate.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

#if DEBUG
import CocoaDebug
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupAppDelegate()
        initview()
        return true
    }
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Ettizan_ios")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}



extension AppDelegate {
    func setupAppDelegate() {
        Language.setCurrentLanguage(lang: .arabic)
        Localizer.localize()
        
        let attributes = [NSAttributedString.Key.font: UIFont.getFont(fontSize: 16)]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        
#if canImport(RestKit)
        BaseModel.sharedInstance.modelSetup()
#endif
#if DEBUG
        CocoaDebug.enable()
        CocoaDebugSettings.shared.showBubbleAndWindow = false
        self.setupShortcuts()
#endif
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .white
        IQKeyboardManager.shared.placeholderColor = .white
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarBarTintColor = .hexColor(hex: "22C1D3")
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = false
        IQKeyboardManager.shared.placeholderFont = UIFont.getFont(fontSize: 20)
        
        if #available(iOS 13.0, *) {
            self.window?.rootViewController?.overrideUserInterfaceStyle = .light
        }
    }
}




// MARK: - Shortcut Menu Configeration
extension AppDelegate {
    func setupShortcuts(){
        var shortcutItems = [UIApplicationShortcutItem]()
        
        shortcutItems.append(UIApplicationShortcutItem(type: "com.iMech.app_info",
                                                       localizedTitle: "App Info",
                                                       localizedSubtitle: "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "-1") | (\(Bundle.main.infoDictionary?["CFBundleVersion"] ?? "-1"))",
                                                       icon: UIApplicationShortcutIcon(type: .task),
                                                       userInfo: nil))
        
        shortcutItems.append(UIApplicationShortcutItem(type: "com.iMech.clear_app",
                                                       localizedTitle: "Clear App",
                                                       localizedSubtitle: "clear app data",
                                                       icon: UIApplicationShortcutIcon(type: .confirmation),
                                                       userInfo: nil))
        
        UIApplication.shared.shortcutItems = shortcutItems
    }
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.iMech.clear_app" {
            let alertController = UIAlertController(title: "Alert", message:"Do you want to clear app\nApplication will close after clearing data", preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title: "App only", style:.destructive, handler: { (action) in
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                }
                exit(0)
            }))
            alertController.addAction(UIAlertAction(title: "App With DB", style:.destructive, handler: { (action) in
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                }
                //                do {
                //                    let storeUrl = URL(string:String(format: "\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])%@.sqlite", GlobalConstants.DataBaseName) )
                //                    try FileManager.default.removeItem(at: storeUrl!)
                //                    exit(0)
                //                } catch {
                //                    print("Could not delete file: \(error)")
                //                    exit(0)
                //                }
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style:.cancel, handler: { (action) in
                
            }))
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}



extension AppDelegate{
    
    
    func initview(){
        
        localizeViewAppearance()
        
        let storyboard : UIStoryboard?
        let initialViewController : UIViewController?
        
        if Cache.shared.isFirstTime == nil {
            storyboard = UIStoryboard(name: "onboardingVC", bundle: nil)
            initialViewController = storyboard?.instantiateViewController(withIdentifier: "onboardingVC") as! onboardingVC
            
        }else{
            storyboard = UIStoryboard(name: "Login", bundle: nil)
            initialViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            
        }
        // Language.setCurrentLanguage(lang: .arabic)
        //        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        //        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        //        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        
        //        let storyboard = UIStoryboard(name: "onboardingVC", bundle: nil)
        //        let initialViewController = storyboard.instantiateViewController(withIdentifier: "onboardingVC") as! onboardingVC
                
        let navigationController = UINavigationController(rootViewController: initialViewController!)
        initialViewController?.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController

        
        //UIApplication.shared.windows.first?.rootViewController = initialViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.window?.makeKeyAndVisible()
        
        
    }
    
    
    fileprivate func localizeViewAppearance() {
        UIView.appearance().semanticContentAttribute = Language.isRTL ? .forceRightToLeft : .forceLeftToRight
        UINavigationBar.appearance().semanticContentAttribute = Language.isRTL ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().semanticContentAttribute = Language.isRTL ? .forceRightToLeft : .forceLeftToRight
        UICollectionView.appearance().semanticContentAttribute = Language.isRTL ? .forceRightToLeft : .forceLeftToRight
    }
}
