# PowerPlatform-Dataverse-Dataflow-LargeCSV

巨大CSVファイルのインポート速度計測

---

# Dataset

| 名称                     | 版                     | サイズ* | バイト数*            | 件数（公開元で公表） | 行数** | レコード数 | URL                                                            | ファイル名                  |
| ------------------------ | ---------------------- | ------- | -------------------- | -------------------- | ------ | ---------- | -------------------------------------------------------------- | --------------------------- |
| ニコニコ大百科IME辞書    | 2024年08月21日 03:54版 | 12.1 MB | 12,704,748 バイト    | 登録単語数261890     |        |            | http://tkido.com/nicoime/nicoime.zip                           | nicoime_msime.txt           |
| 住所.jp                  | 2024-08-09             | 20.6 MB | 21,679,092 バイト    | 約１２万５千件       |        |            | http://jusyo.jp/csv/new.php                                    | zenkoku.csv                 |
| 郵便番号データ           | 2024年7月31日          | 17.4 MB | 18,337,437 バイト    |                      |        |            | https://www.post.japanpost.jp/zipcode/download.html            | utf_ken_all.csv             |
| 位置参照情報　街区レベル | 令和5年 22.0a          | 1.96 GB | 2,110,905,438 バイト |                      |        |            | https://nlftp.mlit.go.jp/cgi-bin/isj/dls/_choose_method.cgi    | -                           |
| 法人番号                 | 令和6年7月31日         | 1.09 GB | 1,178,336,346 バイト |                      |        |            | https://www.houjin-bangou.nta.go.jp/download/zenken/index.html | 00_zenkoku_all_20240731.csv |

* ... エクスプローラーでの表示（ヘッダー行などのデータ行以外を含む）
* ... FINDコマンドでの計測（ヘッダー行などのデータ行以外を含む）

---

Copyright (c) 2024 YA-androidapp(https://github.com/yzkn) All rights reserved.
