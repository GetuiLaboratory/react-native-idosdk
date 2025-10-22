import { RNPackageContext, RNPackage } from '@rnoh/react-native-openharmony/ts';
import  { IdoPackage } from 'IdoOhosSdk/ts';

export function createRNPackages(ctx: RNPackageContext): RNPackage[] {
  return [
    new IdoPackage(ctx),
  ];
}