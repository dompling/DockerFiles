#!/bin/sh

gitPath="/git"
rootPath="/Sub-Store"
backend="$rootPath/backend"
web="$rootPath/web"
nginx="$rootPath/nginx"

echo -e "======================== 1. 启动nginx ========================\n"
mkdir -p /etc/nginx/conf.d
mkdir -p /run/nginx
cp -r /docker/nginx/. /etc/nginx/conf.d
echo -e "生成 nginx 配置文件\n"
envsubst '${ALLOW_IP}' < /etc/nginx/conf.d/front.template > /etc/nginx/conf.d/front.conf
nginx -s reload 2>/dev/null || nginx -c /etc/nginx/nginx.conf
echo -e "==============================================================\n"

echo -e "======================== 2、启动后端接口 ========================\n"
cd "$backend"
pm2 start sub-store.js -n public --source-map-support --time
echo -e "==============================================================\n"

echo -e "======================== 3、启动 Sub-Store 界面 ========================\n"
if [ ! -f "$web/dist/index.html" ]; then
    echo -e "删除自带后端地址，追加配置环境变量配置的后端地址\n"
    sed -i "/BACKEND_BASE\|DEBUG\|DOMIAN/d" "$web/src/config.js"
    echo "export const BACKEND_BASE = '${DOMAIN}';" >>"$web/src/config.js"
    cd "$web"
    echo -e "执行编译前端静态资源\n"    
    npm run build
    echo -e "结束编译，UI 界面已生成\n"
else
    echo -e "验证结束，UI 界面已生成\n"     
fi
echo -e "==============================================================\n"

pm2 log sub-store
exec "$@"