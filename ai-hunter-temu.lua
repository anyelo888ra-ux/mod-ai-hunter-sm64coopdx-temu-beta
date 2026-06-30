-- name: Nightmare Hunter
--------------------------------------------------
-- TORRE 1: CONFIGURACIÓN GENERAL + DIFICULTADES
--------------------------------------------------

HUNTER = {
    active = false,
    player = nil,
    target = nil,
    timer = 0,
    difficulty = "normal", -- facil, normal, dificil, ultra
}

-- Configuración de velocidades según dificultad
local diff_settings = {
    facil =   { speed = 35, fury = 55,  assassin = 80,  msg = "⚠️ MODO FACIL: El Hunter camina tranquilo... por ahora." },
    normal =  { speed = 55, fury = 85,  assassin = 120, msg = "💀 MODO NORMAL: El cazador está al acecho de sus presas." },
    dificil = { speed = 75, fury = 105, assassin = 150, msg = "🚨 ALERTA MÁXIMA: ¡Hunter está furioso y te alcanzará rápido!" },
    ultra =   { speed = 95, fury = 135, assassin = 190, msg = "👹 ERROR DE SISTEMA: ¡EL HUNTER ULTRA ES IMPARABLE! ¡CORRE POR TU VIDA!" }
}

HUNTER_LINES = {
    "Hunter: te veo...",
    "Hunter: no escaparás.",
    "Hunter: estoy detrás de ti.",
    "Hunter: ya perdiste.",
    "Hunter: tu final está cerca.",
}

hook_chat_command("hunter", "Activa el Hunter [facil/normal/dificil/ultra]", function(msg)
    local np = gNetworkPlayers[0]
    if np == nil then return true end

    -- Si se pasa un argumento, cambiar dificultad
    local mode = string.lower(msg)
    if diff_settings[mode] then
        HUNTER.difficulty = mode
    else
        HUNTER.difficulty = "normal" -- por defecto
    end

    HUNTER.active = not HUNTER.active

    if HUNTER.active then
        HUNTER.player = gMarioStates[0]
        HUNTER.target = nil
        HUNTER.timer = 0

        -- Mostrar advertencia de la dificultad elegida
        djui_chat_message_create(diff_settings[HUNTER.difficulty].msg)
        djui_chat_message_create("💀 Modos sombra, fantasma y ataque de lanzamiento listos...")
    else
        djui_chat_message_create("Hunter desactivado.")
    end

    return true
end)

--------------------------------------------------
-- TORRE 2: OBJETIVOS + ENTRADA A CUALQUIER NIVEL
--------------------------------------------------

function hunter_choose_target()
    local list = {}

    for i = 0, MAX_PLAYERS - 1 do
        local np = gNetworkPlayers[i]
        if np and np.connected then
            if gMarioStates[i] ~= HUNTER.player then
                table.insert(list, i)
            end
        end
    end

    if #list == 0 then return nil end
    return list[math.random(#list)]
end

function hunter_sync_level(h, t)
    if h.currLevelNum ~= t.currLevelNum or h.currAreaIndex ~= t.currAreaIndex then
        warp_to_level(t.currLevelNum, t.currAreaIndex, t.currActNum)
        djui_chat_message_create("💨 Hunter entra al área donde estás...")
    end
end

--------------------------------------------------
-- TORRE 3: TELEPORTS
--------------------------------------------------

function hunter_tp_behind(h, t)
    local angle = t.faceAngle.y
    h.pos.x = t.pos.x - math.sin(angle) * 120
    h.pos.z = t.pos.z - math.cos(angle) * 120
    h.pos.y = t.pos.y + 40
end

function hunter_tp_random(h, t)
    h.pos.x = t.pos.x + math.random(-400, 400)
    h.pos.z = t.pos.z + math.random(-400, 400)
    h.pos.y = t.pos.y + math.random(20, 80)
end

function hunter_ghost_mode(h, t)
    local dx = t.pos.x - h.pos.x
    local dz = t.pos.z - h.pos.z
    local dist = math.sqrt(dx*dx + dz*dz)

    if dist > 2500 then
        hunter_tp_random(h, t)
        djui_chat_message_create("👻 Hunter atraviesa paredes...")
    end
end

--------------------------------------------------
-- TORRE 4: ATAQUE DE LANZAMIENTO (NUEVO)
--------------------------------------------------

function hunter_launch_target(h, t)
    -- Calcular la dirección hacia donde el Hunter está mirando
    local angle = h.faceAngle.y
    
    -- Aplicar velocidad masiva a la víctima para lanzarla hacia el frente
    t.vel.x = math.sin(angle) * 110
    t.vel.z = math.cos(angle) * 110
    t.vel.y = 75 -- Fuerza de elevación vertical

    -- Forzar a la víctima a entrar en la animación de ser lanzado
    set_mario_action(t, ACT_THROWN_FORWARD, 0)
    
    -- El Hunter hace animación de golpe/patada tras el lanzamiento
    set_mario_action(h, ACT_JUMP_KICK, 0)

    djui_chat_message_create("🚀 ¡Hunter LANZÓ por los aires a " .. gNetworkPlayers[t.playerIndex].name .. "!")
end

--------------------------------------------------
-- TORRE 5: IA PRINCIPAL
--------------------------------------------------

function hunter_update(m)
    if not HUNTER.active then return end
    if m ~= HUNTER.player then return end

    HUNTER.timer = HUNTER.timer + 1

    if HUNTER.target == nil then
        HUNTER.target = hunter_choose_target()
        if HUNTER.target ~= nil then
            djui_chat_message_create("Hunter está cazando a " .. gNetworkPlayers[HUNTER.target].name)
        end
    end

    if HUNTER.target == nil then return end

    local t = gMarioStates[HUNTER.target]

    hunter_sync_level(m, t)
    hunter_ghost_mode(m, t)

    -- Teleports programados
    if HUNTER.timer % 150 == 0 then
        hunter_tp_random(m, t)
    elseif HUNTER.timer % 90 == 0 then
        hunter_tp_behind(m, t)
        djui_chat_message_create(HUNTER_LINES[math.random(#HUNTER_LINES)])
    end

    -- Obtener distancias
    local dx = t.pos.x - m.pos.x
    local dz = t.pos.z - m.pos.z
    local dist = math.sqrt(dx*dx + dz*dz)

    -- Cargar las velocidades según la dificultad elegida
    local current_config = diff_settings[HUNTER.difficulty]

    if dist > 2000 then
        m.forwardVel = current_config.fury
    else
        m.forwardVel = current_config.speed
    end

    -- Modo asesino con el tiempo
    if HUNTER.timer > 1200 then
        m.forwardVel = current_config.assassin
    end

    m.faceAngle.y = atan2s(dz, dx)

    -- Si está lo suficientemente cerca, lo LANZA y cambia de objetivo
    if dist < 130 then
        hunter_launch_target(m, t)
        HUNTER.target = hunter_choose_target()
    end
end

hook_event(HOOK_MARIO_UPDATE, hunter_update)
