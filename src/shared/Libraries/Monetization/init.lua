--[[
    @name Combat Warriors Programming & Management Application, Technical Demonstration, Rodux, Monetization
    @author Michael Loconte (michael@ignitionswitch.games)
    @description
        This file is part of the CW-P&MA Repository and is used to provide
        fabricated/dummy monetization data for the purpose of showcasing Rodux
]]

-- Type Declarations
type Array<T> = { [number] : T }

export type PurchaseEntry = { type: string, id: number, date: number }
export type GamepassPurchaseEntry = PurchaseEntry & { type: 'Gamepass' }
export type DevProductPurchaseEntry = PurchaseEntry & { type: 'DevProduct', active: boolean, duration: number? }

export type MonetizationData = {
    gamepasses: Array<GamepassPurchaseEntry>,
    subscriptions : Array<DevProductPurchaseEntry>, 
    history : Array<PurchaseEntry>
}

-- Constant Declarations
local Data: MonetizationData = {
    gamepasses = {},
    subscriptions = { { type = 'DevProduct', id = 000000, date = 99999, active = true } },
    history = { { type = 'DevProduct', id = 000000, date = 142342 } }
}

-- Exports
return Data
