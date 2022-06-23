import { Injectable } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { AddPostPage } from '../modals/add-post/add-post.page';
import { HttpClient, HttpHeaders } from  '@angular/common/http';
import { ToastController } from '@ionic/angular';


// let apiURL = "https://";
let apiURL = "http://192.168.1.66:8000/api";


@Injectable({
  providedIn: 'root'
})
export class GeneralService {
  [x: string]: any;
  

  TOKEN = localStorage.getItem('token')
  headers = new HttpHeaders({
    'Accept': 'application/json',
    'Authorization':'Bearer ' + this.TOKEN
  })


  constructor(
    public modalCtrl : ModalController,
    public http: HttpClient,
    private toastController: ToastController,
    ) { }
    
    async openModalAddChild(opts = {}){
      const modal = await this.modalCtrl.create({
        component: AddPostPage,
        ...opts,
      });
      await modal.present();
    }
    
    openSheetModal(typeOfPost){
      if(typeOfPost == 'coment'){
        localStorage.setItem('typeOfPost', typeOfPost)
      }
      
      this.openModalAddChild({
        breakpoints: [0, 0.2, 0.5, 1],
        initialBreakpoint: 1,
      });
    }
    
    // getData(method) {
    //   return new Promise((resolve, reject) => {
    //     let headers = new Headers();
    //     this.http.get(apiURL + method)
    //     .subscribe(res => {
    //       resolve(res);
    //     }, (err) => {
    //       reject(err);
    //       console.error('err | ' + err);
    //     });
    //   });
    // }
    
    // postData(parameters, method) {
    //   return new Promise((resolve, reject) => {
    //     let headers = new Headers();
    //     this.http.post(apiURL + method, JSON.stringify(parameters))
    //     .subscribe(res => {
    //       resolve(res);
    //     }, (err) => {
    //       reject(err);
    //       console.error('err | ' + err);
    //     });
    //   });
    // }
  
  async showToast(header, message, color, time){
    const toast = await this.toastController.create({
      header: header,
      message: message,
      icon: 'information-circle',
      color: color,
      duration: time
    });
    await toast.present();
  }
  

  async getData(param){      
    await this.http.get('http://51.15.209.202:8000/api/' + param, {headers: this.headers})
    .subscribe((response => {
      let res = Object.values(response);
      this.user = res[0]
    }));
  }

}