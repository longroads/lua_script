local scriptTab = 
{
	[1] = {
		["type"] = "vardef",
		["var_key"] = "a",
		["var_value"] = 10,
	},
	[2] = {
		["type"] = "vardef",
		["var_key"] = "b",
		["var_value"] = {
			["func_args"] = {
				[1] = 1,
				[2] = 2,
			},
			["func_name"] = "varfunc1",
			["type"] = "function",
		},
	},
	[3] = {
		["true_statement"] = {
			[1] = {
				["func_args"] = {
					[1] = 3,
					[2] = 4,
				},
				["func_name"] = "sub_true_func1",
				["type"] = "function",
			},
			[2] = {
				["func_args"] = {
					[1] = 4,
					[2] = 5,
				},
				["func_name"] = "sub_true_func2",
				["type"] = "function",
			},
		},
		["type"] = "condition",
		["condition"] = {
			[1] = {
				["type"] = "cond_item",
				["left_param"] = {
					["func_args"] = {
						[1] = 1,
						[2] = 2,
					},
					["func_name"] = "cond1",
					["type"] = "function",
				},
				["compare"] = ">",
				["right_param"] = "a",
			},
			[2] = {
				[1] = {
					["type"] = "cond_item",
					["left_param"] = {
						["func_args"] = {
							[1] = 3,
							[2] = 4,
						},
						["func_name"] = "cond2",
						["type"] = "function",
					},
					["compare"] = ">",
					["right_param"] = "b",
				},
				[2] = {
					["type"] = "cond_item",
					["left_param"] = {
						["func_args"] = {
							[1] = 5,
							[2] = 6,
						},
						["func_name"] = "cond3",
						["type"] = "function",
					},
					["compare"] = ">",
					["right_param"] = "a",
				},
				["out_logic"] = "",
				["type"] = "cond_combine",
				["in_logic"] = "||",
			},
			[3] = {
				["type"] = "cond_item",
				["left_param"] = {
					["func_args"] = {
						[1] = 7,
						[2] = 8,
					},
					["func_name"] = "cond4",
					["type"] = "function",
				},
				["compare"] = ">",
				["right_param"] = "b",
			},
			["out_logic"] = "",
			["type"] = "cond_combine",
			["in_logic"] = "&&",
		},
		["false_statement"] = {
			[1] = {
				["func_args"] = {
					[1] = 6,
					[2] = 7,
				},
				["func_name"] = "sub_false_func1",
				["type"] = "function",
			},
			[2] = {
				["func_args"] = {
					[1] = 8,
					[2] = 9,
				},
				["func_name"] = "sub_false_func2",
				["type"] = "function",
			},
		},
	},
	[4] = {
		["func_args"] = {
			[1] = 4,
			[2] = 5,
		},
		["func_name"] = "func1",
		["type"] = "function",
	},
	[5] = {
		["func_args"] = {
			[1] = 5,
			[2] = 4,
		},
		["func_name"] = "func2",
		["type"] = "function",
	},
}
return scriptTab
