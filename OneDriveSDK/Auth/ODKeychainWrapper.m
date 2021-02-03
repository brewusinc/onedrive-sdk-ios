//  Copyright 2015 Microsoft Corporation
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

#import "ODKeychainWrapper.h"

#import <ADAL/ADKeychainTokenCache.h>
#import <ADAL/ADTokenCacheItem.h>
//#import <ADAL/ADAuthenticationContext.h>
//#import <ADAL/ADTokenCacheStoreKey.h>
//#import <ADAL/ADTokenCacheStoreItem.h>

#import <ADAL/ADUserInformation.h>
#import <Base32/MF_Base32Additions.h>

#import "ODAccountSession.h"
#import "ODAuthConstants.h"
#import "ODAADAccountBridge.h"
#import "ODServiceInfo.h"


@interface ODKeychainWrapper ()

@property ADKeychainTokenCache *keychainStore;

@end

@implementation ODKeychainWrapper

- (instancetype)init
{
    self = [super init];
    if (self){
        _keychainStore = [[ADKeychainTokenCache alloc] initWithGroup:nil];
    }
    return self;
}


- (void)addOrUpdateAccount:(ODAccountSession *)account
{
    NSParameterAssert(account);

    ADTokenCacheStoreItem *accountItem = [ODAADAccountBridge cacheItemFromAccountSession:account];
    ADAuthenticationError *authError = nil;
//    [self.keychainStore addOrUpdateItem:accountItem error:&authError];
}


- (ODAccountSession *)readFromKeychainWithAccountId:(NSString *)accountId serviceInfo:(ODServiceInfo *)serviceInfo
{
    NSParameterAssert(accountId);
    
    NSString *adalSafeUserId = [ODAADAccountBridge adalSafeUserIdFromString:accountId];
    ADTokenCacheKey *accountKey = [self cacheKeyFromServiceInfo:serviceInfo];
    // !!!: 確認タグ
//    ADTokenCacheItem *item =[self.keychainStore getItemWithKey:accountKey userId:adalSafeUserId error:nil];
    NSArray<ADTokenCacheItem *> *items =[self.keychainStore allItems:nil];
    ADTokenCacheItem *item = items.firstObject;
    ODAccountSession *session = nil;
    if (item){
        session = [ODAADAccountBridge accountSessionFromCacheItem:item serviceInfo:serviceInfo];
    }
    return session;
}


- (void)removeAccountFormKeychain:(ODAccountSession *)account
{
    NSParameterAssert(account);
    
    NSString *adalSafeUserId = [ODAADAccountBridge adalSafeUserIdFromString:account.accountId];
    ADTokenCacheKey *key = [self cacheKeyFromServiceInfo:account.serviceInfo];
    
    // !!!: 確認タグ
//    [self.keychainStore removeItemWithKey:key userId:adalSafeUserId error:nil];
//    account.serviceInfo.
//    self.keychainStore removeItem:<#(nonnull ADTokenCacheItem *)#> error:<#(ADAuthenticationError * _Nullable __autoreleasing * _Nullable)#>
    
}

- (ADTokenCacheKey *)cacheKeyFromServiceInfo:(ODServiceInfo *)serviceInfo
{
    
    // !!!: 確認タグ
    return nil;
//    return [ADTokenCacheKey keyWithAuthority:serviceInfo.authorityURL resource:serviceInfo.resourceId clientId:serviceInfo.appId error:nil];
}

@end

