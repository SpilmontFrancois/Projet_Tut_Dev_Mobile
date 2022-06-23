import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { ProfilUsersPageRoutingModule } from './profil-users-routing.module';

import { ProfilUsersPage } from './profil-users.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ProfilUsersPageRoutingModule
  ],
  declarations: [ProfilUsersPage]
})
export class ProfilUsersPageModule {}
