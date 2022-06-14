import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-post',
  templateUrl: './post.page.html',
  styleUrls: ['./post.page.scss'],
})
export class PostPage implements OnInit {

  posts = [
    {
      'id':5,
      'username':'damian82',
      'avatar':'https://i.pravatar.cc/300?u=ZR39cqgCU8',
      'content': 'Rerum repellendus tenetur quia fugiat est.',
    },
  ];

  postsComment = [
    {
      'id':3,
      'username':'hills.diamond',
      'avatar':'https://i.pravatar.cc/300?u=JwOUHDreWQ',
      'content': 'Consequuntur dolores a molestiae nostrum.',
    },
    {
      'id':1,
      'username':'damian82',
      'avatar':'https://i.pravatar.cc/300?u=ZR39cqgCU8',
      'content': 'Et animi hic quo quia voluptatibus.',
    },
    {
      'id':10,
      'username':'lea94',
      'avatar':'https://i.pravatar.cc/300?u=da0gtX84uL',
      'content': 'Provident qui doloribus explicabo enim voluptas omnis aut.',
    }
  ]


  constructor() { }

  ngOnInit() {
  }

}
