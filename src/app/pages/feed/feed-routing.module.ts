import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { FeedPage } from './feed.page';

const routes: Routes = [
  {
    path: '',
    component: FeedPage
  },
  {
    path: 'post/:id',
    loadChildren: () => import('./post/post.module').then( m => m.PostPageModule)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class FeedPageRoutingModule {}
