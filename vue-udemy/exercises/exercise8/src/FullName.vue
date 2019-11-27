<template>
    <div>
        <label>
            First Name
            <input v-model="firstName" @input="setFullName">
        </label>
        <label>
            Last Name
            <input v-model="lastName" @input="setFullName">
        </label>
    </div>
</template>

<script>
export default {
    props: ['value'],
    data() {
        return {
            firstName:'',
            lastName:'',
        }
    },
    methods: {
        setFullName() {
            this.$emit('input', this.firstName + ' ' + this.lastName);
        }
    }
}
</script>