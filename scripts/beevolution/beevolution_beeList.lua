beeList = {
	Forest = {
		productivity = { chance = 60, min = 1, max = 3 },
		specialProductivity = { chance = 40,  min = 1, max = 2 },
		lifeSpan = 500,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_pollenNormal",
		natural = true,
		activity = day
	},
	
	Desert = {
		productivity = { chance = 50, min = 1, max = 3 },
		specialProductivity = { chance = 10,  min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combSandy",
		specialProduce = "beevolution_pollenNormal",
		natural = true,
		activity = day
	},
	
	Common = {
		productivity = { chance = 60, min = 1, max = 3 },
		specialProductivity = { chance = 42, min = 1, max = 2 },
		lifeSpan = 550,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_pollenNormal",
		natural = false
		activity = day
	},
	
	Cultivated = {
		productivity = { chance = 60, min = 2, max = 3},
		specialProductivy = { chance = 45, min = 1, max = 2 },
		lifeSpan = 600,
		fertility = 2,
		produce = "beevolution_combHoney",
		specialProduce = "beevolution_pollenNormal",
		natural = false,
		activity = day
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
	}
}