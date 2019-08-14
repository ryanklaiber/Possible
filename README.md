# asinow

for full description format (do for every rule): 

rule, then reason if necessary, then example if necessary

The goal for this program is to have it compute the way to the most power for humans. Basic input processing functions are run upon input. The rest of the functions, beginning with creation, are run separately when there has been deemed sufficient stored sentences in the hash tables. 

Basic Input Processing (Runs on Input)

1. (Purpose: Independence) Interrogative sentences are removed. 
-Interrogative sentences don't provide information that can be utilized in this algorithm. If the questions were to be answered    in following sentences, then information useful for this algorithm could be utilized, but for similar reasons as pronoun resolution, matching interrogative sentences with their answers has too low of an accuracy for the purposes of this algorithm. 
2. (Purpose: Independence) Sentences with pronouns that can’t be resolved are removed. 
-Current pronoun resolution is not 100% accurate and 100% accuracy is highly preferable for this algorithm. When pronoun resolution becomes 100% accuratie, then it can be incorporated into this algorithm.  
3-6. (Purpose: Unification) Different sentences that carry the same information are conformed into the same sentence.
-Having different sentences that carry the same information being conformed into the same sentence is very important for many aspects of this algorithm including truth value calculating, creation, and power value calculating.  
3. (Purpose: Unification) Same meaning sentences are conformed into one.
-Ex. 
4. (Purpose: Unification) Abbreviations with multiple expansions are expanded.
-Ex. 'GM' becomes 'general manager' or 'General Motors'. The way the algorithm will figure out which expansion the abbreviation should expand to is by searching the source for all of the possible expansions. If one of the expansions can be found and not the other(s), then the expansion found will be the one expanded to. If none of the expansions are found, then the sentences will not currently be utilized (see algorithm expansion 'Abbreviation expansion determining for abbreviations with multiple expansions not found in the source'). If more than one expansion is found, an additional algorithm expansion will be required for how to handle this. 
5. (Purpose: Unification) Same exact meaning words resolved. Ex. can not and cannot - one must be kept and the other replaced with the one determined to be preferred.
6. (Purpose: Unification) Unnecessary words are removed.
-Ex. 'Great white sharks can really swim fast' becomes 'Great white sharks can swim fast'. 
7. (Purpose: Independence) Multiple same name proper nouns are to be renamed including a number. Ex. Ryan Klaiber (1), Ryan Klaiber (2)... If there are no stored same name proper nouns discovered during the independence function, the proper noun is not renamed. If there is at least one stored same name proper noun, sentences from the current input source including the proper noun in question must be compared to sentences previously stored from other sources that include the proper noun in question. If a sufficiently deemed percent of the sentences are contradictory, the proper nouns are not a match. If no matches are found, the proper noun is renamed with the current highest number of the proper noun + 1.  
8. Contradictory present tense sentences must be given some sort of preference based on source date. 
9. The sentences must be stored appropriately in hash tables. Truth data is created/updated during storage. 

Creation

Creation is through logic. Which sentences are created first must be handled correctly due to potential truth value alteration problems (e.g. if a then b, if b then c, if a and b have truth values, then b's truth value would have to be updated from the if a then b statement before b can be used to create/update c). Creation must begin with root sentences, which are sentences whose if component cannot be created from logic (e.g. in the case that there exists an if b then c, then in order to be a root sentence there could be no if a then b). After the first root sentences are used, then the 'b's' of the first root sentences are searched for to check if they are the ifs of the second level root sentences. Second level root sentences do not consider first level root sentences. This pattern continues until no more root sentences of any level can be found. All other data must be part of circular logic (I think - check on in expansions) and cannot be used in the pv calculation. Upon creation at every level, truth values are created or updated. When checking 'if a then b' by checking for 'a', 'a is b' and 'b is a' sentences must be checked. For all 'vara is varb' should be reversed with same truth value to 'varb is vara' if vara and varb are both proper nouns. If 'a is b' exists, then all sentences about b are also true about a (with their respective truth values). This includes any sentences where b is found in any part of the sentence.  

For if abcd then e: if a, b, and c have been completed within their respective time limits, a new sentence if created. If d then e replaces if abcd then e. The truth values for the completions of a, b, and c, as well as the if abcd then e truth value are multiplied together to get the if d then e truth value. 
If at any time during creation there exists multiple sentences that are the same, but have different truth values, the one with the higher truth value is the only one kept. Ex: 'if a then b' (tv = 50%) and 'if a then b' (tv = 40%). The second would be erased. 

The time used for time involving creations is to be the time at the start of the creation function.
*Fading into oblivion expansion to be used during creation

Power Value (pv) Calculating

The power value calculating function has two parameters and looks like this in Common Lisp style: 2(actor)(receiver). 
Utilizes backwards receiver logic and forward actor logic in separate hash tables. Includes a separate hash table for if-thens without actor or receiver, a separate hash table for all if-thens, and a separate hash table for complete actor/receiver chains with power values included. The function begins by searching for if-then-can/can’t data that matches the actor and receiver. For example, if the actor is Ryan Klaiber and the receiver is Ryan Klaiber, then the function searches for: If Ryan Klaiber … then Ryan Klaiber can/can’t, etc. The power value calculating function uses 1. basic searches and 2. forward and backward logic and searches to search for matching data at all stages of the power value calculation. The stages of the power value calculation are as follows: 

1. Search: if actors a (and/ors) then receivers can/can’t ____ (and/ors)
2. If there is no match for #1, return null. 
3. If there is a match for #1, search: actors can a (and/ors)
4. If there is a match for #3, calculate a PV for #1. 
5. If there is no match for #3, search: if actors z (and/ors) then actors can a (and/ors). 
6. If there is no match for #5, return null.
7. If there is a match for #5, search: actors can z (and/ors). 
8. If there is a match for #7, combine with a as ordered procedure and calculate PV for #1.  
9. If there is no match for # 7, loop #5 and then #7 until both are found. Replace a position variables with z position variables and search for new z position variable data during each loop. 
10. For #5’s and similars in loops, search: if actors can a (and/ors) then receivers can/can’t ___ (and/ors). 
11. For #7’s and similars in loops, search: if actors z (and/ors) then receivers can/can’t ___ (and/ors). 
12. Search: if receivers can/cant’s (from #1, #10, and #11) then receivers can/can’t ___ (and/ors). 
13. Delete overlaps. 
14. Count # of cans. 
15. Subtract # of can’ts.
(Expansion)*Leave trail marks for every search found and for every sentence used in a manipulative search. 
 
Sorting and Showing

The sorting and showing function has one parameter and looks like this in Common Lisp style: 3(number highest-or-lowest). It sorts all of the power values and in a nice looking data table, returns all of the information for the number of entries to be shown (provided as the argument) with the highest power values. It does this by accessing the power value data for every actor-receiver-if-then and begins building a list of the sentences with the power values. Once the number of entries to be shown has been met in the list, it continues accessing the power values of other actor-receiver-if-then sentences and adds them to the list if they are higher than any already on the list. If the number is higher, it removes the lowest rated entry in the list and adds the new sentence with pv to the list in its appropriate position. If the pv ties one on the list, the sentence should be positioned below or above the already existing entry in a newly created or updated subcategory of that pv rating, with all other equally rated entries in the same subcategory. If the lowest pv rating gets beat and has multiple entries in a subcategory, all entries with that same pv get removed. 

*The same results should be produced given the same code, sources, and actor/receiver combination. 

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












