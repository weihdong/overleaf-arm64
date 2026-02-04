
# Overleaf Community Edition (Native ARM64) 🚀

 **English** |  **中文**

> **A native, fast, zero-config Overleaf (ShareLaTeX) image for Apple Silicon & Raspberry Pi.** > **专为 Apple Silicon (M系列芯片) 和树莓派打造的原生、高速、零配置 Overleaf 镜像。**

🐳 **Docker Image:** `weihaodong222/overleaf-arm`

---

## ✨ Features / 特性

- 🔥 **Native ARM64**: Runs natively on M1/M2/M3/M4 & Pi 4/5. No Rosetta emulation.  
  **原生极速**：彻底告别 Rosetta 转译，满血运行。
- 📦 **Zero Config**: MongoDB & Redis are pre-configured in `docker-compose.yml`.  
  **零配置启动**：数据库已预置，下载即用，无需烧脑。
- 📚 **Full TeXLive**: Comes with a complete TeXLive installation (~4GB).  
  **完整环境**：内置完整版 TeXLive，宏包一个不少。

---

## 🚀 Quick Start / 快速开始

### 1. Download / 下载配置
Download the `docker-compose.yml` file from this repository.  
下载本仓库中的 `docker-compose.yml` 文件。

### 2. Run / 启动
Open terminal in the folder and run:  
在当前目录打开终端并运行：

```bash
docker-compose up -d
````

### 3. Initialize / 初始化

Wait **30-60 seconds** for first boot. Then open:

首次启动需等待 **30-60秒**。然后访问：

👉 **http://localhost:8081/launchpad**

Create your first admin account.

创建您的第一个管理员账户。

---

## ⚙️ Configuration / 进阶配置

### Email / 邮件服务

Edit `docker-compose.yml` and uncomment the `SMTP` section to enable "Forgot Password" emails.

编辑 `docker-compose.yml`，取消 `SMTP` 部分的注释即可启用“忘记密码”邮件功能。

### External Access / 外网访问

Uncomment the `tunnel` service in `docker-compose.yml` and add your Cloudflare Tunnel Token.

取消注释 `tunnel` 服务并填入 Cloudflare Token，即可实现安全的外网访问。

---

## ❤️ Credits

Based on the official [Overleaf Community Edition](https://github.com/overleaf/overleaf). Built to solve the lack of official ARM64 support.

基于 Overleaf 官方社区版构建，旨在解决官方缺乏 ARM64 镜像的痛点。
