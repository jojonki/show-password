#!/bin/zsh
# ストア用画像を headless Chrome で描画し、解像度を検証する。
set -e
cd "${0:A:h}/.."
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

shot() { # src out w h [transparent]
  local bg=()
  [[ -n "$5" ]] && bg=(--default-background-color=00000000)
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --allow-file-access-from-files --user-data-dir="$TMPDIR/sp-chrome" $bg \
    --window-size="$3,$4" --screenshot="$PWD/$2" "file://$PWD/$1" >/dev/null 2>&1
}

# アイコンは先に作る（スクショ内で参照するため）
# 元画像 store/src/icon-source.png から各サイズを書き出す。
# 128 はストア規定どおり「アートワーク 96 + 四方 16 余白」。
# ツールバー等で使う 16/32/48 は余白なしで全面に描く（他の拡張と同じ見た目の大きさにするため）。
SRC=store/src/icon-source.png
# 下側の薄い影を除き、角丸四角の本体（不透明度 50% 以上）の範囲だけを切り出す
BOX=$(magick "$SRC" -alpha extract -threshold 50% -format "%@" info:)
for s in 16 32 48 128; do
  if [[ $s == 128 ]]; then art=96; else art=$s; fi
  magick "$SRC" -crop "$BOX" +repage -filter Lanczos -resize ${art}x${art} \
    -background none -gravity center -extent ${s}x${s} -strip icons/icon$s.png
done
shot store/src/shot1.html store/screenshots/1-hover-reveal-1280x800.png 1280 800
shot store/src/shot2.html store/screenshots/2-auto-hide-1280x800.png 1280 800
shot store/src/shot3.html store/screenshots/3-privacy-1280x800.png 1280 800
shot store/src/promo.html store/promo-small-440x280.png 440 280

# 解像度チェック
fail=0
check() {
  local w=$(sips -g pixelWidth "$1" | awk '/pixelWidth/{print $2}')
  local h=$(sips -g pixelHeight "$1" | awk '/pixelHeight/{print $2}')
  if [[ "$w" == "$2" && "$h" == "$3" ]]; then echo "OK   ${w}x${h}  $1"; else echo "NG   ${w}x${h} (expected $2x$3)  $1"; fail=1; fi
}
for s in 16 32 48 128; do check icons/icon$s.png $s $s; done
for f in store/screenshots/*.png; do check "$f" 1280 800; done
check store/promo-small-440x280.png 440 280
exit $fail
