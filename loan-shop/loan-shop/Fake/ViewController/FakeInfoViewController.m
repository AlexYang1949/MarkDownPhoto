//
//  FakeInfoViewController.m
//  loan-shop
//
//  Created by Alex yang on 2017/7/5.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "FakeInfoViewController.h"
#import "FakeInfoCell.h"
#import "ProcessView.h"
#import "FakeResultController.h"
/// iOS 9前的框架
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>

#define Is_up_Ios_9 ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
@interface FakeInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,MyTextDelegate,ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic , strong) UIPickerView *picker;;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) UIToolbar *myToolbar;
@property (nonatomic , strong) FakeInfoCell *selectCell;

@end

@implementation FakeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ProcessView *pv =  [[[NSBundle mainBundle] loadNibNamed:@"FackHeader" owner:nil options:nil] lastObject];
    pv.frame = _topView.frame;
    pv.index = _index;
    [_topView addSubview:pv];
    if (_index==2) {
        [self loadAddressBook];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index==2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        return cell;
    }
    FakeInfoCell *fakeCell = [tableView dequeueReusableCellWithIdentifier:@"FakeInfoCell"];
    fakeCell.name = _titleArray[indexPath.row];
    fakeCell.delegate = self;
    fakeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return fakeCell;
}

-(BOOL)myTextViewDidBeginEditing:(UITextField *)textView{
    if ([self.view.subviews containsObject:_picker]) {
        [self cancelClick];
    }
    if (_index==1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        if([textView.superview.superview isEqual:[_tableView cellForRowAtIndexPath:indexPath]]){
            _selectCell = (FakeInfoCell *)textView.superview.superview;
            [self loadPickerViewAndToolbar];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (IBAction)nextPage:(UIButton *)sender {
    if (_index==3) {
        FakeResultController *resultVc = [self getViewController:@"FakeResultController" onStoryBoard:@"Fake"];
        [self.navigationController pushViewController:resultVc animated:YES];
    }else{
        FakeInfoViewController *fakeVc = [self getViewController:@"FakeInfoViewController" onStoryBoard:@"Fake"];
        fakeVc.index = _index+1;
        if (_index==1) {
            [self checkIdentify];
            return;
        }else if (_index==2){
            if (![self checkParent]) return;
            fakeVc.titleArray = @[@"父亲姓名",@"父亲手机号",@"母亲姓名",@"母亲手机号"];
        }
        [self.navigationController pushViewController:fakeVc animated:YES];
    }
}

- (BOOL)checkParent{
    NSString *fname = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).content;
    NSString *fphone = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).content;
    NSString *mname = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).content;
    NSString *mphone = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).content;
    if ([fname isEmpty]) {
        [self showHudTitle:@"请填写父亲姓名" delay:0.5];
        return NO;
    }
    if ([fphone isEmpty]) {
        [self showHudTitle:@"请填写父亲手机号" delay:0.5];
        return NO;
    }
    if ([mname isEmpty]) {
        [self showHudTitle:@"请填写母亲姓名" delay:0.5];
        return NO;
    }
    if ([mphone isEmpty]) {
        [self showHudTitle:@"请填写母亲手机号" delay:0.5];
        return NO;
    }
    return YES;
}

- (void)checkIdentify{
    NSString *name = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).content;
    NSString *idCard = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).content;
    NSString *address = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).content;
    NSString *marry = ((FakeInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).content;
    if ([name isEmpty]) {
        [self showHudTitle:@"请填写姓名" delay:0.5];
        return;
    }
    if ([idCard isEmpty]) {
        [self showHudTitle:@"请填写身份证号" delay:0.5];
        return;
    }
    if ([address isEmpty]) {
        [self showHudTitle:@"请填写住址" delay:0.5];
        return;
    }
    if ([marry isEmpty]) {
        [self showHudTitle:@"请填写婚配信息" delay:0.5];
        return;
    }
    [LoanApi checkIdNum:idCard name:name finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        FakeInfoViewController *fakeVc = [self getViewController:@"FakeInfoViewController" onStoryBoard:@"Fake"];
        fakeVc.index = _index+1;
        if ([resultObj[@"result"] boolValue] == YES) {
            [self showHudTitle:@"实名认证成功" delay:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:fakeVc animated:YES];
            });
        }else{
            [self showHudTitle:@"实名认证失败" delay:1.0];
        }
        
    }];
}

