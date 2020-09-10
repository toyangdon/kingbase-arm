# kingbase-arm64 用于测试
人大金仓数据库容器镜像构建，arm64环境，版本v8r3
# Build
`git clone https://github.com/toyangdon/kingbase-arm.git`  
`cd kingbase-arm`
`docker build -t kingbase:v8r3 .`
# Deploy
## Docker
`docker run -d –name xxxxx -p 54321:54321 -e SYSTEM_PWD=123456 -v /data/xxx: /home/kingbase/data -v /xxx/license.dat: /home/kingbase/kdb/Server/bin/license.dat dockerhub.ccyunchina.com/toyangdon/kingbase:v8r3`  
*数据目录用户id、组id为1000、1000*  
*license文件可以在人大金仓官网下载*  
*默认用户SYSTEM,通过环境变量SYSTEM_PWD指定初始化数据库时的默认用户密码*  
## Kubernetes
修改./deploy/configmap.yaml，替换里面的license内容  
`kubectl apply -f ./deploy/*.yaml`
## Test
### JDBC
`jdbc:kingbase8://<server>:<port54321>/<database>`
