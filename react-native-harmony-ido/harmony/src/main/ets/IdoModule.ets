// entry/src/main/ets/turbomodule/CalculatorModule.ts
import { AnyThreadTurboModule, UITurboModule } from '@rnoh/react-native-openharmony/ts';
import {Ido, IdoConfig} from "@getui/ido"
import { common } from '@kit.AbilityKit';
import { RNOHContext, UITurboModuleContext } from '@rnoh/react-native-openharmony/src/main/ets/RNOH/ts';
import hilog from '@ohos.hilog';

export class IdoModule extends UITurboModule{
  protected _context: common.UIAbilityContext;
  protected _RnContext: RNOHContext;
  protected gtcId: string = '';

  constructor(ctx: UITurboModuleContext) {
    super(ctx);
    this._context = ctx?.uiAbilityContext;
    this._RnContext = ctx;
  }
  version(cb: (param: string) => void): void{
    cb(Ido.getVersion())
  }

  startSdk(appid: string, channel: string): void{
    IdoConfig.setAppId(appid)
    IdoConfig.setChannel(channel)
    Ido.preInit(this._context)
    Ido.init(this._context).then((gtcId) => {
      this. gtcId = gtcId
      hilog.info(0x0000, 'IdoModule', 'IDO init Succeeded. GtcId: (%{public}s)', gtcId);
    })
  }

  gtcid(cb: (param: string) => void): void{
    cb(this.gtcId)
  }

  setDebugEnable(isEnable: boolean): void{
    IdoConfig.setDebugEnable(isEnable)
    // IdoConfig.setDebugEnable(6)
    hilog.info(0x0000, 'IdoModule', `setDebugEnable ${isEnable}`);
  }

  setSessionTime(time: number): void{
    IdoConfig.setSessionTimeoutMillis(time)
  }

  setMinAppActiveDuration(val: number): void{
    IdoConfig.setMinAppActiveDuration(val)
  }

  setMaxAppActiveDuration(val: number): void{
    IdoConfig.setMaxAppActiveDuration(val)
  }

  setEventUploadInterval(val: number): void{
    IdoConfig.setEventUploadInterval(val)
  }

  setEventForceUploadSize(val: number): void{
    IdoConfig.setEventForceUploadSize(val)
  }

  setProfileUploadInterval(val: number): void{
    IdoConfig.setProfileUploadInterval(val)
  }

  setProfileForceUploadSize(val: number): void{
    IdoConfig.setProfileForceUploadSize(val)
  }

  setUserId(val: string): void{
    Ido.setUserId(val)
  }

  trackCustomKeyValueEventBegin(eventId: string): void{
    Ido.onBeginEvent(eventId)
  }

  trackCustomKeyValueEventEnd(eventId: string, args: Object, ext: string): void{

    // 转换前打印原始对象
    hilog.info(0x0000, 'IdoModule', `trackCustomKeyValueEventEnd ${JSON.stringify(args, null, 2)}`);
    // 将 Object 转换为 Map
    const profileMap: Map<string, string | number | Date | boolean> = new Map(
      Object.entries(args).map((entry:[string,object]) => {
        const key = entry[0] as string;  // 显式类型断言
        const value = entry[1] as string | number | Date | boolean;
        return [key, value];
      })
    );


    // 转换后打印 Map 内容

    hilog.info(0x0000, 'IdoModule', '转换后的 Map 内容:');
    profileMap.forEach((value, key) => {
      hilog.info(0x0000, 'IdoModule',`Key: ${key}, Value: ${value} (${typeof value})`);
    });

    Ido.onEndEvent(eventId,profileMap,ext)

  }

  trackCountEvent(eventId: string, args: Object, ext: string): void{

    // 转换前打印原始对象
    hilog.info(0x0000, 'IdoModule', `trackCountEvent ${JSON.stringify(args, null, 2)}`);
    // 将 Object 转换为 Map
    const profileMap: Map<string, string | number | Date | boolean> = new Map(
      Object.entries(args).map((entry:[string,object]) => {
        const key = entry[0] as string;  // 显式类型断言
        const value = entry[1] as string | number | Date | boolean;
        return [key, value];
      })
    );

    // 转换后打印 Map 内容
    hilog.info(0x0000, 'IdoModule', '转换后的 Map 内容:');
    profileMap.forEach((value, key) => {
      hilog.info(0x0000, 'IdoModule',`Key: ${key}, Value: ${value} (${typeof value})`);
    });

    Ido.onEvent(eventId,profileMap,ext)
  }

  setProfile(profiles: Object, ext: string): void{
    // 转换前打印原始对象
    hilog.info(0x0000, 'IdoModule', `setProfile ${JSON.stringify(profiles, null, 2)}`);

    // 将 Object 转换为 Map
    const profileMap: Map<string, string | number | Date | boolean> = new Map(
      Object.entries(profiles).map((entry:[string,object]) => {
        const key = entry[0] as string;  // 显式类型断言
        const value = entry[1] as string | number | Date | boolean;
        return [key, value];
      })
    );

    // 转换后打印 Map 内容
    hilog.info(0x0000, 'IdoModule', '转换后的 Map 内容:');
    profileMap.forEach((value, key) => {
      hilog.info(0x0000, 'IdoModule',`Key: ${key}, Value: ${value} (${typeof value})`);
    });


    // 调用原方法
    Ido.onProfile(profileMap, ext);
  }

}

