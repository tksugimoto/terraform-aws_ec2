# terraform-aws_ec2
TerraformでAmazon EC2インスタンスを作成


## 機能
- VPC, セキュリティグループなどまとめてEC2インスタンス作成
- ssh port番号の変更
- ssh公開鍵ハッシュをEC2インスタンスのタグに自動設定
    - `terraform output` で表示
        - EC2インスタンス作成直後の場合、表示されない場合がある
            - タグ設定に時間がかかるため
            - 表示されない場合は、 `terraform refresh` で更新


## 使い方

1. 事前準備
    1. [Terraform](https://www.terraform.io/ "https://www.terraform.io/") をインストール
    1. 設定用ファイル (`terraform.tfvars`) を作成
        1. [terraform.tfvars.example](./terraform.tfvars.example) ファイルを `terraform.tfvars` という名前でコピー
            ```
            cp terraform.tfvars.example terraform.tfvars
            ```
        1. `terraform.tfvars` に設定を書き込む
            - `aws_access_key`
            - `aws_secret_key`
            - `ssh_secret_key_path`
            - `ssh_public_key_path`
            - など
1. デプロイ
    ```
    terraform apply
    ```
