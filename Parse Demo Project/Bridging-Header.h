//
//  Bridging-Header.h
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

#import <FirebaseAuth/FirebaseAuth.h>
#import <Parse/PFQuery.h>
#import <Parse/PFQueryConstants.h>

@interface PFQuery (Private)
- (instancetype)whereKey:(NSString *)key condition:(NSString *)condition object:(id)object;
@end
