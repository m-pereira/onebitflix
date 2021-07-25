<template>
  <v-app>
    <Header />
    <v-main>
      <h4 class="white--text">Main Component</h4>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Header from './components/shared/header.vue';
import Footer from './components/shared/footer.vue';

export default {
  data() {
    return {};
  },
  components: {
    Header: Header,
    Footer: Footer,
  },
};
</script>

<style>
#app {
  background-color: #0c0c0c !important;
}
</style>
