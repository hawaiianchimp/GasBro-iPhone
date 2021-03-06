//
//  GBAppDelegate.m
//  GasBro
//
//  Created by Sean Thomas Burke on 9/26/13.
//  Copyright (c) 2013 Nyquist Labs. All rights reserved.
//

#import "GBAppDelegate.h"
#import "GAI.h"
#import "GBCache.h"
#import <Parse/Parse.h>
#import <ParseCrashReporting/ParseCrashReporting.h>
#import <Appirater.h>

@implementation GBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    #ifdef DEBUG
//    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
//    #endif
    
    [Parse enableLocalDatastore];
    [ParseCrashReporting enable];
    
    [Parse setApplicationId:@"XaOZLlEYM0Iu49oTedAm1gqQM895vkV66F8RNSL7"
                  clientKey:@"X4PQqGJePMEIGy9i5ziOUngf9ouzBtxdC30VGf0z"];
    
    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    [PFUser enableAutomaticUser];
    
    [[PFUser currentUser] incrementKey:@"appOpened"];
    [[PFUser currentUser] setObject:@"iPhone" forKey:@"Device"];
    [[PFUser currentUser] saveInBackground];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-42611920-1"];
    
    
    [Appirater appLaunched:YES];
    [Appirater setAppId:@"798634160"];
    [Appirater setOpenInAppStore:YES];
    [Appirater setTimeBeforeReminding:3];
    [Appirater setSignificantEventsUntilPrompt:10];
    [Appirater setUsesUntilPrompt:3];
    [Appirater setUsesAnimation:YES];
    [Appirater setDebug:NO];
    
//    [Appirater setCustomAlertCancelButtonTitle:@"I hate it"];
//    [Appirater setCustomAlertRateButtonTitle:@"I like it"];
//    [Appirater setCustomAlertRateLaterButtonTitle:@"Rate later"];
//    [Appirater setCustomAlertTitle:@"Like this app?"];
//    [Appirater setCustomAlertMessage:@"Help a brother out"];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end