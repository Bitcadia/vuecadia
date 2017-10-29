<template>

        <v-container grid-list-md>
          <v-slide-y-transition mode="out-in">
            <v-layout row wrap>
              <v-flex xs12 md8 offset-md2 lg6 offset-lg3 v-for="item in reverse($store.state.newsList)" v-bind:key="item.title">
                <!-- <router-link :to="`/post/${item.id}`"> -->
                  <v-card class="islink">
                    <v-card-title>
                      <v-container grid-list-md @click="goToPost(item.id)">
                        <v-layout row wrap>
                          <v-flex xs9><span class="headline">{{item.title}}</span> - <span class="green--text" style="font-style: italic;">ETH {{item.value}}</span></v-flex>
                          <v-flex xs3 text-xs-center><v-chip :color="styleBadge(item)" text-color="white">{{badge(item)}}</v-chip></v-flex>
                          <v-flex xs10><span style="overflow: hidden;text-overflow:ellipsis;">{{item.body}}</span></v-flex>
                        </v-layout>
                      </v-container>
                    </v-card-title>
                    <v-card-actions>
                    </v-card-actions>
                  </v-card>
                <!-- </router-link> -->
              </v-flex>
            </v-layout>
          </v-slide-y-transition>
        </v-container>

</template>

<script>
  export default {
    name:'Index',
    data () {

      return {
        clipped: false,
        drawer: true,
        fixed: false
      }
    },
    methods: {
      goToPost(id) {
        this.$router.push({ path: `/post/${id}` })
      },
      badge(item) {
        if (item.result === 0) {
          return item.challenges.length > 0 ? "challenged":"unchallenged";
        }
        if (item.result === 1) {
          return "True";
        }
        return "False";
      },
      styleBadge(item) {
        let result = this.badge(item);
        if (result == "challenged") {
          return "warning"
        } else if (result == "unchallenged") {
          return "primary"
        } else if (result == "True") {
          return "green"
        } else {
          return "red"
        }
      },
      reverse(arr) {
        return arr.reverse();
      }
    }
  }
</script>