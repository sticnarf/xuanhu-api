# 选乎

## 部署方式

1. 安装好 Docker 和 Docker Compose。

2. 在项目目录下创建一个 `.env` 文件，内容如下：

```conf
ENDPOINT="https://oss-cn-shenzhen.aliyuncs.com" # 阿里云 OSS 的 ENDPOINT
ACCESS_KEY_ID="abcddcbaabcddcba" # 阿里云 OSS 的 ACCESS_KEY_ID
ACCESS_KEY_SECRET="abcdeedcbaabcdeedcbaabcde" # 阿里云 OSS 的 ACCESS_KEY_SECRET
AVATAR_BUCKET="xuanhu-avatar" # 阿里云 OSS 上存放用户头像的 bucket
SECRET_KEY_BASE="ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff" # 128 位的随机 HEX 串
CDN_HOST="https://mycdn.xuanhu.com" # CDN 地址，应能通过其访问 /js/index.js 和 /css/index.css
# 如果不使用 CDN 请删除上面一行
```

3. 执行 `docker-compose up --build`。第一次初始化数据库可能需要一些时间，所以可能会导致 web 服务器连接数据库失败。如果 web 服务启动失败，重新执行 `docker-compose up` 即可。

4. 上一步执行成功后，可用 `docker-compose up -d` 将服务运行于后台。