import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
@Component({
  selector: 'app-tabs',
  templateUrl: './tabs.page.html',
  styleUrls: ['./tabs.page.scss'],
})
export class TabsPage implements OnInit {

  constructor(
    private http: HttpClient
  ) { }

  ngOnInit() {
  }

  // logout(){
  //   this.http.post('http://localhost:3000/api/logout', {}, {headers: headers})
  //   .subscribe()
  // }

}
