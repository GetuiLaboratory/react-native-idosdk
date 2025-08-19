

export default class GetuiIdo { 
	static startSdk(appid: string, channel: string): void;
	 
	static gtcid(cb: (param: string) => void): void;
 
	static version(cb: (param: string) => void): void;
 
	static setDebugEnable(isEnable: boolean): void;
	
	static setApplicationGroupIdentifier(identifier: string): void;

	static setSessionTime(time: number): void;

	static setMinAppActiveDuration(val: number);
	static setMaxAppActiveDuration(val: number);

	static setEventUploadInterval(val: number);
	static setEventForceUploadSize(val: number);

	static setProfileUploadInterval(val: number);
	static setProfileForceUploadSize(val: number);
	
	static setUserId(val: string);
	static setSyncGenerateGtcid(val: boolean);
	static registerEventProperties(val: Map);

	
	static trackCustomKeyValueEventBegin(eventId:string);
	static trackCustomKeyValueEventEnd(eventId:string, args:Map, ext:string);
	static trackCountEvent(eventId:string, args:Map, ext:string);
	static setProfile(profiles:Map, ext:string) 
  
}
