//
//  PEOSCSender.m
//  PonyExpress
//
//  Created by Jean-Pierre Mouilleseaux on 2 Sept 2011.
//  Copyright (c) 2011 Chorded Constructions. All rights reserved.
//

#import "PEOSCSender.h"
#import "PonyExpress-Internal.h"
#import "PEOSCMessage.h"
#import "PEOSCMessage-Private.h"
#import "AsyncUdpSocket.h"

@interface PEOSCSender()
@property (nonatomic, readwrite, strong) NSString* host;
@property (nonatomic, readwrite) UInt16 port;
@property (nonatomic, strong) AsyncUdpSocket* socket;
@property (nonatomic, readwrite, getter = isConnected) BOOL connected;
- (void)_setupSocket;
- (void)_tearDownSocket;
@end

@implementation PEOSCSender

@synthesize socket, host, port, connected;

+ (id)senderWithHost:(NSString*)host port:(UInt16)port {
    PEOSCSender* sender = [[PEOSCSender alloc] initWithHost:host port:port];
    return sender;
}

- (id)initWithHost:(NSString*)hos port:(UInt16)por {
    self = [super init];
    if (self) {
        self.host = hos;
        self.port = por;

        [self _setupSocket];
    }
    return self;
}

- (void)dealloc {
    [self _tearDownSocket];
}

#pragma mark -

- (NSString*)description {
    return [NSString stringWithFormat:@"<%@: %@:%d>", NSStringFromClass([self class]), self.host, self.port];
}

#pragma mark -

- (BOOL)connect {
    if (self.isConnected)
        return NO;

    NSError* error = nil;
    BOOL status = [self.socket connectToHost:self.host onPort:self.port error:&error];
    if (!status) {
        CCErrorLog(@"ERROR - failed to connect to host: %@:%d - %@", self.host, self.port, [error localizedDescription]);
        return NO;
    }

    self.connected = YES;
    return self.isConnected;
}

- (BOOL)disconnect {
    if (!self.isConnected)
        return NO;
    [self.socket close];

    self.connected = NO;
    return !self.isConnected;
}

- (void)sendMessage:(PEOSCMessage*)message {
    if (!self.isConnected) {
        CCErrorLog(@"ERROR - cannot send message when disconnected");
        return;
    }

    NSData* messageData = [message _data];
    if (!messageData) {
        CCErrorLog(@"ERROR - failed to send message: %@", message);
        return;
    }

    BOOL status = [self.socket sendData:messageData withTimeout:0 tag:13];
    if (!status) {
        CCWarningLog(@"WARNING - failed to send message: %@ to %@:%@", message, self.host, self.port);
    }
}

#pragma mark - SOCKET DELEGATE

- (void)onUdpSocketDidClose:(AsyncUdpSocket*)sock {
    CCDebugLogSelector();
}

- (void)onUdpSocket:(AsyncUdpSocket*)sock didSendDataWithTag:(long)tag {
    CCDebugLogSelector();
}

- (void)onUdpSocket:(AsyncUdpSocket*)sock didNotSendDataWithTag:(long)tag dueToError:(NSError*)error {
    CCDebugLogSelector();
}

#pragma mark - PRIVATE
 
 - (void)_setupSocket {
     AsyncUdpSocket* soc = [[AsyncUdpSocket alloc] initWithDelegate:self];
     self.socket = soc;
}

- (void)_tearDownSocket {
    self.socket = nil;
}

@end
