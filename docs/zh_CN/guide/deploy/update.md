# 如何更新

## 如果部署在 Vercel 上
当你的 forked 仓库不是最新时，你可以按照下面的图片来将其与原始仓库同步：
![image](/assets/deploy/update.png)  
之后，Vercel 将自动重新部署。

## 如果你也部署了文档站点
文档站点来自仓库里的 `docs/` 目录，并通过 GitHub Pages 独立部署。只要你把 `docs/**` 下的变更推送到默认分支，文档部署工作流就会自动发布最新站点。

## 如果使用 Docker 部署
1. 假设你的服务器上的目录是 `~/subconv`。进入该目录。
2. 使用 `docker compose down` 停止服务。
3. 使用 `docker compose pull` 来拉取最新的镜像。
4. 查看 Release 页面，看看有没有需要更新的运行时配置或模板项。若无，跳过 5~6 步。
5. 备份 `config.yaml` 和 `template/` 目录，然后分别与 `config.yaml.example` 和本仓库最新的 `template/` 目录进行对比。
6. 将你需要保留的改动合并回本地的 `config.yaml`、`template/zju.yaml` 或 `template/general.yaml`。
7. 使用 `docker compose up -d` 来启动服务。

## 如果部署在你的 VPS 上（二进制文件）
1. 停止 subconv 的进程。
2. 从 [Releases](https://github.com/SubConv/SubConv/releases) 下载最新的二进制文件。删除原来的 `api` 文件和旧的 `mainpage/dist` 目录，然后把新的文件解压进去。授予 `api` 文件可执行权限。
3. 查看 Release 页面，看看有没有需要更新的运行时配置或模板项。若无，跳过 4~6 步。
4. 备份 `config.yaml` 和 `template/` 目录，然后分别与 `config.yaml.example` 和本仓库最新的 `template/` 目录进行对比。
5. 确保更新后的 `config.yaml` 和 `template/` 目录与 `api` 放在一起。
6. 按需把本地改动合并回 `config.yaml`、`template/zju.yaml` 或 `template/general.yaml`。
7. 重新运行程序。
