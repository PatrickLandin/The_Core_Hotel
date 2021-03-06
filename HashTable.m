//
//  HashTable.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/13/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "HashTable.h"
#import "Bucket.h"

@interface HashTable ()
@property (nonatomic) NSInteger size;
@property (strong,nonatomic) NSMutableArray *array;
@end

@implementation HashTable

-(instancetype)initWithSize:(NSInteger)size {
  self = [super init];
  if (self) {
    self.size = size;
    self.array = [NSMutableArray new];
    for (int i = 0; i <self.size; i++) {
      Bucket *bucket = [Bucket new];
      [self.array addObject:bucket];
    }
  }
  return self;
}

-(NSInteger)hash:(NSString *)key {
  NSInteger total = 0;
  for (int i = 0; i < key.length; i++) {
    NSInteger ascii = [key characterAtIndex:i];
    total = total + ascii;
  }
  NSInteger index = total % self.size;
  return index;
}

-(id)objectForKey:(NSString*)key {
  NSInteger index = [self hash:key];
  Bucket *bucket = self.array[index];
  while (bucket) {
    if ([bucket.key isEqualToString:key]) {
      return bucket.data;
    } else {
      bucket = bucket.next;
    }
  }
  return nil;
}

-(void)removeObjectForKey:(NSString *)key {
  NSInteger index = [self hash:key];
  Bucket *previousBucket;
  Bucket *bucket = self.array[index];
  while (bucket) {
    if ([key isEqualToString:bucket.key]) {
      if (!previousBucket) {
        Bucket *nextBucket = bucket.next;
        if (!nextBucket) {
          nextBucket = [Bucket new];
        }
        self.array[index] = nextBucket;
      } else {
        previousBucket.next = bucket.next;
      }
      return;
    }
    previousBucket = bucket;
    bucket = bucket.next;
  }
  return;
}

-(void)setObject:(id)object forKey:(NSString*)key {
  NSInteger index = [self hash:key];
  Bucket *bucket = [Bucket new];
  bucket.key = key;
  bucket.data = object;
  [self removeObjectForKey:key];
  Bucket *head = self.array[index];
  if (!head.data) {
    self.array[index] = bucket;
  } else {
    bucket.next = head;
    self.array[index] = bucket;
  }
}

@end
