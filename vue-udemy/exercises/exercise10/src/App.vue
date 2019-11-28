<template>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <h1>Filters & Mixins</h1>
                <p>{{ text }}</p>
                <ol>
                    <!-- Exercise 1) -->
                    <!-- Build a local Filter which reverses the Text it is applied on -->
                    <li>{{ text | reverseIt }}</li>
                    <!-- Exercise 2 -->
                    <!-- Build a global Filter which counts the length of a word and it appends it -->
                    <!-- Like this: "Test" => Gets Filtered to => "Test (4)" -->
                    <li>{{ text | display-length }}</li>
                    <!-- Exercise 3 -->
                    <!-- Do the same as in Exercises 1 & 2, now with Computed Properties -->
                    <li>{{ reversedText }} | {{ textWithLength }}</li>
                    <!-- Exercise 4 -->
                    <!-- Share the Computed Property rebuilding Exercise 2 via a Mixin -->
                    <li>{{ mixedReverse }}</li>  
                </ol>
                
            </div>
        </div>
    </div>
</template>

<script>
    import { MixedReverse } from './MixedReverse';
    export default {
        data() {
            return {
                text: 'Hello, my dear friend!'
            }
        },
        filters: {
            reverseIt(value) {
                return value.split('').reverse().join('');
            }
        },
        computed: {
            reversedText() {
                return this.text.split('').reverse().join('');
            },
            textWithLength() {
                return `${this.text} (${this.text.length})`;
            }
        },
        mixins: [MixedReverse]
    }
</script>

<style>
</style>
