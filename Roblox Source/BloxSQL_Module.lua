--[[
Copyright 2021 Harry Madgwick

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

This Software was developed by Harry Madgwick:
HarryCodes - Programmer, Web Developer, Project Manager
]]

local BloxSQL = {}
local HttpService = game:GetService("HttpService")

local function Post(packet)
	local posted = HttpService:PostAsync("http://bloxsql.harrystech.xyz:25565/v1", packet, Enum.HttpContentType.ApplicationJson, false)
	local returnData
	local success, err = pcall(function()
		returnData = HttpService:JSONDecode(posted)
	end)
	
	if success then
		return returnData
	else
		return(err)
	end
end

function BloxSQL:execute(QuerySQL, settings)
	local Host = settings.SQL.Host
	local Username = settings.SQL.Username
	local Password = settings.SQL.Password
	local Database = settings.SQL.Database
	
	if Host ~= nil then
		if Username ~= nil then
			if Password ~= nil then
				if Database ~= nil then
					local Data = {
						Host = settings.SQL.Host,
						Username = settings.SQL.Username,
						Password = settings.SQL.Password,
						Database = settings.SQL.Database,
						Query = QuerySQL
					 }
					
					local response = Post(HttpService:JSONEncode(Data))
					return response
				else
					return("BloxSQL: Database not found!")
				end
			else
				return("BloxSQL: Password not found!")
			end
		else
			return("BloxSQL: Username not found!")
		end
	else
		return("BloxSQL: Host not found!")
	end
end

return BloxSQL
