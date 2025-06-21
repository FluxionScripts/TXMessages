ESX = exports["es_extended"]:getSharedObject()

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    local announceMin = { 300, 240, 180, 120, 60 }

    for _, timess in ipairs(announceMin) do
        if eventData.secondsRemaining == timess then
            CreateThread(function()
                for _, playerId in pairs(ESX.GetPlayers()) do
                    local xPlayer = ESX.GetPlayerFromId(playerId)
                    if xPlayer then
                        local timeText = math.floor(timess / 60) .. " minuten"
                        xPlayer.showNotification('De server wordt gerestart over ' .. timeText, 'warning', 5000)
                    end
                end
            end)
        end
    end

    if eventData.secondsRemaining == 60 then
        CreateThread(function()
            for _, playerId in pairs(ESX.GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(playerId)
                if xPlayer then
                    Wait(30000)
                    xPlayer.showNotification('De server wordt gerestart over 30 seconden', 'warning', 5000)
                    Wait(20000)
                    xPlayer.showNotification('De server wordt gerestart over 10 seconden', 'warning', 5000)
                    Wait(5000)
                    xPlayer.showNotification('De server wordt gerestart over 5 seconden', 'warning', 5000)
                    Wait(1000)
                    xPlayer.showNotification('De server wordt gerestart over 4 seconden', 'warning', 5000)
                    Wait(1000)
                    xPlayer.showNotification('De server wordt gerestart over 3 seconden', 'warning', 5000)
                    Wait(1000)
                    xPlayer.showNotification('De server wordt gerestart over 2 seconden', 'warning', 5000)
                    Wait(1000)
                    xPlayer.showNotification('De server wordt gerestart over 1 seconde', 'warning', 5000)
                end
            end
        end)
    end
end)


AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    if eventData.targetNetId then
        local message = eventData.targetName ..
            ' heeft een waarschuwing ontvangen | Reden: ' .. eventData.reason

        TriggerClientEvent('chat:addMessage', -1, {
            template =
            '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">ADMIN SYSTEEM</span></b><div style="margin-top: 5px; font-weight: 300; color: #e1e1e1;">{0}</div></div>',
            args = { message }
        })
    else
        local message = eventData.targetName .. ' heeft een offline waarschuwing ontvangen | Reden: ' .. eventData
            .reason
        TriggerClientEvent('chat:addMessage', -1, {
            template =
            '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">ADMIN SYSTEEM</span></b><div style="margin-top: 5px; font-weight: 300; color: #e1e1e1;">{0}</div></div>',
            args = { message }
        })
    end

    local embed = {
        {
            ["color"] = 16753920,
            ["title"] = "🙅 Warn",
            ["description"] = "Een stafflid heeft een speler warn gegeven.",
            ["fields"] = {
                {
                    ["name"] = "🔰 Stafflid:",
                    ["value"] = string.format("%s", eventData.author),
                    ["inline"] = true
                },
                {
                    ["name"] = "👶 Speler:",
                    ["value"] = string.format("%s", eventData.targetName),
                    ["inline"] = true
                },
                {
                    ["name"] = "💬 Reden:",
                    ["value"] = string.format("```%s```", eventData.reason),
                    ["inline"] = false
                },
            },
            ["footer"] = {
                ["text"] = 'Fluxion Scripts',
            }
        }
    }

    sendToDiscord(
        'https://discord.com/api/webhooks/1333830935837413376/z2uJ-KJ8x_O2TWboBqwJvhZvk764OoDXUh-Y4NNGKn3k8SLhDncay27peS3gRRrig2fA',
        embed)
end)


AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    if eventData.targetNetId then
        local message = string.format(
            "%s [%s] is geband | Reden: %s | Duur: %s",
            eventData.targetName,
            eventData.targetNetId,
            eventData.reason or "Geen reden opgegeven",
            eventData.durationInput or "Permanent"
        )
        TriggerClientEvent('chat:addMessage', -1, {
            template =
            '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">ADMIN SYSTEEM</span></b><div style="margin-top: 5px; font-weight: 300; color: #e1e1e1;">{0}</div></div>',
            args = { message }
        })
    else
        local message = string.format(
            "%s heeft een offline ban ontvangen | Reden: %s | Duur: %s",
            eventData.targetName,
            eventData.reason or "Geen reden opgegeven",
            eventData.durationInput or "Permanent"
        )
        TriggerClientEvent('chat:addMessage', -1, {
            template =
            '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">ADMIN SYSTEEM</span></b><div style="margin-top: 5px; font-weight: 300; color: #e1e1e1;">{0}</div></div>',
            args = { message }
        })
    end

    local embed = {
        {
            ["color"] = 16711680,
            ["title"] = "👋 Banned",
            ["description"] = "Een stafflid heeft een speler gebanned.",
            ["fields"] = {
                {
                    ["name"] = "🔰 Stafflid:",
                    ["value"] = string.format("%s", eventData.author),
                    ["inline"] = true
                },
                {
                    ["name"] = "👶 Speler:",
                    ["value"] = string.format("%s", eventData.targetName),
                    ["inline"] = true
                },
                {
                    ["name"] = "⌛ Duur:",
                    ["value"] = string.format("%s", eventData.durationInput),
                    ["inline"] = true
                },
                {
                    ["name"] = "💬 Reden:",
                    ["value"] = string.format("```%s```", eventData.reason),
                    ["inline"] = false
                },
            },
            ["footer"] = {
                ["text"] = 'Fluxion Scripts',
            }
        }
    }
    sendToDiscord(
        'https://discord.com/api/webhooks/1333830935837413376/z2uJ-KJ8x_O2TWboBqwJvhZvk764OoDXUh-Y4NNGKn3k8SLhDncay27peS3gRRrig2fA',
        embed)
end)


AddEventHandler('txAdmin:events:scheduledRestartSkipped', function(eventData)
    if eventData then
        CreateThread(function()
            for _, playerId in pairs(ESX.GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(playerId)
                if xPlayer then
                    xPlayer.showNotification('Server restart gaat niet door!', 'warning', 5000)
                end
            end
        end)
    end

    local embed = {
        {
            ["color"] = 8421504,
            ["title"] = "📩 Restart canceled",
            ["description"] = "Een stafflid heeft de restart gecanceld.",
            ["fields"] = {
                {
                    ["name"] = "🔰 Stafflid:",
                    ["value"] = string.format("%s", eventData.author),
                    ["inline"] = true
                },
            },
            ["footer"] = {
                ["text"] = 'Fluxion Scripts',
            }
        }
    }

    sendToDiscord(
        'https://discord.com/api/webhooks/1333830935837413376/z2uJ-KJ8x_O2TWboBqwJvhZvk764OoDXUh-Y4NNGKn3k8SLhDncay27peS3gRRrig2fA',
        embed)
end)



AddEventHandler('txAdmin:events:serverShuttingDown', function(eventData)
    if eventData then
        local embed = {
            {
                ["color"] = 65280,
                ["title"] = "📩 Txadmin restart",
                ["description"] = "Een staff heeft de server plotseling gerestart.",
                ["fields"] = {
                    {
                        ["name"] = "📨 Stafflid:",
                        ["value"] = string.format("%s", eventData.author),
                        ["inline"] = true
                    }
                },
                ["footer"] = {
                    ["text"] = 'Fluxion Scripts',
                }
            }
        }
        sendToDiscord(
            'https://discord.com/api/webhooks/1333830935837413376/z2uJ-KJ8x_O2TWboBqwJvhZvk764OoDXUh-Y4NNGKn3k8SLhDncay27peS3gRRrig2fA',
            embed)
    end
end)


function sendToDiscord(webhook, embed)
    PerformHttpRequest(webhook, function(err, text, headers)
    end, 'POST', json.encode({ embeds = embed }), { ['Content-Type'] = 'application/json' })
end
