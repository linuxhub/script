# Docker Swarm 部署 MySQL 主从

## 0.进入脚本目录
```bash
cd script
```

## 1.配置文件
```bash
vim ./conf.sh
```


## 2.初始化
```bash
./init.sh
```

## 3.部署MySQL服务
```bash
./deploy.sh
```

## 4.验证部署
```bash
./show_databases.sh
```

## 4.配置MySQL主从
```bash
./set_repl.sh
```

## 5.验证主从配置
```bash
./status.sh
```

## 6.停止服务
```bash
./stop.sh
```

## 7.删除数据
```bash
./delete_data.sh
```
