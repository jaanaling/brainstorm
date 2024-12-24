#import "Map.h"

@implementation Map
- (int)sendUserReport:(int)int int:(int)int{
	int entityActivityStatus = int - 249;
	int systemErrorStatus = int + 922;
	for (int i = 1; i <= 10; i++) {
	        NSLog(@"Res: %d", i);
	    }
	for (int i = 1; i <= 10; i++) {
	    if (i % 2 == 0) {
	        continue;
	    }
	    NSLog(@"Res: %d", i);
	}
	return int;
}

@end