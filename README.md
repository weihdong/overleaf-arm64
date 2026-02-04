# Overleaf Community Edition (Native ARM64)

🐳 **Docker Image:** `weihaodong222/overleaf-arm`

---
## ⚡️ Quick Start / 极速开始
### 1. Download / 下载
**Download** the `docker-compose.yml` file from this repository.
下载本仓库中的 `docker-compose.yml` 文件到任意文件夹。
### 2. Run / 运行
Open your terminal in that folder and run:
在文件夹中打开终端，运行以下命令：
```bash
docker-compose up -d
````
### 3. Done / 完成
Wait **30 seconds**. Open your browser:
等待约 **30秒** 让数据库初始化。然后访问：
👉 **http://localhost:8081/launchpad**
Create your admin account and enjoy!
创建管理员账号，开始使用！

---
### 💡 Notes / 说明

- **Database Included**: MongoDB & Redis are auto-configured. No manual setup needed.
    **自带数据库**：已内置 Mongo 和 Redis，无需任何手动配置。
    
- **Email (Optional)**: Uncomment SMTP settings in `docker-compose.yml` if you need password reset.
    **邮件功能(可选)**：如需“找回密码”功能，请取消 YML 文件中 SMTP 部分的注释。
    
