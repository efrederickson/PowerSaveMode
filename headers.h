#import <libstatusbar/LSStatusBarClient.h>
#import <UIKit/UIKit.h>
#import <libstatusbar/LSStatusBarItem.h>
#import <BulletinBoard/BBServer.h>
#import <BulletinBoard/BBBulletin.h>
#import <dlfcn.h>
#import <substrate.h>
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBIconModel.h>
#import <SpringBoard/SBIcon.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBApplicationIcon.h>
#import <SpringBoard/SBIconImageView.h>
#import <UIKit/UIImage.h>
#import <UIKit/UIImageView.h>
#import <SpringBoard/SBIconLabel.h>
#import <SpringBoard/SBApplication.h>
#import <QuartzCore/QuartzCore.h>

@interface LibStatusBar8 : NSObject
+(BOOL) supported;
+(void) addExtension:(NSString*)name identifier:(NSString*)identifier version:(NSString*)version;
+(NSArray*) getCurrentExtensions;
+(NSString*) getCurrentExtensionsString;
@end

@interface SBApplicationController 
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(id)arg1;
@end

@interface LSStatusBarItem (ugh_again_this_isnt_even_a_private_api)
- (void) setCustomViewClass: (NSString*) customViewClass;
- (NSString*) customViewClass;
- (void) update;
- (void) _setProperties: (NSDictionary*) dict;
- (NSDictionary*) properties;
@end

@interface SBLockScreenViewController
- (_Bool)isInScreenOffMode;
@end

@interface SBLockScreenManager
-(SBLockScreenViewController*) lockScreenViewController;
@property(readonly) BOOL isUILocked; // @synthesize isUILocked=_isUILocked;
@end

@interface SBLockStateAggregator
+(id)sharedInstance;
-(void)_updateLockState;
-(BOOL)hasAnyLockState;
-(unsigned)lockState;
@end

@interface SBIconModel (iOS81)
- (id)applicationIconForBundleIdentifier:(id)arg1;
@end

@interface SBBulletinBannerController : NSObject
+(id)sharedInstance;
-(void)_queueBulletin:(BBBulletin *)bulletin;
@end

@interface LibTwitkaFly /* TwitkaFly, duh */
+ (id) sharedTwitkaFly;
- (BOOL) showSheetWithInitialText:(NSString *)text andInitialImage:(UIImage *)image;
// deprecated in the iOS7 version
- (void) QRWithText:(NSString *)text fromUser:(NSString *)sender forPostID:(NSString *)tweetID toOwner:(NSString *)ownerName;   // required the latest version of twitkafly
// use this method for iOS7 version
- (BOOL) showQRForBulletin:(BBBulletin *)bulletin;
- (BOOL) hideSheet;
@end

@interface UIStatusBarForegroundStyle : NSObject
- (UIColor*) tintColor;
- (NSString*) expandedNameForImageName: (NSString*) imageName;
- (UIImage*) shadowImageForImage: (UIImage*) img withIdentifier: (NSString*) id forStyle: (int) style withStrength: (float) strength cachesImage: (bool) cache;
@end

@interface UIColor (Protean)
- (NSString*) styleString;
- (BOOL)_isSimilarToColor:(UIColor *)color withinPercentage:(CGFloat)percentage;
@end

@interface _UILegibilityImageSet : NSObject
+ (_UILegibilityImageSet*) imageFromImage: (UIImage*) image withShadowImage: (UIImage*) imag_sh;
@property(retain) UIImage * image;
@property(retain) UIImage * shadowImage;
@end

@interface BluetoothDevice
- (_Bool)connected;
- (_Bool)paired;
- (id)description;
- (int)type;
- (id)address;
- (id)name;
@end
@interface BluetoothManager
+ (id)sharedInstance;
- (_Bool)connected;
- (id)connectedDevices;
- (id)connectingDevices;
- (id)pairedDevices;
- (void)unpairDevice:(id)arg1;
- (void)resetDeviceScanning;
- (_Bool)deviceScanningInProgress;
- (_Bool)deviceScanningEnabled;
- (_Bool)wasDeviceDiscovered:(id)arg1;
- (void)_removeDevice:(id)arg1;
- (id)addDeviceIfNeeded:(struct BTDeviceImpl *)arg1;
- (void)_connectedStatusChanged;
@end

