import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpHeaders, HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-post',
  templateUrl: './post.page.html',
  styleUrls: ['./post.page.scss'],
})


export class PostPage implements OnInit {

  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer HflxhQS3cm6DPOsuAd5DDypJaIuT9Im39gQhVyOl'
  })

  idPost: string;

  post = []

  posts = [
    {
      'id':5,
      'username':'damian82',
      'avatar':'https://i.pravatar.cc/300?u=ZR39cqgCU8',
      'content': 'Rerum repellendus tenetur quia fugiat est.',
    },
  ];

  postComments = [
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

  postsComment = [ ]


  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private http: HttpClient,
  ) { }

  ngOnInit() {
    this.idPost = this.route.snapshot.paramMap.get('id');

    this.fetchPost()
  }

  fetchPost(){
    let response = this.http.get('http://192.168.1.66:8000/api/posts/' + this.idPost, {headers: this.headers})
    .subscribe((response => {
      this.post = Object.values(response)
      this.post = this.post[0]
      // this.post = Object.values(this.post)
      console.log("🚀 ~ file: post.page.ts ~ line 43 ~ PostPage ~ fetchPost ~ this.post", this.post)
    }));
  }


  goToPost(){
   this.router.navigateByUrl('feed');
  }
}
