<template>
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <br>
                <button @click="currentComponent = 'appBlue'" class="btn btn-primary">Load Blue Template</button>
                <button @click="currentComponent = 'appGreen'" class="btn btn-success">Load Green Template</button>
                <button @click="currentComponent = 'appRed'" class="btn btn-danger">Load Red Template</button>
                <hr>
                <component :is="currentComponent">
                    <template v-slot:title>
                        <h4>I'm a colored one</h4>
                    </template>
                    <p>Look at me!</p>
                </component>
            </div>
        </div>
    </div>
</template>

<script>
    import Blue from './components/Blue.vue';
    import Green from './components/Green.vue';
    import Red from './components/Red.vue';

    export default {
        data() {
            return {
                currentComponent: Blue
            }
        },
        components: {
            appBlue: Blue,
            appGreen: Green,
            appRed: Red
        }
    }
</script>

<style>
</style>
