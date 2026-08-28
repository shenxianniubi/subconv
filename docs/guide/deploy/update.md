# How to Update

## If deployed on Vercel
When your forked repository is out of date, you can sync it with the original repository according to the picture below:  
![image](/assets/deploy/update.png)  
After that, Vercel will redeploy automatically.

## If you also host the documentation site
The documentation site is built from the `docs/` directory and deployed separately through GitHub Pages. After you push changes under `docs/**` to the default branch, the docs deployment workflow will publish the updated site automatically.

## If deployed with Docker
1. Assuming the directory on your server is `~/subconv`. Enter the directory.
2. Stop the service with `docker compose down`.
3. Pull the latest image with `docker compose pull`.
4. Check the Release page to see if there are any runtime or template settings that need to be updated. If not, skip steps 5-6.
5. Backup `config.yaml` and the `template/` directory, then compare them with `config.yaml.example` and the latest `template/` directory from this repository.
6. Merge any changes you need into your local `config.yaml`, `template/zju.yaml`, or `template/general.yaml` files.
7. Start the service with `docker compose up -d`.

## If deployed on your VPS (binary file)
1. Stop the subconv process.
2. Download the latest binary file from [Releases](https://github.com/SubConv/SubConv/releases). Delete the original `api` file and the old `mainpage/dist` directory, then extract the new files into place. Grant the `api` file executable permission.
3. Check the Release page to see if there are any runtime or template settings that need to be updated. If not, skip steps 4-6.
4. Backup `config.yaml` and the `template/` directory, then compare them with `config.yaml.example` and the latest `template/` directory from this repository.
5. Keep the refreshed `config.yaml` and `template/` directory next to `api`.
6. Merge any local changes into `config.yaml`, `template/zju.yaml`, or `template/general.yaml` as needed.
7. Run the program again.
