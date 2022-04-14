<div align="center">
<br>
<img width="200" src="https://raw.githubusercontent.com/58xinian/icon/master/Sub-Store1.png" alt="Sub-Store">
<br>
<br>
<h2 align="center">Sub-Store VPS 部署<h2>
</div>

> Docker-compose 部署

```yml
version: '2.2'
services:
  substore:
    image: domplingyaya/sub-store:dev
    container_name: Substore
    restart: always
    shm_size: 2gb
    ports:
      - "6080:6080"
    volumes:
      - $PWD/backend:/Sub-Store/backend #映射的后端目录，含有缓存的接口数据
    environment:
      - DOMAIN=http://sub-store.com
      - ALLOW_IP=(^xx\.xx\.xx\.xx)  # 限制 IP访问，正则规则的 ip 支持多个匹配，因为是公网访问，所以可以搭配 v2ray 之类的代理作为限制，也可以使用自己已经有的订阅地址的 ip，然后本地 vpn 软件建立相关访问的分流规则
      - TZ=Asia/Shanghai
```

- 将上面内容调整后放到服务器 `substore/docker-compose.yml`中
- 目录文件配置好之后在 `substore`目录执行  
  `docker-compose up -d` 启动；  
  `docker-compose logs` 打印日志扫码登录；  
  `docker-compose pull` 更新镜像；  
  `docker-compose stop` 停止容器；  
  `docker-compose restart` 重启容器；  
  `docker-compose down` 停止并删除容器；

<br>

> 环境变量

<li>
DOMAIN：
（<code style="color:red">（IP+端口）</code> 或者
<code style="color:red">（域名+端口）</code>）端口此处配置  （6080）
</li>
<li>
ALLOW_IP：
  允许访问的 <code style="color:red">IP地址</code> 为正则的方式如<code style="color:red">ALLOW_IP=(^127\.0\.0\.1)</code>
</li>
<br>

#### 常见问题

1.部署成功之后访问方式为 DOMIAN 的写法
2.确保服务器的端口是联通的
3.限制，具体方法请自行网上搜索配置好后使用 v2ray 容器挂载到当前服务器，然后设置代理访问。
#### 结束语

> 感谢 [@Peng-YM](https://github.com/Peng-YM/Sub-Store) 大佬的无私奉献将代码开源
