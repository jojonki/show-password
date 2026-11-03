// パスワード欄にマウスが乗ったら type="text" にし、離れたら戻すだけ。
// 通信・保存・権限は一切なし。
const revealed = new WeakSet();

document.addEventListener("mouseover", (e) => {
  const el = e.target;
  if (el instanceof HTMLInputElement && el.type === "password") {
    el.type = "text";
    revealed.add(el);
  }
}, true);

document.addEventListener("mouseout", (e) => {
  const el = e.target;
  if (revealed.has(el)) {
    el.type = "password";
    revealed.delete(el);
  }
}, true);
