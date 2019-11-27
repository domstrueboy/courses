<template>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <h1 v-my-listener:click="log">Directives Exercise</h1>
                <!-- Exercise -->
                <!-- Build a Custom Directive which works like v-on (Listen for Events) -->

            </div>
        </div>
    </div>
</template>

<script>
    export default {
        methods: {
            log() {
                console.log('log!');
            }
        },
        directives: {
            'my-listener': {
                bind(el, binding, vnode) {
                    const event = binding.arg;
                    el.addEventListener(event, binding.value);
                },
                unbind(el, binding, vnode) {
                    el.removeEventListener(binding.value);
                }
            }
        }
    }
</script>

<style>
</style>
