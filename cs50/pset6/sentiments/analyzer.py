from nltk.tokenize import TweetTokenizer
tknzr = TweetTokenizer()

class Analyzer():
    """Implements sentiment analysis."""

    def __init__(self, positives, negatives):
        """Initialize Analyzer."""
        
        def load(f):
            
            file = open(f, 'r')

            words = [line.strip() for line in file if line[0] != ";" and line[0] != "\n"]
    
            file.close()
            
            return words
            
            
        self.positiveWords = load(positives)
        self.negativeWords = load(negatives)
        
    def analyze(self, text):
        """Analyze text for sentiment, returning its score."""

        text = tknzr.tokenize(text)

        score = 0
        
        for word in text:
            if self.positiveWords.count(word.lower()) > 0:
                score += 1
            elif self.negativeWords.count(word.lower()) > 0:
                score -= 1
        
        return score
