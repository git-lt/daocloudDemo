# 使用 node 6.10.3 的精简版作为基础镜像
FROM node:6.10.3-slim

# 安装 nginx
RUN apt-get update \
  && apt-get install -y nginx

# 指定工作目录
WORKDIR /app

# 将当前目录下所有文件拷贝到工作目录下
COPY . /app/

# 声明容器监控的端口
EXPOSE 80

# 安装项目依赖
# 开始构建项目
# 将 dist 目录所有文件拷贝到 nginx 目录下
# 删除工作目录
RUN npm install \
  && npm run build \
  && cp -r dist/* /var/www/html \
  && rm -rf /app

# 以前台的方式启动 nginx
CMD ["nginx", "-g", "daemon off;"]
