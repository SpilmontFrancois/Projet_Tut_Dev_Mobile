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
  
  TOKEN = localStorage.getItem('token')
  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer ' + this.TOKEN
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

    goToProfil(user_id){
      this.router.navigateByUrl('feed/profil-users/'+ user_id);
    }
    
    fetchPost(){
      let response = this.http.get('http://51.15.209.202:8000/api/posts', {headers: this.headers})
      .subscribe((response => {
        let res = Object.values(response);
        this.posts = res[0]
      }));
    }


    addStar(id){
      let response = this.http.post('http://51.15.209.202:8000/api/star/' + id, '', {headers: this.headers})
      .subscribe((response => {
      console.log("🚀 ~ ", response)
      console.log("🚀 ~ file: feed.page.ts ~ line 58 ~ FeedPage ~ addStar ~ response", response)
      this.fetchPost()
      }));
    }

    addShare(id){
      let response = this.http.post('http://51.15.209.202:8000/api/share/' + id, '', {headers: this.headers})
      .subscribe((response => {
      console.log("🚀 ~ ", response)
      console.log("🚀 ~ file: feed.page.ts ~ line 58 ~ FeedPage ~ addStar ~ response", response)
      this.fetchPost()
      }));
    }

    

  }