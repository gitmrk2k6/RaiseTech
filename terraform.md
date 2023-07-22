# 第１０回の課題をTerraformを用いて環境構築を行う

## 実行した手順は以下の通り（とっておいたメモをそのまま転記）

※ 作成したtfファイル等はterraformフォルダに格納

1. AWS CLIをローカルPCにインストール
2. Terraformのインストール、（brew install tfenv  tfenv use latest)  
3. Terraformに使用するIAMユーザーを作成し、アクセスキーなどを確認。
4. aws configureコマンドでIAMユーザーの認証情報を登録

（これがデフォルトになる。他のIAMユーザーで実行する場合はプロファイルを複数登録し、コマンドの後ろに   — profile ~で指定する。）

（例）aws configure --profile terraform
　　　→ Terraformという名前のプロファイルを登録。この後に認証情報が会話形式で聞かれる。

5. tfstateファイルを配置するS3バケット作成
6. tfファイルの作成

　　main.tf（全体的な設定をする）　vpc.tf（VPCを作成するコード記述）

　　記述された内容を見るのでファイルの名前何でも良い。
   main.tfにterraform.tfstateをS3バケットに保存するようにする（バックエンド）

　　複数人でterraformを共有するときに自分のローカルにだけこのファイルがあると

　　他の人との差分が出て困るので。

7. terraform initコマンドの実行（初回必ず実行。main.tfのディレクトリーで）
8. ls -laでファイル確認すると、.terraformと.terrafom.lock.hclファイルが作成されている。
9. terrafom planコマンドでどのようなインフラ環境が構築されるのか確認する。
10. terraform applyコマンドでデプロイ（vpc_idを指定していると自動的にIGWをアタッチしてくれるため重複のエラーがでた。アタッチのコードを削除した）
11. コマンド実行後、terraform.tfstateファイルが作成される。

　　このファイルは現在のリソース構成情報が入っている。

　　Terraformはこのファイルの中身が実際の環境の前提で動く。

　　なお、.terraform内に同じ名前のファイルがあるがこれはローカルでの変更のみなので基本的

　　には参照することはない。githubにあげないように設定。

　　（terrafom.lock.hclはあげたほうが良いらしい）

12. 同様にEC2.tf、RDS.tfなど必要なtfファイルを作成していき、同様にapply。コンソール上で実際に作成できているかどうかを確認していった。
13. RDS作成時のパスワード等の機密情報について

variable.tfに仮のパスワードを環境変数として設定する。terraform.tfvarsに本当のパスワードを設定。（そうするとtfvarsの値が上書きする）terraform.tfvarsは.gitignoreへ。

tfstateファイルを保存しているS3のパブリックアクセスは禁じておく

14. terraform destroyで全てを削除。

## 感想

課題提出ではなかったが、Terraformにも触れておきたかったため第10回課題を利用して実際に環境構築を行なった。CloudFormationとは少し考え方が違う部分もあった。どちらが良いとかは感じなかったが、CloudFormationのテンプレートを作成した後だったのでコード化のイメージもあり、先を見据えながら学習を進めることができた。
