import { Injectable } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { AddPostPage } from '../modals/add-post/add-post.page';

@Injectable({
  providedIn: 'root'
})
export class GeneralService {

  constructor(
    public modalCtrl : ModalController,
  ) { }

  async openModalAddChild(opts = {}){
    const modal = await this.modalCtrl.create({
      component: AddPostPage,
      ...opts,
    });
    await modal.present();
  }

  openSheetModal(){
    this.openModalAddChild({
      breakpoints: [0, 0.2, 0.5, 1],
      initialBreakpoint: 0.9,
    });
  }


}
