require 'string'


function string:split(sSeparator, nMax, bRegexp)
	sSeparator = sSeparator or ''
	if sSeparator == '' then
		sSeparator = ' '
	end
	if nMax and nMax <= 0 then
		nMax = nil
	end

	local aRecord = {}
	if self:len() > 0 then
		local bPlain = not bRegexp
		nMax = nMax or -1

		local nField=1 nStart=1
		local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
		while nFirst and nMax ~= 0 do
			aRecord[nField] = self:sub(nStart, nFirst-1)
			nField = nField+1
			nStart = nLast+1
			nFirst,nLast = self:find(sSeparator, nStart, bPlain)
			nMax = nMax-1
		end
		aRecord[nField] = self:sub(nStart)
	end
	return aRecord
end

