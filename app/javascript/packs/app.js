import Vue from 'vue';
import App from './App.vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';

Vue.use(Vuetify);

const vuetify = new Vuetify({});

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    vuetify: vuetify,
    render: h => h(App),
  }).$mount();
});
