#import <Foundation/Foundation.h>

@interface Client : NSObject
{
    NSString * _profileNumber;
    NSString * _firstName;
    NSString * _middleName;
    NSString * _lastName;
    NSString * _info;
    NSString * _photoFileName;
    NSDate   * _lastVisitDate;
    NSString * _subUrb;
    NSString * _age;
}

@property (strong, nonatomic) NSString * profileNumber;
@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * middleName;
@property (strong, nonatomic) NSString * lastName;
@property (strong, nonatomic) NSString * photoFileName;
@property (strong, nonatomic) NSString * info;
@property (strong, nonatomic) NSDate * lastVisitDate;
@property (strong, nonatomic) NSString * subUrb;
@property (strong, nonatomic) NSString * age;
@end
