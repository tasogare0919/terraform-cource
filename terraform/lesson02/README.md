# Lesson02 でやること
## 0. 事前確認
以下のコマンドを実行して、自分の検証アカウントor個人利用アカウントの番号が出るかを確認してください。

```sh
% aws sts get-caller-identity
{
    "UserId": "AIDAJC2MGSO7CUQ3EDVR4",
    "Account": "xxxxxxxxxxxx",
    "Arn": "arn:aws:iam::xxxxxxxxxxxx:user/tada"
}
```

`docker-compose.yml` を以下のように変更してください。

```yaml
version: '3'

services: 
    terraform:
        image: hashicorp/terraform:1.0.0
        container_name: terraform
        volumes:
            - ./terraform/lesson02:/terraform <=マウントポイントをlesson02に変更
        env_file: .env
        working_dir: /terraform
```

## 1. terraform init の実行
まずは、Terraform の初期化(最初だけ)を行います。`main.tf`を開いてもらうと下記の部分が初期化を行うために必要な部分です。

```sh
% make init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0"...
- Installing hashicorp/aws v3.53.0...
- Installed hashicorp/aws v3.53.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

~資料作成中~

今回は以上です。お疲れ様でした。