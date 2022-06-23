import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ProfilUsersPage } from './profil-users.page';

const routes: Routes = [
  {
    path: '',
    component: ProfilUsersPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ProfilUsersPageRoutingModule {}
