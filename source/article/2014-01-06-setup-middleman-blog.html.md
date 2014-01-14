---
title: middleman-blogのセットアップ
date: 2014-01-06 08:30 JST
tags: middleman
---

middlemna-blogのセットアップメモ。

### middlemanのインストール

何も難しくはない。

```
gem install middleman
```

### middlemanの初期化
middlemanを使うためのテンプレートファイル(jsとかcssとか)が生成される。
この後blog用にもう一度セットアップコマンド走らせるので、別にやらなくても大丈夫。

```
middleman init [dir]
```

### middleman-blogの初期化
blog特化のテンプレートファイル(calendarとかtagとかfeedとか)が生成される。
config.rbに設定のテンプレートが配備されるので、コメントを眺めながらカスタマイズ。

```
middleman init [dir] --template=blog
```

### middleman-deployの導入
今回はGitHub Pagesのユーザサイトを構築しているので、masterブランチにpushするように設定。

```ruby
activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = 'master' #=> ユーザページなのでmasterにpush
  deploy.build_before = true #=> deploy前にbuild実行
end
```

とりあえず、これでワンコマンド (``bundle exec middleman deploy``)でbuildとdeployが出来るようになったのですごく便利にデプロイテストが出来た。
けれども、この後Travis CIと連携させようと思ったらどうにも上手くpushできなかったので、rakeに置き換えてしまった。


### Travis CIからデプロイを実行する

middleman-deployを使うとdeployは簡単になるけれども、もうちょっと楽をするためにGitHubにpushしたタイミングでTravis CIを使ってデプロイをすることにした。rakeはほとんどパクリな状態だけど、push先がmasterなのでbranchの存在確認とか、masterでCIが走らないように.travis.ymlをコピーしておくあたりの操作を追加した感じでひとまず決着させた。

### はまったこと

[middlemanの公式情報](http://middlemanapp.com/basics/blogging/)を眺めてて、``blog.prefix``という設定を見かけたので、なんとなく使ってみたのだけれどこれが上手く動かず、記事を年月のディレクトリ階層に分かれなかったりしたので、それを諦めたら結構簡単に設定は終わった。

### これから

ひとまずデプロイまでは出来るようになったので満足してしまった感があるけども・・・デザイン決めたりコンテンツ増やしたり、していかないとなぁ


### 参考にした情報
多謝 m(_ _)m

- [ブログをJekyllからmiddlemanに移行してTravis CIでGitHub Pagesにデプロイするようにした](http://webtech-walker.com/archive/2013/08/jekyll_to_middleman.html)

- [middleman-blogをgithubでホストする](http://blog.coiney.com/2013/06/21/host-middleman-blog-on-github/)

