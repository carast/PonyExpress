//
//  PEOSCSender.h
//  PonyExpress
//
//  Created by Jean-Pierre Mouilleseaux on 2 Sept 2011.
//  Copyright (c) 2011 Chorded Constructions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PEOSCMessage;

@interface PEOSCSender : NSObject
+ (id)senderWithHost:(NSString*)host port:(UInt16)port;
- (id)initWithHost:(NSString*)host port:(UInt16)port;

@property (nonatomic, readonly, strong) NSString* host;
@property (nonatomic, readonly) UInt16 port;
@property (nonatomic, readonly, getter = isConnected) BOOL connected;

- (BOOL)connect;
- (BOOL)disconnect;

- (void)sendMessage:(PEOSCMessage*)message;
@end
