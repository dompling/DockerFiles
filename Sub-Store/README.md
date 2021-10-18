<div align="center">
<br>
<img width="200" src="https://raw.githubusercontent.com/58xinian/icon/master/Sub-Store1.png" alt="Sub-Store">
<br>
<br>
<h2 align="center">Sub-Store VPS 部署<h2>
</div>

> Docker-compose 部署

```yml
version: '1.0'
services:
  substore:
    image: domplingyaya/sub-store:dev
    container_name: substore
    restart: unless-stopped
    shm_size: 2gb
    volumes:
      - '$PWD/Sub-Store:/Sub-Store'
    ports:
      - '6080:6080'
    environment:
      - DOMIAN='http://sub.store'
```

- 将上面内容调整后放到服务器 `substore/docker-compose.yml`中
- 目录文件配置好之后在 `substore`目录执行  
  `docker-compose up -d` 启动；  
  `docker-compose logs` 打印日志扫码登录；  
  `docker-compose pull` 更新镜像；  
  `docker-compose stop` 停止容器；  
  `docker-compose restart` 重启容器；  
  `docker-compose down` 停止并删除容器；

> Docker 命令

```
docker pull domplingyaya/sub-store:dev

docker run -dit -v $PWD/Sub-Store:/Sub-Store -p 6080:6080 --name substore --restart unless-stopped domplingyaya/sub-store:dev -e DOMAIN="http://sub.store"

```

<br>

> 环境变量

<li>
DOMIAN：部署的 
（<code style="color:red">Ip</code> |
<code style="color:red">域名</code>） ：端口 （6080）
</li>
<br>

#### 常见问题

1.部署成功之后访问方式为 DOMIAN 的写法 2.确保服务器的端口是联通的 3.如果要设置为私人 IP 访问推荐修改 nginx 配置，使用<code>
allow 127.0.0.1;deny all;</code>限制，具体方法请自行网上搜索配置好后使用 v2ray 容器挂载到当前服务器，然后设置代理访问。

#### 结束语

> 感谢 [@Peng-YM](https://github.com/Peng-YM/Sub-Store) 大佬的无私奉献将代码开源
