<template>
    <form @submit.prevent="addQuote">
        <div>Quote</div>
        <textarea v-model="text"></textarea>
        <button :disabled="!canAddQuotes">Add quote</button>
    </form>
</template>

<script>
export default {
    props: {
        canAddQuotes: Boolean,
    },
    data() {
        return {
            text: ''
        }
    },
    methods: {
        addQuote() {
            this.$emit('addQuote', this.text);
            this.text = '';
        }
    }
}
</script>

<style scoped>
form {
    display: flex;
    flex-direction: column;
    align-items: center;
}
textarea {
    min-width: 400px;
    min-height: 5em;
    margin-bottom: 10px;
}
button:disabled {
    color: #ccc;
}
</style>