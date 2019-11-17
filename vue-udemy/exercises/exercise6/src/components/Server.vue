<template>
    <li
        class="list-group-item"
        
    >
        Server #{{ server.id }} : {{ server.status }}
        <button
            @click="fixServer()"
            :disabled="server.status === 'Normal'"
        >
            Fix it
        </button>
    </li>
</template>

<script>
export default {
    props: ['server'],
    methods: {
        fixServer() {
            this.server.status = 'Normal';
        }
    }
}
</script>

<style scoped>
    button:disabled {
        background: white;
        border: 0;
        color: gray;
    }
</style>