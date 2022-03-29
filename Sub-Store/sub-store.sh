#!/bin/sh

gitPath="/git"
rootPath="/Sub-Store"
backend="$rootPath/backend"
web="$rootPath/web"
nginx="$rootPath/nginx"

echo -e "======================== 1、初始化配置 ========================\n"
echo -e "开始初始化 UI 界面\n"
cp -r /git/web /Sub-Store/
cd "$web"
cnpm install

echo -e "开始初始化接口\n"
cp -r /git/backend /Sub-Store/
cd "$backend" 
cnpm install 


echo -e "======================== 2、验证 UI 界面 ========================\n"
if [ ! -f "$web/dist/index.html" ]; then
    echo -e "删除自带后端地址，追加配置环境变量配置的后端地址\n"
    sed -i "/BACKEND_BASE\|DEBUG\|DOMIAN/d" "$web/src/config.js"
    echo "export const BACKEND_BASE = '${DOMAIN}';" >>"$web/src/config.js"
    cd "$web"
    echo -e "执行编译前端静态资源\n"    
    npm run build
    echo -e "结束编译\n"
else
    echo -e "验证结束\n"     
fi

echo -e "======================== 3、启动 UI 界面 ========================\n"
cp -rf  "$web/dist" /var/www/sub-store
mkdir -p /etc/nginx/conf.d
cp -r /Sub-Store/nginx/front.conf /etc/nginx/conf.d
nginx -c /etc/nginx/nginx.conf 
nginx -s reload

echo -e "======================== 4、启动后端接口 ========================\n"
cd "$backend"
pm2 start sub-store.js
pm2 log sub-store