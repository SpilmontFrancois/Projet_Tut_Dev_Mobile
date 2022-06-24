import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './guards/auth.guard';
import { AutoLoginGuard } from './guards/auto-login.guard';

const routes: Routes = [
  {
    path: '',
    redirectTo: '/feed',
    pathMatch: 'full',
    // loadChildren: () => import('./tabs/tabs.module').then(m => m.TabsPageModule)
    // loadChildren: () => import('./pages/login/login.module').then( m => m.LoginPageModule),
    canLoad: [AutoLoginGuard] //Check if we should show the introduction or forward to inside
  },
  {
    path: 'tabs',
    loadChildren: () => import('./tabs/tabs.module').then(m => m.TabsPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'profil',
    loadChildren: () => import('./pages/profil/profil.module').then( m => m.ProfilPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'search',
    loadChildren: () => import('./pages/search/search.module').then( m => m.SearchPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'add-post',
    loadChildren: () => import('./modals/add-post/add-post.module').then( m => m.AddPostPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'feed',
    loadChildren: () => import('./pages/feed/feed.module').then( m => m.FeedPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'feed/post/:id',
    loadChildren: () => import('./pages/feed/feed.module').then( m => m.FeedPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'feed/profile-user/:id',
    loadChildren: () => import('./pages/feed/feed.module').then( m => m.FeedPageModule),
    canLoad: [AuthGuard] //Secure all child pages
  },
  {
    path: 'login',
    loadChildren: () => import('./pages/login/login.module').then( m => m.LoginPageModule),
  },
  {
    path: 'register',
    loadChildren: () => import('./pages/register/register.module').then( m => m.RegisterPageModule),
  },


];
@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
