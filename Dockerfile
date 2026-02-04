# syntax=docker/dockerfile:1.7-labs
# ---------------------------------------------
# Overleaf Community Edition (Native ARM64 Build)
# Overleaf 社区版 (原生 ARM64 构建)
# ---------------------------------------------

ARG OVERLEAF_BASE_TAG=sharelatex/sharelatex-base:latest
FROM $OVERLEAF_BASE_TAG

WORKDIR /overleaf

# 1. Copy dependency definitions
# 1. 复制依赖定义文件
# -----------------------------------------
COPY --parents libraries/*/package.json patches/ services/*/package.json tools/migrations/ package.json package-lock.json /overleaf/
COPY server-ce/genScript.js server-ce/services.js /overleaf/

# 2. Install npm dependencies
# 2. 安装 npm 依赖
# ------------------------
RUN --mount=type=cache,target=/root/.cache \
    --mount=type=cache,target=/root/.npm \
    --mount=type=cache,target=/overleaf/services/web/node_modules/.cache,id=server-ce-webpack-cache \
    --mount=type=tmpfs,target=/tmp node genScript install | bash

# 3. Copy source code and compile
# 3. 复制源代码并编译
# ---------------------------
COPY --parents libraries/ services/ tools/migrations/ /overleaf/
RUN --mount=type=cache,target=/root/.cache \
    --mount=type=cache,target=/root/.npm \
    --mount=type=cache,target=/overleaf/services/web/node_modules/.cache,id=server-ce-webpack-cache \
    --mount=type=tmpfs,target=/tmp node genScript compile | bash

# 4. Copy service scripts and configurations
# 4. 复制服务脚本和配置文件
# --------------------------------------------------
ADD server-ce/runit /etc/service
ADD server-ce/config/env.sh /etc/overleaf/env.sh

# Configure Nginx / 配置 Nginx
ADD server-ce/nginx/nginx.conf.template /etc/nginx/templates/nginx.conf.template
ADD server-ce/nginx/overleaf.conf /etc/nginx/sites-enabled/overleaf.conf
ADD server-ce/nginx/clsi-nginx.conf /etc/nginx/sites-enabled/clsi-nginx.conf

# Configure Log Rotation / 配置日志轮转
ADD server-ce/logrotate/overleaf /etc/logrotate.d/overleaf
RUN chmod 644 /etc/logrotate.d/overleaf

# Configure Cron Tasks / 配置定时任务
ADD server-ce/cron /overleaf/cron
ADD server-ce/config/crontab-history /etc/cron.d/crontab-history
RUN chmod 600 /etc/cron.d/crontab-history
ADD server-ce/config/crontab-deletion /etc/cron.d/crontab-deletion
RUN chmod 600 /etc/cron.d/crontab-deletion

# Init Scripts / 初始化脚本
COPY server-ce/init_scripts/ /etc/my_init.d/
COPY server-ce/init_preshutdown_scripts/ /etc/my_init.pre_shutdown.d/

# App Settings / 应用设置
COPY server-ce/config/settings.js /etc/overleaf/settings.js

# History Service Config / 历史记录服务配置
COPY server-ce/config/production.json /overleaf/services/history-v1/config/production.json
COPY server-ce/config/custom-environment-variables.json /overleaf/services/history-v1/config/custom-environment-variables.json

# Grunt & Helper Scripts / Grunt 和辅助脚本
ADD server-ce/bin/grunt /usr/local/bin/grunt
RUN chmod +x /usr/local/bin/grunt
ADD server-ce/bin/flush-history-queues /overleaf/bin/flush-history-queues
RUN chmod +x /overleaf/bin/flush-history-queues
ADD server-ce/bin/force-history-resyncs /overleaf/bin/force-history-resyncs
RUN chmod +x /overleaf/bin/force-history-resyncs

# Latexmk Config / Latexmk 配置
COPY server-ce/config/latexmkrc /usr/local/share/latexmk/LatexMk

# Maintenance File / 维护状态文件
ENV SITE_MAINTENANCE_FILE="/etc/overleaf/site_status"
RUN touch $SITE_MAINTENANCE_FILE

# 5. Set Environment Variables
# 5. 设置环境变量
# --------------------------------
ENV OVERLEAF_CONFIG=/etc/overleaf/settings.js
ENV WEB_API_USER="overleaf"
ENV ADMIN_PRIVILEGE_AVAILABLE="true"
ENV OVERLEAF_APP_NAME="Overleaf Community Edition"
ENV OPTIMISE_PDF="true"

# Phusion Init Timeouts / Phusion 初始化超时设置
ENV KILL_PROCESS_TIMEOUT=55
ENV KILL_ALL_PROCESSES_TIMEOUT=55
ENV GRACEFUL_SHUTDOWN_DELAY_SECONDS=1
ENV NODE_ENV="production"
ENV LOG_LEVEL="info"

EXPOSE 80

ENTRYPOINT ["/sbin/my_init"]
