import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { GeneralService } from '../../services/general.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';


import { HttpClient, HttpHeaders } from  '@angular/common/http';

@Component({
  selector: 'app-register',
  templateUrl: './register.page.html',
  styleUrls: ['./register.page.scss'],
})
export class RegisterPage implements OnInit {

  form: FormGroup;
  type = false;

  API_URL = this.services.getAPI_URL();
  constructor(
    private router: Router,
    private services : GeneralService,
    private http: HttpClient,
  ) { }

  ngOnInit() {
    this.initForm();
  }

  initForm() {
    this.form = new FormGroup({
      email: new FormControl(null, {validators: [Validators.required, Validators.email]}), // added email validator also
      password: new FormControl(null, {validators: [Validators.required, Validators.minLength(8)]}),
      confirmedPassword: new FormControl(null, {validators: [Validators.required, Validators.minLength(8)]}),
      firstname: new FormControl(null, {validators: [Validators.required]}),
      lastname: new FormControl(null, {validators: [Validators.required]}),
      username: new FormControl(null, {validators: [Validators.required]}),
    });
  }

  changeType() {
    this.type = !this.type;
  }

  onSubmit(){
    if(!this.form.valid){
      this.form.markAllAsTouched();
      return;
    }else if (this.form.value.password != this.form.value.confirmedPassword){
      this.services.showToast('Mauvais mot de passe', 'Vos 2 mots de passe sont différens', 'danger', 3000);
    }

    this.register();
  }
  


register(){
  let body = new URLSearchParams;
  body.set("grant_type", "authorization_code");
  body.set("username", this.form.value.username);
  body.set("firstname", this.form.value.firstname);
  body.set("lastname", this.form.value.lastname);
  body.set("email", this.form.value.email);
  body.set("password", this.form.value.password);
  
  let headers = new HttpHeaders({
    'Content-Type': 'application/x-www-form-urlencoded'
  });

  let options = { headers: headers };

  this.http.post(
     this.API_URL + "/register",
    body,
    options
  ).subscribe((response: any) => {
    localStorage.setItem('token', response)
    console.log("🟢");
  })
}

}
