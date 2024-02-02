// By Jennifer Guajardo

VAR loopCount = 0 // This will increment everytime the player goes through the start of loop. Declared zero here, but will incriment by one each reset.
VAR timeUnits = 3  // Used to keep track of time in certain instances. Will gradually decrease. If back to zero, the player will return to the start, after the intro.
VAR ringAmount = 0 // The player will recieve a ring through an event. This will stay consistent through loops, and only increase or decrease if given or giving a ring respectively.
VAR proposalKnowledge = false // Designed to hint to the player that the rings are infintely collectable.
VAR filthUnits = 0 // The protagonist will start the game clean, incrementing through some events. This will effect some interactions in the knots.

VAR passcodeTracker = 0 // This variable will be used to track how many parts of the end-password the player got correct.
VAR deerHeadObtained = false // Simple item check for later. Will be gotten in the Hunter's room.
VAR orbObtained = false // This will judge if the player has the orb, from the wizard, in possession.


// Okay, so the intended solution is to aquire a bunch of items and knowledge to get to the wizard Wuzzuf. These include, the knowledge from the books, which give the password (ALL, MARIO, BAT) for the final door, the ring item, which you can infinitely farm from the Arthur/Garden area, and the accumulation of filth, measured in units, from your menial job.
// Towards the end, I ran into some issues involving the implimentation of a couple areas, such as the library.

A Wizard's Grounghog Day
* [Start Game] // A title and classic "start game" text, because I felt like it.
You are Scarlet, a humble servant from the renowned Ashford castle!
Though you never seen the monarch of the same name, the grand architecture and the casual presence of mighty knights and wizards speaks volumes to the amount of power the royal family has. 
- But truthfully, you feel a little jealous due to being at the bottom of the hierarchy.
* [Continue] // This and the above gather were used for pacing reasons.
- Oh well, nothing you can do, but dream.
* [Sleep] You sleep like a baby, and have visions of extraordinary wealth and beauty only princess could hope to achieve.

However, this respite doesn't last.
An orb, made of pure ruby, comes careening through your window and crashes by your bedside!

- On impact, it lets out a harsh, explosive noise, snatching you from your reverie and letting out a blinding light through the room!

* [Wake Up] You practically jump out of your bed!

- You're tempted to call for help, but the visage of a person, almost ghost-like appears where the orb landed.

* [Examine the Ghost] You look at the ghost in awe. It starts to speak.
// Intro ends here. Time for loop.
-> DayStart

==TimeReset==
TIMES UP! The day is over.
// Scene where the player gets reverted back to the start.
~ timeUnits = 3 //Reset time units.
~ loopCount += 1 // Add one to the loop count.
You find yourself warped back into your room, right after the orb let off its flash.
All of your memories from before, as well as your carried possessions, are intact.

The wizard's message starts again.
-> DayStart

== DayStart ==
"Greetings," the ghost says. "I am Wuzzuf, the lead court wizard. I don't know who is seeing this, but I'm in danger! I've been experimenting with time travel magic. A dangerous field, I know. But don't worry, I sent this orb out as a contingency for accidental time-loops. This day will keep repeating over and over, and anyone caught in the orb's blast will keep their memories for each repetition. I NEED you to come find me, so I can undo the spell! My lab is located below the castle dungeon.

