--- COA W.I.P. ---

-- TODO: ADAPT FUNCTIONS TO DRAGONFLIGHT TREES

 COA_ROLE_BY_SPEC = {}
local COA_ROLE_BY_CLASS = {}

local specListLookup = { -- LVL 10 passive spellID to specID
    -- PYROMANCER
    [92126] = 37, [92124] = 38, [300755] = 39,
    -- CULTIST
    [92131] = 40, [92130] = 41, [680750] = 96, [92129] = 42,
    -- VENOMANCER
    [92144] = 52, [92143] = 53, [92142] = 54, [680800] = 101,
    -- WITCH HUNTER
    [707064] = 97, [92093] = 11, [92091] = 10, [92094] = 12,
    -- REAPER
    [92145] = 56, [92147] = 57, [92146] = 55,
    -- TEMPLAR
    [92111] = 24, [92109] = 22, [92108] = 23,
    -- WITCH DOCTOR
    [92086] = 4, [92085] = 6, [92084] = 5,
    -- FELSWORN
    [92089] = 9, [92087] = 8, [92088] = 7,
    -- BARBARIAN
    [92083] = 3, [92082] = 1, [92081] = 2,
    -- PRIMALIST
    [92150] = 58, [92148] = 59, [92149] = 95, [680395] = 60,
    -- SUN CLERIC
    [707072] = 47, [92135] = 46, [92137] = 48, [92136] = 98,
    -- RANGER
    [92115] = 28, [92117] = 29, [92116] = 30,
    -- BLOODMAGE
    [92114] = 99, [681078] = 25, [92112] = 26, [92113] = 27,
    -- RUNEMASTER
    [92153] = 61, [92152] = 62, [92154] = 63,
    -- TINKER
    [92141] = 50, [92140] = 51, [92138] = 49,
    -- STORMBRINGER
    [92097] = 13, [92098] = 14, [92096] = 15,
    -- KNIGHT OF XOROTH
    [92101] = 16, [92104] = 17, [92100] = 18,
    -- GUARDIAN
    [92105] = 21, [92107] = 20, [92106] = 19,
    -- NECROMANCER
    [92121] = 34, [92123] = 35, [92122] = 36,
    -- CHRONOMANCER
    [92120] = 33, [92118] = 32, [92119] = 31,
    -- STARCALLER
    [680725] = 45, [92132] = 100, [92133] = 44, [92134] = 43,
}


for spellID,specID in pairs(specListLookup) do
    local specInfo = C_ClassInfo.GetSpecInfoByID(specID)
	if specInfo.Tank then
		COA_ROLE_BY_SPEC[specInfo.Name] = VUHDO_ID_MELEE_TANK
	elseif specInfo.Healer then
		COA_ROLE_BY_SPEC[specInfo.Name] = VUHDO_ID_RANGED_HEAL
	elseif specInfo.MeleeDPS then
		COA_ROLE_BY_SPEC[specInfo.Name] = VUHDO_ID_MELEE_DAMAGE
	elseif specInfo.RangedDPS or specInfo.CasterDPS then
		COA_ROLE_BY_SPEC[specInfo.Name] = VUHDO_ID_RANGED_DAMAGE
	elseif specInfo.Support then
		COA_ROLE_BY_SPEC[specInfo.Name] = VUHDO_ID_SUPPORT
	end
end



-- PURE ROLE CLASSES
COA_ROLE_BY_CLASS[VUHDO_ID_NECROMANCER] =	VUHDO_ID_MELEE_DAMAGE
COA_ROLE_BY_CLASS[VUHDO_ID_RANGER] =		VUHDO_ID_MELEE_DAMAGE
COA_ROLE_BY_CLASS[VUHDO_ID_STORMBRINGER] =	VUHDO_ID_MELEE_DAMAGE
COA_ROLE_BY_CLASS[VUHDO_ID_PYROMANCER] =	VUHDO_ID_MELEE_DAMAGE
COA_ROLE_BY_CLASS[VUHDO_ID_BARBARIAN] =		VUHDO_ID_MELEE_DAMAGE

local function CoA_Determine_Role_By_Class(anInfo)
	local uniClass = anInfo["classId"]

	-- CA_debug_from("CoA_RoleDeterminator","Checking "..VUHDO_ID_CLASSES[uniClass],"ce7e00")
	if COA_ROLE_BY_CLASS[uniClass] == nil then
			CA_debug_from("CoA_RoleDeterminator","Class "..VUHDO_ID_CLASSES[uniClass].. " is Unknown","ce7e00")
	elseif COA_ROLE_BY_CLASS[uniClass] == VUHDO_ID_TYPE_SPECIAL then
			CA_debug_from("CoA_RoleDeterminator","Class "..VUHDO_ID_CLASSES[uniClass].. " requires specialization check.","ce7e00")
	else
		VUHDO_DF_TOOL_ROLES[anInfo["name"]] = COA_ROLE_BY_CLASS[uniClass]
		return COA_ROLE_BY_CLASS[uniClass]
	end
end

function CoA_Determine_Role(anInfo)
	if not IsCustomClass(anInfo["unit"]) then 
		return
	end
	local results = CoA_Determine_Role_By_Class(anInfo)

	if tostring((results and results>=60) or false) then
		CA_debug_from("CoA_RoleDeterminator","Valid Role Found","ce7e00")
	else
		CA_debug_from("CoA_RoleDeterminator","Valid Role Not Found","ce7e00")
	end
	return results
end