@interface UIApplication (Protean)
-(id) statusBar;
@end
@interface UIStatusBar
- (void)_setStyle:(id)arg1;
- (int)legibilityStyle;
- (id)initWithFrame:(CGRect)arg1 showForegroundView:(BOOL)arg2 inProcessStateProvider:(id)arg3;
- (id)initWithFrame:(CGRect)arg1 showForegroundView:(BOOL)arg2;
- (id)initWithFrame:(CGRect)arg1;

- (void)_crossfadeToNewBackgroundView;
- (void)_crossfadeToNewForegroundViewWithAlpha:(float)arg1;
- (void)crossfadeTime:(BOOL)arg1 duration:(double)arg2;
- (void)setShowsOnlyCenterItems:(BOOL)arg1;
- (void)forceUpdateData:(BOOL)arg1;

- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;
-(id) superview;
-(CGRect)frame;
-(void) setFrame:(CGRect)frame;
@end
@interface BSQRController /* BiteSMS */
+(BOOL)maybeLaunchQRFromURL:(id)url;
+(void)markAsReadFromBulletin:(id)bulletin;
+(BOOL)canLaunchQRFromBulletin:(id)bulletin;
+(BOOL)maybeLaunchQRFromBulletin:(id)bulletin;
+(BOOL)launchQRFromMessage:(id)message;
+(BOOL)receivedBulletin:(id)bulletin;
+(void)receivedFZMessage:(id)message inGroup:(id)group addresses:(id)addresses;
+(BOOL)_handleReceivedMessage:(id)message;
+(void)_showQR:(id)qr;
@end
@interface UIImage (Protean)
+ (UIImage*)imageNamed:(NSString *)imageName inBundle:(NSBundle*)bundle;
- (UIImage*) _flatImageWithColor: (UIColor*) color;
+(UIImage*)kitImageNamed:(NSString*)name;
@end
@interface IBMessageHeadsWindow : UIWindow
+ (id)sharedInstance;
- (void)showAnimated;
- (void)hideAnimated;
- (void)show;
- (void)hide;
- (void)setShowingConversation:(_Bool)arg1;
@end

@interface BBServer ()
- (id)allBulletinIDsForSectionID:(id)arg1;
- (id)futureBulletinIDsForSectionID:(id)arg1;
- (id)todayBulletinIDsForSectionID:(id)arg1;
- (id)noticesBulletinIDsForSectionID:(id)arg1;
- (id)bulletinIDsForSectionID:(id)arg1 inFeed:(unsigned long long)arg2;
@end

@interface KJUARR : NSObject /* AUIKI */
+(BOOL)doUrThing:(BBBulletin *)bulletin;
+(BOOL)doUrThing:(BBBulletin *)bulletin withImages:(NSArray *)images;
+(BOOL)doUrThing:(BBBulletin *)bulletin withRecipients:(NSArray *)recipients;
+(BOOL)doUrThing:(BBBulletin *)bulletin withImages:(NSArray *)images recipients:(NSArray *)recipients;
@end

@interface Couria : NSObject /* COURIA */
+ (Couria *)sharedInstance; // You should always use this shared instance when needed.
- (void)presentControllerForApplication:(NSString *)applicationIdentifier user:(NSString *)userIdentifier; // Manually present a quick compose view controller. If applicationIdentifier has not been registered, nothing will happen. If userIdentifier is nil and getContacts: has been implemented in the data source, contacts search view will be showed.
- (void)handleBulletin:(BBBulletin *)bulletin; // Manually activate action of a bulletin. You may find useful if you are making some notifications tweaks.
@end

@interface SBStatusBarStateAggregator
+ (id) sharedInstance;
- (_Bool)_setItem:(int)arg1 enabled:(_Bool)arg2;
- (void)_updateServiceItem;
- (void)_updateSignalStrengthItem;
- (void)_updateTimeItems;
- (void)_resetTimeItemFormatter;
- (void)_restartTimeItemTimer;
- (void)updateStatusBarItem:(int)arg1;
@end

@interface SBApplicationIcon (Protean2)
-(void) noteBadgeDidChange;
@end
@interface SBBulletinBannerItem
-(BBBulletin*)seedBulletin;
@end
@interface SBUIBannerContext
-(SBBulletinBannerItem*)item;
@end
@interface UIApplication (Protean_launch_apps)
-(BOOL)launchApplicationWithIdentifier:(id)identifier suspended:(BOOL)suspended;
@end
@interface SBIconController (Protean)
+(id) sharedInstance;
-(SBIconModel*) model;
@end

