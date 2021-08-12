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

## 2. terraform plan の実行
次にdry-run的な`terraform plan`を実行してきます。役割はTerraformのコードを書いた後の期待通りの動作をするかを確認します。基本的には`terraform plan`が通れば適用のための`terraform apply`も成功します。ただ、必ずしも通るわけではないのでその辺は注意してください。
ただが遭遇した失敗例

* S3 を削除しようとしたが S3 にオブジェクトがあるから削除できない(AWSの仕様)
* 作成しようとするとリソースのtfファイルは問題ないが他の設定(ELBのログをS3に出力させる時のバケットポリシーがないとか)が起因して失敗する

今回の定義は`main.tf`の下記の部分です。これだけでEC2が作れます。

```terraform
resource "aws_instance" "tf_test_server" {
  ami           = "ami-09ebacdc178ae23b7"
  instance_type = "t3.micro"

  tags = {
    Name = "tf-test"
  }
}
```

`terraform plan`は`make plan` を実行します。実行の結果が、`Plan: 1 to add, 0 to change, 0 to destroy.`という形で意図したリソースが作成・変更・削除されるかを確認できればOKです。今回はEC2一台が追加されるので`1 to add`になればOK。

```sh
% make plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.tf_test_server will be created
  + resource "aws_instance" "tf_test_server" {
      + ami                                  = "ami-09ebacdc178ae23b7"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "tf-test"
        }
      + tags_all                             = {
          + "Name" = "tf-test"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run
"terraform apply" now.
```

## 3. terraform apply の実行
`terraform plan`で問題なければAWSにtfファイルのコードを適用していきます。
適用には`terraform apply`を使います。`make apply`を実行してください。

```sh
% make apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create
~中略~

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
aws_instance.tf_test_server: Creating...
aws_instance.tf_test_server: Still creating... [10s elapsed]
aws_instance.tf_test_server: Creation complete after 13s [id=i-0f89b3ad4d11af8b2]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## 4. terraform destroy の実行
最後に、作ったリソースを消します。AWSは使った分だけの課金であるため不要になった削除は消さないとどんどんお金が嵩みますので削除します。
削除には`terraform destory`を使います。`make destroy`を実行して`Destroy complete! Resources: 1 destroyed.`と出て正常に終了すれば完了です。

```sh
% make destroy 
aws_instance.tf_test_server: Refreshing state... [id=i-0f89b3ad4d11af8b2]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  - destroy

Terraform will perform the following actions:
~中略~
Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
yes

aws_instance.tf_test_server: Destroying... [id=i-0f89b3ad4d11af8b2]
aws_instance.tf_test_server: Still destroying... [id=i-0f89b3ad4d11af8b2, 10s elapsed]
aws_instance.tf_test_server: Still destroying... [id=i-0f89b3ad4d11af8b2, 20s elapsed]
aws_instance.tf_test_server: Still destroying... [id=i-0f89b3ad4d11af8b2, 29s elapsed]
aws_instance.tf_test_server: Destruction complete after 30s

Destroy complete! Resources: 1 destroyed.
```

今回は以上です。お疲れ様でした。