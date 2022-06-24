import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { HttpHeaders, HttpClient } from '@angular/common/http';

import { AuthenticationService } from '../../services/authentication.service';
import { GeneralService } from '../../services/general.service';

// import { HTTP, HTTPOriginal } from '@ionic-native/http';

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
    // private http: HTTPOriginal,
  ) {
    this.initForm();
  }

  ngOnInit() {
    // localStorage.setItem('token', '8Fxg0ilKLfqre9RHbpBfUx6olwfnPs3iRHbZcFG3')
    // localStorage.setItem('user_id', '12')

  }

  initForm() {
    this.form = new FormGroup({
      email: new FormControl(null, {validators: [Validators.required, Validators.email]}),
      password: new FormControl(null, {validators: [Validators.required]})
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
    console.log("email : ", this.form.value.email);
    console.log("pass : ", this.form.value.password);
    
    let body = new URLSearchParams;
    body.set("grant_type", "authorization_code");
    body.set("email", this.form.value.email);
    body.set("password", this.form.value.password);

    // let body = {data : {
    //   grant_type: "authorization_code",
    //   email: this.form.value.email,
    //   password: this.form.value.password
    // }}
  
    let headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  
    let options = { headers };
  
    console.log("body : ", body);
    
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
