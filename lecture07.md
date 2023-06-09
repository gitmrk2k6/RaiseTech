# 脆弱と対策

- セキュリティー関連のサービスの未使用  
　 → 様々な脆弱性管理サービスや認証許可を容易にするサービスが展開されているので、それらを理解し適正に組み合わせて、リスクを抑えたシステムを作る。  
（例）WAF、Shield、Key Management Service、Secrets Manager、Inspector、GuardDuty、Security Hub 　etc
- AdministratorAccess権限のIAMユーサーを使用している  
　 → 必要な権限のみを与えるようにする。
- 課題を行う上で、不必要なポート番番号を開けたままにしていた  
　 → 不意必要なポートは閉じる。
- SSL証明の未発行  
　 → ACMでALBにアタッチ、HTTPアクセスをHTTPSに転送する設定を追加
- EC2を1つだけで稼働させている。  
　 → 別のサブネットにも設置。

## 感想

どのような攻撃があるのかという知識がまだないところではあるが、様々な危険があることは常に頭に入れて考えておかなければならないことだと感じました。  
また、どんなことをするにしてもセキュリティー対策は全ての地盤であり、木であれば根の部分であると思いました。  
足元がしっかりしている状態を作って初めて様々なサービスや運用が成立するものだと考えました。  
このようなことに関るも人間の知識がしっかりしていないこと自体も、ある意味脆弱性であると思いますのでしっかりと学習していきたい。
