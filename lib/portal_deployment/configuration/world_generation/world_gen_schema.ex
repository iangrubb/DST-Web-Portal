defmodule PortalDeployment.Configuration.WorldGenSchema do
  def field_ast(module, key, values) do
    {{:., [], [{:__aliases__, [alias: false], [:Ecto, :Schema]}, :__field__]}, [],
     [
       {:__MODULE__, module, PortalDeployment.Configuration.WorldGenOptions},
       key,
       {:__aliases__, [alias: false], [:Ecto, :Enum]},
       [values: values, default: :default]
     ]}
  end

  def types() do
    %{
      special_event: [
        %{name: :none, nice_name: "None"},
        %{name: :default, nice_name: "Auto"},
        %{name: :hallowed_nights, nice_name: "Hallowed Nights"},
        %{name: :winters_feast, nice_name: "Winter's Feast"},
        %{name: :year_of_the_gobbler, nice_name: "Year of the Gobbler"},
        %{name: :year_of_the_varg, nice_name: "Year of the Varg"},
        %{name: :year_of_the_pig, nice_name: "Year of the Pig"},
        %{name: :year_of_the_carrat, nice_name: "Year of the Carrat"},
        %{name: :year_of_the_beefalo, nice_name: "Year of the Beefalo"}
      ],
      season_length: [
        %{name: :noseason, nice_name: "None"},
        %{name: :veryshortsseason, nice_name: "Very Short"},
        %{name: :shortseason, nice_name: "Short"},
        %{name: :default, nice_name: "Default"},
        %{name: :longseason, nice_name: "Long"},
        %{name: :verylongseason, nice_name: "Very Long"},
        %{name: :random, nice_name: "Random"}
      ],
      day_length: [
        %{name: :default, nice_name: "Default"},
        %{name: :longday, nice_name: "Long Day"},
        %{name: :longdusk, nice_name: "Long Dusk"},
        %{name: :longnight, nice_name: "Long Night"},
        %{name: :noday, nice_name: "No Day"},
        %{name: :nodusk, nice_name: "No Dusk"},
        %{name: :nonight, nice_name: "No Night"},
        %{name: :onlyday, nice_name: "Only Day"},
        %{name: :onlydusk, nice_name: "Only Dusk"},
        %{name: :onlynight, nice_name: "Only Night"}
      ],
      frequency: [
        %{name: :never, nice_name: "Never"},
        %{name: :rare, nice_name: "Rare"},
        %{name: :default, nice_name: "Default"},
        %{name: :often, nice_name: "Often"},
        %{name: :always, nice_name: "Always"}
      ],
      extra_starting_items: [
        %{name: :"0", nice_name: "Always"},
        %{name: :"5", nice_name: "After Day 5"},
        %{name: :default, nice_name: "After Day 10"},
        %{name: :"15", nice_name: "After Day 15"},
        %{name: :"20", nice_name: "After Day 20"},
        %{name: :none, nice_name: "Never"}
      ],
      never_default: [
        %{name: :never, nice_name: "Never"},
        %{name: :default, nice_name: "Default"}
      ],
      never_default_always: [
        %{name: :never, nice_name: "Never"},
        %{name: :default, nice_name: "Default"},
        %{name: :always, nice_name: "Always"}
      ],
      default_always: [
        %{name: :default, nice_name: "Default"},
        %{name: :always, nice_name: "Always"}
      ],
      petrification_speed: [
        %{name: :none, nice_name: "None"},
        %{name: :few, nice_name: "Slow"},
        %{name: :default, nice_name: "Default"},
        %{name: :many, nice_name: "Fast"},
        %{name: :max, nice_name: "Very Fast"}
      ],
      speed: [
        %{name: :never, nice_name: "Never"},
        %{name: :veryslow, nice_name: "Very Slow"},
        %{name: :slow, nice_name: "Slow"},
        %{name: :default, nice_name: "Default"},
        %{name: :fast, nice_name: "Fast"},
        %{name: :veryfast, nice_name: "Very Fast"}
      ],
      atrium_speed: [
        %{name: :veryslow, nice_name: "Very Slow"},
        %{name: :slow, nice_name: "Slow"},
        %{name: :default, nice_name: "Default"},
        %{name: :fast, nice_name: "Fast"},
        %{name: :veryfast, nice_name: "Very Fast"}
      ],
      starting_season: [
        %{name: :default, nice_name: "Autumn"},
        %{name: :winter, nice_name: "Winter"},
        %{name: :spring, nice_name: "Spring"},
        %{name: :summer, nice_name: "Summer"},
        %{name: :"autumn|spring", nice_name: "Autumn or Spring"},
        %{name: :"winter|summer", nice_name: "Winter or Summer"},
        %{name: :"autumn|winter|spring|summer", nice_name: "Random"}
      ],
      default_classic: [
        %{name: :default, nice_name: "Together"},
        %{name: :classic, nice_name: "Classic"}
      ],
      starting_location: [
        %{name: :default, nice_name: "Default"},
        %{name: :darkness, nice_name: "Dark"},
        %{name: :plus, nice_name: "Plus"}
      ],
      world_size: [
        %{name: :small, nice_name: "Small"},
        %{name: :medium, nice_name: "Medium"},
        %{name: :default, nice_name: "Large"},
        %{name: :huge, nice_name: "Huge"}
      ],
      world_branching: [
        %{name: :never, nice_name: "Never"},
        %{name: :least, nice_name: "Least"},
        %{name: :default, nice_name: "Default"},
        %{name: :most, nice_name: "Most"},
        %{name: :random, nice_name: "Random"}
      ],
      quantity: [
        %{name: :never, nice_name: "None"},
        %{name: :rare, nice_name: "Little"},
        %{name: :uncommon, nice_name: "Less"},
        %{name: :default, nice_name: "Default"},
        %{name: :often, nice_name: "More"},
        %{name: :mostly, nice_name: "Lots"},
        %{name: :always, nice_name: "Tons"},
        %{name: :insane, nice_name: "Insane"}
      ],
      resource_variety: [
        %{name: :classic, nice_name: "Classic"},
        %{name: :default, nice_name: "Default"},
        %{name: :"highly random", nice_name: "Highly Random"}
      ]
    }
  end

  def options() do
    [
      # Settings

      # Global

      %{
        name: :specialevent,
        nice_name: "Special Event",
        zone: :cluster,
        category: "Global",
        type: :special_event,
        setting_or_generation: :setting
      },
      %{
        name: :autumn,
        nice_name: "Autumn",
        zone: :cluster,
        category: "Global",
        type: :season_length,
        setting_or_generation: :setting
      },
      %{
        name: :winter,
        nice_name: "Winter",
        zone: :cluster,
        category: "Global",
        type: :season_length,
        setting_or_generation: :setting
      },
      %{
        name: :spring,
        nice_name: "Spring",
        zone: :cluster,
        category: "Global",
        type: :season_length,
        setting_or_generation: :setting
      },
      %{
        name: :summer,
        nice_name: "Summer",
        zone: :cluster,
        category: "Global",
        type: :season_length,
        setting_or_generation: :setting
      },
      %{
        name: :day,
        nice_name: "Day Type",
        zone: :cluster,
        category: "Global",
        type: :day_length,
        setting_or_generation: :setting
      },
      %{
        name: :beefaloheat,
        nice_name: "Beefalo Mating",
        zone: :cluster,
        category: "Global",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :krampus,
        nice_name: "Krampii",
        zone: :cluster,
        category: "Global",
        type: :frequency,
        setting_or_generation: :setting
      },

      # Survivors

      %{
        name: :extrastartingitems,
        nice_name: "Extra Starting Resources",
        zone: :cluster,
        category: "Survivors",
        type: :extra_starting_items,
        setting_or_generation: :setting
      },
      %{
        name: :seasonalstartingitems,
        nice_name: "Seasonal Starting Items",
        zone: :cluster,
        category: "Survivors",
        type: :never_default,
        setting_or_generation: :setting
      },
      %{
        name: :spawnprotection,
        nice_name: "Griefer Spawn Protection",
        zone: :cluster,
        category: "Survivors",
        type: :never_default_always,
        setting_or_generation: :setting
      },
      %{
        name: :dropeverythingondespawn,
        nice_name: "Drop Items on Disconnect",
        zone: :cluster,
        category: "Survivors",
        type: :default_always,
        setting_or_generation: :setting
      },
      %{
        name: :brightmarecreatures,
        nice_name: "Enlightenment Monsters",
        zone: :cluster,
        category: "Survivors",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :shadowcreatures,
        nice_name: "Sanity Monsters",
        zone: :cluster,
        category: "Survivors",
        type: :frequency,
        setting_or_generation: :setting
      },

      # World

      %{
        name: :petrification,
        nice_name: "Forest Petrification",
        zone: :forest,
        category: "World",
        type: :petrification_speed,
        setting_or_generation: :setting
      },
      %{
        name: :frograin,
        nice_name: "Frog Rain",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :hounds,
        nice_name: "Hound Attacks",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :alternate_hunt,
        nice_name: "Hunt Surprises",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :hunt,
        nice_name: "Hunts",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :lightning,
        nice_name: "Lightning",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :meteor_showers,
        nice_name: "Meteor Frequency",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :weather,
        nice_name: "Rain",
        zone: :shard,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :wildfires,
        nice_name: "Wildfires",
        zone: :forest,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :atriumgate,
        nice_name: "Ancient Gateway",
        zone: :cave,
        category: "World",
        type: :atrium_speed,
        setting_or_generation: :setting
      },
      %{
        name: :wormattacks,
        nice_name: "Cave Worm Attacks",
        zone: :cave,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :earthquakes,
        nice_name: "Earthquakes",
        zone: :cave,
        category: "World",
        type: :frequency,
        setting_or_generation: :setting
      },

      # Resource Regrowth

      %{
        name: :regrowth,
        nice_name: "Regrowth Multiplier",
        zone: :shard,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :deciduoustree_regrowth,
        nice_name: "Birchnut Trees",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :carrots_regrowth,
        nice_name: "Carrots",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :evergreen_regrowth,
        nice_name: "Evergreens",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :flowers_regrowth,
        nice_name: "Flowers",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :moon_tree_regrowth,
        nice_name: "Lune Trees",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :saltstack_regrowth,
        nice_name: "Salt Formations",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :twiggytrees_regrowth,
        nice_name: "Twiggy Trees",
        zone: :forest,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :flower_cave_regrowth,
        nice_name: "Light Flower",
        zone: :cave,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :lightflier_flower_regrowth,
        nice_name: "Lightflier Flower",
        zone: :cave,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :mushtree_moon_regrowth,
        nice_name: "Lunar Mushtrees",
        zone: :cave,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },
      %{
        name: :mushtree_regrowth,
        nice_name: "Mushroom Trees",
        zone: :cave,
        category: "Resource Regrowth",
        type: :speed,
        setting_or_generation: :setting
      },

      # Creatures

      %{
        name: :bees_setting,
        nice_name: "Bees",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :birds,
        nice_name: "Birds",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :bunnymen_setting,
        nice_name: "Bunnymen",
        zone: :shard,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :butterfly,
        nice_name: "Butterflies",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :catcoons,
        nice_name: "Catcoons",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :gnarwail,
        nice_name: "Gnarwails",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :perd,
        nice_name: "Gobblers",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :grassgekkos,
        nice_name: "Grass Gekko Morphing",
        zone: :shard,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :moles_setting,
        nice_name: "Moles",
        zone: :shard,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :penguins,
        nice_name: "Pengulls",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :pigs_setting,
        nice_name: "Pigs",
        zone: :shard,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :rabbits_setting,
        nice_name: "Rabbits",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :fishschools,
        nice_name: "Schools of Fish",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :wobsters,
        nice_name: "Wobsters",
        zone: :forest,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :lightfliers,
        nice_name: "Bulbous Lightbugs",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :dustmoths,
        nice_name: "Dust Moths",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :mushgnome,
        nice_name: "Mush Gnomes",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :rocky_setting,
        nice_name: "Rock Lobsters",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :slurtles_setting,
        nice_name: "Slurtles",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :snurtles,
        nice_name: "Snurtles",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :monkey_setting,
        nice_name: "Splumonkeys",
        zone: :cave,
        category: "Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },

      # Hostile Creatures

      %{
        name: :bats_setting,
        nice_name: "Bats",
        zone: :shard,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :cookiecutters,
        nice_name: "Cookie Cutters",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :frogs,
        nice_name: "Frogs",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :mutated_hounds,
        nice_name: "Horror Hounds",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :hound_mounds,
        nice_name: "Hounds",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :wasps,
        nice_name: "Killer Bees",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :lureplants,
        nice_name: "Lureplants",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :walrus_setting,
        nice_name: "MacTusk",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :merms,
        nice_name: "Merms",
        zone: :shard,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :penguins_moon,
        nice_name: "Moonrock Pengulls",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :mosquitos,
        nice_name: "Mosquitos",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :sharks,
        nice_name: "Sharks",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :moon_spider,
        nice_name: "Shattered Spiders",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :squid,
        nice_name: "Skittesquids",
        zone: :forest,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :spider_warriors,
        nice_name: "Spider Warriors",
        zone: :shard,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :spiders_setting,
        nice_name: "Spiders",
        zone: :shard,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :spider_hider,
        nice_name: "Cave Spiders",
        zone: :cave,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :spider_dropper,
        nice_name: "Dangling Depth Dwellers",
        zone: :cave,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :molebats,
        nice_name: "Naked Mole Bats",
        zone: :cave,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :nightmarecreatures,
        nice_name: "Ruins Nightmares",
        zone: :cave,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :spider_spitter,
        nice_name: "Spitter Spiders",
        zone: :cave,
        category: "Hostile Creatures",
        type: :frequency,
        setting_or_generation: :setting
      },

      # Giants

      %{
        name: :antliontribute,
        nice_name: "Antlion Tribute",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :bearger,
        nice_name: "Bearger",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :beequeen,
        nice_name: "Beequeen",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :crabking,
        nice_name: "Crabking",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :deerclops,
        nice_name: "Deerclops",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :dragonfly,
        nice_name: "Dragonfly",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :klaus,
        nice_name: "Klaus",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :fruitfly,
        nice_name: "Lord of the Fruit Flies",
        zone: :shard,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :malbatross,
        nice_name: "Malbatross",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :goosemoose,
        nice_name: "Meese/Geese",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :deciduousmonster,
        nice_name: "Poison Birchnut Trees",
        zone: :forest,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :spiderqueen,
        nice_name: "Spider Queen",
        zone: :shard,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :liefs,
        nice_name: "Treeguards",
        zone: :shard,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },
      %{
        name: :toadstool,
        nice_name: "Toadstool",
        zone: :cave,
        category: "Giants",
        type: :frequency,
        setting_or_generation: :setting
      },

      # Generation

      # Global

      %{
        name: :season_start,
        nice_name: "Starting Season",
        zone: :cluster,
        category: "Global",
        type: :starting_season,
        setting_or_generation: :generation
      },

      # World

      %{
        name: :task_set,
        nice_name: "Biomes",
        zone: :forest,
        category: "World",
        type: :default_classic,
        setting_or_generation: :generation
      },
      %{
        name: :start_location,
        nice_name: "Spawn Area",
        zone: :forest,
        category: "World",
        type: :starting_location,
        setting_or_generation: :generation
      },
      %{
        name: :world_size,
        nice_name: "World Size",
        zone: :shard,
        category: "World",
        type: :world_size,
        setting_or_generation: :generation
      },
      %{
        name: :branching,
        nice_name: "Branches",
        zone: :shard,
        category: "World",
        type: :world_branching,
        setting_or_generation: :generation
      },
      %{
        name: :loop,
        nice_name: "Loops",
        zone: :shard,
        category: "World",
        type: :never_default_always,
        setting_or_generation: :generation
      },
      %{
        name: :touchstone,
        nice_name: "Touchstones",
        zone: :shard,
        category: "World",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :boons,
        nice_name: "Failed Survivors",
        zone: :shard,
        category: "World",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :cavelight,
        nice_name: "Sinkhole Lights",
        zone: :cave,
        category: "World",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :prefabswaps_start,
        nice_name: "Starting Resource Variety",
        zone: :shard,
        category: "World",
        type: :resource_variety,
        setting_or_generation: :generation
      },
      %{
        name: :moon_fissure,
        nice_name: "Celestial Fissures",
        zone: :forest,
        category: "World",
        type: :quantity,
        setting_or_generation: :generation
      },

      # Resources

      %{
        name: :moon_starfish,
        nice_name: "Anenemies",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_bullkelp,
        nice_name: "Beached Bull Kelp",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :berrybush,
        nice_name: "Berry Bushes",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :rock,
        nice_name: "Boulders",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :ocean_bullkelp,
        nice_name: "Bull Kelp",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :cactus,
        nice_name: "Cacti",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :carrot,
        nice_name: "Carrots",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :flint,
        nice_name: "Flint",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :flowers,
        nice_name: "Flowers, Evil Flowers",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :grass,
        nice_name: "Grass",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_hotsprings,
        nice_name: "Hot Springs",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_rock,
        nice_name: "Lunar Rocks",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_sapling,
        nice_name: "Lunar Saplings",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_tree,
        nice_name: "Lune Trees",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :meteorspawner,
        nice_name: "Meteor Fields",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :rock_ice,
        nice_name: "Mini Glaciers",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :mushroom,
        nice_name: "Mushrooms",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :ponds,
        nice_name: "Ponds",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :reeds,
        nice_name: "Reeds",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :sapling,
        nice_name: "Saplings",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :ocean_seastack,
        nice_name: "Sea Stacks",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :marshbush,
        nice_name: "Spiky Bushes",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_berrybush,
        nice_name: "Stone Fruit Bushes",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :trees,
        nice_name: "Trees (All)",
        zone: :shard,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :tumbleweed,
        nice_name: "Tumbleweeds",
        zone: :forest,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :banana,
        nice_name: "Cave Bananas",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :fern,
        nice_name: "Cave Ferns",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :wormlights,
        nice_name: "Glow Berries",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :lichen,
        nice_name: "Lichen",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :flower_cave,
        nice_name: "Light Flowers",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :mushtree,
        nice_name: "Mushroom Trees",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :cave_ponds,
        nice_name: "Ponds",
        zone: :cave,
        category: "Resources",
        type: :quantity,
        setting_or_generation: :generation
      },

      # Creatures and Spawners

      %{
        name: :bees,
        nice_name: "Bee Hives",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :beefalo,
        nice_name: "Beefalos",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :buzzard,
        nice_name: "Buzzards",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_carrot,
        nice_name: "Carrats",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :catcoon,
        nice_name: "Hollow Stump",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moles,
        nice_name: "Mole Burrows",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :pigs,
        nice_name: "Pig Houses",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :rabbits,
        nice_name: "Rabbit Holes",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_fruitdragon,
        nice_name: "Saladmander",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :ocean_shoal,
        nice_name: "Shoals",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :lightninggoats,
        nice_name: "Volt Goats",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :ocean_wobsterden,
        nice_name: "Wobster Mounds",
        zone: :forest,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :bunnymen,
        nice_name: "Rabbit Hutches",
        zone: :cave,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :rocky,
        nice_name: "Rock Lobsters",
        zone: :cave,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :slurper,
        nice_name: "Slurpers",
        zone: :cave,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :slurtles,
        nice_name: "Slurtle Mounds",
        zone: :cave,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :monkey,
        nice_name: "Splumonkey Pods",
        zone: :cave,
        category: "Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },

      # Hostile Creatures and Spawners

      %{
        name: :chess,
        nice_name: "Clockworks",
        zone: :shard,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :houndmound,
        nice_name: "Hound Mounds",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :angrybees,
        nice_name: "Killer Bee Hives",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :merm,
        nice_name: "Leaky SHack",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :walrus,
        nice_name: "MacTusk Camps",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :ocean_waterplant,
        nice_name: "Sea Weeds",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :moon_spiders,
        nice_name: "Shattered Spider Holes",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :spiders,
        nice_name: "Spider Dens",
        zone: :shard,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :tallbirds,
        nice_name: "Tallbirds",
        zone: :forest,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :tentacles,
        nice_name: "Tentacles",
        zone: :shard,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :bats,
        nice_name: "Bats",
        zone: :cave,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :worms,
        nice_name: "Cave Worms",
        zone: :cave,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :fissure,
        nice_name: "Nightmare Fissures",
        zone: :cave,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      },
      %{
        name: :cave_spiders,
        nice_name: "Spilagmites",
        zone: :cave,
        category: "Hostile Creatures and Spawners",
        type: :quantity,
        setting_or_generation: :generation
      }
    ]
  end

  def module_options(:forest),
    do: options() |> Enum.filter(fn opt -> opt.zone == :forest or opt.zone == :shard end)

  def module_options(:cave),
    do: options() |> Enum.filter(fn opt -> opt.zone == :cave or opt.zone == :shard end)

  def module_options(:cluster), do: options() |> Enum.filter(fn opt -> opt.zone == :cluster end)

  defmacro __using__({key, module}) do
    types = types()

    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key false
      embedded_schema do
        (unquote_splicing(
           key
           |> module_options()
           |> Enum.map(fn option ->
             field_ast(
               module,
               option.name,
               types[option.type] |> Enum.map(fn type -> type.name end)
             )
           end)
         ))
      end

      def changeset(gen, params) do
        gen
        |> cast(params, unquote(key |> module_options |> Enum.map(fn %{name: name} -> name end)))
      end
    end
  end
end
