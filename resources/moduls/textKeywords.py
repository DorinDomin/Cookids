from nltk.stem import PorterStemmer
from nltk.corpus import stopwords

stemmer = PorterStemmer()
sw = stopwords.words('english')


def tokenizer(keyword):
    """ This function gets a meme and cuts it into words in their basic form

    :param keyword: string
    :return: An array of words in their basic form
    """
    return [stemmer.stem(w) for w in keyword.split()]


def line_to_keywords(line):
    """ This function receives a sentence, turns it into an array of words in their basic form and deletes stopwords.

    :param line: a string
    :return: Array of words in their basic form without stopwords.
    """
    # Split the line to array of words in their basic form
    text_tokens = tokenizer(line)
    # Delete stopwords from the array
    tokens_without_sw = [word for word in text_tokens if not word in stopwords.words()]
    return tokens_without_sw
