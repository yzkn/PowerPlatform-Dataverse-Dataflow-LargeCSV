# PowerPlatform-Dataverse-Dataflow-LargeCSV

巨大CSVファイルのインポート速度計測

---

## Dataset

| 名称                     | 版                     | サイズ* |            バイト数* | 件数（公開元で公表） |     行数** | 1行当たりバイト数 | レコード数 | スキップ行*** | 列数 | URL                                                            | ファイル名                  |
| ------------------------ | ---------------------- | ------: | -------------------: | -------------------- | ---------: | ----------------: | ---------: | ------------: | ---: | -------------------------------------------------------------- | --------------------------- |
| ニコニコ大百科IME辞書    | 2024年08月21日 03:54版 | 12.1 MB |    12,704,748 バイト | 登録単語数261890     |    261,897 |              48.5 |    261,890 |             7 |      | http://tkido.com/nicoime/nicoime.zip                           | nicoime_msime.txt           |
| 郵便番号データ           | 2024年7月31日          | 17.4 MB |    18,337,437 バイト | -                    |    124,386 |             147.4 |    124,386 |             0 |      | https://www.post.japanpost.jp/zipcode/download.html            | utf_ken_all.csv             |
| 住所.jp                  | 2024-08-09             | 20.6 MB |    21,679,092 バイト | 約１２万５千件       |    150,137 |             144.4 |    150,136 |             1 |      | http://jusyo.jp/csv/new.php                                    | zenkoku.csv                 |
| 法人番号（東京都）       | 令和6年8月31日         |  271 MB |   232,908,335 バイト | -                    |  1,271,414 |             183.2 |  1,271,414 |             0 |      | https://www.houjin-bangou.nta.go.jp/download/zenken/index.html | 13_tokyo_all_20240830.csv   |
| 法人番号（全国）         | 令和6年7月31日         | 1.09 GB | 1,178,336,346 バイト | -                    |  5,507,150 |             214.0 |  5,507,150 |             0 |      | https://www.houjin-bangou.nta.go.jp/download/zenken/index.html | 00_zenkoku_all_20240731.csv |
| 位置参照情報　街区レベル | 令和5年 22.0a          | 1.96 GB | 2,110,905,438 バイト | -                    | 19,576,028 |             107.9 | 19,576,027 |             1 |      | https://nlftp.mlit.go.jp/cgi-bin/isj/dls/_choose_method.cgi    | -                           |



- `*` ... エクスプローラーでの表示（ヘッダー行などのデータ行以外を含む）
- `**` ... FINDコマンドでの計測（ヘッダー行などのデータ行以外を含む） `find /v /c "" .\*.csv`
- `***` ... `Get-Content .\*.csv -TotalCount 10`

## 制限事項・注意事項

### Power Apps ライセンスの制限事項