@interface SBIconModel (iOS40)
- (/*SBApplicationIcon*/SBIcon *)applicationIconForDisplayIdentifier:(NSString *)displayIdentifier;
-(id) leafIconsByIdentifier;
-(id)visibleIconIdentifiers;
@end

@interface SBIcon (iOS40)
- (void)prepareDropGlow;
- (UIImageView *)dropGlow;
- (void)showDropGlow:(BOOL)showDropGlow;
- (long long)badgeValue;
- (id)leafIdentifier;
- (SBApplication*)application;
- (NSString*)applicationBundleID;
- (id)nodeIdentifier;
- (id)badgeNumberOrString;
- (long long)badgeValue;
@end

@interface SBApplicationIcon (Protean)
- (NSString*)applicationBundleID;
- (long long)badgeValue;
@end

@interface SBIconController (iOS40)
- (BOOL)canUninstallIcon:(SBIcon *)icon;
@end

@protocol SBIconViewDelegate, SBIconViewLocker;
@class SBIconImageContainerView, SBIconBadgeImage;

@interface SBIconView : UIView {
	SBIcon *_icon;
	id<SBIconViewDelegate> _delegate;
	id<SBIconViewLocker> _locker;
	SBIconImageContainerView *_iconImageContainer;
	SBIconImageView *_iconImageView;
	UIImageView *_iconDarkeningOverlay;
	UIImageView *_ghostlyImageView;
	UIImageView *_reflection;
	UIImageView *_shadow;
	SBIconBadgeImage *_badgeImage;
	UIImageView *_badgeView;
	SBIconLabel *_label;
	BOOL _labelHidden;
	BOOL _labelOnWallpaper;
	UIView *_closeBox;
	int _closeBoxType;
	UIImageView *_dropGlow;
	unsigned _drawsLabel : 1;
	unsigned _isHidden : 1;
	unsigned _isGrabbed : 1;
	unsigned _isOverlapping : 1;
	unsigned _refusesRecipientStatus : 1;
	unsigned _highlighted : 1;
	unsigned _launchDisabled : 1;
	unsigned _isJittering : 1;
	unsigned _allowJitter : 1;
	unsigned _touchDownInIcon : 1;
	unsigned _hideShadow : 1;
	NSTimer *_delayedUnhighlightTimer;
	unsigned _onWallpaper : 1;
	unsigned _ghostlyRequesters;
	int _iconLocation;
	float _iconImageAlpha;
	float _iconImageBrightness;
	float _iconLabelAlpha;
	float _accessoryAlpha;
	CGPoint _unjitterPoint;
	CGPoint _grabPoint;
	NSTimer *_longPressTimer;
	unsigned _ghostlyTag;
	UIImage *_ghostlyImage;
	BOOL _ghostlyPending;
}
+ (CGSize)defaultIconSize;
+ (CGSize)defaultIconImageSize;
+ (BOOL)allowsRecycling;
+ (id)_jitterPositionAnimation;
+ (id)_jitterTransformAnimation;

- (id)initWithDefaultSize;
- (void)dealloc;

@property(assign) id<SBIconViewDelegate> delegate;
@property(assign) id<SBIconViewLocker> locker;
@property(readonly, retain) SBIcon *icon;
- (void)setIcon:(SBIcon *)icon;

