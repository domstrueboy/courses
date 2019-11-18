<template>
    <ul>
        <Quote
            v-for="quote in quotes"
            :key="quote.id"
            :quote="quote"
        />
    </ul>
</template>

<script>
import Quote from './Quote.vue';

export default {
    props: ['quotes'],
    components: {
        Quote
    }
}
</script>

<style scoped>
ul {
    list-style-type: none;
    display: flex;
    flex-wrap: wrap;
}
</style>