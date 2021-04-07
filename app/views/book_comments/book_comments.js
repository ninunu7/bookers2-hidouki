$(".comment").html("<%= j(render 'show', { comments: @comment.book.comments }) %>")
$("textarea").val('')