- (int)location;
- (void)setLocation:(int)location;
- (void)showIconAnimationDidStop:(id)showIconAnimation didFinish:(id)finish icon:(id)icon;
- (void)setIsHidden:(BOOL)hidden animate:(BOOL)animate;
- (BOOL)isHidden;
- (BOOL)isRevealable;
- (void)positionIconImageView;
- (void)applyIconImageTransform:(CATransform3D)transform duration:(float)duration delay:(float)delay;
- (void)setDisplayedIconImage:(id)image;
- (id)snapshotSettings;
- (id)iconImageSnapshot:(id)snapshot;
- (id)reflectedIconWithBrightness:(CGFloat)brightness;
- (void)setIconImageAlpha:(CGFloat)alpha;
- (void)setIconLabelAlpha:(CGFloat)alpha;
- (SBIconImageView *)iconImageView;
- (void)setLabelHidden:(BOOL)hidden;
- (void)positionLabel;
- (CGSize)_labelSize;
- (Class)_labelClass;
- (void)updateLabel;
- (void)_updateBadgePosition;
- (id)_overriddenBadgeTextForText:(id)text;
- (void)updateBadge;
- (id)_automationID;
- (BOOL)pointMostlyInside:(CGPoint)inside withEvent:(UIEvent *)event;
- (CGRect)frameForIconOverlay;
- (void)placeIconOverlayView;
- (void)updateIconOverlayView;
- (void)_updateIconBrightness;
- (BOOL)allowsTapWhileEditing;
- (BOOL)delaysUnhighlightWhenTapped;
- (BOOL)isHighlighted;
- (void)setHighlighted:(BOOL)highlighted;
- (void)setHighlighted:(BOOL)highlighted delayUnhighlight:(BOOL)unhighlight;
- (void)_delayedUnhighlight;
- (BOOL)isInDock;
- (id)_shadowImage;
- (void)_updateShadow;
- (void)updateReflection;
- (void)setDisplaysOnWallpaper:(BOOL)wallpaper;
- (void)setLabelDisplaysOnWallpaper:(BOOL)wallpaper;
- (BOOL)showsReflection;
- (float)_reflectionImageOffset;
- (void)setFrame:(CGRect)frame;
- (void)setIsJittering:(BOOL)isJittering;
- (void)setAllowJitter:(BOOL)allowJitter;
- (BOOL)allowJitter;
- (void)removeAllIconAnimations;
- (void)setIconPosition:(CGPoint)position;
- (void)setRefusesRecipientStatus:(BOOL)status;
- (BOOL)canReceiveGrabbedIcon:(id)icon;
- (double)grabDurationForEvent:(id)event;
- (void)setIsGrabbed:(BOOL)grabbed;
- (BOOL)isGrabbed;
- (void)setIsOverlapping:(BOOL)overlapping;
- (CGAffineTransform)transformToMakeDropGlowShrinkToIconSize;
- (void)prepareDropGlow;
- (void)showDropGlow:(BOOL)glow;
- (void)removeDropGlow;
- (id)dropGlow;
- (BOOL)isShowingDropGlow;
- (void)placeGhostlyImageView;
- (id)_genGhostlyImage:(id)image;
- (void)prepareGhostlyImageIfNeeded;
- (void)prepareGhostlyImage;
- (void)prepareGhostlyImageView;
- (void)setGhostly:(BOOL)ghostly requester:(int)requester;
- (void)setPartialGhostly:(float)ghostly requester:(int)requester;
- (void)removeGhostlyImageView;
- (BOOL)isGhostly;
- (int)ghostlyRequesters;
- (void)longPressTimerFired;
- (void)cancelLongPressTimer;
- (void)touchesCancelled:(id)cancelled withEvent:(id)event;
- (void)touchesBegan:(id)began withEvent:(id)event;
- (void)touchesMoved:(id)moved withEvent:(id)event;
- (void)touchesEnded:(id)ended withEvent:(id)event;
- (BOOL)isTouchDownInIcon;
- (void)setTouchDownInIcon:(BOOL)icon;
- (void)hideCloseBoxAnimationDidStop:(id)hideCloseBoxAnimation didFinish:(id)finish closeBox:(id)box;
- (void)positionCloseBoxOfType:(int)type;
- (id)_newCloseBoxOfType:(int)type;
- (void)setShowsCloseBox:(BOOL)box;
- (void)setShowsCloseBox:(BOOL)box animated:(BOOL)animated;
- (BOOL)isShowingCloseBox;
- (void)closeBoxTapped;
- (BOOL)pointInside:(CGPoint)inside withEvent:(id)event;
- (UIEdgeInsets)snapshotEdgeInsets;
- (void)setShadowsHidden:(BOOL)hidden;
- (void)_updateShadowFrameForShadow:(id)shadow;
- (void)_updateShadowFrame;
- (BOOL)_delegatePositionIsEditable;
- (void)_delegateTouchEnded:(BOOL)ended;
- (BOOL)_delegateTapAllowed;
- (int)_delegateCloseBoxType;
- (id)createShadowImageView;
- (void)prepareForRecycling;
- (CGRect)defaultFrameForProgressBar;
- (void)iconImageDidUpdate:(id)iconImage;
- (void)iconAccessoriesDidUpdate:(id)iconAccessories;
- (void)iconLaunchEnabledDidChange:(id)iconLaunchEnabled;
- (SBIconImageView*)_iconImageView;

