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
  
  API_URL = this.services.getAPI_URL();
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
      this.router.navigateByUrl('tabs/feed/profil-users/'+ user_id);
    }
    
    fetchPost(){
      let response = this.http.get(this.API_URL + '/posts', {headers: this.headers})
      .subscribe((response => {
        let res = Object.values(response);
        this.posts = res[0]
      }));
    }


    addStar(id){
      let response = this.http.post(this.API_URL +  '/star/' + id, '', {headers: this.headers})
      .subscribe((response => {
      this.fetchPost()
      }));
    }

    addShare(id){
      let response = this.http.post(this.API_URL + '/share/' + id, '', {headers: this.headers})
      .subscribe((response => {
      this.fetchPost()
      }));
    }

    

  }