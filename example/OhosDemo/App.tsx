import { GetuiIdo } from "gt-ido-ohos-plugin";
import type { PropsWithChildren } from 'react';
import React, { useEffect, useState } from 'react';
import {
  DeviceEventEmitter,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  View,
  Button,
  Alert,
  useColorScheme,
} from 'react-native';

import { Colors } from 'react-native/Libraries/NewAppScreen';

type SectionProps = PropsWithChildren<{
  title: string;
}>;

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  const [gtcid, setGtcid] = useState<string | null>(null); // 存储 gtcid
  const [version, setVersion] = useState<string>('未知'); // 存储版本号


  // 初始化运营工具
  const initIdo = () => {
    try {
     // 获取版本号
      GetuiIdo.version((ver: string) => {
        setVersion(ver);
      });

      const appId = 'djYjSlFVMf6p5YOy2OQUs8';
      const channel = 'rn';
      GetuiIdo.setDebugEnable(true)

      GetuiIdo.startSdk(appId, channel);

      setTimeout((): void => {
           // 获取 gtcid
                 GetuiIdo.gtcid((id: string) => {
                     Alert.alert('成功', '运营工具初始化成功 \n '+id);
                     setGtcid(id);
                 });
      }, 5000);




      // 开启调试模式（可选）
      GetuiIdo.setDebugEnable(true);
      // 设置其他可选配置（根据需求调整，时间单位为毫秒）
      GetuiIdo.setSessionTime(30000); // 设置会话时间（毫秒）
      GetuiIdo.setMinAppActiveDuration(60000); // 设置最小活跃时长（毫秒）
      GetuiIdo.setMaxAppActiveDuration(3600000); // 设置最大活跃时长（毫秒）
      GetuiIdo.setEventUploadInterval(300000); // 设置事件上传间隔（毫秒）
      GetuiIdo.setEventForceUploadSize(50); // 设置强制上传事件数量
      GetuiIdo.setProfileUploadInterval(600000); // 设置用户画像上传间隔（毫秒）
      GetuiIdo.setProfileForceUploadSize(20); // 设置用户画像强制上传数量

      const profiles = {
          "userId": 123,
          "name": "Alice",
          "isActive": true
      };

      GetuiIdo.setProfile(profiles,  "sss");



    } catch (error) {
      Alert.alert('错误', '初始化运营工具失败: ' + error);
    }
  };
  const trackCountEvent = () =>{
         const profiles = {
                "userId": 123,
                "name": "Alice",
                "isActive": true
            };

           GetuiIdo.trackCountEvent("123",profiles,"ss");
   }

  // 组件生命周期管理
  useEffect(() => {
    // 可在此处添加其他初始化逻辑或事件监听
    return () => {
      // 清理逻辑（如果需要）
    };
  }, []);

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };
  const safePadding = '5%';

  return (
    <View style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView style={backgroundStyle}>
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            paddingHorizontal: safePadding,
            paddingBottom: safePadding,
          }}
        >
          <Text style={styles.cidText}>当前版本号：{version}</Text>
          <Button title="初始化运营工具" onPress={initIdo} />
          {gtcid ? (
            <Text style={styles.cidText}>当前设备gtcid：{gtcid}</Text>
          ) : (
            <Text style={styles.cidText}>未获取到gtcid</Text>
          )}
        <Button style={styles.sectionContainer}  title="计数" onPress={trackCountEvent} />
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
  cidText: {
    marginTop: 16,
    fontSize: 16,
    color: '#333',
    textAlign: 'center',
  },
});

export default App;