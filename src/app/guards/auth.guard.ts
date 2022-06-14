import { Injectable } from '@angular/core';
import { CanLoad, Route, UrlSegment, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { Router } from '@angular/router';
import { AuthenticationService } from '../services/authentication.service';
import { filter, map, take } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanLoad {

  constructor(
    private api: AuthenticationService,
    private router: Router,
  ) {}

  canLoad(): Observable<boolean> {    
    return this.api.isAuthenticated.pipe(
      filter(val => val !== null), // Filter out initial Behaviour subject value
      take(1), // Otherwise the Observable doesn't complete!
      map(isAuthenticated => {
        if (isAuthenticated) {          
          return true;
        } else {          
          this.router.navigateByUrl('/login')
          return false;
        }
      })
    );
  }
}
