//
//  HashTable.h
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/13/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

-(void)setObject:(id)object forKey:(NSString*)key;
-(void)removeObjectForKey:(NSString *)key;
-(id)objectForKey:(NSString*)key;
-(instancetype)initWithSize:(NSInteger)size;


@end