@end

@class NSMapTable;

@interface SBIconViewMap : NSObject {
	NSMapTable* _iconViewsForIcons;
	id<SBIconViewDelegate> _iconViewdelegate;
	NSMapTable* _recycledIconViewsByType;
	NSMapTable* _labels;
	NSMapTable* _badges;
}
+ (SBIconViewMap *)switcherMap;
+(SBIconViewMap *)homescreenMap;
+(Class)iconViewClassForIcon:(SBIcon *)icon location:(int)location;
-(id)init;
-(void)dealloc;
-(SBIconView *)mappedIconViewForIcon:(SBIcon *)icon;
-(SBIconView *)_iconViewForIcon:(SBIcon *)icon;
-(SBIconView *)iconViewForIcon:(SBIcon *)icon;
-(void)_addIconView:(SBIconView *)iconView forIcon:(SBIcon *)icon;
-(void)purgeIconFromMap:(SBIcon *)icon;
-(void)_recycleIconView:(SBIconView *)iconView;
-(void)recycleViewForIcon:(SBIcon *)icon;
-(void)recycleAndPurgeAll;
-(id)releaseIconLabelForIcon:(SBIcon *)icon;
-(void)captureIconLabel:(id)label forIcon:(SBIcon *)icon;
-(void)purgeRecycledIconViewsForClass:(Class)aClass;
-(void)_modelListAddedIcon:(SBIcon *)icon;
-(void)_modelRemovedIcon:(SBIcon *)icon;
-(void)_modelReloadedIcons;
-(void)_modelReloadedState;
-(void)iconAccessoriesDidUpdate:(SBIcon *)icon;
@end

@interface SBIconViewMap (iOS6)
@property (nonatomic, readonly) SBIconModel *iconModel;
@end

@interface SBApplication (iOS6)
- (BOOL)isRunning;
- (id)badgeNumberOrString;
- (NSString*)bundleIdentifier;
- (_Bool)_isRecentlyUpdated;
- (_Bool)_isNewlyInstalled;
- (void) setBadge:(id)badge;
@end

@interface SBIconBlurryBackgroundView : UIView
{
    struct CGRect _wallpaperRelativeBounds;
    _Bool _isBlurring;
    id _wantsBlurEvaluator;
    struct CGPoint _wallpaperRelativeCenter;
}

@property(copy, nonatomic) id wantsBlurEvaluator; // @synthesize wantsBlurEvaluator=_wantsBlurEvaluator;
@property(readonly, nonatomic) _Bool isBlurring; // @synthesize isBlurring=_isBlurring;
@property(nonatomic) struct CGPoint wallpaperRelativeCenter; // @synthesize wallpaperRelativeCenter=_wallpaperRelativeCenter;
- (_Bool)_shouldAnimatePropertyWithKey:(id)arg1;
- (void)setBlurring:(_Bool)arg1;
- (void)setWallpaperColor:(struct CGColor *)arg1 phase:(struct CGSize)arg2;
- (_Bool)wantsBlur:(id)arg1;
- (struct CGRect)wallpaperRelativeBounds;
- (void)didAddSubview:(id)arg1;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1;
@end

@interface SBFolderIconBackgroundView : SBIconBlurryBackgroundView
- (id)initWithDefaultSize;
@end

@interface SBIconImageView ()
{
    UIImageView *_overlayView;
    //SBIconProgressView *_progressView;
    _Bool _isPaused;
    UIImage *_cachedSquareContentsImage;
    _Bool _showsSquareCorners;
    SBIcon *_icon;
    double _brightness;
    double _overlayAlpha;
}

