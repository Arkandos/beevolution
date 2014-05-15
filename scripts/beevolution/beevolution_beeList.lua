beeList = {
	Forest = {
		productivity = { chance = 60, min = 1, max = 3 },
		specialProductivity = { chance = 20,  min = 1, max = 2 },
		lifeSpan = 500,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_waxNormal",
		natural = true,
		activity = "day"
	},
	
	Desert = {
		productivity = { chance = 50, min = 1, max = 3 },
		specialProductivity = { chance = 0,  min = 0, max = 0 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combSandy",
		specialProduce = "beevolution_pollenNormal",
		natural = true,
		activity = "day"
	},
	
	Tundra = {
		productivity = { chance = 60, min = 1, max = 3 },
		specialProductivity = { chance = 20,  min = 1, max = 2 },
		lifeSpan = 650,
		fertility = 2,
		produce = "beevolution_combChilled",
		specialProduce = "beevolution_waxNormal",
		natural = true,
		activity = "day"
	},
	
	Rocky = {
		productivity = { chance = 50, min = 1, max = 1 },
		specialProductivity = { chance = 0,  min = 0, max = 0 },
		lifeSpan = 600,
		fertility = 1,
		produce = "beevolution_combRocky",
		specialProduce = "beevolution_pollenNormal",
		natural = true,
		activity = "both"
	},
	
	Common = {
		productivity = { chance = 60, min = 1, max = 3 },
		specialProductivity = { chance = 0, min = 0, max = 0 },
		lifeSpan = 550,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_pollenNormal",
		natural = false,
		activity = "day"
	},
	
	Cultivated = {
		productivity = { chance = 60, min = 1, max = 3},
		specialProductivity = { chance = 0, min = 0, max = 0 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_pollenNormal",
		natural = false,
		activity = "day"
	},
	
	Patrician = {
		productivity = { chance = 60, min = 1, max = 3},
		specialProductivity = { chance = 30, min = 1, max = 1 },
		lifeSpan = 550,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_waxNormal",
		natural = false,
		activity = "day"
	},
	Noble = {
		productivity = { chance = 60, min = 1, max = 3},
		specialProductivity = { chance = 30, min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combDripping",
		specialProduce = "beevolution_waxNormal",
		natural = false,
		activity = "day"
	},
	Royal = {
		productivity = { chance = 60, min = 2, max = 3},
		specialProductivity = { chance = 30, min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combDripping",
		specialProduce = "beevolution_jellyRoyal",
		natural = false,
		activity = "day"
	},
	Diligent = {
		productivity = { chance = 60, min = 1, max = 3},
		specialProductivity = { chance = 30, min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_waxNormal",
		natural = false,
		activity = "day"
	},
	Hardworking = {
		productivity = { chance = 60, min = 2, max = 3},
		specialProductivity = { chance = 30, min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_waxNormal",
		natural = false,
		activity = "day"
	},
	Industrious = {
		productivity = { chance = 60, min = 2, max = 4},
		specialProductivity = { chance = 30, min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_pollenNormal",
		natural = false,
		activity = "day"
	}
}

beeBranches = {
	Common = {
		species1 = "natural",
		species2 = "natural",
		chance = 20
	},
	Cultivated = {
		species1 = "Common",
		species2 = "natural",
		chance = 20
	},
	Patrician = {
		species1 = "Common",
		species2 = "Cultivated",
		chance = 15
	},
	Noble = {
		species1 = "Noble",
		species2 = "Cultivated",
		chance = 15
	},
	Royal = {
		species1 = "Patrician",
		species2 = "Noble",
		chance = 15
	},
	Diligent = {
		species1 = "Common",
		species2 = "Cultivated",
		chance = 15
	},
	Hardworking = {
		species1 = "Diligent",
		species2 = "Cultivated",
		chance = 15
	},
	Industrious = {
		species1 = "Diligent",
		species2 = "Hardworking",
		chance = 15
	}
}