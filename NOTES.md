# MISSION STRUCTURE
Mission -> Encounter -> Card

Compared to Darkest Dungeon, a Mission :: Dungeon, an Encounter :: Room, and a Card :: Enemy-ish

# MVP-1 GAMEPLAY
Show the basic info on screen.
Have a `Fight` button.
    This "rolls" the dice to decide if there was a win or not.
Continue fighting until the mission is won or lost.

## TODO
GameState singleton.
    Use this on the GameOver scene to know if the game was a win or a loss

# MVP-2 BASIC COMBAT ENGINE -- Cards have different power levels. 
<!-- Skip this, because combat will not look like this at all. -->
Cards have a number of soldiers on them, called X
Player has a number of soldiers, called P
roll 1dX and 1dP. 
The loser loses 1dX - 1dP number of soldiers
Roll until a winner is determined.
    Player continues to click roll here
Create a few more cards

Stretch goal: winning an encounter allows the player to gain 1dM soldiers back, where M is the number of casualties sustained.

# MVP-3 BASIC CAMPAIGN PROGRESS -- Choose one mission, or another.
Give the player choice in which mission to take.
Have a start button
Have a few more different cards and encounters to make new missions

# MVP-4 BASIC MISSION PROGRESS -- Choose one encounter, or another.
Give player choice in which encounters to take.

# FUTURE MVPS
Procgen within Missions
    A Mission may be pre-set to have 4 encounters: MainRoom, NextRoom, OtherRoom and LastRoom,
    but the Cards within the Encounter can be different. 
        Example: MainRoom has a "deck" of 15 cards, but the Encounter will pick 4 at random. 
    Some Missions may have 4 encounters, but with one room being chosen from a set of rooms. 
        Example: MainRoom, ControlRoom, CargoRoom/OtherRoom/LeadershipRoom, ReactorRoom
Narrative encounters
    Example: 1) Breach doors, 2) Cover fire, 3) Advance into cover, 4) Return fire \\Should the narrative be from the POV of the aliens, or the marines?
Convert to a Darkest Dungeon layout for encounters in a mission.
    Branching encounters will the ability to backtrack
    Some rooms will only open after conditions are met
        Reactor Room will only open once the user finds and clears the Control Room
Preparation
    Before starting a mission, the user has "skills" theye can use.
        A Scout skill to see the layout of the mission (where specific rooms are, or what rooms may be present)
        A Recon skill to know what cards are prsent in a specic encounter
        A Sabotage skill to reduce an enemy card
        A Infiltrate skill to ... increase loot?
Fleshed out combat engine
    Have more components than just Soldier vs Soldier
        CryingSuns had those icons. 
    More options for the player:
        Have separate teams that the player can deploy to certain encounters.
Loot

## ICONS MIND DUMP
Crying Suns has icons. A 3x3 grid.
When a "card" is drawn, the success depends on the icons shown. If the player has all the icons, then they win! Otherwise, they take damage OR simply don't get loot.

My game can do the same thing. 
    __Version 1__
    Simply copy Crying Suns. If my icons == card icons, I win. Otherwise, I lose.
    ...
    __Version N__
    Units gain icons by training. These icons remain for as long as the unit is doing that training.
    As that icon is used during battle, the unit gains mastery in it. Once it is mastered, it no longer needs to be trained.
        Example: Basic Training will assign a Gun icon. Medical Training will assign a Cross icon.
    ...see training mind dump.

### TRAINING MIND DUMP -- Training grants icons
__Units__
1) Combat
    Increases icon mastery
        >> Master means it takes less time to Drill an icon. 
            Maybe a soldier has 4 slots, and when mastery is achieved, they get 5?
            Maybe a soldier has 10 hours a day, and a Drill will take 10% less time for each mastery level? 
2) Drills
    Grants icons temporarily
    Increases icon mastery _slowly_
3) Study
    Grants access to new/improved icons
    Grants access to new/improved Drills

The general flow will be: 
    The soldier is assigned Drills. These grant icons temporarily
    The soldier goes into Combat. These icons help the unit fight and surive. Doing so increases icon mastery.
    The soldier masters an icon, and no longer needs to Drills them. 
        The soldier may Drill other icons.
        The soldier may Study to grant access to new icons and Drills.

