extends Node

const ABBREVIATIONS = {
	3: "k",
	6: "M",
	9: "B",
	12: "T",
	15: "Qa",
	18: "Qi",
	21: "Sx",
	24: "Sp",
	27: "Oc",
	30: "No",
	33: "Dc",
	36: "Ud",
	39: "Dd",
	42: "Td",
}


func shorten_number(number: Variant) -> String:
	for i in range(42, -3):
		if number >= 10 ** i:
			var divided = snapped(float(number) / (10 ** (i - 3)), 0.01)
			var string := "%s%s" % [divided, ABBREVIATIONS[i]]
			return string
	return str(number)
