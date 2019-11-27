<template>
    <div class="container">
        <div class="row" v-if="submitted">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>Your Data</h4>
                    </div>
                    <div class="panel-body">
                        <p>Full Name: {{ fullName }}</p>
                        <p>Mail: {{ email }}</p>
                        <p>Password: {{ password }}</p>
                        <p>Store in Database?: {{ store }}</p>
                    </div>
                </div>
            </div>
        </div>
        <form v-else>
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>Form</h4>
                        </div>
                        <div class="panel-body">
                            <FullName v-model="fullName" />
                            <label>
                                Email
                                <input type="email" v-model="email">
                            </label>
                            <label>
                                Password
                                <input type="password" v-model="password">
                            </label>
                            <p><strong>Store Data?</strong></p>
                            <label>
                                Yes
                                <input type="radio" v-model="store" value="true">
                            </label>
                            <label>
                                No
                                <input type="radio" v-model="store" value="false">
                            </label>
                            <button @click.prevent="submitForm">Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
    import FullName from './FullName.vue';
    export default {
        data() {
            return {
                fullName: '',
                email: '',
                password: '',
                store: false,
                submitted: false,
            }
        },
        methods: {
            submitForm() {
                this.submitted = true;
            }
        },
        components: {
            FullName
        }
    }
</script>

<style scoped>
label {
    display: block;
}
</style>
