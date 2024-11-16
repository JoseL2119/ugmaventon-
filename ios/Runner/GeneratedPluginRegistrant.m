//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_osm_plugin/FlutterOsmPlugin.h>)
#import <flutter_osm_plugin/FlutterOsmPlugin.h>
#else
@import flutter_osm_plugin;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<pointer_interceptor_ios/PointerInterceptorIosPlugin.h>)
#import <pointer_interceptor_ios/PointerInterceptorIosPlugin.h>
#else
@import pointer_interceptor_ios;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterOsmPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterOsmPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [PointerInterceptorIosPlugin registerWithRegistrar:[registry registrarForPlugin:@"PointerInterceptorIosPlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
}

@end
