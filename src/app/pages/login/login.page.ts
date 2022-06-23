import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { HttpHeaders, HttpClient } from '@angular/common/http';

import { AuthenticationService } from '../../services/authentication.service';
import { GeneralService } from '../../services/general.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {

  form: FormGroup;
  type = true;

  API_URL = this.services.getAPI_URL();
  constructor(
    public router: Router,
    public http: HttpClient,
    private api: AuthenticationService,
    private services : GeneralService,
  ) {
    this.initForm();
  }

  ngOnInit() {
  }

  initForm() {
    this.form = new FormGroup({
      email: new FormControl(null, {validators: [Validators.required, Validators.email]}),
      password: new FormControl(null, {validators: [Validators.required, Validators.minLength(8)]})
    });
  }

  changeType() {   
    this.type = !this.type;
  }

  onSubmit(){
    if(!this.form.valid) {
      console.log('not valid');
      
      this.form.markAllAsTouched();
      return;
    }
    this.login();
   
  }


  login(){
    let body = new URLSearchParams;
    body.set("grant_type", "authorization_code");
    body.set("email", this.form.value.email);
    body.set("password", this.form.value.password);
  
    let headers = new HttpHeaders({
      'Content-Type': 'application/x-www-form-urlencoded'
    });
  
    let options = { headers: headers };
  
    this.http.post(
      this.API_URL + "/login",
      body,
      options
    ).subscribe((response: any) => {
      let data = response;
      data = data.access_token.split('|')
      if(data[1]){
        localStorage.setItem('token', data[1])
        this.router.navigateByUrl('/tabs/feed')

        this.getUserById(data[1])
      }
      this.api.login(response)
    })

  }

  getUserById(token){

    let headers = new HttpHeaders({
      'Accept': 'application/json',
      'Authorization':'Bearer ' + token
    })


    this.http.get(this.API_URL + "/me", {headers: headers})
    .subscribe((response: any) => {
      let data = response;
      localStorage.setItem('user_id', data.user.id)
    })
  }
}
