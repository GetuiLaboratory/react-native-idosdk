

# react-native-idosdk
* idosdk 是个推官方开发的 IDOSDK React Native 插件，使用该插件可以方便快速地集成推送功能。



# 环境

1. React Native Version 
   "react": "18.3.1"
   "react-native": "0.75.4"
2. 当前react-native-idosdk版本 1.0.2


注意：
 


# 1.安装

### 1.1 使用 npm 自动安装

在您的项目根目录下执行

````js
step1:添加npm包依赖
 npm install react-native-idosdk@latest --save 


step2:iOS, pod项目, 链接iOS原生代码
npx pod-install


step2: 链接 (非Autolinking项目, 和iOS非pod项目)
react-native link
 

 

# 2. 配置

* appId 需要去 [个推官网](https://dev.getui.com) 注册后，在后台配置获取。



## 2.1 Android


 

## 2.2 IOS
 


### 2.2.2 使用CocoaPods安装 

如果是原生应用集成react-native

如果你的 React Native 是通过 Cocoapods 来集成的则使用下面两个步骤来集成 

1. 在Podfile中添加如下代码（需要写在对应的 target 里）：

````
pod 'IdoSdkRN', :path => '../node_modules/react-native-idosdk'

````

2. 终端执行如下命令：

````
pod install

````

**注意:** 

*  使用 pod 就不要使用 react-native link 了，不然会有冲突。

* 在 iOS 工程中如果找不到头文件可能要在 TARGETS-> BUILD SETTINGS -> Search Paths -> Header Search Paths 添加如下如路径

  ```
  $(SRCROOT)/../node_modules/react-native-getui/ios/RCTGetuiModule
  ```




### 2.4 API调用与订阅消息

查看示例

android 与 ios 有部分API不同, 查看插件的index.js 或 index.d.ts中API的注释


## 3.iOS注意事项 


