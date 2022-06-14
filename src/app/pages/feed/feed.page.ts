import { Component, OnInit } from '@angular/core';
import { GeneralService } from '../../services/general.service';
import { Router } from '@angular/router';

import { HttpHeaders, HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.page.html',
  styleUrls: ['./feed.page.scss'],
})
export class FeedPage implements OnInit {
  
  posts = [
    {
      'id':1,
      'username':'damian82',
      'avatar':'https://i.pravatar.cc/300?u=ZR39cqgCU8',
      'content': 'Dolore quo incidunt necessitatibus illum culpa.',
      'stars': Math.floor(Math.random() * 1000),
      'share': Math.floor(Math.random() * 1000),
      'answer': Math.floor(Math.random() * 1000),
    },
    {
      'id':9,
      'username':'alyce20',
      'avatar':'https://i.pravatar.cc/300?u=bspVJyRKoB',
      'content': 'Error occaecati repellat voluptas.',
      'stars': Math.floor(Math.random() * 1000),
      'share': Math.floor(Math.random() * 1000),
      'answer': Math.floor(Math.random() * 1000),

    },
    {
      'id':7,
      'username':'bertha.cremin',
      'avatar':'https://i.pravatar.cc/300?u=rUlLVTOVdP',
      'content': 'Ullam consequuntur totam qui possimus eum.',
      'stars': Math.floor(Math.random() * 1000),
      'share': Math.floor(Math.random() * 1000),
      'answer': Math.floor(Math.random() * 1000),
    }
  ]

  test = Math.floor(Math.random() * 1000)
  
  constructor(
    public services : GeneralService,
    private router: Router,
    private http: HttpClient,
    ) { }
    
    ngOnInit() {
      // this.fetch();
    }
    
    fetch(){
      this.services.getData('posts')
      .then((res) => {
        console.log(res);
      });
    }

    goToPostComment(param){
     this.router.navigateByUrl('feed/post/'+param);
    }
    
    fetchPosts(){
      let body = new URLSearchParams;
      body.set("grant_type", "authorization_code");
      body.set("email", '');
      body.set("password", '');
    
      let headers = new HttpHeaders({
        'Content-Type': 'application/x-www-form-urlencoded'
      });
    
      let options = { headers: headers };
    
      this.http.post(
        "http://192.168.1.66:8000/api/login",
        body,
        options
      ).subscribe((response: any) => {
        console.log("🚀 ~ file: register.page.ts ~ line 79 ~ RegisterPage ~ ).subscribe ~ response", response)
        localStorage.setItem('token', response)
    
        //"17|Je7ohAZ9RBFKBovUcSE6wfZs2AWUZ0BFmRbfBGcV"
        this.router.navigateByUrl('feed')
      })
    }

    addStar(id){
      for(let i = 0; i < this.posts.length; i++){
        if(this.posts[i].id == id){
          this.posts[i].stars++;
        }
      }
      
    }

    addShare(id){
      for(let i = 0; i < this.posts.length; i++){
        if(this.posts[i].id == id){
          this.posts[i].share++;
        }
      }
    }
  }
  
  