> Power Apps ライセンスを使用してデータフローを作成する場合、作成できるデータフローとテーブルの数に制限はありません。 ただし、使用してパフォーマンスを更新できる Dataverse サービスのサイズには制限があります。
>
> Power Apps のアプリごとのプランは、最大 50 MB のデータベース容量に対応しています。 Power Apps のユーザーごとのプランを使用すると、250 MB の容量のデータベースを使用できます。
>
> Power Apps には次の制限があります。
>
> - データフローの更新は最大 24 時間実行できます。
> - データフローは、24 時間あたり最大 48 回 (30 分に 1 回) 更新できます。
> - 各クエリ/パーティションの最大実行時間は 4 時間です。
> - 更新ごとに、同時に更新できるクエリ/パーティションは 4 つまでという同時実行制限があります。
> - Power Query Online の更新制限はユーザーごとに適用されます。 詳細: [リフレッシュ制限](https://learn.microsoft.com/ja-jp/power-query/power-query-online-limits#refresh-limits)

- [データフローを使用するために必要なライセンス 各ライセンスの制限事項](https://learn.microsoft.com/ja-jp/power-query/dataflows/what-licenses-do-you-need-in-order-to-use-dataflows#power-apps-licenses)

### データフローの挙動

- 新規テーブルにインポートする設定、かつ、データファイルに空行が含まれている場合、空行もレコードとして追加される。
  - データファイルの最終行が空行になっていないか確認する `tail -n 2 ***.csv`
  - Power Queryで空行を削除する
  - 既存テーブルにインポートする場合は、予めいずれかの列に必須設定を行う

- データフローの発行中に、データ型／範囲の不一致などのエラーが大量に発生しすぎるとデータフローの実行が途中で中断される。

> upsert に失敗した行が多すぎるため、データフローの更新が取り消されました。エラーを確認し、データフローを編集して問題を解決してから、もう一度お試しください。

## ファイルサイズの上限

| 種別         | 上限サイズ |
| ------------ | ---------: |
| テキスト/CSV |    1,024MB |

## 環境の種類

| 種類                          | データフロー |
| ----------------------------- | :----------: |
| 既定                          |      ×       |
| 実稼働                        |      ○       |
| サンドボックス                |      ○       |
| 試用版                        |     低速     |
| 開発者                        |     低速     |
| Microsoft Dataverse for Teams |      -       |

- [Power Platform 環境の種類](https://learn.microsoft.com/ja-jp/power-platform/admin/environments-overview#power-platform-environment-types)

## 計測結果

「ファイルのアップロード」（データフローのウィザード内での OneDrive for Business へのアップロード）に掛かる時間は除く。

上り方向の回線速度に依存するが、アプリを利用する場合は、自動または 50 KB/s ～ 100 MB/s に設定可能。

- [OneDrive 同期アプリのアップロードまたはダウンロードの速度を変更する](https://support.microsoft.com/ja-jp/office/onedrive-%E5%90%8C%E6%9C%9F%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%83%AD%E3%83%BC%E3%83%89%E3%81%BE%E3%81%9F%E3%81%AF%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%AE%E9%80%9F%E5%BA%A6%E3%82%92%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B-71cc69da-2371-4981-8cc8-b4558bdda56e)

XRMToolBox の Bulk Data Updater による削除の場合、事前の Fetch が約 5 msec / record 、削除が約 70 msec / record （以下の表には後者のみ記載）。事前の Fetch では、 FetchXML に含める列の数を制限すると速度向上する。

### 試用環境（開発者環境）

| 名称                  | 追加 計測結果 | 削除（レコードの一括削除） 計測結果 |
| --------------------- | ------------: | ----------------------------------: |
| ニコニコ大百科IME辞書 |      04:18:02 |                          約00:50:00 |
| 住所.jp               |      03:07:42 |                          約00:35:00 |

### 運用環境（サンドボックス環境）

#### 1回目

| 名称                        |             追加（データフロー） 計測結果 | 削除（レコードの一括削除） 計測結果 |
| --------------------------- | ----------------------------------------: | ----------------------------------: |
| ニコニコ大百科IME辞書       |                                  00:16:12 |                          約00:50:00 |
| 郵便番号データ              |                                  00:10:43 |                          約00:20:00 |
| 住所.jp                     |                                  00:10:11 |                          約00:25:00 |
| 法人番号（東京都）          |                                  01:20:10 |                          約03:00:00 |
| 法人番号（全国） *          |            05:04:43 + 04:33:04 = 09:37:47 |                          約15:20:00 |
| 位置参照情報　街区レベル ** | 17:19:21 + 17:18:52 + 15:28:01 = 50:06:14 |  約128:35:00 <br> （5日 + 8.6時間） |

- `*` ... 3,000,000行ごとにファイルを分割して入力
- `**` ... 7,000,000行ごとにファイルを分割して入力

#### 2回目

| 名称                     |           追加（データフロー） 計測結果 | 削除（ Bulk Data Updater ） 計測結果 | 備考                                                  |
| ------------------------ | --------------------------------------: | -----------------------------------: | ----------------------------------------------------- |
| ニコニコ大百科IME辞書    |                                00:15:54 |                            約4:40:00 |                                                       |
| 郵便番号データ           |                                00:15:28 |                            約2:10:00 |                                                       |
| 住所.jp                  |                                00:14:56 |                            約2:50:00 |                                                       |
| 法人番号（東京都）       |                                01:09:16 |                           約22:24:00 |                                                       |
| 法人番号（全国）         |          05:08:23 + 04:39:33 = 09:47:56 |                                    - | 削除: タイムアウト                                    |
| 位置参照情報　街区レベル | （失敗） 24:00:01 + 24:00:01 + 24:00:01 |                                    - | 追加: タイムアウト: 5637068件 + 5616288件 + 5616288件 |

#### 3回目

| 名称                  |  追加（データフロー） 計測結果 |
| --------------------- | -----------------------------: |
| ニコニコ大百科IME辞書 |                       00:20:39 |
| 郵便番号データ        |                       00:12:21 |
| 住所.jp               |                       00:07:41 |
| 法人番号（東京都）    |                       01:06:48 |
| 法人番号（全国）      | 02:42:13 + 02:14:08 = 04:56:21 |

## リンク

### レコードの一括追加

[データフロー](https://make.powerapps.com/environments/{GUID}/dataintegration/list)から追加する。

### レコードの一括削除

[Power Platform管理センター > （対象の）環境 > 設定 > データ管理 > 一括削除](https://org********.crm5.dynamics.com/tools/bulkdelete/home_bulkDeletionJobs.aspx)から一括削除ウィザードを実行する。

---

Copyright (c) 2024 YA-androidapp(https://github.com/yzkn) All rights reserved.
