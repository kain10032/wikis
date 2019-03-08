# 各Wikiの試用docker-compose

## これは何？

以下のWikiをdocker containerとして作成するためのスクリプト集

Wikiをお試しで使用してみるために作成した。

- Pukiwiki 1.5.2
- Mediawiki
- Dokuwiki
- Crowi
- Growi
- Gitlab（Wiki機能がメインではないが…）
- Redmine（Wiki機能がメインではないが…）


## 前提

- Cent OS 7
- dockerがインストールされている。
  - されていない場合は[ここ](https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce)を参考にインストール
- docker-composeがインストールされている。
  - されていない場合は[ここ](https://docs.docker.com/compose/install/)を参考にインストール
- 本リポジトリをgit cloneし、ルートディレクトリにいるものとする。
- インターネットにつながる環境であること
- gitがインストールされていること


## 使い方

### 設定

.envファイルを修正してください。

|name|description|default|
|---|---|---|
|HOST|サーバのアドレス|localhost|
|PUKIWIKI_PORT|Pukiwikiのポート|30010|
|MEDIAWIKI_PORT|Mediawikiのポート|30020|
|DOKUWIKI_PORT|Dokuwikiのポート|30030|
|CROWI_PORT|Crowiのポート|30040|
|GROWI_PORT|Growiのポート|30050|
|GITLAB_PORT|Gitlabのポート|30060|
|GITLAB_SSH_PORT|Gitlabのsshアクセス用ポート。内部利用のみ|30061|
|REDMINE_PORT|Redmineのポート|30070|

以下の手順では上記デフォルト設定として説明するので、違う場合は読み替えること。

### アクセス先

```
http://${HOST}:${*_PORT}
```

### Pukiwiki

1. 以下からpukiwiki-1.5.2_utf8.zipをダウンロードして、pukiwikiディレクトリに置く。

    [PukiWiki/Download/1.5.2 - PukiWiki-official](https://pukiwiki.osdn.jp/?PukiWiki/Download/1.5.2)
    
1. 以下のコマンドでdockerイメージをビルドする

    ```
    docker-compose build pukiwiki
    ```
    
1. 以下のコマンドでdockerコンテナを起動する

    ```
    docker-compose up -d pukiwiki
    ```
    
1. http://localhost:30010 でアクセスできる


### Mediawiki

1. 以下のコマンドでイメージをダウンロードしてきて、dockerコンテナを起動する

    ```
    docker-compose up -d mediawiki
    ```

1. http://localhost:30020 にアクセスすると以下の画面が出てくるので、「set up the wiki」で設定を行う。
    1. 言語を設定する
    2. 環境の確認およびライセンスについての確認。問題なければ続行
    3. データベース設定。MySQLサーバを立ててもいいが、最速で始めるならSQLiteがいい。
    4. アカウント・パスワード等を設定する。
    5. 以降の設定はスキップできるのでお好みで。

1. 設定が終わると「LocalSettings.php」というファイルがダウンロードされる。

1. 下記コマンドでLocalSettings.phpをdockerコンテナ内に移動する

    ```
    docker cp /path/to/LocalSettings.php mediawiki:/var/www/html/
    ```
    
1. 再度 http://localhost:30020 にアクセスするとWikiにアクセスできる。

1. ちなみにdockerイメージに上記設定を反映するには以下コマンドでコミットする

    ```
    docker commit mediawiki mediawiki:latest
    ```

### Dokuwiki

1. 以下のコマンドでイメージをダウンロードしてきて、dockerコンテナを起動する

    ```
    docker-compose up -d dokuwiki
    ```

1. http://localhost:30030 にアクセスするとWikiにアクセスできる。


### Crowi

1. 以下のスクリプトを実行する。

    ```
    sh crowi.sh
    ```
    
1. http://localhost:30040 にアクセスするとWikiにアクセスできる。


### Growi

1. 以下のスクリプトを実行する。

    ```
    sh growi.sh
    ```
    
1. http://localhost:30050 にアクセスするとWikiにアクセスできる。


### Gitlab

1. 以下のコマンドでイメージをダウンロードしてきて、dockerコンテナを起動する

    ```
    docker-compose up -d gitlab
    ```

1. http://localhost:30060 にアクセスするとGitlabにアクセスできる。


### Redmine

1. 以下のコマンドでイメージをダウンロードしてきて、dockerコンテナを起動する

    ```
    docker-compose up -d redmine
    ```

1. http://localhost:30070 にアクセスするとRedmineにアクセスできる。
