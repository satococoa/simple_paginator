# SimplePaginator

API を作るときなどに使えるページネーション用のライブラリです。

## 特徴
- count 文を発行しません。
- 最大ページ数が設定できます。
- 1 ページあたりのレコード数を設定できます。

## インストール方法

Gemfile に以下のように記述してください。

    gem 'simple_paginator'

そして、以下を実行します。

    $ bundle

## 使い方

モデルに以下のように SimplePaginator を include してください。

```
class Post < ActiveRecord::Base
  include SimplePaginator
end
```

`Post.paged(page)` メソッドでページ分けされたレコードを取得します。

デフォルトでは 1 ページあたり 25 件ずつ、最大 10 ページまで取得できるようになっています。また、次のページにレコードがある場合は規定より 1 件多くレコードが返ります。

```
Post.paged(1) #=> 最大 26 件のオブジェクトが返ります。
Post.paged(11) #=> 最大ページ以降は常に 0 件のレコードが返ります。
```

1 ページあたりのレコード数や最大ページ数を変えたい場合は `per_page`, `max_page` メソッドを使います。

```
class Post < ActiveRecord::Base
  include SimplePaginator
  per_page 10
  max_page 5
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
