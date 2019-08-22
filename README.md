# asinow

The goal for this program is to have it compute the way to the most power for humans. Basic input processing (BIP) functions are run upon input. The rest of the functions (creation, power value calculating, and sorting) are run separately when there has been deemed sufficient stored sentences in the hash tables. Sources to be input must be non-fiction literature.

-The goal of humans, beknownst to them or not, is to get more power. This may not always be obvious because often times short term powers are rejected in favor of longer term powers. All living creatures have evolved that way. Power is one's abilities, whether or not they use those abilities is up to each individual. Each individual perceives power differently to some extent. As it is our primary evolved goal to obtain more power, because power helps us survive and reproduce, all of our emotions are related to us getting what we want, which is what each individual percieves as more power. The emotions are as follows: 

1. We love what we want 
2. We are happy when we get what we want 
3. We are excited when we think we will get what we want
4. We are depressed when we think we wont get what we want
5. We are sad when we don’t get what we want
6. We are angry when the path to getting what we want is increased in difficulty
7. We are afraid of not getting what we want
8. What is funny is when someone thinks something that is not true


Basic Input Processing (Runs on Input)


Terms:
1. (Purpose: Independence) Making sentences independent in this algorithm means making them so that the information held within them can be fully understood without needing the information within any other sentences. 

2. (Purpose: Unification) Unificaiton in this algorithm is taking different sentences that carry the same information and conforming them into the same sentence. Doing this is beneficial to truth value calculating, creation, and power value calculating. 

Steps: 
1. (Purpose: Lisp Formatting) Every sentence needs to be turned into a list of words.

1a. As a string, periods and exclamation points and their following space need to be replaced with only a period. Ex. 'Dogs can bark! They really can.' becomes 'Dogs can bark.They really can.' 

1b. Question marks and their following spaces need to be replaced with a question mark followed by a period. Ex.\
'Can dogs bark? They really can.' becomes 'Can dogs bark?.They really can.' This will allow for their later removal.  

1c. Periods need to be replaced with a closed parentheses followed an open parentheses. Ex. 'Dogs can bark.They really can.' becomes 'Dogs can bark)(They really can)('

