-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

woodBlocks = {
    {
        definition = "BLOCK_WOOD_1X1_1",
        definitionFrozen = "BLOCK_LIGHT_1X1_1",
        definitionHeldByForce = "FORCE_GLOW_RED_1X1",
        type = "box",
        width = 1.5,
        height = 1.5,
        sprite = "BLOCK_WOOD_1_1",
        controllable = false,
        material = "wood",
        strength = 15,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_1", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_1", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_1", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_1X2_1",
        definitionFrozen = "BLOCK_LIGHT_1X2_1",
        definitionHeldByForce = "FORCE_GLOW_RED_2X1",
        type = "box",
        width = 3,
        height = 1.5,
        sprite = "BLOCK_WOOD_1_2",
        controllable = false,
        material = "wood",
        strength = 24,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_2", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_2", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_2", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_1X4_1",
        definitionFrozen = "BLOCK_LIGHT_1X4_1",
        definitionHeldByForce = "FORCE_GLOW_RED_4X1",
        type = "box",
        width = 6,
        height = 1.5,
        sprite = "BLOCK_WOOD_1_4",
        controllable = false,
        material = "wood",
        strength = 42,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_4", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_4", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_4", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_1X8_1",
        definitionFrozen = "BLOCK_LIGHT_1X8_1",
        definitionHeldByForce = "FORCE_GLOW_RED_8X1",
        type = "box",
        width = 12,
        height = 1.5,
        sprite = "BLOCK_WOOD_1_6",
        controllable = false,
        material = "wood",
        strength = 78,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_6", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_6", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_6", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_1X10_1",
        definitionFrozen = "BLOCK_LIGHT_1X10_1",
        definitionHeldByForce = "FORCE_GLOW_RED_10X1",
        type = "box",
        width = 15,
        height = 1.5,
        sprite = "BLOCK_WOOD_10X1_1",
        controllable = false,
        material = "wood",
        strength = 96,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_10X1_1", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_10X1_2", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_10X1_3", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_2X2_1",
        definitionFrozen = "BLOCK_LIGHT_2X2_1",
        definitionHeldByForce = "FORCE_GLOW_RED_2X2",
        type = "box",
        width = 3,
        height = 3,
        sprite = "BLOCK_WOOD_1_3",
        controllable = false,
        material = "wood",
        strength = 60,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_3", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_3", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_3", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_2X4_1",
        definitionFrozen = "BLOCK_LIGHT_2X4_1",
        definitionHeldByForce = "FORCE_GLOW_RED_4X2",
        type = "box",
        width = 6,
        height = 3,
        sprite = "BLOCK_WOOD_1_5",
        controllable = false,
        material = "wood",
        strength = 96,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_5", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_5", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_5", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_4X4_1",
        definitionFrozen = "BLOCK_LIGHT_4X4_1",
        definitionHeldByForce = "FORCE_GLOW_RED_4X4",
        type = "box",
        width = 6,
        height = 6,
        sprite = "BLOCK_WOOD_4X4_1",
        controllable = false,
        material = "wood",
        strength = 120,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_4X4_1", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_4X4_2", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_4X4_3", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_ROUND_2X2_1",
        definitionFrozen = "BLOCK_LIGHT_ROUND_2X2_1",
        definitionHeldByForce = "FORCE_GLOW_RED_CIRCLE_S",
        type = "circle",
        radius = 1.5,
        sprite = "BLOCK_WOOD_1_8",
        controllable = false,
        material = "wood",
        strength = 47,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_8", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_8", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_8", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_ROUND_4X4_1",
        definitionFrozen = "BLOCK_LIGHT_ROUND_4X4_1",
        definitionHeldByForce = "FORCE_GLOW_RED_CIRCLE_L",
        type = "circle",
        radius = 3,
        sprite = "BLOCK_WOOD_1_7",
        controllable = false,
        material = "wood",
        strength = 188,
        scale = 1.6200000047683716,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_1_7", max = 100, min = 67 },
            damage2 = { sprite = "BLOCK_WOOD_2_7", max = 67, min = 33, particles = "woodenBuff" },
            damage3 = { sprite = "BLOCK_WOOD_3_7", max = 33, min = -1, particles = "woodenBuff" }
        }
    },
    {
        definition = "BLOCK_WOOD_TRIANGLE_R_4X4_1",
        definitionFrozen = "BLOCK_LIGHT_TRIANGLE_R_4X4_1",
        definitionHeldByForce = "FORCE_GLOW_RED_TRIANGLE_L",
        type = "polygon",
        vertices = { { x = 0, y = 0 }, { x = 1, y = 1 }, { x = 0, y = 1 } },
        width = 6,
        height = 6,
        sprite = "BLOCK_WOOD_TRIANGLE_L_1",
        controllable = false,
        material = "wood",
        strength = 80,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_TRIANGLE_L_1", max = 100, min = 67 },
            damage2 = {
                sprite = "BLOCK_WOOD_TRIANGLE_L_2",
                max = 67,
                min = 33,
                particles = "woodenBuff"
            },
            damage3 = {
                sprite = "BLOCK_WOOD_TRIANGLE_L_3",
                max = 33,
                min = -1,
                particles = "woodenBuff"
            }
        }
    },
    {
        definition = "BLOCK_WOOD_TRIANGLE_E_4X4_1",
        definitionFrozen = "BLOCK_LIGHT_TRIANGLE_E_4X4_1",
        definitionHeldByForce = "FORCE_GLOW_RED_TRIANGLE_M",
        type = "polygon",
        vertices = { { x = 0.5, y = 0 }, { x = 1, y = 1 }, { x = 0, y = 1 } },
        width = 6,
        height = 6,
        sprite = "BLOCK_WOOD_TRIANGLE_M_1",
        controllable = false,
        material = "wood",
        strength = 80,
        scale = 1.5,
        damageSprites = {
            damage1 = { sprite = "BLOCK_WOOD_TRIANGLE_M_1", max = 100, min = 67 },
            damage2 = {
                sprite = "BLOCK_WOOD_TRIANGLE_M_2",
                max = 67,
                min = 33,
                particles = "woodenBuff"
            },
            damage3 = {
                sprite = "BLOCK_WOOD_TRIANGLE_M_3",
                max = 33,
                min = -1,
                particles = "woodenBuff"
            }
        }
    }
}
