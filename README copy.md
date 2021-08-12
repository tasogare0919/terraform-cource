# terraform-private-course
スナックミーのTerraform講座で使うリポジトリ

# 事前準備
下記の作業は事前に行なってください。

* AWS アカウントの発行
* AWS アクセスキー・シークレットアクセスキーの発行
  * Administrator の権限をつけた IAM ユーザーを作ってください
* Visual Studio Code 
* Visual Sudio Code の [Terrform プラグイン](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

## AWS アクセスキー・シークレットアクセスキーの発行
これはシステムアカウントでは行わないでください。
個人利用で使っているものもしくは検証用のAWSアカウントで行なってください。
管理者ユーザーとしての権限で発行して欲しいので`Administrators`権限をつけてください。
詳しいやり方は下記ドキュメントを参照ください。 

https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/getting-started_create-admin-group.html

## AWS CLI の設定
してなければ設定してください。`Administrator の権限をつけた IAM ユーザー`のものを設定してください。

```sh
$ aws configure
AWS Access Key ID [*********************]: 
AWS Secret Access Key [********************]: 
Default region name [ap-northeast-1]: 
Default output format [json]: 
```

