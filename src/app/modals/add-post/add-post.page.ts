import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ModalController } from '@ionic/angular';
import { FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-add-post',
  templateUrl: './add-post.page.html',
  styleUrls: ['./add-post.page.scss'],
})
export class AddPostPage implements OnInit {

  formPost: FormGroup;

  constructor(
    private router : Router,
    private modalCtrl: ModalController,
  ) { }

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

    // ...
    
    
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }
}