+ (id)dequeueRecycledIconImageViewOfClass:(Class)arg1;
+ (void)recycleIconImageView:(id)arg1;
+ (double)cornerRadius;
@property(nonatomic) _Bool showsSquareCorners; // @synthesize showsSquareCorners=_showsSquareCorners;
@property(nonatomic) double overlayAlpha; // @synthesize overlayAlpha=_overlayAlpha;
@property(nonatomic) double brightness; // @synthesize brightness=_brightness;
@property(retain, nonatomic) SBIcon *icon; // @synthesize icon=_icon;
- (_Bool)_shouldAnimatePropertyWithKey:(id)arg1;
- (void)iconImageDidUpdate:(id)arg1;
- (struct CGRect)visibleBounds;
- (struct CGSize)sizeThatFits:(struct CGSize)arg1;
- (id)squareDarkeningOverlayImage;
- (id)darkeningOverlayImage;
- (id)squareContentsImage;
- (UIImage*)contentsImage;
- (void)_clearCachedImages;
- (id)_generateSquareContentsImage;
- (void)_updateProgressMask;
- (void)_updateOverlayImage;
- (id)_currentOverlayImage;
- (void)updateImageAnimated:(_Bool)arg1;
- (id)snapshot;
- (void)prepareForReuse;
- (void)layoutSubviews;
- (void)setPaused:(_Bool)arg1;
- (void)setProgressAlpha:(double)arg1;
- (void)_clearProgressView;
- (void)progressViewCanBeRemoved:(id)arg1;
- (void)setProgressState:(long long)arg1 paused:(_Bool)arg2 percent:(double)arg3 animated:(_Bool)arg4;
- (void)_updateOverlayAlpha;
- (void)setIcon:(id)arg1 animated:(_Bool)arg2;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1;
@end

@interface UIStatusBarItem : NSObject
{
    long long _idiom;
    int _type;
}

+ (_Bool)isItemWithTypeExclusive:(int)arg1;
+ (_Bool)itemType:(int)arg1 idiom:(long long)arg2 appearsInRegion:(int)arg3;
+ (_Bool)itemType:(int)arg1 idiom:(long long)arg2 canBeEnabledForData:(id)arg3 style:(id)arg4;
+ (_Bool)typeIsValid:(int)arg1;
+ (id)itemWithType:(int)arg1 idiom:(long long)arg2;
@property(readonly, nonatomic) int type; // @synthesize type=_type;
- (id)description;
- (long long)compareRightOrder:(id)arg1;
- (long long)compareLeftOrder:(id)arg1;
- (long long)comparePriority:(id)arg1;
- (_Bool)appearsInRegion:(int)arg1;
- (_Bool)appearsOnRight;
- (_Bool)appearsOnLeft;
@property(readonly, nonatomic) NSString *indicatorName;
@property(readonly, nonatomic) int rightOrder;
@property(readonly, nonatomic) int leftOrder;
@property(readonly, nonatomic) int priority;
@property(readonly, nonatomic) Class viewClass;
- (id)initWithType:(int)arg1;
@end

@interface UIStatusBarLayoutManager : NSObject
@property BOOL persistentAnimationsEnabled;
@property(readonly) BOOL usesVerticalLayout;
- (SEL)_itemSortSelector;
- (id)_itemViews;
- (id)_itemViewsSortedForLayout;
- (float)_positionAfterPlacingItemView:(id)arg1 startPosition:(float)arg2 firstView:(BOOL)arg3;
- (void)_positionNewItemViewsWithEnabledItems:(BOOL*)arg1;
- (void)_prepareEnabledItemType:(int)arg1 withEnabledItems:(BOOL*)arg2 withData:(id)arg3 actions:(int)arg4 itemAppearing:(BOOL*)arg5 itemDisappearing:(BOOL*)arg6;
- (BOOL)_processDelta:(float)arg1 forView:(id)arg2;
- (float)_sizeNeededForItemView:(id)arg1;
- (float)_startPosition;
- (BOOL)_updateItemView:(id)arg1 withData:(id)arg2 actions:(int)arg3 animated:(BOOL)arg4;
- (id)_viewForItem:(id)arg1;
- (void)clearOverlapFromItems:(id)arg1;
- (void)dealloc;
- (float)distributeOverlap:(float)arg1 amongItems:(id)arg2;
- (id)foregroundView;
- (id)initWithRegion:(int)arg1 foregroundView:(id)arg2 usesVerticalLayout:(BOOL)arg3;
- (BOOL)itemIsVisible:(id)arg1;
- (void)itemView:(id)arg1 sizeChangedBy:(float)arg2;
- (void)makeVisibleItemsPerformPendedActions;
- (BOOL)persistentAnimationsEnabled;
- (void)positionInvisibleItems;
- (BOOL)prepareDoubleHeightItemWithEnabledItems:(BOOL*)arg1;
- (BOOL)prepareEnabledItems:(BOOL*)arg1 withData:(id)arg2 actions:(int)arg3;
- (void)reflowWithVisibleItems:(id)arg1 duration:(double)arg2;
- (void)removeDisabledItems:(BOOL*)arg1;
- (float)removeOverlap:(float)arg1 fromItems:(id)arg2;
- (void)setForegroundView:(id)arg1;
- (void)setPersistentAnimationsEnabled:(BOOL)arg1;
- (void)setVisibilityOfAllItems:(BOOL)arg1;
- (void)setVisibilityOfItem:(id)arg1 visible:(BOOL)arg2;
- (float)sizeNeededForItem:(id)arg1;
- (float)sizeNeededForItems:(id)arg1;
- (BOOL)updateDoubleHeightItem;
- (BOOL)updateItemsWithData:(id)arg1 actions:(int)arg2 animated:(BOOL)arg3;
- (BOOL)usesVerticalLayout;
@end

