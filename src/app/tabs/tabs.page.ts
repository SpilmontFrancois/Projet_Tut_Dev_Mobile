import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AuthenticationService } from '../services/authentication.service';


@Component({
  selector: 'app-tabs',
  templateUrl: './tabs.page.html',
  styleUrls: ['./tabs.page.scss'],
})
export class TabsPage implements OnInit {

  constructor(
    private http: HttpClient,
    private auth: AuthenticationService
  ) { }

  ngOnInit() {
  }

  // logout(){
  //   this.http.post('http://localhost:3000/api/logout', {}, {headers: headers})
  //   .subscribe()
  // }

  logout(){
    this.auth.logout()
  }

}
