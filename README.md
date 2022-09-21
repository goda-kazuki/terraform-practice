# terraform-practice

公式チュートリアル
https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started
VPC+EC2
https://kacfg.com/terraform-vpc-ec2/

### ダウンロード

https://www.terraform.io/downloads

```shell
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### 各種コマンドについて

- terraform init
    - 初期化とプロバイダの情報をダウンロード
- terraform fmt
    - 定義ファイルのフォーマット
- terraform validate
    - 定義ファイルの検証
- terraform apply
    - インフラ作成
- terraform show
    - 今の状態に関連付けられた情報の出力
- terraform destroy
    - インフラ削除
