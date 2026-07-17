FROM ghcr.io/chenyme/grok2api:latest

# 1. 切换到 root 用户以获取最高权限
USER root

# 2. 将你仓库根目录的 config.yaml 复制到容器内
COPY config.yaml /app/config.yaml

# 3. 核心修复：把整个 /app 目录及配置文件的权限完全放开
# 这不仅能解决启动时的 cp 报错，还能让你未来在 /admin 网页后台修改配置时顺利保存
RUN chown -R 1000:1000 /app && chmod -R 777 /app

# 4. 切换回非 root 用户 (符合 Render 的安全策略)
USER 1000
