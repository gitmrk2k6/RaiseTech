# 第5回課題提出

## EC2上にサンプルアプリケーションをデプロイして作動させる

- 組み込みサーバーだけでデプロイ

![kumikomi](./images/ec2-rds.png)

- nginxとunicornに分けてデプロイ

![nginxunicorn](./images/nginx-unicorn.png)

## ELBを追加してデプロイ

![elb](./images/elb.png)

## Databaseで確認

![database](./images/database-5.png)

## S3の追加

- EC2に直接マウントして、S3と連携したEC2上からファイルを消したり、追加したりした際に、バケットに反映されているか確認した。
- active storageに使用する方法も現在挑戦中。
![ec2-s3](./images/ec2-s3.png)

## 今回構築した環境を構成図に書き起こす

![kouseizu](./images/kouseizu-3.png)
