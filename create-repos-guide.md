# GitHub仓库创建指南（手动）

## 需要创建的仓库

### 1. 博客网站仓库
- **名称**: `fire13141.github.io`
- **描述**: 现金活动自动化机器人博客
- **类型**: Public
- **初始化**: 不添加README、.gitignore、许可证

**创建步骤**：
1. 访问 https://github.com/new
2. 填写仓库信息
3. 点击 "Create repository"

### 2. 部署包仓库
- **名称**: `cash-bot-deployment`
- **描述**: 现金活动机器人一键部署包
- **类型**: Public
- **初始化**: 不添加README、.gitignore、许可证

**创建步骤**：
1. 访问 https://github.com/new
2. 填写仓库信息
3. 点击 "Create repository"

## 创建后立即推送

### 博客网站推送命令：
```bash
cd /root/.openclaw/workspace
git remote add origin git@github.com:fire13141/fire13141.github.io.git
git push -u origin master
```

### 部署包推送命令：
```bash
cd /root/.openclaw/workspace/cash-bot-deployment
git remote add origin git@github.com:fire13141/cash-bot-deployment.git
git push -u origin master
```

## 验证部署

### 博客网站验证：
访问: https://fire13141.github.io/
预期: 现金活动机器人首页

### 部署包验证：
访问: https://github.com/fire13141/cash-bot-deployment
预期: 完整部署包文件

## 管理面板更新

### 更新步骤：
1. 访问现有管理面板仓库
2. 上传 `openclaw-managenment-panel-index.html`
3. 重命名为 `index.html`（覆盖）
4. 提交更改

### 验证更新：
访问: https://fire13141.github.io/openclaw-managenment-panel/
检查: 新增培训清单链接

## 时间预估
- 仓库创建: 2分钟
- 代码推送: 3分钟
- 页面生效: 1-2分钟
- 总计: 5-7分钟

## 成功标志
1. ✅ 博客网站可访问
2. ✅ 部署包可下载
3. ✅ 管理面板已更新
4. ✅ 所有链接正常工作

## 故障排除
**问题**: 推送失败 "Repository not found"
**解决**: 确认仓库名称正确，且为Public

**问题**: 页面404
**解决**: 等待1-2分钟，GitHub Pages需要时间部署

**问题**: SSH认证失败
**解决**: 重新添加SSH公钥到GitHub