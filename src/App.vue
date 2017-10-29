<template>
  <v-app light>
    <!-- <v-navigation-drawer
      v-model="drawer"
      enable-resize-watcher
      app
    >
      <v-list>
        <v-list-tile
          v-for="(item, i) in items"
          :key="i"
          value="true"
        >
          <v-list-tile-action>
            <v-icon light v-html="item.icon"></v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <router-link :to="item.route">
            <v-list-tile-title v-text="item.title"></v-list-tile-title>
            </router-link>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer> -->
    <v-toolbar color="primary" dark fixed app :clipped-left="clipped" extended>
      <!-- <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon> -->
      <v-flex xs12 class="text-xs-center" @click="$router.push({ path: `/` })"><v-toolbar-title><v-flex xs12 class="text-xs-center"><img class="islink" style="margin-top: 60px" width="300" src="public/logo.png" alt="Bitcadia"></v-flex></v-toolbar-title></v-flex>
      <v-btn
              color="pink"
              dark
              absolute
              bottom
              right
              fab
              @click="goToCreate()"
            >
              <v-icon>add</v-icon>
            </v-btn>
    </v-toolbar>
    <main>
      <v-content>
        <router-view></router-view>
      </v-content>
    </main>
    <v-footer :fixed="fixed" app>
      <span>&copy; 2017</span>
    </v-footer>
  </v-app>
</template>

<script>
  export default {
    name: 'App',
    data () {
      return {
        drawer: true,
        clipped: false,
        fixed: false,
        items: [
          { icon: 'bubble_chart', title: 'Home', route: '/' },
          { icon: 'bubble_chart', title: 'Create a new Claim', route: '/create' },
          { icon: 'bubble_chart', title: 'Judge', route: '/judge' }
        ],
        title: 'Bitcadia',
        newsList: [
          {
            title: "Fake news",
            body: "this is some fake news",
            bounty: 200,
            challenged: false,
          },
          {
            title: "True news",
            body: "this is some true news ajasd fjfads jklf adsjkdfs jk djklafs djkladfs jas dfjadfsjadfs jkladfs jkladfs as jkaas fjklas dfjkas dfas dfas dfjkla fsdjads fjkads fadfs ",
            bounty: 200,
            challenged: true
          },
          {
            title: "Trueish news",
            body: "this is some true news ajasd fjfads jklf adsjkdfs jk djklafs djkladfs jas dfjadfsjadfs jkladfs jkladfs as jkaas fjklas dfjkas dfas dfas dfjkla fsdjads fjkads fadfs ",
            bounty: 200,
            challenged: true
          }
        ]
      }
    },
    methods: {
      goToCreate: function () {
        this.$router.push({ path: `/create` })
      }
    }
  }
</script>

<style>
  .islink{ cursor: pointer; }
</style>
