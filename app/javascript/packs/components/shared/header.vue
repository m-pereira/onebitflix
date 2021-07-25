<template>
  <v-toolbar color="black" dark>
    <v-layout row wrap>
      <v-flex xs10 sm4>
        <img :src="logo" class="logo" />
      </v-flex>
    </v-layout>
    <v-toolbar-items class="hidden-sm-and-down">
      <v-text-field
        text
        prepend-icon="search"
        label="Search"
        class="hidden-sm-and-down"
        color="red"
        pr-3
      ></v-text-field>

      <v-menu bottom text>
        <template v-slot:activator="{ on }">
          <v-btn v-on="on" slot="activator" text>
            <v-icon large>account_box</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-list-item>
            <v-list-item-title>
              <a href="/users/edit">Details</a>
            </v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>
              <a data-method="delete" href="/users/sign_out">Logout</a>
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script>
import Logo from '../../assets/images/logo.png';

export default {
  data() {
    return {
      logo: Logo,
    };
  },
};
</script>

<style scoped>
.logo {
  width: 120px !important;
  margin-top: 10px;
}
</style>
