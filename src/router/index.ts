import Vue, { AsyncComponent } from 'vue';
import Router, { RouteConfig, Route, NavigationGuard } from 'vue-router';

const Index: AsyncComponent = (): any =>
  import('@/components/Index.vue');

Vue.use(Router);

const routes: RouteConfig[] = [
  {
    path: '/',
    name: 'Index',
    component: Index,
  },
];

const router: Router = new Router({
  mode: 'history',
  base: '/',
  routes,
});

export default router;
