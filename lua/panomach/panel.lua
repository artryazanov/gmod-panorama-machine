-- Panorama Machine
-- Copyright (c) 2009 sk89q <http://www.sk89q.com>
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 2 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 
-- $Id$

local function SettingsPanel(panel)
	panel:ClearControls()
	--panel:AddHeader()

    local cbox = panel:AddControl("CheckBox", {
        Label = "Use gm_image",
        Command = "panomach_gm_image",
    })
    
    if not image then
        cbox:SetDisabled(true)
    end

    local cbox = panel:AddControl("CheckBox", {
        Label = "Pre-render to render targets",
        Command = "panomach_prerender",
    })
    
    if GetConVarNumber("panomach_rt_count") == 0 or 
        (image and GetConVar("panomach_gm_image"):GetBool()) then
        cbox:SetDisabled(true)
    end

    local cbox = panel:AddControl("CheckBox", {
        Label = "Use JPEG instead of TGA",
        Command = "panomach_jpeg",
    })
    
    if image and GetConVar("panomach_gm_image"):GetBool() then
        cbox:SetDisabled(true)
    end

	panel:AddControl("Slider", {
		Label = "Screenshot delay:",
		Command = "panomach_delay",
		Type = "Float",
		Min = "0.01",
		Max = "5",
	})
            
    panel:AddControl("Label", {
        Text = "Decreasing the delay minimizes problems with objects in movement during the capture (if not using gm_image or render targets), but it may result in desynchronized captures on slower systems."
    })
end

local function CubicProjectionPanel(panel)
	panel:ClearControls()
	--panel:AddHeader()
    
    panel:AddControl("Button", {
        Label = "Capture Cubic Projection",
        Command = "panomach_cubic",
    })
    
    panel:AddControl("Label", {
        Text = "Your game will freeze momentarily to create the images."
    })
end

local function RectilinearProjectionPanel(panel)
	panel:ClearControls()
	--panel:AddHeader()

	panel:AddControl("Slider", {
		Label = "Change in horizontal degrees:",
		Command = "panomach_rect_hdeg",
		Type = "Int",
		Min = "0",
		Max = "180",
	})

	panel:AddControl("Slider", {
		Label = "Field of view:",
		Command = "panomach_rect_fov",
		Type = "Int",
		Min = "1",
		Max = "180",
	})
    
    panel:AddControl("Button", {
        Label = "Capture Rectilinear Projection",
        Command = "panomach_rectilinear",
    })
    
    panel:AddControl("Label", {
        Text = "Your game will freeze momentarily to create the images."
    })
end

local function StitchableImagesPanel(panel)
	panel:ClearControls()
	--panel:AddHeader()

	panel:AddControl("Slider", {
		Label = "Change in horizontal degrees:",
		Command = "panomach_stitch_hdeg",
		Type = "Int",
		Min = "0",
		Max = "180",
	})

	panel:AddControl("Slider", {
		Label = "Change in vertical degrees:",
		Command = "panomach_stitch_vdeg",
		Type = "Int",
		Min = "0",
		Max = "180",
	})

	panel:AddControl("Slider", {
		Label = "Field of view:",
		Command = "panomach_stitch_fov",
		Type = "Int",
		Min = "1",
		Max = "180",
	})
    
    panel:AddControl("Button", {
        Label = "Capture Stitchable Images",
        Command = "panomach_stitchable",
    })
    
    panel:AddControl("Label", {
        Text = "Your game will freeze momentarily to create the images."
    })
end

local function InformationPanel(panel)
	panel:ClearControls()
	--panel:AddHeader()

    panel:AddControl("Label", {
        Text = "Resolution: " .. tostring(ScrH()) .. " pixels (square)"
    })
    
    if image then
        panel:AddControl("Label", {
            Text = "gm_image: Installed."
        })
    else
        panel:AddControl("Label", {
            Text = "gm_image: Not installed. It provides instant panorama captures, neglecting the need to worry about movement during capture."
        })
    end

    panel:AddControl("Label", {
        Text = "Panorama Machine was created by sk89q <http://www.sk89q.com>."
    })
end

local function PopulateToolMenu()
	spawnmenu.AddToolMenuOption("Utilities", "Panorama Machine", "PanoMachSettings", "Settings", "", "", SettingsPanel)
	spawnmenu.AddToolMenuOption("Utilities", "Panorama Machine", "PanoMachInfo", "Information", "", "", InformationPanel)
	spawnmenu.AddToolMenuOption("Utilities", "Panorama Machine", "PanoMachCubic", "Capture Cubic", "", "", CubicProjectionPanel)
	spawnmenu.AddToolMenuOption("Utilities", "Panorama Machine", "PanoMachRect", "Capture Rectilinear", "", "", RectilinearProjectionPanel)
	spawnmenu.AddToolMenuOption("Utilities", "Panorama Machine", "PanoMachStitch", "Capture Stitchable", "", "", StitchableImagesPanel)
end

hook.Add("PopulateToolMenu", "PanoMach", PopulateToolMenu)

function PanoMach.UpdatePanels()
    SettingsPanel(GetControlPanel("PanoMachSettings"))
    InformationPanel(GetControlPanel("PanoMachInfo"))
end