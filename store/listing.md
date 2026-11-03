# Chrome ウェブストア 掲載情報（v1.0.0）

デベロッパーダッシュボードの各欄にそのまま貼り付けられる形でまとめています。

---

## ストアの掲載情報タブ

### 名前（manifest の `name` から自動取得・最大 75 文字）
Show Password on Hover

### 概要（manifest の `description` から自動取得・最大 132 文字）
パスワード欄にマウスオーバーすると中身を表示します。

### 説明（日本語）
```
パスワード欄にマウスを乗せるだけで、入力中のパスワードをその場で確認できます。

「打ち間違えていないかな？」というときに、目のアイコンを探したり、全部消して打ち直したりする必要はもうありません。

■ 使い方
・パスワード欄にカーソルを合わせる → 文字が表示されます
・カーソルを外す → 自動で伏せ字（●●●）に戻ります
ボタン操作や設定は一切不要です。インストールした直後から、すべてのサイトで動作します。

■ 安心の設計
・追加の権限を要求しません（タブ、履歴、ストレージなどへのアクセスなし）
・外部への通信を一切行いません
・入力内容を記録・保存しません
・コードは 20 行ほどのシンプルなものです

■ ご注意
カーソルを乗せている間はパスワードが画面に表示されます。人前や画面共有中はご注意ください。
```

### 説明（English）
```
See your password just by hovering over the password field.

No more hunting for the eye icon or retyping everything when you're not sure you typed it right.

HOW IT WORKS
- Hover over a password field: the characters are shown
- Move the mouse away: it goes back to hidden (●●●) automatically
No buttons and no settings. It works on every site as soon as it's installed.

PRIVACY BY DESIGN
- Asks for no extra permissions (no access to tabs, history, storage, etc.)
- Makes no network requests
- Never records or stores what you type
- The whole extension is about 20 lines of plain code

NOTE
Your password is visible on screen while the mouse is over the field. Be careful in public places or while sharing your screen.
```

### カテゴリ
ツール（Tools）

### 言語
日本語（English の説明は「ローカライズ」で英語を追加して貼り付け）

---

## グラフィック アセット

| 項目 | 規定 | ファイル | 実寸 |
|---|---|---|---|
| ストアアイコン | 128×128 PNG（必須） | `icons/icon128.png` | 128×128 ✅ |
| スクリーンショット | 1280×800 または 640×400、1〜5 枚（1 枚以上必須） | `store/screenshots/1-hover-reveal-1280x800.png` | 1280×800 ✅ |
| | | `store/screenshots/2-auto-hide-1280x800.png` | 1280×800 ✅ |
| | | `store/screenshots/3-privacy-1280x800.png` | 1280×800 ✅ |
| プロモーション タイル（小） | 440×280 PNG/JPEG（必須） | `store/promo-small-440x280.png` | 440×280 ✅ |
| マーキー プロモーション タイル | 1400×560（任意） | 未作成 | — |

画像を作り直すときは `store/render.sh` を実行します。headless Chrome で描画したあと、`sips` で解像度を自動チェックします。
スクリーンショット 1・2 は、実際の `content.js` を読み込み、ホバー操作のイベントを発火させて撮影しています。

---

## プライバシーへの取り組みタブ

### 単一用途の説明
```
パスワード入力欄にマウスカーソルを合わせている間だけ、その欄の入力内容を伏せ字なしで表示し、カーソルが離れたら伏せ字に戻します。
```

### ホスト権限が必要な理由（content_scripts の `<all_urls>`）
```
ユーザーがどのサイトでログインやパスワード入力をしても機能するよう、すべてのページでコンテンツスクリプトを実行します。スクリプトが行うのは、マウスが乗った <input type="password"> の type 属性を一時的に "text" に切り替え、マウスが離れたら "password" に戻すことだけです。ページの内容を読み取ったり、送信したり、保存したりはしません。
```

### リモートコードの使用
いいえ（すべてのコードがパッケージに含まれています）

### データ使用
収集するデータ：**すべてチェックなし**
（個人を特定できる情報、健康情報、金融情報、認証情報、個人的な通信、位置情報、ウェブ履歴、ユーザーのアクティビティ、ウェブサイトのコンテンツ のいずれも収集しません）

以下 3 項目の証明にすべてチェックを入れます：
- 承認されている用途以外で、ユーザーデータを第三者に販売、転送しない
- 単一用途と関係のない目的で、ユーザーデータを使用、転送しない
- 信用度の判断や融資目的で、ユーザーデータを使用、転送しない

### プライバシー ポリシー URL
データを収集しない場合、必須ではありません。用意するなら次の文面を GitHub Pages や Gist などで公開します：
```
Show Password on Hover は、いかなるユーザーデータも収集・送信・保存しません。
拡張機能はページ内でパスワード欄の表示形式を切り替えるだけで、外部との通信を一切行いません。
```

---

## 提出前チェック
- [ ] `dist/show-password-1.0.0.zip` をアップロード（icons を含む最新版）
- [ ] `<all_urls>` があるため、審査に数日かかる場合があります
- [ ] デベロッパー登録（初回のみ 5 USD）とメールアドレスの確認
