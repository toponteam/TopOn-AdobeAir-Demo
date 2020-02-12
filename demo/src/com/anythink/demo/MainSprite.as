package com.anythink.demo {
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

import com.anythink.demo.BannerListenerImpl;
import com.anythink.demo.CommonConfig;
import com.anythink.demo.InterstitialListenerImpl;
import com.anythink.demo.NativeBannerListenerImpl;
import com.anythink.demo.NativeListenerImpl;
import com.anythink.demo.RewardedVideoListenerImpl;
import com.anythink.sdk.ATAirSDK;
import com.anythink.sdk.banner.ATBannerAd;
import com.anythink.sdk.interstitial.ATInterstitialAd;
import com.anythink.sdk.nativead.ATNativeAd;
import com.anythink.sdk.nativead.ATNativeAdConfig;
import com.anythink.sdk.nativead.ATNativeItemProperty;
import com.anythink.sdk.nativebanner.ATNativeBannerAd;
import com.anythink.sdk.nativebanner.ATNativeBannerAdConfig;
import com.anythink.sdk.rewardedvideo.ATRewardedVideoAd;


public class MainSprite extends Sprite
{
    private var rewardedVideoListener:RewardedVideoListenerImpl;
    private var intertistialListener:InterstitialListenerImpl;
    private var bannerListener:BannerListenerImpl;
    private var nativeListener:NativeListenerImpl;
    private var nativebannerListener:NativeBannerListenerImpl;

    public function MainSprite():void
    {
        var textField:TextField = new TextField();
        textField.text = "Hello World!";
        textField.autoSize = TextFieldAutoSize.LEFT;

        var format:TextFormat = new TextFormat();
        format.size = 48;

        textField.setTextFormat ( format );
        this.addChild( textField );

        initAnythinkSDK();
    }


    public function initAnythinkSDK():void
    {
        CommonConfig.setPlatform();

        ATAirSDK.getInstance().initSDK(CommonConfig.getAppId(), CommonConfig.getAppKey());
        ATAirSDK.getInstance().setDebugLog(1);

        rewardedVideoListener = new RewardedVideoListenerImpl();
        intertistialListener = new InterstitialListenerImpl();
        bannerListener = new BannerListenerImpl();
        nativeListener = new NativeListenerImpl();
        nativebannerListener = new NativeBannerListenerImpl();
    }


    public function gdpr_clickHandler():void
    {
        ATAirSDK.getInstance().showGdprAuth();
    }

    public function load_rv_clickHandler():void
    {
        trace("load_rv_clickHandler");
        ATRewardedVideoAd.setAdListener(rewardedVideoListener);
        var customObj:Object = {};
        customObj["age"] = 17;
        customObj["sex"] = "man";

        ATRewardedVideoAd.loadRewardedVideoAd(CommonConfig.getRewardedVideoPlacement(), "", customObj);

    }

    public function show_rv_clickHandler():void
    {
        trace("show_rv_clickHandler");

        if(ATRewardedVideoAd.isRewardedVideoReady(CommonConfig.getRewardedVideoPlacement()))
        {
            ATRewardedVideoAd.showRewardedVideoAd(CommonConfig.getRewardedVideoPlacement());
        }else{
            trace("!isRewardedVideoReady");
        }

    }

    public function load_inter_clickHandler():void
    {
        trace("load_inter_clickHandler");
        ATInterstitialAd.setAdListener(intertistialListener);
        var customObj:Object = {};
        customObj["age"] = 17;
        customObj["sex"] = "man";
        ATInterstitialAd.loadInterstitialAd(CommonConfig.getInterstitialPlacement(), customObj)

    }

    public function show_inter_clickHandler():void
    {
        trace("show_inter_clickHandler");
        if(ATInterstitialAd.isInsterstitialAdReady(CommonConfig.getInterstitialPlacement()))
        {
            ATInterstitialAd.showInterstitialAd(CommonConfig.getInterstitialPlacement());

        }else{
            trace("!isInsterstitialAdReady");
        }

    }

    public function load_banner_clickHandler():void
    {
        trace("load_banner_clickHandler");
        ATBannerAd.setBannerListener(bannerListener);
        var customObj:Object = {};
        customObj["age"] = 17;
        customObj["sex"] = "man";
        ATBannerAd.loadBannerAd(CommonConfig.getBannerPlacement(), customObj);

    }

    public function show_banner_clickHandler():void
    {
        trace("show_banner_clickHandler");
        if(ATBannerAd.isBannerAdReady(CommonConfig.getBannerPlacement())){
            var rectangle:Rectangle = new Rectangle();
            rectangle.x = 0;
            trace("width:" + ATAirSDK.getInstance().getScreenWidth() + " height:" + ATAirSDK.getInstance().getScreenHeight());
            rectangle.y = ATAirSDK.getInstance().getScreenHeight() - ATAirSDK.getInstance().getScreenHeight() * 50/800;
            rectangle.width = ATAirSDK.getInstance().getScreenWidth() * 320/480;
            rectangle.height = ATAirSDK.getInstance().getScreenHeight() * 50/800;
            ATBannerAd.showBannerAd(CommonConfig.getBannerPlacement(), rectangle);
        }else{
            trace("!isBannerAdReady");
        }



    }

    public function remove_banner_clickHandler():void
    {
        trace("remove_banner_clickHandler");

        ATBannerAd.removeBannerAd(CommonConfig.getBannerPlacement());

    }

    public function load_native_clickHandler():void
    {
        trace("load_native_clickHandler");
        ATNativeAd.setNativeListener(nativeListener);
        var customObj:Object = {};
        customObj["age"] = 17;
        customObj["sex"] = "man";
        var extraObj:Object = {};
        //传入gdt需要的普通广告
        extraObj["native_ad_type"] = 2;
        extraObj["native_image_size"] = "image_size_228_150";

        ATNativeAd.loadNativeAd(CommonConfig.getNativePlacement(), customObj, extraObj);

    }

    public function show_native_clickHandler():void
    {
        trace("show_native_clickHandler");
        if(ATNativeAd.isNativeAdReady(CommonConfig.getNativePlacement()))
        {
            var nativeAdConfig:ATNativeAdConfig = getNativeAdConfig();
            ATNativeAd.showNativeAd(CommonConfig.getNativePlacement(), nativeAdConfig);
        }else{
            trace("!isNativeAdReady");
        }


    }

    public function remove_native_clickhandler():void
    {
        trace("remove_native_clickhandler");
        ATNativeAd.removeNativeAd(CommonConfig.getNativePlacement());

    }

    public function getNativeAdConfig():ATNativeAdConfig
    {
        var nativeAdConfig:ATNativeAdConfig = new ATNativeAdConfig();
        var parentRect:ATNativeItemProperty = new ATNativeItemProperty(); //父容器属性
        parentRect.rect = new Rectangle();
        parentRect.rect.x = 0;
        parentRect.rect.y = ATAirSDK.getInstance().getScreenHeight() - ATAirSDK.getInstance().getScreenHeight() * 200/800;
        parentRect.rect.width = ATAirSDK.getInstance().getScreenWidth() * 320/480;
        parentRect.rect.height = ATAirSDK.getInstance().getScreenHeight() * 200/800;
        parentRect.backgroundColor = "#ffffff";
        parentRect.textColor = "#777777";
        parentRect.textSize = 10;
        var iconRect:ATNativeItemProperty = new ATNativeItemProperty(); //icon属性
        iconRect.rect = new Rectangle();
        iconRect.rect.x = 0;
        iconRect.rect.y = ATAirSDK.getInstance().getScreenHeight() * 50/800;
        iconRect.rect.width = ATAirSDK.getInstance().getScreenWidth() * 60/480;
        iconRect.rect.height = ATAirSDK.getInstance().getScreenHeight() *50/800;
        iconRect.backgroundColor = "#ffffff";
        iconRect.textColor = "#777777";
        iconRect.textSize = ATAirSDK.getInstance().getScreenWidth() * 10/480;
        var mainImageRect:ATNativeItemProperty = new ATNativeItemProperty(); //大图属性
        mainImageRect.rect = new Rectangle();
        mainImageRect.rect.x = ATAirSDK.getInstance().getScreenWidth() * 60/480;
        mainImageRect.rect.y = ATAirSDK.getInstance().getScreenHeight() *10/800;
        mainImageRect.rect.width = ATAirSDK.getInstance().getScreenWidth() * 240/480;
        mainImageRect.rect.height = ATAirSDK.getInstance().getScreenHeight() *120/800;
        mainImageRect.backgroundColor = "#ffffff";
        mainImageRect.textColor = "#777777";
        mainImageRect.textSize = ATAirSDK.getInstance().getScreenWidth() * 10/480;
        var titleRect:ATNativeItemProperty = new ATNativeItemProperty(); //标题属性
        titleRect.rect = new Rectangle();
        titleRect.rect.x = 0;
        titleRect.rect.y = ATAirSDK.getInstance().getScreenHeight() *100/800;
        titleRect.rect.width = ATAirSDK.getInstance().getScreenWidth() *50/480;
        titleRect.rect.height = ATAirSDK.getInstance().getScreenHeight() *50/800;
        titleRect.backgroundColor = "#ffffff";
        titleRect.textColor = "#777777";
        titleRect.textSize = ATAirSDK.getInstance().getScreenWidth() *12/480;
        var descRect:ATNativeItemProperty = new ATNativeItemProperty(); //描述文字属性
        descRect.rect = new Rectangle();
        descRect.rect.x = ATAirSDK.getInstance().getScreenWidth() *60/480;
        descRect.rect.y =  ATAirSDK.getInstance().getScreenHeight() *140/800;
        descRect.rect.width = ATAirSDK.getInstance().getScreenWidth() *240/480;
        descRect.rect.height =  ATAirSDK.getInstance().getScreenHeight() *30/800;
        descRect.backgroundColor = "#ffffff";
        descRect.textColor = "#777777";
        descRect.textSize = ATAirSDK.getInstance().getScreenWidth() *10/480;
        var adLogoRect:ATNativeItemProperty = new ATNativeItemProperty(); //广告logo属性
        adLogoRect.rect = new Rectangle();
        adLogoRect.rect.x = 0;
        adLogoRect.rect.y = 0;
        adLogoRect.rect.width = ATAirSDK.getInstance().getScreenWidth() *30/480;
        adLogoRect.rect.height = ATAirSDK.getInstance().getScreenHeight() *20/800;
        adLogoRect.backgroundColor = "#ffffff";
        adLogoRect.textColor = "#777777";
        adLogoRect.textSize = ATAirSDK.getInstance().getScreenWidth() *10/480;
        var ctaRect:ATNativeItemProperty = new ATNativeItemProperty(); //点击按钮属性
        ctaRect.rect = new Rectangle();
        ctaRect.rect.x = ATAirSDK.getInstance().getScreenWidth() *60/480;
        ctaRect.rect.y = ATAirSDK.getInstance().getScreenHeight() *170/800;
        ctaRect.rect.width = ATAirSDK.getInstance().getScreenWidth() *300/480;
        ctaRect.rect.height = ATAirSDK.getInstance().getScreenHeight() *30/800;
        ctaRect.backgroundColor = "#297ff9";
        ctaRect.textColor = "#ffffffff";
        ctaRect.textSize = ATAirSDK.getInstance().getScreenWidth() *17/480;

        nativeAdConfig.parentRect = parentRect;
        nativeAdConfig.iconRect = iconRect;
        nativeAdConfig.mainImageRect = mainImageRect;
        nativeAdConfig.titleRect = titleRect;
        nativeAdConfig.descRect = descRect;
        nativeAdConfig.adLogoRect = adLogoRect;
        nativeAdConfig.ctaRect = ctaRect;
        return nativeAdConfig;
    }


    public function load_nativebanner_clickHandler():void
    {
        trace("load_nativebanner_clickHandler");
        ATNativeBannerAd.setNativeBannerListener(nativebannerListener);
        var customObj:Object = {};
        customObj["age"] = 17;
        customObj["sex"] = "man";

        ATNativeBannerAd.loadNativeBannerAd(CommonConfig.getNativeBannerPlacement(), customObj);

    }

    public function show_nativebanner_clickHandler():void
    {
        trace("show_native_clickHandler");
        if(ATNativeBannerAd.isNativeBannerAdReady(CommonConfig.getNativeBannerPlacement()))
        {
            var rectangle:Rectangle = new Rectangle();
            rectangle.x = 0;
            rectangle.y = ATAirSDK.getInstance().getScreenHeight() - 80;
            rectangle.width = ATAirSDK.getInstance().getScreenWidth();
            rectangle.height = 80;

            var nativeBannerAdConfig:ATNativeBannerAdConfig = new ATNativeBannerAdConfig();
            nativeBannerAdConfig.bgColor = "#ff0000";
            nativeBannerAdConfig.showCloseButton = true;
            nativeBannerAdConfig.ctaTitleSize = 11;
            nativeBannerAdConfig.ctaBgColor = "#ffffff";
            nativeBannerAdConfig.ctaTitleColor = "#000000";
            nativeBannerAdConfig.autoRefreshTime = 10000;
            nativeBannerAdConfig.adTitleColor = "#ffffff";
            nativeBannerAdConfig.adTitleSize = 12;
            nativeBannerAdConfig.adDescColor = "#ffffff";
            nativeBannerAdConfig.adDescSize = 10;
            nativeBannerAdConfig.showCtaButton = true;

            ATNativeBannerAd.showNativeBannerAd(CommonConfig.getNativeBannerPlacement(), rectangle, nativeBannerAdConfig);
        }else{
            trace("!isNativeBannerAdReady");
        }


    }

    public function remove_nativebanner_clickhandler():void
    {
        trace("remove_nativebanner_clickhandler");
        ATNativeBannerAd.removeNativeBannerAd(CommonConfig.getNativeBannerPlacement());

    }
}
}