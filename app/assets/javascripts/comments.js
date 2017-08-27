function renderComments(comments){
  console.log(comments)
  var root = document.getElementById('comments');
  var i = 0, added = 0;
  while(comments.length > 0){
    var parent = null;
    if(comments[i].parent_id)parent = document.getElementById('comment_'+comments[i].parent_id)
    else parent = root;
    if(parent!=null){
      parent.append(renderComment(comments[i]));
      added ++;
      comments.splice(i, 1);
    }else{
      i++;
    }
    //i--;
    if(i >= comments.length){
      i = 0;
      if(added==0)break;
      added = 0;
    }
  }
  root.getElementsByClassName('loading')[0].style.display = "none";
  console.log(comments.length + ' not added')
}

function renderComment(comment){
  var root = document.createElement('div');
  root.classList.add('comment');
  root.id = 'comment_'+comment.id;
  root.appendChild(document.createTextNode('+' + comment.score + ' '));
  if(comment.user)root.appendChild(document.createTextNode(comment.user.username + ': '));
  root.appendChild(document.createTextNode(comment.content));
  return root;
}
