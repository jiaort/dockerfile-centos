# Docker环境部署说明

### 私有镜像地址列表:
* centos-python: python环境基础包，依赖centos官方镜像centos:7.2.1511
```
centos-python:version
```
* centos-django: django环境基础镜像，依赖centos-python
```
centos-django:version
```
* centos-django-supervisor: 基于supervisor跑celery、python后台脚本等镜像，依赖centos-django
```
centos-django-supervisor:version
```

#### 0. 目的：只需执行一条build命令，即可将系统环境搭建并运行

>* 编写Dockerfile
>* 准备项目相关文件
>* 生成镜像
>* 启动容器
>* 进入容器

#### 1、编写Dockerfile：
>* [Dockerfile文档说明](https://yeasy.gitbooks.io/docker_practice/content/dockerfile/basic_structure.html)

#### 2、准备项目相关文件(根据自己项目增减)
>* git访问相关文件 id_rsa，config
>* uwsgi配置文件 uwsgi.ini
>* 启动脚本文件 run.sh
>* 其他

#### 3、生成镜像([文档说明](https://yeasy.gitbooks.io/docker_practice/content/image/create.html))
**注意：SEP镜像开头都为sep/，如sep/centos-python**

执行命令sudo docker build -t * -f * *
>* -t *为指定镜像标签信息
>* 第二个*指定Dockerfile所在路径
>* 第三个*指定工作域
>* 例：sudo docker build -t pigeon -f ./pigeon/Dockerfile .

#### 4、启动容器([文档说明](https://yeasy.gitbooks.io/docker_practice/content/container/run.html))
每个项目创建etc/docker-compose.yml文件，使用一下命令启动容器
```shell
sudo docker-compose -f etc/docker-compose.yml up -d
```
#### 5、进入容器([文档说明](https://yeasy.gitbooks.io/docker_practice/content/container/enter.html))
```shell
sudo docker exec -it 容器名 bash
```

### CI自动build&&push有变更的Dockerfile
Dockerfile写好之后，CI会自动发现有变更的Dockerfile文件，并buid&&push（mr合并到master，脚本会找到这次合并更改的文件），但是要满足以下条件：
1. 文件名必须是Dockerfile
2. Dockerfile文件里面必须要有以下2行（必须分开写成2行）
    ```
    LABEL name="***"
    LABEL version="****"
    ```
    build的时候name为镜像名，version为镜像tag，最后会push name:version
    所以每次修改Dockerfile一定要修改version，建议使用时间戳
3. 脚本是bin/docker_build.sh 如果有新的编译需求，直接改这个脚本


### 为容器配置直接拉代码权限
1. 添加delploy key：在项目settings--Deploy keys菜单下，点击右边的deploy-key 行的enable按钮，deploy-key出现在左侧 Enabled deploy keys for this project列表内，即添加deploy key完成
2. 映射/home/admin/.ssh目录到镜像的 /root/.ssh目录，并且保证.ssh文件夹权限为700, .ssh下所有文件权限为600。
```
- /home/admin/.ssh:/root/.ssh
```
