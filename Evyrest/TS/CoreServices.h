extern NSString *LSInstallTypeKey;

@interface LSBundleProxy
@property (nonatomic,readonly) NSString * bundleIdentifier;
@property (nonatomic) NSURL* dataContainerURL;
@property (nonatomic,readonly) NSURL* bundleContainerURL;
-(NSString*)localizedName;
@end

@interface LSApplicationProxy : LSBundleProxy
+ (instancetype)applicationProxyForIdentifier:(NSString*)identifier;
+ (instancetype)applicationProxyForBundleURL:(NSURL*)bundleURL;
@property NSURL* bundleURL;
@property NSString* bundleType;
@property NSString* canonicalExecutablePath;
@property (nonatomic,readonly) NSDictionary* groupContainerURLs;
@property (nonatomic,readonly) NSArray* plugInKitPlugins;
@property (getter=isInstalled,nonatomic,readonly) BOOL installed; 
@property (getter=isPlaceholder,nonatomic,readonly) BOOL placeholder; 
@property (getter=isRestricted,nonatomic,readonly) BOOL restricted;
@property (nonatomic,readonly) NSSet* claimedURLSchemes;
@property (nonatomic,readonly) NSString* applicationType;
@property(readonly) BOOL isContainerized;
@property(readonly) BOOL isAppUpdate;
@property(readonly) BOOL isBetaApp;
@property(readonly) NSString * bundleVersion;
@property(readonly) NSString * applicationIdentifier;
@property(readonly) NSString * itemName;
@property(readonly) NSString * minimumSystemVersion;
@property(readonly) NSString * teamID;

@end

@interface LSApplicationWorkspace : NSObject
+ (instancetype)defaultWorkspace;
- (BOOL)registerApplicationDictionary:(NSDictionary*)dict;
- (BOOL)unregisterApplication:(id)arg1;
- (BOOL)_LSPrivateRebuildApplicationDatabasesForSystemApps:(BOOL)arg1 internal:(BOOL)arg2 user:(BOOL)arg3;
- (NSArray<LSApplicationProxy*>*)allApplications;
- (NSArray<LSApplicationProxy*>*)allInstalledApplications;
- (BOOL)openApplicationWithBundleID:(NSString *)arg1;
- (void)enumerateApplicationsOfType:(NSUInteger)type block:(void (^)(LSApplicationProxy*))block;
- (BOOL)installApplication:(NSURL*)appPackageURL withOptions:(NSDictionary*)options error:(NSError**)error;
- (BOOL)uninstallApplication:(NSString*)appId withOptions:(NSDictionary*)options;
- (void)addObserver:(id)arg1;
- (void)removeObserver:(id)arg1;
@end

@protocol LSApplicationWorkspaceObserverProtocol <NSObject>
@optional
-(void)applicationsDidInstall:(id)arg1;
-(void)applicationsDidUninstall:(id)arg1;
@end

@interface LSEnumerator : NSEnumerator
@property (nonatomic,copy) NSPredicate * predicate;
+ (instancetype)enumeratorForApplicationProxiesWithOptions:(NSUInteger)options;
@end

@interface LSPlugInKitProxy : LSBundleProxy
@property (nonatomic,readonly) NSString* pluginIdentifier;
@property (nonatomic,readonly) NSDictionary * pluginKitDictionary;
+ (instancetype)pluginKitProxyForIdentifier:(NSString*)arg1;
@end

@interface MCMContainer : NSObject
+ (id)containerWithIdentifier:(id)arg1 createIfNecessary:(BOOL)arg2 existed:(BOOL*)arg3 error:(id*)arg4;
@property (nonatomic,readonly) NSURL * url;
@end

@interface MCMDataContainer : MCMContainer

@end

@interface MCMAppDataContainer : MCMDataContainer

@end

@interface MCMAppContainer : MCMContainer
@end

@interface MCMPluginKitPluginDataContainer : MCMDataContainer
@end
