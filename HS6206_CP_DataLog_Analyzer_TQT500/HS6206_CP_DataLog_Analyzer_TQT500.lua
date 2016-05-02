print "\n\n------------------\nHello, world\n"

ft = {
[[d:\Users\hgz\Documents\work\LuaScripts\HS6206_CP_DataLog_Analyzer_TQT500\03#-R.LOG]],
---[[d:\Users\hgz\Documents\work\LuaScripts\HS6206_CP_DataLog_Analyzer_TQT500\05#-R.LOG]],
---[[d:\Users\hgz\Documents\work\LuaScripts\HS6206_CP_DataLog_Analyzer_TQT500\07#-2R.LOG]],
}

analyze_bin4 = function (filename) 
	print("filename = "..filename)
	local lines = {}
	for line in io.lines(filename) do table.insert(lines, line); end

	dut = { bin4_lock = 109, bin4_gate = 45; {},{}}
	dut[1].bin4 = {
		--v = {};
		out_of_limit = {};
		tb_report_fail = {};
		total = function () return #dut[1].bin4.out_of_limit + #dut[1].bin4.tb_report_fail end;
		v_lt_gate = {};
		v_gt_gate = {};
		v_lock = {};
	}
	dut[2].bin4 = {
		--v = {};
		out_of_limit = {};
		tb_report_fail = {};
		total = function () return #dut[2].bin4.out_of_limit + #dut[2].bin4.tb_report_fail end;
		v_lt_gate = {};
		v_gt_gate = {};
		v_lock = {};
	}


	func_bin4 = function (site, i, v)
		if (v:find("DUT"..site.." FAIL  =>  BIN04")) then
			for j = i-1, 1, -1 do
				if (lines[j]:find("DPS"..site) and lines[j]:find("35.000uA")) then
				--if (lines[j]:find("DPS"..site.."[gs]+".."35.000uA")) then
					--print(j, lines[j])
					local ws = {}
					for w in string.gmatch(lines[j], "%g+") do ws[#ws+1] = w end
					--print("hi ", table.unpack(ws))
					table.insert(dut[site].bin4.out_of_limit, tonumber(ws[4]:sub(1,-3)));
					break
				elseif (lines[j]:find("DUT"..site.." RUN <COM03>") and lines[j]:find("FAIL")) then
					--print(j, lines[j])
					table.insert(dut[site].bin4.tb_report_fail, j);
					break
				end
			end
			return true
		else
			return false
		end
	end

	for i, v in ipairs(lines) do
		if (func_bin4(1, i, v)) then
		else
			func_bin4(2, i, v)
		end
	end

	table.sort(dut[1].bin4.out_of_limit); --dut[1].bin4.out_of_limit:sort() can't work
	table.sort(dut[2].bin4.out_of_limit)

	for site = 1, 2 do
		for i, v in ipairs(dut[site].bin4.out_of_limit) do
			if (v > dut.bin4_lock) then
				table.insert(dut[site].bin4.v_lock, v)
			elseif (v > dut.bin4_gate) then
				table.insert(dut[site].bin4.v_gt_gate, v)
			else
				table.insert(dut[site].bin4.v_lt_gate, v)
			end
		end
	end

	--[[
	print("dut[1].bin4.value:")
	for k,v in pairs(dut[1].bin4.out_of_limit) do print(v) end
	print("dut[2].bin4.value:")
	for k,v in pairs(dut[2].bin4.out_of_limit) do print(v) end
	--]]
	---[[
	--print "\n"
	for site = 1, 2 do
		print "\n"
		print("dut["..site.."].bin4.tb_report_fail = ", #dut[site].bin4.tb_report_fail)
		print("dut["..site.."].bin4.v_lock =\t",  #dut[site].bin4.v_lock)
		print("dut["..site.."].bin4.v_gt_gate =\t",  #dut[site].bin4.v_gt_gate)
		print("dut["..site.."].bin4.v_lt_gate =\t",  #dut[site].bin4.v_lt_gate)
		print("dut["..site.."].bin4.out_of_limit = ", #dut[site].bin4.out_of_limit)
		print("dut["..site.."].bin4.total =\t",  dut[site].bin4.total())
	end
	print("\ndut.bin4.v_gt_gate.total =", #dut[1].bin4.tb_report_fail+#dut[1].bin4.v_lock+#dut[1].bin4.v_gt_gate + #dut[2].bin4.tb_report_fail+#dut[2].bin4.v_lock+#dut[2].bin4.v_gt_gate);
	print("dut.bin4.total =\t", dut[1].bin4.total()+dut[2].bin4.total());
	--]]
end

for i, v in ipairs(ft) do
	print "\n\n-------------------------------"
	print(i)
	analyze_bin4(v)
end
