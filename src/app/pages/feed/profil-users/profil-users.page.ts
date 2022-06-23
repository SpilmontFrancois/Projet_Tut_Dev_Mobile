import { Component, OnInit } from '@angular/core';

import { HttpHeaders, HttpClient } from '@angular/common/http';
import { ActivatedRoute, Router } from '@angular/router';
import { GeneralService } from '../../../services/general.service';

@Component({
  selector: 'app-profil-users',
  templateUrl: './profil-users.page.html',
  styleUrls: ['./profil-users.page.scss'],
})
export class ProfilUsersPage implements OnInit {

  user_id = this.route.snapshot.paramMap.get('id');
  user : any = {};

  TOKEN = localStorage.getItem('token')
  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer ' + this.TOKEN
  })

  constructor(
    private http: HttpClient,
    private route: ActivatedRoute,
    private service: GeneralService,
  ) { }

  ngOnInit() {    
    this.fetchUser()
  }

  // 51.15.209.202

  async fetchUser(){      
    await this.http.get('http://51.15.209.202:8000/api/users/' + this.user_id, {headers: this.headers})
    .subscribe((response => {
      let res = Object.values(response);
      this.user = res[0]
    }));
  }

}
