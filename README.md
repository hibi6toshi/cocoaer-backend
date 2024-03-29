# cocoaer

こちらはバックエンドのリポジトリです。

## 主な使用技術
### バックエンド
- Ruby on Rails(APIモード)
- MySQL
- Rspec

#### 主要ライブラリ(gem)
- carrierwave
- mini_magick
- kaminari
- ransack
- jwt
- fog-aws

carrierwaveおよびfog-awsを使いS3に画像を保存しています。

ページングにkaminariを使用しています。

検索機能にransackを使用しています。

### フロントエンド
- React
- TypeScript
- Tailwind
- Jest
- React Testing Library 

### 認証
- Auth0

### インフラ
- フロントエンド：S3 + CloudFront
- バックエンド: ECR + ECS + AWS Fragate
- 画像ストレージ: S3

## サービス概要

孝行をもっと身近に、手軽に。  
孝行に特化したCGMです。

## ユーザーが抱える課題

- 孝行をしたいがきっかけがない。
- 孝行をしたいが何をすればいいかわからない。

## 課題に対する仮説

- 孝行をしたいがきっかけがない。
  - 孝行することに対して費やすコスト（金銭・時間）がない・想像がつかない
  - 改めて孝行することの照れ臭さ
- 孝行をしたいが何をすればいいかわからない。
  - 孝行の具体的なやり方・事例を知らない。

## 解決方法

- アプリを利用してもらい、「アプリに投稿するから」という口実（きっかけ）を提供する。
- 行った孝行を投稿してもらうことで、孝行についてのデータベースとなる。
  - かかったコストも書いてもらうことで、目安にできる（記載は任意）
- フォーラム機能でトピックを立てて質問することができる。 
   - 孝行を受ける側からの意見も聞くことができるかも。

## メインのターゲットユーザー

20~40代
自分のライフステージの変化、親の定年・還暦・銀婚式といったイベントのタイミングで孝行したいと思っている人

## 実装予定の機能

- 非ログイン時

   - 投稿された孝行について、一覧/詳細を見ることができる。
     - コメントを見ることができる。
     
   - フォーラムについて、一覧を見ることができる。
   - プロジェクトについて、一覧を見ることができる。
   - パスワードリセット機能
   
- ログインユーザー  

  - <孝行>
    - 投稿された孝行について、一覧/詳細を見ることができる。
      - コメントについて閲覧/投稿できる
      - ブックマークすることができる
      
    - 投稿された孝行について、検索することができる。
        
    - 孝行を新規投稿/編集することができる  
  - <フォーラム>  
    - フォーラムについて、 一覧/詳細を見ることができる。
      - コメントについて閲覧/投稿できる
      - ブックマークすることができる
      
    - フォーラムについて、検索できる 

    - フォーラムを作成することができる
  
  - <プロジェクト機能> :孝行をプロジェクトライクで進めるための機能。- カテゴリ、期間や予算を設定して使う日記的なもの。
    - カテゴリ、期間や予算を設定する。
    - 行動を記録できる。  
    - カテゴリ（旅行・贈り物・etc...）や期間、予算で検索できる。

## なぜこのサービスを作りたいのか？

いざ親孝行しようとした際に、何をすればいいのかわからなかった経験がある。
調べてもランキングや広告のサイトが多く、具体的にどういうものが良いのわからなかった。
その時にさまざまな選択肢があればと感じ、孝行を投稿するSNSがあればいいと思ったから。

■　画面遷移図
https://www.figma.com/file/fsUtM0ocbfR2CHklVjkkZC/Untitled?node-id=0%3A1&t=rIkv44a6duu7mhQc-1

■　ER図：上段はマスタ系、それ以外はトランザクション系です。
![ER図](./er.drawio.png)
[Users]ユーザ情報マスタ
  - name: ユーザの名前
  - sub: auth0から払い出されるuserIdを格納する
  - avatar: アバター画像
  - introduction: 自己紹介
  
[Piety_Targets]ターゲット情報マスタ(例: 父・母・兄弟,etc...)
  - name: ターゲット情報

[Piety_Categorys]カテゴリマスタ(例： 食事・贈り物・旅行, etc...)
  - name: カテゴリ情報

[Articles]孝行の記録情報
  - user_id: 投稿者のユーザーID
  - target_id: ターゲット情報のID
  - category_id: カテゴリ情報のID
  - days: 孝行の実施日数
  - cost: 費用
  - title: タイトル
  - body: 詳細
  - picture: 画像用

[Forums]フォーラム機能
  - user_id: 投稿者のユーザID
  - target_id: ターゲット情報のID
  - category_id: カテゴリ情報のID
  - days: 孝行の実施日数
  - cost: 予算
  - title: タイトル
  - body: 詳細

[Projects]プロジェクト機能
  - user_id: 投稿者のユーザID
  - target_id: ターゲット情報のID
  - category_id: カテゴリ情報のID
  - limit_date: 締切日
  - cost: 予算
  - title: タイトル
  - body: 詳細

[Comments]Article/Forumに対するコメント
  - commentable_type: Article or Forum
  - commentable_id: Article or ForumのID
  - user_id: コメントをしたユーザのID
  - body: コメント内容

[Favorites]Article/Forum/Projectに対するお気に入り
  - favoritable_type: Article or Forum or Project
  - favoritable_id: Article or Forum or ProjectのID
  - user_id: お気に入りをしたユーザのID

[Tasks]プロジェクトのタスク
  - user_id: タスクを作成したユーザのID
  - project_id: タスク対象のプロジェクトID
  - value: タスク内容

[Actions]プロジェクトでの行動記録
  - user_id: アクションを作成したユーザのID
  - project_id: アクション対象のプロジェクトID
  - value: アクション内容

■　インフラ構成図：ECR + ECSは省略。

![インフラ構成図](./infra.drawio.png)
