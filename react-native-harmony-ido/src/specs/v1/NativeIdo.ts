// NativeCalculator.ts
import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport';
import { TurboModuleRegistry } from 'react-native';


export interface Spec extends TurboModule {

  startSdk(appid: string, channel: string): void;

  gtcid(cb: (param: string) => void): void;

  version(cb: (param: string) => void): void;

  setDebugEnable(isEnable: boolean): void;

  setSessionTime(time: number): void;

  setMinAppActiveDuration(val: number): void;

  setMaxAppActiveDuration(val: number): void;

  setEventUploadInterval(val: number): void;

  setEventForceUploadSize(val: number): void;

  setProfileUploadInterval(val: number): void;

  setProfileForceUploadSize(val: number): void;

  setUserId(val: string): void;

  trackCustomKeyValueEventBegin(eventId: string): void;

  trackCustomKeyValueEventEnd(eventId: string, args:{[key: string]: string|number|boolean}, ext: string): void;

  trackCountEvent(eventId: string, args:{[key: string]: string|number|boolean}, ext: string): void;

  setProfile(profiles: {[key: string]: string|number|boolean}, ext: string): void;

}

export default TurboModuleRegistry.get<Spec>(
  'IdoModule',
) as Spec | null;