import Vue from 'vue'
import App from './App.vue'
import Vuetify from 'vuetify'
import './stylus/main.styl'
import Index from './components/Index.vue'
import Create from './components/Create.vue'
import Post from './components/Post.vue'

import VueRouter from 'vue-router'
import Vuex from 'vuex'

Vue.use(Vuex)
Vue.use(VueRouter)

const routes = [
  { path: '/', component: Index },
  { path: '/create', component: Create },
  { path: '/post/:id', component: Post }
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const router = new VueRouter({
  routes // short for `routes: routes`
})

const store = new Vuex.Store({
  state: {
    newsList: [
      {
        title: "Fake news",
        body: "this is some fake news",
        value: 200,
        submitted: Date.now() - 2000,
        result: 0,
        challenges: [],
        id: 0
      },
      {
        title: "True news",
        body: "this is some true news ajasd fjfads jklf adsjkdfs jk djklafs djkladfs jas dfjadfsjadfs jkladfs jkladfs as jkaas fjklas dfjkas dfas dfas dfjkla fsdjads fjkads fadfs ",
        value: 200,
        submitted: Date.now() - 1000,
        result: 1,
        challenges: [{reason: "this is a reason this is wrong."}],
        id: 1
      },
      {
        title: "Trueish news",
        body: "this is some true news ajasd fjfads jklf adsjkdfs jk djklafs djkladfs jas dfjadfsjadfs jkladfs jkladfs as jkaas fjklas dfjkas dfas dfas dfjkla fsdjads fjkads fadfs ",
        value: 200,
        submitted: Date.now() - 500,
        result: -1,
        challenges: [{reason: "this is a reason this is wrong."}],
        id: 2
      }
    ]
  },
  mutations: {
    create(state, obj) {
      state.newsList.push({title:obj.title, body:obj.body, value:obj.value, challenges:[], id: state.newsList.length, submitted: Date.now(), result: 0});
    },
    challenge(state, obj) {
      state.newsList[obj.id].challenges.unshift({reason: obj.reason});
    },
    judge(state, obj) {
      state.newsList[obj.id].result = obj.result;
    }
  }
})


Vue.use(Vuetify)

// const app = new Vue({
//   router
// }).$mount('#app')
new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
