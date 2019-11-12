const initialData = {
    yourHealth: 100,
    monstersHealth: 100,
    isStarted: false,
    logs: [],
}

new Vue({
    el: '#app',
    data: {...initialData},
    computed: {
        styles__healthbar1() {
            return { width: this.yourHealth + '%' };
        },
        styles__healthbar2() {
            return { width: this.monstersHealth + '%' };
        },
        showStartButton() {
            return !this.isStarted;
        },
        showControls() {
            return this.isStarted;
        },
        showLogs() {
            return this.isStarted;
        },
    },
    watch: {
        yourHealth() {
            if (this.yourHealth <= 0) {
                alert('You lose!');
                this.refreshData();
            }
        },
        monstersHealth() {
            if (this.monstersHealth <= 0) {
                alert('You win!');
                this.refreshData();
            }
        }
    },
    methods: {
        refreshData() {
            for(let key in initialData) {
                this[key] = initialData[key];
            }
        },
        startNewGame() {
            this.isStarted = true;
        },
        generateNum(num) {
            const to = num || 10;
            return Math.round(Math.random() * to);
        },
        randomMonstersAction() {
            const actions = [this.MonstersAttack, this.MonstersSpecialAttack, this.MonstersHeal];
            const num = this.generateNum(actions.length - 1);
            actions[num]();
        },
        YourAttack() {
            const damage = this.generateNum();
            this.monstersHealth -= damage;
            this.addLog({player: 'Player', action: 'hits', num: damage})
            this.randomMonstersAction();
        },
        YourSpecialAttack() {
            const damage = this.generateNum(30);
            this.monstersHealth -= damage;
            this.addLog({player: 'Player', action: 'hits', num: damage})
            this.randomMonstersAction();
        },
        YourHeal() {
            const heal = this.yourHealth + this.generateNum(50);
            this.yourHealth = (heal < 100) ? heal : 100;
            this.randomMonstersAction();
        },
        MonstersAttack() {
            const damage = this.generateNum();
            this.yourHealth -= damage;
            this.addLog({player: 'Monster', action: 'hits', num: damage})
        },
        MonstersSpecialAttack() {
            const damage = this.generateNum(30);
            this.yourHealth -= damage;
            this.addLog({player: 'Monster', action: 'hits', num: damage})
        },
        MonstersHeal() {
            const heal = this.monstersHealth + this.generateNum(50);
            this.monstersHealth = (heal < 100) ? heal : 100;
        },
        addLog({player, action, num}) {
            this.logs.push({
                player,
                action,
                num,
            })
        }
    },
    mounted() {
        this.refreshData();
    }
});