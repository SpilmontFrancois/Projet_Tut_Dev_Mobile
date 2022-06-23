import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalController } from '@ionic/angular';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { GeneralService } from 'src/app/services/general.service';

@Component({
  selector: 'app-add-post',
  templateUrl: './add-post.page.html',
  styleUrls: ['./add-post.page.scss'],
})
export class AddPostPage implements OnInit {

  typeOfPost = localStorage.getItem('typeOfPost')
  TOKEN = localStorage.getItem('token')
  // headers = {
  //   'Accept': 'application/json',
  //   'Authorization':'Bearer ' + this.TOKEN
  // }
  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer ' + this.TOKEN
  })

  formPost: FormGroup;

  API_URL = this.services.getAPI_URL();
  constructor(
    private router : Router,
    private modalCtrl: ModalController,
    private http: HttpClient,
    private route: ActivatedRoute,
    public services : GeneralService,
  ) {
    let test = this.route.snapshot.paramMap.get('id')
    console.log("🚀 ~ file: add-post.page.ts ~ line 33 ~ AddPostPage ~ test", test)
    }

  ngOnInit() {
    this.initForm();
  }

  initForm() {
    this.formPost = new FormGroup({
      postContent: new FormControl('', {validators: [Validators.required]}),
    });
  }

  addPost(){
    console.log(this.formPost.value.postContent);

    let data = {
      'content': this.formPost.value.postContent,
      'user_id': localStorage.getItem('user_id'),
    }
  
    this.http.post(this.API_URL + '/posts', data, {headers: this.headers})
    .subscribe((response) => {
      console.log(response);
    })
    
    this.dismiss();
  }

  addPostComment(){
    console.log(this.formPost.value.postContent);

    let data = {
      'content': this.formPost.value.postContent,
      'post_id': localStorage.getItem('post_id'),
      'user_id': localStorage.getItem('user_id'),
    }
  
    this.http.post( this.API_URL + 'post_comments', data, {headers: this.headers})
    .subscribe((response) => {
      console.log(response);
    })

    this.dismiss();
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }
}
