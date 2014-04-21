# haruna.rb
榛名の時間

## これなに
榛名が大丈夫かどうか診断します。

### くわしく
診断メーカーの番号と、診断に使う名前と、診断する時刻を設定しておくと、自動的にそのタイミングで診断してpost するプラグインです。

## Install

``` sh
$ mkdir -p ~/.mikutter/plugin/; git clone https://github.com/nna774/mikutter_haruna.git ~/.mikutter/plugin/haruna/
``` 

bundle を使ってmikutter を使ってるなら
``` sh
$ bundle
```

そうでないなら
``` sh
 $ gem install nokogiri
```

## 使いかた
設定の「榛名の時間」から有効にチェックを入れて、適当に診断番号と名前、発火時間を入れてください。

設定した発火時間になると、自動的に診断してpost してくれます。
