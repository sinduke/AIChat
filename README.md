# 🤖 AIChat - iOS AI聊天应用

<div align="center">

![Swift](https://img.shields.io/badge/Swift-6-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

*AIChat是一个现代化的iOS AI聊天应用，专注于架构演进和最佳实践*

</div>

---

## 📖 项目介绍

AIChat是一个用于学习和实践iOS开发架构演进的项目。从最基础的编码开始，逐步演进到Manager模式、MV、MVVM、VIPER架构，最终结合Uber的RIBs框架，打造一个完整的、可扩展的AI聊天应用。

### 🎯 项目目标

- **架构学习**: 通过实际项目学习不同架构模式的优缺点
- **最佳实践**: 实现iOS开发的最佳实践和设计模式
- **完整功能**: 构建包含完整功能的AI聊天应用
- **可维护性**: 确保代码的可维护性和可扩展性

---

## 🚀 功能特性

### 核心功能
- 💬 AI智能对话
- 🎨 现代化UI设计
- 📱 原生iOS体验
- 🔄 实时消息同步

### 技术特性
- 📊 数据埋点与分析
- 🔔 推送通知
- 🧪 A/B测试支持
- 💰 收费墙集成
- 🧪 单元测试覆盖
- 📦 模块化架构

---

## 🏗️ 技术架构

### 当前架构
- **框架**: SwiftUI
- **语言**: Swift 6
- **最低版本**: iOS 17+
- **数据存储**: SwiftData + AppStorage + Firebase

### 架构演进计划
1. **纯编码** → 基础功能实现
2. **Manager模式** → 业务逻辑分离
3. **MV模式** → Model-View分离
4. **MVVM模式** → 响应式数据绑定
5. **VIPER模式** → 模块化架构
6. **RIBs框架** → 企业级架构

---

## 📱 应用截图

<div align="center">

*应用截图将在后续开发过程中添加*

</div>

---

## 🛠️ 开发环境

### 系统要求
- **macOS**: 14.0+
- **Xcode**: 15.0+
- **iOS**: 17.0+
- **Swift**: 6+

### 依赖管理
- Swift Package Manager
    - SwiftfulThink 系列
    - SDWebImageSwiftUI
    - Firebase
    - Mixpanel
- 原生iOS框架

---

## 🚀 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/sinduke/AIChat.git
cd AIChat
```

### 2. 打开项目
```bash
open AIChat.xcodeproj
```

### 3. 运行项目
- 选择目标设备或模拟器
- 点击运行按钮或使用快捷键 `Cmd + R`

---

## 📁 项目结构

```
AIChat/
├── AIChat/                    # 主应用目录
│   ├── AIChatApp.swift       # 应用入口
│   ├── ContentView.swift     # 主视图
│   └── Assets.xcassets/      # 资源文件
├── AIChatTests/              # 单元测试
├── AIChatUITests/            # UI测试
└── README.md                 # 项目文档
```

---

## 🧪 测试

### 单元测试
```bash
# 运行单元测试
Cmd + U
```

### UI测试
```bash
# 运行UI测试
Product → Test
```

---

## 📋 TODO 列表

### 🎯 第一阶段：基础架构
- [ ] 实现基础的AI聊天界面
- [ ] 集成AI API服务
- [ ] 实现消息发送和接收功能
- [ ] 添加基础的数据存储

### 🏗️ 第二阶段：架构演进
- [ ] 实现Manager模式
  - [ ] 创建ChatManager
  - [ ] 创建UserManager
  - [ ] 创建SettingsManager
- [ ] 实现MV模式
  - [ ] 分离Model层
  - [ ] 优化View层
- [ ] 实现MVVM模式
  - [ ] 添加ViewModel层
  - [ ] 实现数据绑定
  - [ ] 添加响应式编程

### 🔧 第三阶段：高级功能
- [ ] 实现VIPER架构
  - [ ] 创建Interactor层
  - [ ] 创建Presenter层
  - [ ] 创建Router层
  - [ ] 创建Entity层
- [ ] 集成RIBs框架
  - [ ] 实现模块化架构
  - [ ] 添加依赖注入
  - [ ] 实现路由系统

### 📊 第四阶段：数据与分析
- [ ] 数据埋点系统
  - [ ] 用户行为追踪
  - [ ] 性能监控
  - [ ] 错误日志
- [ ] A/B测试框架
  - [ ] 实验配置
  - [ ] 数据收集
  - [ ] 结果分析

### 🔔 第五阶段：通知与付费
- [ ] 推送通知
  - [ ] 本地通知
  - [ ] 远程推送
  - [ ] 通知管理
- [ ] 收费墙集成
  - [ ] 订阅管理
  - [ ] 支付集成
  - [ ] 权限控制

### 🧪 第六阶段：测试与优化
- [ ] 单元测试
  - [ ] 业务逻辑测试
  - [ ] 网络层测试
  - [ ] 数据层测试
- [ ] UI测试
  - [ ] 界面交互测试
  - [ ] 用户体验测试
- [ ] 性能优化
  - [ ] 内存优化
  - [ ] 启动时间优化
  - [ ] 网络请求优化

---

## 🤝 贡献指南

我们欢迎所有形式的贡献！

### 如何贡献
1. Fork 这个项目
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

### 代码规范
- 遵循Swift官方编码规范
- 使用有意义的变量和函数名
- 添加适当的注释
- 确保代码覆盖率

---

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

---

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者和设计师！

---

<div align="center">
如果你想要学习Swift和提升Swift技能 请关注 YouTube: Swiftful Thinking
如果想要学习Swift组件 请关注 YouTube: Kavsoft

**⭐ 如果这个项目对你有帮助，请给它一个星标！**

</div>
