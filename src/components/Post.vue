<template>

        <v-container grid-list-md>
          <v-slide-y-transition mode="out-in">
            <v-layout row wrap>
              <v-flex xs12 md8 offset-md2 lg6 offset-lg3>
                  <v-card>
                    <v-card-title>
                      <v-container grid-list-md>
                        <v-layout row wrap>
                          <v-flex xs9><span class="headline">{{$store.state.newsList[parseInt($route.params.id)].title}}</span> - <span class="green--text" style="font-style: italic;">ETH {{$store.state.newsList[parseInt($route.params.id)].value}}</span></v-flex>
                          <v-flex xs3 text-xs-center><v-chip :color="styleBadge($store.state.newsList[parseInt($route.params.id)])" text-color="white">{{badge($store.state.newsList[parseInt($route.params.id)])}}</v-chip></v-flex>
                          <v-flex xs10><span style="overflow: hidden;text-overflow:ellipsis;">{{$store.state.newsList[parseInt($route.params.id)].body}}</span></v-flex>
                        </v-layout>
                      </v-container>
                    </v-card-title>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn v-if="$route.query.judge" color="red" @click="judge(-1)" flat>False</v-btn>
                      <v-btn v-if="$route.query.judge" color="green" @click="judge(1)" flat>True</v-btn>
                      <v-btn v-else flat color="primary" @click.native="dialog = true">Challenge</v-btn>
                    </v-card-actions>
                  </v-card>
              </v-flex>
              <v-flex xs12 md8 offset-md2>
                <v-dialog v-model="dialog" persistent max-width="500px">
                <v-card>
                  <v-card-title>
                    <span class="headline">Challenge Claim</span>
                  </v-card-title>
                  <v-card-text>
                    <v-container grid-list-md>
                      <v-layout wrap>
                        <v-flex xs12>
                          <v-text-field label="Reason" multi-line v-model="reason"></v-text-field>
                        </v-flex>
                      </v-layout>
                    </v-container>
                    <small>Note: if you're challenge is not accepted, you lose 10% of the inital bet</small>
                  </v-card-text>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="blue darken-1" flat @click.native="dialog = false">Close</v-btn>
                    <v-btn color="blue darken-1" flat @click.native="challenge()">Save</v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
              </v-flex>
              <v-flex xs12 md8 offset-md2 lg6 offset-lg3 v-for="item in $store.state.newsList[parseInt($route.params.id)].challenges" v-bind:key="item.reason">
                  <v-card>
                    <v-card-title>
                      <v-container grid-list-md>
                        <v-layout row wrap>
                          <v-flex xs10><span style="overflow: hidden;text-overflow:ellipsis;">{{item.reason}}</span></v-flex>
                        </v-layout>
                      </v-container>
                    </v-card-title>
                    <!-- <v-card-actions>
                    </v-card-actions> -->
                  </v-card>
              </v-flex>
              <v-snackbar
                v-model="snackbar"
                color="green"
              >
                Submitted!
                <v-btn flat color="white" @click.native="snackbar = false">Close</v-btn>
              </v-snackbar>
            </v-layout>
          </v-slide-y-transition>
        </v-container>

</template>

<script>
  export default {
    name:'Post',
    data () {
      return {
        clipped: false,
        drawer: true,
        dialog: false,
        snackbar: false,
        reason:"",
        fixed: false
      }
    },
    methods: {
      challenge() {
        this.$store.commit("challenge", {id:parseInt(this.$route.params.id), reason: this.reason});
        this.reason = "";
        this.dialog = false;
        this.snackbar = true;
      },
      judge(result) {
        this.$store.commit("judge", {id:parseInt(this.$route.params.id), result: parseInt(result)});
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
          return "yellow"
        } else if (result == "unchallenged") {
          return "primary"
        } else if (result == "True") {
          return "green"
        } else {
          return "red"
        }
      }
    }
  }
</script>