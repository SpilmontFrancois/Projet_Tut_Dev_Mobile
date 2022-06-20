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

  postUser = [];

  postComments = []

  postCommentsUser = [];


  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private http: HttpClient,
  ) { }

  ngOnInit() {
    this.idPost = this.route.snapshot.paramMap.get('id');

    this.fetchPost()
    this.fetchPostComments()
  }

  fetchPost(){
    let response = this.http.get('http://192.168.1.66:8000/api/posts/' + this.idPost, {headers: this.headers})
    .subscribe((response => {
      this.post = Object.values(response)
      this.post = this.post[0]
      
      this.postUser = this.post['user']
    }));
  }

  fetchPostComments(){
    let response = this.http.get('http://192.168.1.66:8000/api/post_comments/' + this.idPost, {headers: this.headers})
    .subscribe((response => {
      this.postComments = Object.values(response)
      this.postComments = this.postComments[0]
      console.log("🚀 ~ file: post.page.ts ~ line 60 ~ PostPage ~ fetchPostComments ~ this.postComments", this.postComments)
      
      

    }))
  }


  goToPost(){
   this.router.navigateByUrl('feed');
  }
}
