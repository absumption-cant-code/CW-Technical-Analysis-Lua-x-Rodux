--[[
    @name Combat Warriors Programming & Management Application, Technical Demonstration, Rodux, Server
    @author Michael (Absumption) (absumptioncantcode@gmail.com)
    @description
        This file is part of the CW-P&MA Repository and is used to demonstrate
        my familitarity and knowledge of Rodux as well as my personal code styling
        tendencies.

    @notes
        -> This file isn't meant to be the best implementation for what it is trying to achieve, there are better ways
        to handle user - state management through Rodux using less functionality. 
        -> Since this is meant to be a very small file and project, it may seem overly documented. 
        I take pride in making my code exetremely readable and clean while maintaining performance
        and compatibility. I organize most of my code into overall sections and break it down deepending
        on what its purpose is.
]]


-- Game Services
local Players: Players = game:GetService('Players')
local ReplicatedStorage: ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Directories
local Libraries: Folder = ReplicatedStorage.Common:FindFirstChild('Libraries')
local Databases: Folder = ReplicatedStorage.Common:FindFirstChild('Databases')

-- Dependencies
local Rodux: Rodux = require(Libraries:FindFirstChild('Rodux'));
local Monetization: any = require(Libraries:FindFirstChild('Monetization'));

-- Type Declarations
type Action = (args: any) -> {}
type Updater = Rodux.Reducer
type Store = Rodux.Store

-- Action Declarations
local DispatchUserData: Action = Rodux.makeActionCreator('userData', function(player: Player)
    return { player = player }
end)

local DispatchMonetizationData: Action = Rodux.makeActionCreator('monetizationData', function(data: Monetization.MonetizationData)
    return { data = data }
end)

-- Compartmental Reducer Declarations
local UpdateUserData: Updater = Rodux.createReducer({}, {
    userData = function(state: {}, action: {}) 
        local player: Player = action.player
        
        local userId: number = player.UserId
        local userName: string = player.name
        local displayName: string = player.DisplayName

        local isPremium: boolean = player.MembershipType == Enum.MembershipType.Premium
        local isInfluential: boolean = player.HasVerifiedBadge
    
        return {
            id = userId,
            name = userName,
            preferredName = displayName,
            
            isPremium = isPremium,
            isInfluential = isInfluential
        }
    end
})

local UpdateMonetizationData: Updater = Rodux.createReducer({}, {
    monetizationData = function(state: {}, action: {}) return action.data end
})

-- Top Reducer Declarations
local ReducePlayerData: Updater = Rodux.combineReducers({
    User = UpdateUserData,
    Monetization = UpdateMonetizationData
})

-- Store Declarations
local PlayerData: Store = Rodux.Store.new(ReducePlayerData, {}, { Rodux.loggerMiddleware })

-- Hooks
Players.PlayerAdded:Connect(function(player: Player)
    PlayerData:dispatch(DispatchUserData(player))
    PlayerData:dispatch(DispatchMonetizationData(Monetization))
end)
