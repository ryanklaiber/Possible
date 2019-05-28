# asinow

The goal for this program is to have it compute the way to the most power for humans. The independence, unification, and truth functions are run upon input. The rest of the functions, beginning with creation are run separately when there has been deemed sufficient stored sentences in the hash tables. 

Independence

During the independence function, interrogative sentences are removed, sentences with pronouns that can’t be resolved are removed,
Questions to be handled: 
names ex. Jacob (1) Jacob (2) same name, different people - how to differentiate? 

Unification

Methods of unification: same meaning sentences into one, abbreviations expanded, same exact meaning words resolved. ex. can not and cannot - one must be kept and the other replaced with the one determined better, unnecessary words removed, 

Truth

Truth data is created/updated directly after the independence and unification functions and also after each creation. 

Storage

The sentences must be stored appropriately in hash tables.

Creation

Creation is through logic. Which sentences are created first must be handled correctly due to potential truth value alteration problems (e.g. if a then b, if b then c, if a and b have truth values, then b's truth value would have to be updated from the if a then b statement before b can be used to create/update c). Creation must begin with root sentences, which are sentences whose if component cannot be created from logic (e.g. in the case that there exists an if b then c, then in order to be a root sentence there could be no if a then b). After the first root sentences are used, then the 'b's' of the first root sentences are searched for to check if they are the ifs of the second level root sentences. Second level root sentences do not consider first level root sentences. This pattern continues until no more root sentences of any level can be found. All other data must be part of circular logic (I think - check on in expansions) and cannot be used in the pv calculation. Upon creation at every level, truth values are created or updated.

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

The sorting and showing function has one parameter and looks like this in Common Lisp style: 3(number highest-or-lowest). It sorts all of the power values and in a nice looking data table, returns all of the information for the number of entries to be shown (provided as the argument) with the highest power values. It does this by accessing the power value data for every actor-receiver-if-then and begins building a list of the sentences with the power values. Once the number of entries to be shown has been met in the list, it continues accessing the power values, but now compares that number to the lowest rated entry in the list. If the number is lower, it moves on to the next pv. If the number is higher, it removes the lowest rated entry in the list and adds the new sentence with pv to the list in its appropriate position. If the pv ties one on the list, the sentence should be positioned below the already existing entry. If the sentences pv ties the lowest rated entry, it should be added to the list even if the number of entries would then exceed the number of entries requested as an argument. If that lowest entry gets beat, all entries with that same pv get removed. 

Action Completion 

The action completion function has one parameter and looks like this in Common Lisp style: 4(number). It takes the ordering number assigned to the if-then-can/can’t data in the Sorted and Shown Table as an argument and writes a sentence that that action has been completed. It then sends that data to the BIP with a truth value ratio of 1/1 that cannot be altered and that uses “manager” as it’s source. 

Expansions

Panning for gold functions (removal of no trail mark or low pv data, data connections or data connection trail marks), directed questions from the machine, spoken language translations, physical sensing machines, physical motor performing machines, sense to sense to string conversions, other functions such as 1. future prediction, 2. action effect prediction, 3. problem solving, 4. question answering, 5. undoing data input. source specialization levels varied on multiple computers working together, better pronoun resolution

Notes 

@bip: past tense if-then-can/can’t requires up/downgrading, incorporates time restrictions, part/part-ofs. 
lifting is to be used 1. @expansions: during the undoing input function, 2. @bip: when an action with parts has been completed and the parts were completed earlier and their time has not expired (a prevention for this is required in calculating the pv for the data with parts), 3. @expansions: during the panning for gold function to remove data and trail marks. Is lifting the right term for trail marks? data? power value numbers? up/downgrading? 
@bip: action completion overlapping: for pv’s if a=5, b=4, c=3, d=2, abcd=1 and a, b, and c have been completed; if within time limits, d receives pv of abcd (in this case, pv=1). It should also gain prevention measures as noted in the lifting notes above. 
@bip: some actions can be completed, within the same actions completion time limit. If so, the power value may be constantly altered with passing time. Ex. Action 1 effect is 5 days, action 1 can be done again within action 1 time limit with effects, action 1 done again on day 3 of original action 1 effects, therefore, action 1 effects are felt until day 8. The pv for action 1 within those 5 days of the original action 1 effects is to be constantly increasing.  
PV: if panning for gold is performed, it is important that the actor and receiver remain the same. If the actor/receiver/both are changed after gold panning, important data may have been lost due to the original gold panning that may have been data or data connections in the pv calculations with the new actor/receiver combination. To prevent this and use one set of data with multiple actors/receivers, copies of data tables can be made to be used as actor/receiver specific data tables. 
BIP: would having different hash tables, each with specific POS sentence arrangements make searches faster? 

The same results should be produced given the same code, sources, and actor/receiver combination. 








