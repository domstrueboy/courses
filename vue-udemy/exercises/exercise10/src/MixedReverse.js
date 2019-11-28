export const MixedReverse = {
    computed: {
        mixedReverse() {
            return this.text.split('').reverse().join('');
        }
    }
}