// entry/src/main/ets/GeneratedPackage.ets
import {
  RNOHPackage,
  AnyThreadTurboModule,
  AnyThreadTurboModuleContext,
  UITurboModule,
  UITurboModuleContext
} from '@rnoh/react-native-openharmony';

import { IdoModule } from './IdoModule';

export  class IdoPackage extends RNOHPackage {
  override getUITurboModuleFactoryByNameMap(): Map<string, (ctx: UITurboModuleContext) => UITurboModule | null> {
    return new Map<string, ((ctx: UITurboModuleContext) => UITurboModule)>()
      .set("IdoModule", (ctx) => new IdoModule(ctx))
  }


  override async createEagerUITurboModuleByNameMap(ctx: UITurboModuleContext): Promise<Map<string, UITurboModule>> {
    const calculatorModule = new IdoModule(ctx);
    return new Map()
      .set("IdoModule", calculatorModule)
  }
}