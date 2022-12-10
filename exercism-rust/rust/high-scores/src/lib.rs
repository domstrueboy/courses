#[derive(Debug)]
pub struct HighScores<'a> {
    scores: &'a[u32],
}

impl<'a> HighScores<'a> {
    pub fn new(scores: &'a[u32]) -> Self {
        Self {
            scores,
        }
    }

    pub fn is_empty(&self) -> bool {
        self.scores.len() == 0 as usize
    }

    pub fn scores(&self) -> &[u32] {
        &self.scores
    }

    pub fn latest(&self) -> Option<u32> {
        if self.is_empty() { return None };

        let last_index = &self.scores.len() - 1;
        Some(self.scores[last_index])
    }

    pub fn personal_best(&self) -> Option<u32> {
        if self.is_empty() { return None };

        let mut max = 0;
        for score in self.scores.iter() {
            if score > &max {
                max = *score;
            }
        }

        Some(max)
    }

    pub fn personal_top_three(&self) -> Vec<u32> {

        let mut best = vec![];
        let mut best_indexes: Vec<usize> = vec![];
        let mut max = 0;
        let mut max_index: usize = 0;

        while best.len() < 3 && best.len() < self.scores.len() {
            for (index, score) in self.scores.iter().enumerate() {
                if best_indexes.iter().any(|&i| i == index) {
                    continue;
                }
                if score > &max {
                    max = *score;
                    max_index = index;
                }
            }
            best.push(max);
            best_indexes.push(max_index);
            max = 0;
            max_index = 0;
        }

        best
    }
}
