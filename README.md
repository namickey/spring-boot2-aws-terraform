# spring-boot2-aws-terraform

GitHubからAWSへの自動デプロイに挑戦

## やりたいこと
* EC2インスタンスのみで動作するWEBアプリケーションをAWSへデプロイしたい
* AWSへのデプロイを自動化したい
* AWSのネットワーク構築を自動化したい
* アプリケーションのビルド～デプロイ～起動まで自動化したい

## AWS構成
![AWS構成](aws.png)

## 準備

1. GitHub
	1. アカウント登録（無料プラン有り）
	1. リポジトリ作成（WEBアプリケーションを格納するリポジトリ。tfファイルと同じリポジトリでもOK）
	1. リポジトリ作成（Terraform用のtfファイルを格納するリポジトリ）
1. AWS
	1. アカウント登録（1年間の無料枠付き有り。クレジットカード必要）
	1. terraform向け準備としてIAMにて、ユーザ及びアクセスキーの作成を行う
	1. 事前にEC2インスタンス用SSHキーペア（pemファイル）を作成し、端末にダウンロードし保管する
1. Terraform Cloud
	1. アカウント登録（無料プラン有り）
	1. Workspace作成
	1. GitHubリポジトリ登録（tfファイルを格納するリポジトリ）
	1. AWSアクセスキー登録


## WEBアプリケーション作成
今回はEC2インスタンスのみで単独起動できるWEBアプリケーションを作成し、GitHubリポジトリへ格納する  
今回は以下のspring-bootアプリケーションを使用  
https://github.com/namickey/spring-boot2-train  


## tfファイル作成
VPC+EC2作成用tfファイル作成、GitHubリポジトリに格納する  
今回は本リポジトリに格納しているtfファイルとセットアップ用シェルファイルを使用する  
* `main.tf`  
* `setup.sh`  

## TerraformCloudからデプロイ
VPC作成+EC2作成+アプリケーションのビルド～デプロイ～起動まで自動化

1. plan
1. apply
1. 作成されたEC2インスタンスの公開用IPアドレスを確認
1. 念のため、AWSコンソールにて結果確認
1. ブラウザ動作確認
1. SSH接続確認
1. destroy
1. 念のため、AWSコンソールにて結果確認

## 参考サイト：Terraform

Terraform Cloudの始め方  
https://qiita.com/boccham/items/190f04bfbc9ffc0b5baf  

Terraformで構築するAWS  
https://y-ohgi.com/introduction-terraform/handson/vpc/  

terraform構築手順〜EC2編〜  
https://colabmix.co.jp/tech-blog/terraform-ec2/  

TerraformでEC2インスタンスを構築してみた。（Terraform, AWS, EC2）  
https://qiita.com/takahashi-kazuki/items/c2fe3d70e3a9490adf64  


## 参考サイト：AWSを手動で構築する場合

【AWS①】ネットワークを構築してみる  
https://zenn.dev/oreo2990/articles/bf3112bb6ccb48  

【AWS】EC2インスタンスの作成方法解説！サーバーを作成して接続してみる  
https://engineer-ninaritai.com/aws-ec2-make/  