1d. Two open parentheses need to be added to the beginning of the source, the open parentheses at the end of the source needs to be removed and a closed parentheses added in it's place, and the string needs to be completely converted into a list. Ex. 'Dogs can bark)(They really can)(' becomes ((Dogs can bark)(They really can)).  

2. (Purpose: Independence) Interrogative sentences are removed. 

-Interrogative sentences don't provide information that can be utilized in this algorithm. If the questions were to be answered    in following sentences, then information useful for this algorithm could be utilized, but for similar reasons as pronoun resolution, matching interrogative sentences with their answers has too low of an accuracy for the purposes of this algorithm. 

2a. The last character of every list will be checked for a question mark character. If one is found, that list will be removed. Ex. ((Dogs bark)(Do they bark?)(They do bark)) becomes ((Dogs bark)(They do bark)).

3. (Purpose: Independence) Sentences with pronouns that can’t be resolved are removed. 

-Pronoun resolution is the process of matching a pronoun with the noun it is subsituting for. Current pronoun resolution is not 100% accurate and 100% accuracy is highly preferable for this algorithm. When pronoun resolution becomes 100% accurate, then it can be incorporated into this algorithm.  

3a. Every list will be checked for any pronouns. If any pronoun is found within the list, the list will be removed. Ex. ((Dogs bark)(They do bark)) becomes ((Dogs bark)).

4. (Purpose: Unification) Same meaning sentences with different sentence constuctions are conformed into the same sentence. 
-Part of this includes all passive voice sentences being converted into active voice sentences. Ex. (Bones can be chewed on by dogs) becomes (Dogs can chew on bones). 

5. (Purpose: Unification) Abbreviations are expanded.

-Abbreviations need to be either expanded or expansions need to be abbreviated for unification purposes. Abbreviations in this algorithm will be expanded due to the presence of abbreviations with multiple different expansions. Ex. 'GM' can expand to 'general manager' or 'General Motors'. Abbreviations mostly include acronyms, contractions, initial abbreviations, and syllabic abbreviations. Without unification of abbreviations (NASA has spaceships) and (If The National Aeronautics and Space Administration has spaceships, then people can go into space) would not conclude that (people can go into space) during creation. Additionally, if the two lists (NASA has spaceships) and (The National Aeronautics and Space Administration) were stored, they would each have truth values of 1/1 instead of 2/2 for both if the lists were unified. 

5a. Abbreviations with only one expansion are expanded.  

5b. Abbreviations with multiple expansions are expanded. An example of an abbreviation with multipole expansions is 'GM' which can expand to 'general manager' or 'General Motors'. The way the algorithm will figure out which expansion the abbreviation should expand to is by searching the source for all of the possible expansions. If one of the expansions can be found and not the other(s), then the expansion found will be the one expanded to. If more than one expansion is found, an additional algorithm expansion will be required for how to handle this. If none of the expansions are found, then the sentences will not currently be utilized (see algorithm 'Abbreviation expansion determining for abbreviations with multiple expansions not found in the source').

6. (Purpose: Unification) Same meaning words, word-phrase combinations (ex. 'can' and 'is able to'), and phrases are unified. 
Only one word or phrase out of a set of same meaning words and phrases is be kept and the others are replaced with that one.

6a. (Same meaning proper nouns unified) In sources that sometimes use full names and sometimes partial names (Ex. Trump, Donald Trump, Donald J Trump), the fullest name should be the one to replace the others. 

6b. (Same meaning proper nouns unified) Name titles such as Mr., Mrs., Dr., etc. need to be dropped and how to match names with titles to names without titles is yet to be determined. The titles cannot just be dropped without an additional rule to match them with another proper noun. 

6c. (Same meaning proper nouns unified) If sentences exist in the source that 'x is y' and 'x' and 'y' are both proper nouns, then a tally should be started of the frequency each proper noun is used within the source. The tally should be made on a separate proper nouns tally list. If there is already a tally on the proper nouns tally list of either of these proper nouns that have already been stored in the hash table, the tally from the source should be added to the tally on the proper nouns tally list. The proper noun with the higher use frequency should be replace the other. If the tally of one proper noun should ever overtake the tally of another, all proper nouns with the lower tally in the hash table should be replaced by the proper noun with the higher tally. All sentences 'x is y' should be kept in a separate lists - one list for if 'x' and 'y' are both proper nouns and another list for if 'y' is not a proper noun.     

7. (Purpose: Unification) Unnecessary words are removed.
-Ex. (Great white sharks can really swim fast) becomes (Great white sharks can swim fast). 

8. (Purpose: Independence) Multiple same name proper nouns are to be renamed including a number (Ex. Ryan Klaiber (1), Ryan Klaiber (2)) 

8a. Every sentence with a proper noun is pushed to a separate list after being formatted in previous steps (steps 1-7). This list will be referred to as the proper nouns sentence list.

8b. (proper noun contradictions within the source) Matches and contradictions for each sentence in the proper nouns sentence list are searched for, searching within the proper nouns sentence list itself. If a sufficiently deemed percent of the sentences are contradictory, the proper nouns are renamed. Ex. Ryan Klaiber (1), Ryan Klaiber (2). An unlimited number of different proper noun names can be given within a single source. All of the sentences that include the same proper noun will make up a proper noun group. 

8c. (proper noun group matches within the hash table) Matches and contradictions for each proper noun group from the proper nouns sentence list are searched for, searching within the hash table of sentences previously fully formatted and stored. Each proper noun group will take the name of any other previosly stored proper noun group if a sufficiently deemed percent of the sentences within that stored proper noun group are matching.

8d. (proper noun group contradictions within the hash table) If a sufficiently deemed percent of source proper noun group sentences are contradictory to all other stored proper noun group sentences, the proper nouns in that source proper noun group are renamed with the current highest number of the proper noun + 1. 

8e. (no contradictions within the source and hash table and no matches within the hash table) If no contradictions are found while searching within the proper nouns sentence list itself, and no matches or contradictions are found while searching within the hash table of sentences previously fully formatted and stored, the proper noun is not renamed. 

8f. At the end of step 8, all sentences in the proper nouns sentence list are pushed back to the source BIP list. 

9. The sentences must be stored appropriately in hash tables. Truth data is created/updated during storage. 

-The subject is the hash entry key and the predicate is the entry. Source date/time, and other provided date/time provided is stored at the end of the sentence as a separate list along with truth values. This separate list is to exist at the end of all stored sentences and the order of all values in this separate list is to be the same for all stored sentences. 1 is added to any matching entry truth value numerator, contradictory entry truth value denominator. If the entry is unique, a truth value of 1/1 is created. A unique entry input on 8/19/2019 as 'Yesterday after lunch WHHS students were excited about studying.' would have an entry key as (Westchester Hebrew High School students) and a possible entry order as ((were excited about studying)(1/1 8.19.2019 8.18.2019 (after lunch))). As variables, the entry key would be (subject) and the entry might be ((predicate)(truth-value source-date/time sentence-event-date/time (relative-date/time))). 


Creation


1. Creation is through logic. Which sentences are created first must be handled correctly due to potential truth value alteration problems. Ex. If the sentences 'if a then b' and 'if b then c' exist, and if 'a' and 'b' have truth values, then 'b's' truth value would have to be updated from the 'if a then b' statement before b can be used to create/update c). Creation must begin with root sentences, which are sentences whose 'if' component cannot be created from logic. Ex. In the case that there exists an 'if b then c', then in order to be a root sentence there could be no 'if a then b'). After the first root sentences are used, then the 'b's' of the first root sentences are searched for to check if they are the 'ifs' of the second level root sentences. Second level root sentences do not consider first level root sentences. This pattern continues until no more root sentences of any level can be found. All other data must be part of circular logic (I think - check on in expansions) and cannot be used in the pv calculation. Upon creation at every level, truth values are created or updated. 

2. When checking 'if a (is, can, or has) b then c' by checking for the truth of 'a'?, if there exists a sentence in which the subject 'a' is in set 'x' and 'x' is not a proper noun, then the truth of 'if a (is, can, or has) b' needs to also be checked for by replacing the subject 'a' with 'x'. Ex. if the sentences exist 'If dachsunds can bark then dachsunds can sing', since dachsunds are dogs, the truth of 'dogs can bark' should also be checked and the one with the higher truth value should be used. Lower level root sentences need to be calculated first as with all logic (see creation 1). The list of sentences in which 'x is y' and 'y' is not a proper noun should be checked in this step (see BIP 6c.). 

3. For 'if abcd then e', if 'a', 'b', and 'c' are true, then 'if d then e' replaces if 'abcd then e'. The truth values for 'a', 'b', 'c', and 'if abcd then e' are multiplied together to get the if 'd then e' truth value. This assumes that there are no lower level root sentences at this point in creation that could create 'a', 'b', or 'c' (see creation rule 1).  
If at any time during creation there exists multiple sentences that are the same, but have different truth values, the one with the higher truth value is the only one kept. Ex: 'if a then b' (tv = 50%) and 'if a then b' (tv = 40%). The second would be erased. 

The time used for time involving creations is to be the time at the start of the creation function.

*Fading into oblivion expansion to be used during creation (See expansions below for more information about fading into oblivion)


Power Value (pv) Calculating


The power value calculating function has two parameters and looks like this in Common Lisp style: pv (actor receiver). 

Steps
1. Search: if actors a (and/ors) then receivers can/can’t ____ (and/ors)
2. If there is no match for #1, return null. 
3. If there is a match for #1, push all matches to a pv list
4. For the first list in the pv list, search: actors can a (and/ors)
5. If there is a match for #4, calculate a PV for that list. 
6. If there is no match for #5, search: if actors z (and/ors) then actors can a (and/ors). 
7. If there is no match for #6, return null.
8. If there is a match for #6, search: actors can z (and/ors). 
9. If there is a match for #8, combine with a as ordered procedure and calculate PV for that list.  
10. If there is no match for # 8, loop #6 and then #8 until both are found. Replace a position variables with z position variables and search for new z position variable data during each loop. 
11. For #6’s and similars in loops, search: if actors can a (and/ors) then receivers can/can’t ___ (and/ors). 
12. For #8’s and similars in loops, search: if actors z (and/ors) then receivers can/can’t ___ (and/ors). 
13. Search: if receivers can/cant’s (from #1, #11, and #12) then receivers can/can’t ___ (and/ors). 
14. Delete overlaps. 
15. Count # of cans. 
16. Subtract # of can’ts.
17. Push the pv calculated for that list to that list in the pv list. 
18. Loop #'s 4-17 until the end of the pv list. 


(Expansion)*Leave trail marks for every search found and for every sentence used in a manipulative search. 


Sorting 

Sorting has two parameters and looks like this in Common Lisp style: sort(number from-highest-or-lowest)

1. Using the pv list non-destructively, sort the list in order of highest or lowest pv values (depending on which argument is used in the 'from-highest-or-lowest' parameter).
2. Print the lists with the first 'number' (specified as the argument to the 'number parameter') pv's that are different from each other, beginning from the start of the list sorted in step #1. 


Expansions


1. Panning for gold functions (removal of sentences with no trail marks). If panning for gold is performed, it is important that the actor and receiver remain the same. If the actor/receiver/both are changed after gold panning, important data may have been lost due to the original gold panning that may have been able to be used in the pv calculations with the new actor/receiver combination. To prevent this and use one set of data with multiple actors/receivers, copies of data tables can be made to be used as actor/receiver specific data tables. 
2. internet connectivity (allows the program to access the internet to obtain input data)
3. future prediction (begins with searching all if-will sentences and checking if the if is true, proceeds similar to creation using root if-will sentences (maybe - not totally thought through).
4. action effect prediction (based on one if, lists the then and all then statements of branching if-then sentences - if the then is a part-of a further branches if, it checks for truth of all  other parts before listing the then)
5. problem solving (begins with using the problem as a then statement and searching for ifs that will produce it, then working backward...)
6. question answering (utilizes sentences stored after creation to answer questions. Each type of question requires different functions)
7. Pronouns replaced with proper nouns during the independence function (able to be done when pronoun resolution capabilities become close to 100%)
8. hierarchical computation (running the program in separate locations with partially or completely separate input data - allows for certain locations to utilize full computing power for specialized sets of data, whereas other locations can use the results of the specialized locations as input data as less specialized locations, similar to how scientists gather information and share it, allowing decision makers to make better decisions).
9. Fading into oblivion - when the truth value of a sentence reaches a predetermined very small number, the sentence with that truth value attached to it is erased so that logic utilizing it does not proceed. 
10. Abbreviation expansion determining for abbreviations with multiple expansions not found in the source - can determine which abbreviation expansion is appropriate by searching for key words highly related to one expansion, but not the other(s). 

*The same results should be produced given the same code, sources, and actor/receiver combination. 











