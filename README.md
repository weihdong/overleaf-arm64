# Overleaf Community Edition (Native ARM64)

🐳 **Docker Image:** `weihaodong222/overleaf-arm`

---
### ⚡️ Quick Start / 极速开始

#### 1. Clone / 克隆

Open your terminal and clone the repository: 打开终端，克隆本项目代码并进入目录：

Bash

```
git clone https://github.com/weihaodong222/overleaf-deploy.git
cd overleaf-deploy
```

_(注意：请将 `weihaodong222/overleaf-deploy` 替换为你实际的仓库地址)_

#### 2. Run / 运行

Start the service with one command: 运行以下命令一键启动：

Bash

```
docker-compose up -d
```

#### 3. Done / 完成

Wait **30 seconds** for the database to initialize. Then visit: 等待约 **30秒** 让数据库初始化。然后访问：

👉 **http://localhost:8081/launchpad**

Create your admin account and enjoy! 创建管理员账号，开始使用！

---
### 💡 Notes / 说明

- **Database Included**: MongoDB & Redis are auto-configured. No manual setup needed.
    **自带数据库**：已内置 Mongo 和 Redis，无需任何手动配置。
    
- **Email (Optional)**: Uncomment SMTP settings in `docker-compose.yml` if you need password reset.
    **邮件功能(可选)**：如需“找回密码”功能，请取消 YML 文件中 SMTP 部分的注释。
    
- **External Access / 外网访问**：Uncomment the `tunnel` service in `docker-compose.yml` and add your Cloudflare Tunnel Token.
取消注释 `tunnel` 服务并填入 Cloudflare Token，即可实现安全的外网访问。
