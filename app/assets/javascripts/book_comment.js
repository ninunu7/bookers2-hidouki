$(book).on('turbolinks:load', ()=> {
  // 追加するビューを定義。長く見えますが、先ほど書いたビューのeach以下と同じです。
  function buildHTML(comment){
    // コメントをしたのが出品者だった時の場合分け
    if (comment.user_id === comment.saler_id) {
      let html =
      `<div class='product__topContent__commentBox__index__box'>
        <span class='product__topContent__commentBox__index__box--name'>${comment.user_name}</span>
        <span class='product__topContent__commentBox__index__box--saler'>出品者</span>
        <span class='product__topContent__commentBox__index__box--date'>${comment.created_at}</span>
        <p class='product__topContent__commentBox__index__box--text'>${comment.text}</p>
      </div>`
      return html;
    } else {
      let html =
      `<div class='product__topContent__commentBox__index__box'>
        <span class='product__topContent__commentBox__index__box--name'>${comment.user_name}</span>
        <span class='product__topContent__commentBox__index__box--date'>${comment.created_at}</span>
        <p class='product__topContent__commentBox__index__box--text'>${comment.text}</p>
      </div>`
      return html;
    }
  }
  // データが送信された時の処理
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    // 送るデータとオプションを指定
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    // 通信が成功した時
    .done(function(data){
      // 上で定義したHTML
      let html = buildHTML(data);
      // html要素を追加する
      $('.product__topContent__commentBox__index').append(html);
      // フォームの中身をからにする
      $('.product__topContent__commentBox__text').val('');
      // 追加した要素の分だけスクロールさせる
      $('.product__topContent__commentBox__index').animate({ scrollTop: $('.product__topContent__commentBox__index')[0].scrollHeight});
      // 送信ボタンが一度押したら再度押せなくなる処理を無効にして、連続投稿可能にする。
      $('.product__topContent__commentBox__submit').prop('disabled', false);
    })
    // 通信に失敗した時
    .fail(function(){
      alert('コメントを入力してください');
    })
  })
})
