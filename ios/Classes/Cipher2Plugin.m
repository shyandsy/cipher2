#import "Cipher2Plugin.h"
#import <cipher2/cipher2-Swift.h>

@implementation Cipher2Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCipher2Plugin registerWithRegistrar:registrar];
}
@end
