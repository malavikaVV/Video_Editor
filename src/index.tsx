import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-bridge-rn' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const BridgeRn = NativeModules.BridgeRn
  ? NativeModules.BridgeRn
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return BridgeRn.multiply(a, b);
}

export const passTextToAAR = async (text: any) => {
  try {
    const result = await BridgeRn.passTextToAAR(text);
    console.log('Result from AAR:', result);
    return result;
  } catch (error) {
    console.error('Error:', error);
  }
};

export const launchVideoEditor = async ( url : any, url2?: any) => {
  try{
    const result = await BridgeRn.launchVideoEditor(url, url2);
    console.log('video url:', url, url2);
    return result;
  } catch (error) {
    console.error('Error: video ---> ', error);
  }
}