#pragma mark -- 通讯录
- (void)loadAddressBook{
    
    ///获取通讯录权限，调用系统通讯录
    [self CheckAddressBookAuthorization:^(bool isAuthorized , bool isUp_ios_9) {
        if (isAuthorized) {
            [self callAddressBook:isUp_ios_9];
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }];
}

- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    if (Is_up_Ios_9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else if (!granted)
                {
                    
                    block(NO,YES);
                }
                else
                {
                    block(YES,YES);
                }
            }];
        }
        else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        }
        else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        
        if (authStatus == kABAuthorizationStatusNotDetermined)
        {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error)
                    {
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    }
                    else if (!granted)
                    {
                        
                        block(NO,NO);
                    }
                    else
                    {
                        block(YES,NO);
                    }
                });
            });
        }else if (authStatus == kABAuthorizationStatusAuthorized)
        {
            block(YES,NO);
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
}

- (void)callAddressBook:(BOOL)isUp_ios_9 {
    if (isUp_ios_9) {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController:contactPicker animated:YES completion:nil];
    }else {
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [self presentViewController:peoplePicker animated:YES completion:nil];
        
    }
}

#pragma mark -- CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
        /// 电话
        NSString *text2 = phoneNumber.stringValue;
        //        text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
    }];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    CFStringRef anFullName = ABRecordCopyCompositeName(person);
    
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@",anFullName];
        /// 电话
        NSString *text2 = (__bridge NSString*)value;
        //        text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
    }];
}

#pragma mark --- pickerView

- (void)loadPickerViewAndToolbar {
    [self.view endEditing:YES];
    if ([self.view.subviews containsObject:_picker]) {
        return;
    }
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];

    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-PICKERVIEW_HEIGHT, self.view.bounds.size.width, PICKERVIEW_HEIGHT)];
    self.picker.showsSelectionIndicator = YES;
    self.picker.backgroundColor = [UIColor whiteColor];
    [self.picker selectRow: 0 inComponent: 0 animated: YES];
    [self.view addSubview:self.picker];
    
    UIBarButtonItem *doneBBI = [[UIBarButtonItem alloc]
                                initWithTitle:@"确定"
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:@selector(doneClick)];
    self.picker.delegate = self;
    self.picker.dataSource = self;

    UIBarButtonItem *cancelBBI = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    UIBarButtonItem *flexibleBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.myToolbar = [[UIToolbar alloc]initWithFrame:
                      CGRectMake(0, self.view.frame.size.height-
                                 self.picker.frame.size.height-20, self.view.bounds.size.width, 40)];
    [self.myToolbar setBarStyle:UIBarStyleDefault];
    NSArray *toolbarItems = [NSArray arrayWithObjects:cancelBBI, flexibleBBI, doneBBI, nil];
    [self.myToolbar setItems:toolbarItems];
    [self.view addSubview:self.myToolbar];
}

- (void)doneClick{
    NSInteger provinceIndex = [self.picker selectedRowInComponent: PROVINCE_COMPONENT];
    NSInteger cityIndex = [self.picker selectedRowInComponent: CITY_COMPONENT];
    NSInteger districtIndex = [self.picker selectedRowInComponent: DISTRICT_COMPONENT];
    
    NSString *provinceStr = [province objectAtIndex: provinceIndex];
    NSString *cityStr = [city objectAtIndex: cityIndex];
    NSString *districtStr = [district objectAtIndex:districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
        districtStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }
    NSString *showMsg = [NSString stringWithFormat: @"%@ %@ %@", provinceStr, cityStr, districtStr];
    
    _selectCell.content = showMsg;
}

- (void)cancelClick {
    [self.picker removeFromSuperview];
    [self.myToolbar removeFromSuperview];
}

#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province count];
    }
    else if (component == CITY_COMPONENT) {
        return [city count];
    }
    else {
        return [district count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [city objectAtIndex: row];
    }
    else {
        return [district objectAtIndex: row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        city = [[NSArray alloc] initWithArray: array];

        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        [self.picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [self.picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [self.picker reloadComponent: CITY_COMPONENT];
        [self.picker reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", [province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [self.picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [self.picker reloadComponent: DISTRICT_COMPONENT];
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}

@end
