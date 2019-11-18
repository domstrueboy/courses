<template>
    <section>
        <h3>Quotes added</h3>
        <p>{{value}} / {{max}}</p>
        <progress :value="value" :max="max"></progress>
    </section>
</template>

<script>
export default {
    props: {
        value: Number,
        max: Number,
    }
}
</script>

<style scoped>
    progress {
        height: 20px;
    }
</style>