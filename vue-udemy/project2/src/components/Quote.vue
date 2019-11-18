<template>
    <li @click="deleteMe">
        {{quote.text}}
    </li>
</template>

<script>
import { eventBus } from '../main';

export default {
    props: ['quote'],
    methods: {
        deleteMe() {
            eventBus.$emit('deleteQuote', this.quote.id);
        }
    }
}
</script>

<style scoped>
li {
    display: block;
    border: 1px solid #ccc;
    padding: 15px;
    border-radius: 0 10px 10px 10px;
    margin-bottom: 10px;
}
li:not(:first-child) {
    margin-left: 10px;
}
</style>