The image of Wuzzuf fades, leaving only a cracked red orb on the ground. Any trace of magic seems to be gone.
//Placeholderposition for more dialogue.
+ [Assess the Situation] You think about what you know so far:
// This is so the player can keep track of how many times they went through. Also, flavor text for the player's first run.
{loopCount != 0: You understand you're in a time-loop. You've went through this day {loopCount} time(s).|You don't understand what on earth just happened, and this "Wuzzuf" fella seems out of the ordinary. Nothing seems to have visibly changed around you, so you turn your mind to what you had planned for today.}
// These branches are supposed to tip the player off that they can farm rings.
// Check if the player would pseudo-logically know of this event to come.
{proposalKnowledge == false: You were supposed to meet Arthur, a knight you're courting, in the garden. He had something he wanted to ask you.| You know Arthur is going to propose to you in the garden.}
{ringAmount > 0: You have {ringAmount} diamond ring(s).|} 
Although, you have your daily duties at the stables that you'd be scolded for neglecting. // World-building to imply depth of routine.
// Filth level will be used in an interaction later. This is an indicator of status.
{filthUnits == 0: You start the day nice and clean!|}
{filthUnits == 1: You are rather dirty from the previous loop, though, and you feel hesitant to do so again.|}
{filthUnits == 2: Your garments are covered in mud and God-knows-what, and you want to hurl. You don't wanna go to the stables again.|}
{filthUnits >= 3: Although not in this loop for long, flies instantly start hovering over your head. You don't think you can get much dirtier. You'd probably SCARE something with your hideous appearence.|}
-> PlayerRoom // So this text won't repeat if player goes back in here.

== PlayerRoom ==
// Check for time
{timeUnits == 0: -> TimeReset}
You are in your bedroom.
What will you do?
+ [Go into the castle hallways.] You go into the castle hallways.
// No time will be spent going from the castlehalls and the player room, and vice versa, mainly for convenience.
-> CastleHalls
+ [Go back to sleep.] You spend the day sleeping, ignoring your responsibilites.
// Easy reset to implement.
-> TimeReset
+ [Go wash up.] You spend some time bathing.
~ timeUnits = timeUnits - 1 // Standard time expendeture.
{filthUnits > 0: The dirt and grime from your working time falls away. |Although, you were already clean, so you didn't need to do it.}
~ filthUnits = 0
-> PlayerRoom
// End of PlayerRoom

== CastleHalls ==
// check for time
{timeUnits == 0: -> TimeReset}
There's lot of branching pathways to various portions of the castle.
Where will you go?
// Downstairs portions.
// Going back to player bedroom.
+ [Go back to your room.] You head back to your bed room.
-> PlayerRoom // Again, no time spent moving to the player bed room is the exception.
// To the Dungeon.
+ [Head to the dungeons.] You make your way to the dungeons.
~ timeUnits = timeUnits - 1 // Standard time expendature.
-> Dungeon
// To the GardenArea.
+ [Head to the gardens.] You make your way to the garden.
~ timeUnits = timeUnits - 1 // Standard time expendature.
-> GardenArea
// To the Stables.
+ [Head to the stables.] You make your way to the stables.
~ timeUnits = timeUnits - 1 // Standard time expendature.
-> Stables
// End of first floor.

// Upstairs portion
// I seperated it for my own sake. Easier to visualize. Idk why.
+ [Head to a higher floor.] You follow a path upstairs.
+ + [Head to a the lower floor.] You go back down stairs.
-> CastleHalls
+ + [Head to the kitchen] You make your way to the kitchen.
~ timeUnits = timeUnits - 1
-> Kitchen
+ + [Head to the hunter's room.] You find the hunter's room.
~ timeUnits = timeUnits - 1 // Standard time expendature.
-> HunterRoom
+ + [Head to the wizard's room.] You go upstairs and find Wuzzuf's bedroom.
~ timeUnits = timeUnits - 1 // Standard time expendature.
-> WizardRoom
+ [Head to the library.] You follow a path to the library.
~ timeUnits = timeUnits - 1 // Standard time expendature.
-> Library
// END OF CASTLEHALLS

== Dungeon ==
// Standard time check
{timeUnits == 0: -> TimeReset}
You find that the dungeons rest in their own isolated tower.
Seperating it from the main castle is a small yard.
The sheer emptiness of the area makes it feel like you're trespassing.
+ [Go to the Tower] You walk to the tower, and hear the barking of a group of dogs!
Before you can even register that they're even there, they charge at you.
    + + [Scare Them Off] You try to scare them off...
    {deerHeadObtained == true && filthUnits >= 3: and, with the help of your newlyfound, grotesque appearence, you do!|-> TorntoShreds} 
    // The player will die if they don't have both the deer head and enough filth.
    //Admittedly, I'm relying on legacy knowledge to make this conditional work. TO DO: EXTRA TESTING!
    With the dogs out of your hair, you finally come across to the dungeon entrance.
    A guard leans by the door, and gives you a harsh look.
    "Go back to the castle, lass," he says.
        -> GuardConvoPart1 // I'm seperating] this into multiple stitchs for simplicity.
    + + [Run Away] You rush out of there, almost tripping in the process!
        -> CastleHalls
+ [Return to the Castle] You go back inside, trusting your uneasy feeling.
-> TimeReset

= TorntoShreds
// The player will die if they don't have both the deer head and enough filth.
but you fail!
You're death upon the guard dogs is slow and painful.
+ [Bleed to Death] Given that you DIED, you couldn't do anything else the rest of the day.
    -> TimeReset

= GuardConvoPart1
// Before a successful bribery.
+ [Bribe Him] You try to bribe the guard.
    {ringAmount >= 1:-> GuardConvoPart2| Unfortunately, you don't have anything to bribe him with.}
    You just get an uncomfortable glare in return.
    "GO. BACK." He commands.
    -> GuardConvoPart1
+ [Go Back]
    You go back to the castle, being rather intimidated by his presence.
    You think you wasted some time.
    -> CastleHalls

= GuardConvoPart2
// Area of successful bribery.
You pull the diamond ring out of your pocket!
"Hmph. On my wage, it'd take a year's worth of work to grab one of these," he says.
"I dunno where you got this, but I don't care. Just go ahead."
The guard takes your ring and steps aside.
~ ringAmount = ringAmount - 1 // Guard takes your ring because you bribed him.
    + [Go Inside] You go into the dungeon.
    -> PasswordTime

= PasswordTime
You travel down the cramped hallways of the dungeon prison, trying to ignore the ramblings of the occupants. Eventually, passing beyond a few dark corners, you do manage to find an odd looking door.
While the lights in here are dim, you can make out several buttons protruding from it. Each of them have their own unique shapes engraved onto it.
You get the feeling that this might be Wuzzuf's lab.
What's the combination?
// You get the combination from the library.
// The 3rd word from the Red Book, the 3th word from the Blue book, and the animal described in the yellow book.
~ passcodeTracker = 0 // This is to reset the passcodeTracker in order to prevent the brute forcing of answers.
+ ALL
    ~ passcodeTracker = passcodeTracker + 1
+ SOME
+ NO
-
+ MARIA
+ MARIO
    ~ passcodeTracker = passcodeTracker + 1
+ MORIA
-
+ BAT
    ~ passcodeTracker = passcodeTracker + 1
+ BEAR
+ BEE
- You do your best to enter the combination.
// This is the equivalent of having all three correct choices selected.
{passcodeTracker == 3: You hear a click!->Lab| The door doesn't budge. As it turns out, you wasted too much time! ->TimeReset}

== Lab == 
You enter the lab, and come face-to-face with Wuzzuf.
"Who are you?" He asks.
{orbObtained == true: "And why do you have a copy of my orb?" |}
+ [Tell Him About the Time Loop] You tell him about the time loop.
    "What!? It got that bad? I need to fix this!
    In a near panic, he does some magic/science stuff with his orb!
    Thankfully, the 
    The time loop is over, and everything is back to normal!
    {orbObtained == true: Sadly, though, Wuzzuf takes his orb back from you.}
        -> END
+ [Steal His Orb]
    // While tiny, I wanted to give a tiny something to complete this paradoxical time loop.
    // Also, the orb is going to be used in the wizard's actual room.
    {orbObtained == true: "You push him over, just for the fun of it!" |You push him over, and steal his orb!}
    ~orbObtained = true // Regardless of what happens, player gets orb.
    Before he can retaliate, time resets!
    -> TimeReset
    

== GardenArea ==
// With the Arthur & ring scene.
~ ringAmount = ringAmount + 1 // Adding one ring.
You got a ring!
Also this took all day.
AUTHOR'S NOTE: Pretend that I wrote a rom-com scene here, ending with a cute proposal.
-> TimeReset

== Stables == 
// Basic function of the Stables ahead.
~ filthUnits = filthUnits + 1 // Adding one filth.
You got some dirt one you!
Also, this took all day.
AUTHOR'S NOTE: Pretend that I wrote a comical scene where Scarlet gets progressively dirty from her work.
-> TimeReset

== HunterRoom ==
// standerd time check
{timeUnits == 0: -> TimeReset}
Grab the Taxodermy Deer Head?
// A simple area where you grab the head.
+ [Yes] You grabbed the deer head!
    You waltz back into the halls with it in tow.
    ~ deerHeadObtained = true
    -> CastleHalls
+ [No] You don't grab the deer head, and go back into the rest of the castle.
    -> CastleHalls

== WizardRoom ==
// Making sure player doesn't waste time, as per usual.
{timeUnits == 0: -> TimeReset}
You make it to Wuzzuf's room.
What do you do?
+ [Read Wuzzuf's Journal] You read Wuzzuf's journal.
    It says, "The 3rd word from the Red Book, the 3th word from the Blue book, and the animal described in the yellow book."
    -> WizardRoom
+ [Poke the TOMB OF ANNIHILATION] You poke the TOMB OF ANNIHILATION!
    // Orb-check for a secret alt ending.
    {orbObtained == true: With the help of the orb's power, you achieve the power of your dreams, and take over the world! -> END| Disappointingly, it does nothing. Perhaps you need a source of power. Orb-shaped, perhaps?}
    - ->WizardRoom
+ [Go Away] You leave the room.
    -> CastleHalls

== Kitchen ==
// THis area is supposed to waste time.
{timeUnits == 0: -> TimeReset}
// This is just a simple thing.
There's just a chef here.
{filthUnits >= 1: He beats you to death for not being clean enough. Since, by definition, time will pass after you die, enough time passes for day to reset! -> TimeReset|There's nothing to do here, though.}
-> CastleHalls

== Library ==
// Making sure that THYME passes, lol.
// Each book takes a time unit to read. I don't care that it's probably tedious, but I don't care. :P
// Screw the player! Who needs good game design anyway?
{timeUnits == 0: -> TimeReset}
You make it to the library.
Read a book?
// Issues with syntax of typing extra stuff in, so I just spouted the answers in each book.
// I tried to make the yellow book contains an ASCII bat I took from: https://www.asciiart.eu/animals/bats
// However, I couldn't make it work without syntax errors.
// I don't know why, but I have to put it in this order to make "No" appear. It won't otherwise. If I don't, the game softlocks.
+ [No] Reading is for nerds anyway.
        -> CastleHalls
+ [Red Book] Reading
        Mario is the answer.
        -> Library
+ [Blue Book] Reading
        ALL is the answer.
        -You put the book down.
        -> Library
+ [Yellow Book] Reading // I don't know why this isn't appearing.
        Bat is part of the combination.
        -You put the book down.
        -> Library
