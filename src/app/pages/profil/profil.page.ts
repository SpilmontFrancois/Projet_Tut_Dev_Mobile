import { Component, OnInit } from '@angular/core';

import { HttpHeaders, HttpClient } from '@angular/common/http';
import { GeneralService } from 'src/app/services/general.service';


@Component({
  selector: 'app-profil',
  templateUrl: './profil.page.html',
  styleUrls: ['./profil.page.scss'],
})
export class ProfilPage implements OnInit {

  user_id = localStorage.getItem('user_id')
  user : any = {};

  TOKEN = localStorage.getItem('token')
  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer ' + this.TOKEN
  })

  API_URL = this.services.getAPI_URL();
  
  constructor(
    private http: HttpClient,
    private services: GeneralService,
  ) { }

  ngOnInit() {
    this.fetchUser()
  }

  async fetchUser(){      
    await this.http.get(this.API_URL + '/users/' + this.user_id, {headers: this.headers})
    .subscribe((response => {
      let res = Object.values(response);
      this.user = res[0]
      // console.log("🚀 ~ ~ res[0]", res[0])
      // console.log("🚀 ~  ~  ~ this.user", this.user)
    }));
  }

}
