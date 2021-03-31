# 工作站

## 构建镜像

```
docker build . -f php/7.2/alpine/Dockerfile -t workspace --build-arg username=leo --build-arg useremail=docker@qq.com
```

phpx
```
docker build . -f php/7.2/alpine/phpx.Dockerfile -t workspace --build-arg username=leo --build-arg useremail=docker@qq.com
```

## 启动镜像

```
docker run -it -p 9501:9501 -v $PWD/.ssh:/root/.ssh -v $PWD/workspace:/root/workspace workspace
```

## 创建私钥

> 如果没有密钥，则创建一个，不要忘了将公钥放到你的托管平台上

```
ssh-keygen -t rsa -C "docker@qq.com"
```

