pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    pub fn revive(&self) -> Option<Player> {

        if self.health > 0 {
            return None;
        }

        Some (
            Player {
                health: 100,
                mana: if self.level > 9 {
                    Some(100)
                } else {
                    None
                },
                level: self.level,
            }
        )
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {

        if self.mana.is_none() {

            if self.health > mana_cost {
                self.health = self.health - mana_cost;
            } else {
                self.health = 0;
            }

            return 0;
        }

        let mana = self.mana.unwrap();

        if mana < mana_cost {
            return 0;
        }

        self.mana = Some(mana - mana_cost);
        return mana_cost * 2;
    }
}