__Departments__
These are non-combat Units that perform meta-mission tasks like research, discovery, UFO takedown.
Example: SIGINT, the Department that finds UFOs.
    Their daily tasks will be SIGINT (others exist, but this will be the primary one)
    This will grant them temporary icons. Department icons are always temporary.
    In order to gain more icons, the Department needs more staff.
        A Recruitment task will increase the staff of the Department, allowing more icons.
    In order to gain new icons, the Department needs to Research.

#### JOINT OPERATIONS -- Units and Departments need to be able to work together.
<!-- I don't know how this will look. Maybe this will be for the sequel lol. -->

## COMBAT MIND DUMP
How will combat look?
The player will have one or many soldiers with icons.
The "enemy" is really a situation: Soldiers breaching a room and taking fire. Soldiers engaging in a fire-fight. 
    I want to avoid directly modeling combat. That's the whole point of icons. 
`Should each individual soldier have an icon, or only the specialist? aka the entire team?`

I want the player to manage teams. A group dedicatd to breaching alien hulls. A group dedicated to looting. A group dedicated to capturing live specimen. A group dedicated to combat. A group dedicated to interactiong with the UFO systems live.
    How are these groups managed? Are they moved like a piece along a board -- this would lead to the player forces splitting up and whatnot. Are they "applied" abstractly? That seems odd.

__Solution A__ \\This kind of looks a lot like DD and CS blended.
The User has many Units. (A Unit in this context is a group of soldiers).
<!-- I could make use of the Lancer system, where if HP == 0 >>> roll to lose soldiers; more soldiers lost, more soldiers you risk losing. Losing 2/5ths of the soldiers would reduce the XP of the team by 2/5ths. -->
The User moves their Units around the Map, like in Darkest Dungeons.
    Maybe it's turn based, and each turn the enemy cards improve.
    If the player has a RECON team, they can perform reconaissance here. 
The User chooses a Unit to enter a Room, leading to an Encounter.
    The Encounter is resolved between that Unit and the enemy forces.
    <!-- The enemy forces are abstract and don't move around. Maybe there are ambushes. This could be done by adding cards to an encounter. -->
    An Encounter is resolved like in Crying Suns: it is a series of many Cards. Each time the Unit matches the icons, they beat that card.
        Example: Breaching the locked doors to a room:
            1. Setting explosives
            2. Taking cover
            3. Igniting explosives
        Example: Entering a breeched room:
            1. Toss smoke bomb
            2. Provide cover fire
            3. Advance into cover
            4. Return fire
            5. Engage in firefight
        Example: Engage enemy
            1. Supress 
            <NARRATIVE_STUFF> The cards could change depending on if it's won or loss.
                Example: If the User has all the right icons for a Breach card, then they take the aliens by surprise.
                    Breach Card has three icons: [Explosives], [SupressingFire], [Rush].
                        If 3/3 icons: success, and the aliens are surprised 
                            BONUS: add a "surprised" card, where the User gets some free kills
                        If 2/3 icons: success, but the aliens are not suprised (nothing changes)
                            NO CHANGE
                        If 1/3 icons: success, but it's sloppy (the aliens upgrade one card)
                            PENALTY: add a "expected" card, a many-icon card
                        If 0/3 icons: failure, cannot enter the room.
                            The User has to find another way in.
The User uses the Units to do things in that Room.
    The Medical Unit and heal the Unit that resolved the Encounter.
    A Science Unit could study the room.
    An Engineering Unit could scrap the room.
    A Tech Unit could interact with the room.
    <!-- When the User is in a Room, they can pick what to do. If the Unit has the icons for it, they win. So a combat-damaged Unit will have damage icons added to them. Searching a room for loot with have looting icons. -->
The end the Mission, the User resolves all the Encounters or abandons the Mission.
Loot is awarded.
Between Missions, new Drills/Study are assigned to crew.
    Study is essentially research too. A unit will spend time Studying a looted item, for example. (This takes away from the drilling)