@interface UIStatusBarItemView : UIView
+ (id)createViewForItem:(id)arg1 withData:(id)arg2 actions:(int)arg3 foregroundStyle:(id)arg4;
@property(nonatomic) _Bool allowsUpdates; // @synthesize allowsUpdates=_allowsUpdates;
@property(nonatomic, getter=isVisible) _Bool visible; // @synthesize visible=_visible;
@property(nonatomic, retain) UIStatusBarLayoutManager *layoutManager; // @synthesize layoutManager=_layoutManager;
@property(readonly, nonatomic) UIStatusBarItem *item; // @synthesize item=_item;
- (id)description;
- (void)willMoveToWindow:(id)arg1;
- (id)imageWithShadowNamed:(id)arg1;
- (id)imageWithText:(id)arg1;
- (void)endImageContext;
- (id)imageFromImageContextClippedToWidth:(double)arg1;
- (void)beginImageContextWithMinimumWidth:(double)arg1;
- (void)setPersistentAnimationsEnabled:(_Bool)arg1;
- (void)performPendedActions;
- (_Bool)cachesImage;
- (id)contentsImage;
- (_Bool)animatesDataChange;
- (_Bool)updateForNewData:(id)arg1 actions:(int)arg2;
- (double)maximumOverlap;
- (double)addContentOverlap:(double)arg1;
- (double)resetContentOverlap;
- (double)extraRightPadding;
- (double)extraLeftPadding;
- (double)shadowPadding;
- (double)standardPadding;
- (long long)textAlignment;
- (id)textFont;
- (long long)textStyle;
- (void)drawText:(id)arg1 forWidth:(double)arg2 lineBreakMode:(long long)arg3 letterSpacing:(double)arg4 textSize:(struct CGSize)arg5;
- (void)setContentMode:(long long)arg1;
- (double)updateContentsAndWidth;
- (void)setLayerContentsImage:(id)arg1;
- (double)legibilityStrength;
- (long long)legibilityStyle;
- (double)setStatusBarData:(id)arg1 actions:(int)arg2;
- (double)currentRightOverlap;
- (double)currentLeftOverlap;
- (double)currentOverlap;
- (void)setCurrentOverlap:(double)arg1;
- (void)setVisible:(_Bool)arg1 frame:(struct CGRect)arg2 duration:(double)arg3;
- (void)dealloc;
- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4;
- (_Bool)_shouldAnimatePropertyWithKey:(id)arg1;
- (UIStatusBarForegroundStyle*)foregroundStyle;
@end

@interface UIStatusBarCustomItemView : UIStatusBarItemView
@end

@interface BBServer (Protean)
- (id)_bulletinsForSectionID:(id)arg1 inFeeds:(unsigned int)arg2;
- (id)_allBulletinsForSectionID:(id)arg1;
- (id)allBulletinIDsForSectionID:(id)arg1;
@end

