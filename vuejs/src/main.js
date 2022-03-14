import { createApp } from "vue";
import App from "./routes/index.vue";
import "./registerServiceWorker";
import { createWebHistory, createRouter } from "vue-router";

import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import axios from "axios";
import VueAxios from "vue-axios";

import "./assets/css/main.css"
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"

import Home from './routes/index.vue'
import Login from './routes/login/index.vue'
import Feed from './routes/feed/index.vue'
import Profile from './routes/profile/index.vue'
import Messages from './routes/messages/index.vue'

library.add(fas)

const routes = [
    { path: '/', component: Home },
    { path: '/login', component: Login },
    { path: '/feed', component: Feed },
    { path: '/profile', component: Profile },
    { path: '/messages', component: Messages }
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

createApp(App).component("font-awesome-icon", FontAwesomeIcon).use(VueAxios, axios).use(router).mount("#app");
