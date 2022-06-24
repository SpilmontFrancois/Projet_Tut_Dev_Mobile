import { Injectable } from '@angular/core';
import { BehaviorSubject, from, Observable, Subject } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map, tap, switchMap } from 'rxjs/operators';
import { Storage } from '@capacitor/storage';

const TOKEN_KEY = 'my-token';

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  // Init with null to filter out the first value in a guard!
  isAuthenticated: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(null);
  token = '';

  constructor(
    private http: HttpClient,
  ) {
    this.loadToken();
   }

  

  async loadToken() {
    // const token = await Storage.get({ key: TOKEN_KEY });    
    const token = localStorage.getItem('token')
    if (token && token) {
      console.log('set token: ', token);
      this.token = token;
      this.isAuthenticated.next(true);
    } else {
      this.isAuthenticated.next(false);
    }
  }

  login(uid){
    this.isAuthenticated.next(true);
    // console.log({key: TOKEN_KEY, value: uid});
    console.log(localStorage.getItem('token'));
    if(localStorage.getItem('token')){
      this.isAuthenticated.next(true);
    }
    // return from(Storage.set({key: TOKEN_KEY, value: uid}));
    return localStorage.getItem('token');
  }

  logout(): Promise<void> {
    this.isAuthenticated.next(false);
    localStorage.removeItem("token");
    localStorage.removeItem("user_id");
    return Storage.remove({key: TOKEN_KEY});
  }
  
}
