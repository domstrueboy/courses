<template>
    <div class="container">
        <Progress
            :value="quotesLen"
            :max="maxQuotes"
        />
        <hr>
        <QuoteInput
            :canAddQuotes="canAddQuotes"
            @addQuote="addQuote"
        />
        <hr>
        <QuotesList :quotes="quotes" />
    </div>
</template>

<script>
    import { eventBus } from './main';
    import Progress from './components/Progress.vue';
    import QuoteInput from './components/QuoteInput.vue';
    import QuotesList from './components/QuotesList.vue';

    export default {
        data() {
            return {
                quotes: [],
                maxQuotes: 10,
            }
        },
        computed: {
            quotesLen() {
                return this.quotes.length;
            },
            lastQuoteId() {
                return this.quotes.length > 0 ? this.quotes[this.quotes.length - 1].id + 1 : 1;
            },
            canAddQuotes() {
                return this.quotesLen < 10;
            }
        },
        methods: {
            addQuote(text) {
                this.quotes.push({
                    id: this.lastQuoteId,
                    text,
                })
            },
            deleteQuote(id) {
                const index = this.quotes.findIndex((quote) => quote.id === id);
                this.quotes.splice(index, 1);
            }
        },
        created() {
            eventBus.$on('deleteQuote', this.deleteQuote);
        },
        components: {
            Progress, QuoteInput, QuotesList
        }
    }
</script>

<style>
body {
    padding: 0;
}
.container {
    text-align: center;
}
</style>
