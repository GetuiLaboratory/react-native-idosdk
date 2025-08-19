import {
	NativeModules,
	Platform
} from 'react-native';

const GetuiIdoModule = NativeModules.GetuiIdoModule;

/**
 * Logs message to console with the [Getui] prefix
 * @param  {string} message
 */
const log = (message) => {
	console.log(`[Getui][Ido] ${message}`);
}

export default class GetuiIdo {
    /**
	 * 初始化推送服务 只有Android,  IOS在AppDelegate中初始化
     */
    static startSdk(appid, channel){
    	GetuiIdoModule.startSdk(appid, channel);
	} 

	/**
	 *  获取SDK的Cid
	 *
	 *  @return Cid值
	 */
	static gtcid(cb) {
		GetuiIdoModule.gtcid((param)=>{
			cb(param)
		});
	} 
	static version(cb) {
		GetuiIdoModule.version((param)=>{
			cb(param)
		});
	} 
	static setDebugEnable(isEnable) {
		GetuiIdoModule.setDebugEnable(isEnable);
	}
	
	static setApplicationGroupIdentifier(idnetifier) {
		GetuiIdoModule.setApplicationGroupIdentifier(identifier);
	}

	static setSessionTime(time) {
		GetuiIdoModule.setSessionTime(time);
	}

	static setMinAppActiveDuration(val) {
		GetuiIdoModule.setMinAppActiveDuration(val);
	}
	static setMaxAppActiveDuration(val) {
		GetuiIdoModule.setMaxAppActiveDuration(val);
	}

	static setEventUploadInterval(val) {
		GetuiIdoModule.setEventUploadInterval(val);
	}
	static setEventForceUploadSize(val) {
		GetuiIdoModule.setEventForceUploadSize(val);
	}
	static setProfileUploadInterval(val) {
		GetuiIdoModule.setProfileUploadInterval(val);
	}
	static setProfileForceUploadSize(val) {
		GetuiIdoModule.setProfileForceUploadSize(val);
	}
	static setUserId(val) {
		GetuiIdoModule.setUserId(val);
	}
	static setSyncGenerateGtcid(val) {
		GetuiIdoModule.setSyncGenerateGtcid(val);
	}   
	static registerEventProperties(val) {
		GetuiIdoModule.registerEventProperties(val);
	}    
 
	static trackCustomKeyValueEventBegin(eventId) {
		GetuiIdoModule.trackCustomKeyValueEventBegin(eventId);
	} 
	static trackCustomKeyValueEventEnd(eventId, args, ext) {
		GetuiIdoModule.trackCustomKeyValueEventEnd(eventId, args, ext);
	} 
	static trackCountEvent(eventId, args, ext) {
		GetuiIdoModule.trackCountEvent(eventId, args, ext);
	} 
	static setProfile(profiles, ext) {
		GetuiIdoModule.setProfile(profiles, ext);
	}  
  
}
