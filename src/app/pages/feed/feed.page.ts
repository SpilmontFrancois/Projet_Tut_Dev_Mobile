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
  
  posts = []

  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer HflxhQS3cm6DPOsuAd5DDypJaIuT9Im39gQhVyOl'
  })

  test = Math.floor(Math.random() * 1000)
  
  constructor(
    public services : GeneralService,
    private router: Router,
    private http: HttpClient,
    ) { }
    
    ngOnInit() {
      this.fetchPost();
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
    
    fetchPost(){

      console.log("💨");
      
      const headers = new HttpHeaders({
        'Accept': 'application/json',
        'Authorization':'Bearer HflxhQS3cm6DPOsuAd5DDypJaIuT9Im39gQhVyOl'
      })
      

      let response = this.http.get('http://192.168.1.66:8000/api/posts', {headers: headers})
      .subscribe((response => {
        let res = Object.values(response);
        this.posts = res[0]
        console.log("🚀 ~ file: feed.page.ts ~ line 81 ~ FeedPage ~ fetchPost ~ this.posts", this.posts)
        
        
        
      }));
    }

    addStar(id){
      // for(let i = 0; i < this.posts.length; i++){
      //   if(this.posts[i].id == id){
      //     this.posts[i].stars++;
      //   }
      // }

      console.log('http://192.168.1.66:8000/api/star/' + id);

      
      let response = this.http.post('http://192.168.1.66:8000/api/star/' + id, {headers: this.headers})
      .subscribe((response => {
      console.log("🚀 ~ file: feed.page.ts ~ line 70 ~ FeedPage ~ addStar ~ response", response)

      this.fetchPost()
      }));
      
      
    }

    addShare(id){
      for(let i = 0; i < this.posts.length; i++){
        if(this.posts[i].id == id){
          this.posts[i].share++;
        }
      }
    }
  }
  
  