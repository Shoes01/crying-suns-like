# DARKEST DUNGEON vs CRYING SUNS vs XCOM Game
The game is split between the `Geoscape` and the `Battlescape`. The Player manages ``Departments`` and ``Units``, but does not oversee direct combat. Instead, the player manages how the Departments and Units prepare for battle. The game is played in the abstract.
## Turn structure
A turn is done in three phases.
1. [GEOSCAPE] Departments submit reports to the player. 
2. [GEOSCAPE] The player assigns tasks to departments and units. 
3. [BATTLESCAPE] Deployed units engage in battle.



## Battlescape
When a `mission` presents itself, the player may send any number of `units` to conduct it. In brief, the mission will present `icons` to the player which the sent units need to have. 

The player may also prepare for the mission in a number of ways with the help of various departments.
### _Mission Prep_
On the Geoscape, the player may use departments and spend manhours preparing for the mission. For each day spent preparing for the mission, the mission gets harder. 
### _Missions_
A mission is chunked into a series of `encounters`. The player commits one unit encounter. The player does not micromanage the unit during the encounter - it is automatically resolved. 
### _Encounters and Cards_
An encounter is a series of `cards`, each showing a number of `icons`. The unit committed by the player has icons as well; the result of each card depends on how many icons match.

A card may be nothing more than a narrative description followed by icons. 
## Icons :: The core of the combat engine, and other interactions.
Everything is resolved by matching icons. The more that match, the better the outcome. This goes for combat, but also research.
## Geoscape
The player manages `departments` and `units` on the Geoscape. The primary currency is `MANHOURS` - as the player takes on the role of government, money is no issue.


# OTHER
The player starts with a few ``departments``.
* SIGINT: Detects new ``missions``.
* XCOM: Coducts ``missions``. 

# _EXAMPLE of GAMEPLAY_
# __Game Start__

SATCOM is doing Active Listening.
> SATCOM generates missions and provides more details about them.

> Active Listening: This is the default state of SATCOM. This is how missions are generated.

XCOM's units are doing Basic Training.
> XCOM houses the ground units that are sent to missions

> Basic Training: Grants a variety of icons, with no particular focus.

FLEETCOM units are doing Basic Maneuvers.
> FLEETCOM houses the air unts that are sent to intercept UFO.

> Basic Maneuvers: Grants a variety of icons, with no particular focus.

R&D is completing XCOM Initiative.
<!-- I think R&D could have a better name... -->
> R&D researches loot and whatnot. This ultimately leads to more/better icons.

> XCOM Initiative: It's the game.

# __Day 01__

## GEOSCAPE

__Phase 1: Report__
> Phase 1: Various departments report the results of their tasks.

SATCOM reports mission choices, if any.

XCOM reports post battle results, if any.

FLEETCOM reports post battle results, if any.

R&D reports results, if any.

_R&D delivers a report about the XCOM Initiative, introducing the game. SATCOM delivers a report: an alien scouting party is on the ground._

__Phase 2: Preparation__
> Phase 2: The player assigns tasks to all departments and units.

SATCOM possible tasks are Signal Analysis and Prepare Engagement.

> Signal Analysis: give more information about the mission, but delays engagement by a day.

> Prepare Engagement: allow the player to deploy units.

_The player chooses Prepare Engagement_.

XCOM possible tasks are Basic Training and Deploy.

_The player may deploy as many or as few units as they want._

> Deploy will send the unit to the location.

FLEETCOM possible tasks are Basic Maneuvers or Airstrike.

> Airstrike: Destroys the mission location. 

R&D possible tasks related to whatever has been looted.
<!-- I don't know what the "basic" task of R&D would be. -->

__Phase 3: Engagement__
> Phase 3: If the player is deploying units, then there is an engagement phase. Engagement happens on the Battlescape.

## BATTLESCAPE

_The player deploys two units._

### _Turn 01_

A unit may perform a move and an action per turn. Actions are based on icons the units have. A unit will need half a day of R&R for each action they take on a mission.
> Basic Training will provide icons for Engage, Mend, Loot. 

> Engage: Begin an encounter in a room.

> Mend: Heal wounded units.

> Loot: Take things from the cleared room. Can be from the downed aliens, or equipment in the room.

> R&R: It is a task that does nothing. 

Only rooms adjacent to the deployment zone are visible. Each room can be sent one unit. 

A unit deployed to a room begins an encounter. If the unit is victorious, they take control of the room and can see adjacent rooms.
> Encounter: a series of cards are shown with icons on them. The result of each card is dependent on the icons shown. Resolving the last card means the unit has taken control of the room.

_The player engages with one unit, clearing the room and sustaining injuries.The second unit mends the first._

### _Turn 02_

_The player rotates units and continue clears the next room._
<!-- It's not clear how injured soldiers affect a unit's combat abilites. -->

### _Turn 03_

_The player loots both cleared rooms and ends the mission._

### _Mission End_

_The units return from the mission with dead and wounded, and some loot._

> Wounded soldier: Every wounded soldier adds a Medbay task to the unit.

> Dead solider: Every dead soldier reduces the overall XP of the unit by 1/N. 
<!-- It's not clear what XP does, or how they relate to icons. -->

> Loot: Loot can be studied by different departments for rewards.

# __Day 02__

__Phase 1: Report__

SATCOM reports mission choices, if any.

XCOM reports post battle results, if any.

FLEETCOM reports post battle results, if any.

R&D reports results, if any.

_SATCOM, FLEETCOM and R&D have nothing to report. XCOM reports mandatory tasks that units need to perform._

__Phase 2: Preparation__

_SATCOM and FLEETCOM are assigned their basic tasks._

_XCOM units are assigned their mandatory tasks; basic tasks are assigned for the rest of the day._

_R&D begins researching the mission loot._

__Phase 3: Engagement__

_No engagement._

# __Day 03__

etc.