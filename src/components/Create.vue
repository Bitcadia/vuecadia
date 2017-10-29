<template>

        <v-container grid-list-md>
          <v-slide-y-transition mode="out-in">
            <v-layout row wrap>
              <v-flex xs9><v-text-field
              name="title"
              label="Title"
              id="title"
              v-model="title"
            ></v-text-field></v-flex>
            <v-flex xs2 offset-xs1><v-text-field
              name="value"
              label="Value"
              id="value"
              v-model="value"
            ></v-text-field></v-flex>
            <v-flex xs12><v-text-field
              name="body"
              label="Body"
              multi-line
              v-model="body"
            ></v-text-field></v-flex>
            <v-flex xs12>
              <v-btn block color="primary" @click="submit">Submit</v-btn>
            </v-flex>
            </v-layout>
          </v-slide-y-transition>
          <v-snackbar
            v-model="snackbar"
            color="green"
          >
            Submitted!
            <v-btn flat color="white" @click.native="snackbar = false">Close</v-btn>
          </v-snackbar>
        </v-container>
</template>

<script>
  export default {
    name:'Create',
    data () {
      return {
        title: "",
        value: 0,
        body: "",
        snackbar: false
      }
    },
    methods: {
      submit: function submit() {
        
        bitcadiaInstance.newClaim(
          this.title, 
          this.body, 
          this.value,
          new Date().getTime(),
          { from: web3.eth.accounts[0] }, 
          function(error, txHash) {
            if (error) { console.log('error', error) }        
            console.log('txHash', txHash)            
          });

        this.$store.commit("create", {title:this.title, body:this.body, value:this.value});
        this.title = "";
        this.value = null;
        this.body = "";
        this.snackbar = true;
        this.$router.push({path: "/"})
      }
    }
  }
</script>