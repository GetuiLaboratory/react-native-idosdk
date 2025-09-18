package com.getui.reactnativegetui;

import android.content.Context;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.getui.gs.sdk.GsManager;
import com.getui.gs.ias.core.GsConfig;
import org.json.JSONObject;
import org.json.JSONException;
import android.text.TextUtils;
import com.getui.gs.sdk.IGtcIdCallback;
import android.util.Log;
import android.os.Handler;
import android.os.Looper;
import android.widget.Toast;

public class GetuiIdoModule extends ReactContextBaseJavaModule {

    private Context mContext;
 
    private Callback callback;
    private static  String TAG = "GetuiIdoModule";

    public GetuiIdoModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;
    }

    @Override
    public String getName() {
        return "GetuiIdoModule";
    }

    @ReactMethod
    public void startSdk(String appid, String channel) {
        // 设置AppId
        if (!TextUtils.isEmpty(appid)){
            GsConfig.setAppId(appid);
        }
        // 预初始化
        GsManager.getInstance().preInit(mContext);
        // 初始化并注册gtcid
        GsManager.getInstance().init(mContext);
        Toast.makeText(mContext, "GsManager init ", Toast.LENGTH_SHORT).show();
    }

    @ReactMethod
    public void gtcid(final Callback callback) {
        String gtCid =  GsManager.getInstance().getGtcId();
        if (TextUtils.isEmpty(gtCid)){
            Toast.makeText(mContext, "gtcId: is Empty", Toast.LENGTH_SHORT).show();
            GsManager.getInstance().setGtcIdCallback(new IGtcIdCallback() {
                @Override
                public void onGetGtcId(String gtcId) {
                    Log.d(TAG, "onGetGtcId: " + gtcId);
                    new Handler(Looper.getMainLooper()).post(() -> {
                        Toast.makeText(mContext, "gtcId: "+gtcId, Toast.LENGTH_SHORT).show();
                        callback.invoke(gtcId);
                    });
                }
            });
        }else {
           // Toast.makeText(mContext, "gtcId: is not Empty", Toast.LENGTH_SHORT).show();
            callback.invoke(gtCid);
        }
    }

    @ReactMethod
    public void version(Callback callback) {
        callback.invoke(GsManager.getInstance().getVersion());
    }

    @ReactMethod
    public void setDebugEnable(boolean isEnable) {
        GsConfig.setDebugEnable(isEnable);
    }

    @ReactMethod
    public void setApplicationGroupIdentifier(String identifier) {
        // Android不需要实现此方法，iOS专用
    }

    @ReactMethod
    public void setSessionTime(int time) {
        GsConfig.setSessionTimeoutMillis(time ); // 转换为毫秒
    }

    @ReactMethod
    public void setMinAppActiveDuration(int val) {
        GsConfig.setMinAppActiveDuration(val ); // 转换为毫秒
    }

    @ReactMethod
    public void setMaxAppActiveDuration(int val) {
        GsConfig.setMaxAppActiveDuration(val); // 转换为毫秒
    }

    @ReactMethod
    public void setEventUploadInterval(int val) {
        GsConfig.setEventUploadInterval(val);
    }

    @ReactMethod
    public void setEventForceUploadSize(int val) {
        GsConfig.setEventForceUploadSize(val);
    }

    @ReactMethod
    public void setProfileUploadInterval(int val) {
        GsConfig.setProfileUploadInterval(val);
    }

    @ReactMethod
    public void setProfileForceUploadSize(int val) {
        GsConfig.setProfileForceUploadSize(val);
    }

    @ReactMethod
    public void setUserId(String val) {
        // 设置用户ID，需要根据实际SDK提供的方法实现
         GsManager.getInstance().setUserId(val);
    }

    @ReactMethod
    public void setSyncGenerateGtcid(boolean val) {
        // 设置同步生成Gtcid，需要根据实际SDK提供的方法实现
        GsManager.getInstance().syncGenerateGtcId(val);
    }

    @ReactMethod
    public void registerEventProperties(ReadableMap val) {
        try {
            JSONObject properties = convertReadableMapToJson(val);
            GsManager.getInstance().registerEventProperties(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void trackCustomKeyValueEventBegin(String eventId) {
        try {
             GsManager.getInstance().onBeginEvent(eventId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void trackCustomKeyValueEventEnd(String eventId, ReadableMap args, String ext) {
        try {
             GsManager.getInstance().onEndEvent(eventId,convertReadableMapToJson(args),ext);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void trackCountEvent(String eventId, ReadableMap args, String ext) {
        try {
            // 跟踪计数事件
            GsManager.getInstance().onEvent(eventId, convertReadableMapToJson(args),ext);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void setProfile(ReadableMap profiles, String ext) {
        try {
            JSONObject profileData = convertReadableMapToJson(profiles);
            // 设置用户属性
            GsManager.getInstance().setProfile(profileData,ext);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




    // 辅助方法：将ReadableMap转换为JSONObject
    private JSONObject convertReadableMapToJson(ReadableMap readableMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        if (readableMap != null) {
            ReadableMapKeySetIterator iterator = readableMap.keySetIterator();
            while (iterator.hasNextKey()) {
                String key = iterator.nextKey();
                ReadableType type = readableMap.getType(key);
                switch (type) {
                    case Null:
                        jsonObject.put(key, JSONObject.NULL);
                        break;
                    case Boolean:
                        jsonObject.put(key, readableMap.getBoolean(key));
                        break;
                    case Number:
                        // 尝试获取整数，如果不是整数则获取双精度浮点数
                        try {
                            jsonObject.put(key, readableMap.getInt(key));
                        } catch (Exception e) {
                            jsonObject.put(key, readableMap.getDouble(key));
                        }
                        break;
                    case String:
                        jsonObject.put(key, readableMap.getString(key));
                        break;
                    case Map:
                        jsonObject.put(key, convertReadableMapToJson(readableMap.getMap(key)));
                        break;
                    case Array:
                        // 数组处理需要额外实现
                        jsonObject.put(key, readableMap.getArray(key).toString());
                        break;
                }
            }
        }
        return jsonObject;
    }

    // 发送事件到JS
    private void sendEvent(String eventName, WritableMap params) {
        getReactApplicationContext()
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

}