__Turn Structure__
(Turn based) During a Mission ("Battlescape"), the User chooses how each Unit will act. Be it Move, Engage, Recon, etc. 
(Turn based) During the "Geoscape", the user assigns Units to do whatever. Drills, but also SIGINT (to monitor for UFOs, another cool uppercase abbrev (to monitor for bases). Perhaps these non-combat operations can be carried out by Department instead of Units.

__Progress__
A Unit will do Combat, Drills and Study to progress.
A Department will do Tasks, conduct Research and Recruit to progress.


# MISC NOTES
\\many of thee departments could be a single entity performing these tasks.
SIGINT is first contact mission gen
SATCOM generates more info about the mission
<!-- What do these departments do while they are not doing mission-specific things? Drills/Study? -->
BLACKOPS gets up close to the mission \\want better name
NAVCOM takes down UFOs
    may contain Units?
XCOM is the soldier units that conduct the missions

Budget is MANHOURS, not money. Things cost MANHOURS, and can vary.
Departments recruit to have more personnel, increasing MANHOURS
A mission may be prepared for in 4 ways:
    A list of icons contain ALL present icons, and some that are not present.
    An icon is NOT present.
    How many icons are present in TOTAL.
    How many icons can be expected ON AVERAGE on a card.

Each turn is one day.

Combat Units perform Drills to grant temp icons.
The first time a Drill is conducted, the Unit gains +1 of that icon. 
    Icons are not spent, but some encounter cards will have many icons to win it. 

When a mission is spawned, it is an Easy mission.
Each time a day is spent preparing for the mission, it gets harder and harder.
    Hard mission with known variables vs unknown mission with unknown variables.

Icons: To force the user to pick which situations to prepare for, there will be many versions of icons. Like the "shoot at alien" icon will have a version for each race.
    Some cards will be generic like "take cover" or "return fire" - failure to do so will cause injuries.
    Other cards will be "aim for the kill", but will have race-specific icons that need for success
        succes grants loot and will also downgrade future cards in the encounter

Encounters: once an encounter is started, the player will have no input. The player trains and preps their units, but the units do the fighting.
    Units can prep for "recieve orders" or something, where they will have a chance to retreat or press the attack
    For combat-less tasks, like looting, each time a task is done, it repeats with +1 icon on it. 
        If the Unit is well prepared, they can loot a lot.
        Sometimes the loot icons will be traps or deadly or whatever.
    An Encounter that was failed (the unit was killed before reaching the last card) and be retried; the cards that had icons matched remain matched.
    
Research: When new loot is found, "research" is time spent studying -- studying grants access to new icons. After that, other departments have access to training that grant said icon.

When a unit is deployed, they have mandatory R&R that reduces the amount of MANHOURS they can dedicate to their tasks.
    The player will need to decide between maintaining proficiencies or not.
    Every action a unit takes during a mission requires they have half a day of R&R.
    The first day back will also required a half day of Debrief

Drills: There should be two version: increase proficiency and maintain proficiency
    The maintain will be == to the amount of time that would have been spent doing one day on and one day off.
        I want to avoid the situation where the player will stop training one thing in order to train up another - instead I would rather they be able to "maintain" one and train up the other.
            This probably means that they will simply need to pick
            I also need to decide how icon degredation will work ...

Currencies: Primary currencvy is MANPOWER, second is INFLUENCE.
    You are limited by the number of staff you, and the access you are granted.
    MANPOWER is spent on tasks. It is the basic currency.
    INFLUENCE is spent on _other stuff_. It is essentially looted from spaceships. There are icons for influence, but it will be used as "general" and "quest-specific".


# GAME LOOP
## GEOSCAPE
The player commits MANHOURS to different projects and tasks.
## BATTLESCAPE
Each turn, the player sends Units to different rooms or whatever.
    This trigger Encounters.
    The player may commit a Unit to an Encounter.
    The Encounter is resolved.
        Unless the Unit is prepared for it, there is no input from the player.
This repeats until the player recalls the Units.
    The player may recall Units because there is nothing else to do, or because the risks are too high.