@interface SBUserAgent
+(id)sharedUserAgent;
-(void)disableLockScreenBundleNamed:(id)named deactivationContext:(id)context;
-(void)enableLockScreenBundleNamed:(id)named activationContext:(id)context;
-(void)setWallpaperTunnelActive:(BOOL)active forFullscreenAlertController:(id)fullscreenAlertController;
-(BOOL)isUsingLegacyStyle;
-(void)activateRemoteAlertService:(id)service options:(id)options;
-(void)activateStarkRemoteAlertService:(id)service ofType:(id)type;
-(void)setMinimumBacklightLevel:(float)level animated:(BOOL)animated;
-(BOOL)isSBUILoggingEnabled;
-(void)removeActiveInterfaceOrientationObserver:(id)observer;
-(void)addActiveInterfaceOrientationObserver:(id)observer;
-(void)activateModalBulletinAlert:(id)alert;
-(id)modalBulletinAlertHandlerRegistry;
-(void)stopRinging;
-(void)playRingtoneAtPath:(id)path vibrationPattern:(id)pattern;
-(void)playRingtoneAtPath:(id)path;
-(int)networkUsageTypeForAppWithDisplayID:(id)displayID;
-(void)setIdleText:(id)text;
-(void)setBadgeNumberOrString:(id)string forApplicationWithID:(id)anId;
-(void)notifyOnNextUserEvent;
-(BOOL)isIdleTimerDisabledForReason:(id)reason;
-(void)setIdleTimerDisabled:(BOOL)disabled forReason:(id)reason;
-(void)lockAndDimDeviceDisconnectingCallIfNecessary:(BOOL)necessary andDimScreen:(BOOL)screen;
-(void)lockAndDimDeviceDisconnectingCallIfNecessary:(BOOL)necessary;
-(void)lockAndDimDevice;
-(void)undimScreen;
-(void)dimScreen:(BOOL)screen;
-(void)updateLockScreenInterfaceIfNecessary;
-(CGRect)defaultContentRegionForAwayViewPlugin:(id)awayViewPlugin withOrientation:(int)orientation;
-(BOOL)launchFromAwayViewPluginWithURL:(id)url bundleID:(id)anId allowUnlock:(BOOL)unlock animate:(BOOL)animate;
-(BOOL)canLaunchFromAwayViewPluginWithURL:(id)url bundleID:(id)anId;
-(BOOL)launchFromPushOrLocalBulletin:(id)pushOrLocalBulletin origin:(int)origin;
-(BOOL)launchFromBulletinWithURL:(id)url bundleID:(id)anId allowUnlock:(BOOL)unlock animate:(BOOL)animate launchOrigin:(int)origin;
-(BOOL)canLaunchFromBulletinWithURL:(id)url bundleID:(id)anId;
-(BOOL)_launchFromSource:(int)source withURL:(id)url bundleID:(id)anId allowUnlock:(BOOL)unlock animate:(BOOL)animate;
-(BOOL)launchFromSource:(int)source withURL:(id)url bundleID:(id)anId allowUnlock:(BOOL)unlock;
-(BOOL)launchApplicationFromSource:(int)source withURL:(id)url options:(id)options;
-(BOOL)launchApplicationFromSource:(int)source withDisplayID:(id)displayID options:(id)options;
-(BOOL)canLaunchFromSource:(int)source withURL:(id)url bundleID:(id)anId;
-(BOOL)_openApplication:(id)application withURL:(id)url fromSource:(int)source animated:(BOOL)animated options:(id)options;
-(void)_cleanupFromBannerLaunch;
-(id)_safeValue:(id)value forKey:(id)key ofType:(Class)type;
-(BOOL)openURL:(id)url allowUnlock:(BOOL)unlock animated:(BOOL)animated;
-(void)openURL:(id)url animateIn:(BOOL)anIn scale:(float)scale start:(double)start duration:(float)duration animateOut:(BOOL)anOut;
-(void)prepareToAnswerCall;
-(BOOL)launchDisplayWithURL:(id)url forCall:(BOOL)call sender:(id)sender;
-(void)setFlipBackAttributeForSEODisplayWithIdentifier:(id)identifier;
-(BOOL)lockScreenIsShowing;
-(BOOL)deviceIsTethered;
-(BOOL)deviceIsBlocked;
-(BOOL)deviceIsPasscodeLockedRemotely;
-(BOOL)deviceIsPasscodeLocked;
-(BOOL)deviceIsLocked;
-(BOOL)canUserLaunchIcon;
-(BOOL)alertIsActive;
-(BOOL)springBoardIsActive;
-(BOOL)applicationInstalledForDisplayID:(id)displayID;
-(id)topSuspendedEventsOnlyDisplayID;
-(id)foregroundDisplayID;
-(id)foregroundApplicationDisplayID;
-(int)activeInterfaceOrientation;
-(void)updateInterfaceOrientationIfNecessary;
-(void)dealloc;
-(id)init;
@end

@interface UIStatusBarCustomItem : UIStatusBarItem
@end




