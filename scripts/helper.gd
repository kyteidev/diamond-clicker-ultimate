extends Node

const SUFFIXES = {
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
	for i in range(42, 0, -3):
		if number >= 10.0 ** i:
			var divided: float = floor(number / pow(10.0, i) * 100.0) / 100.0
			var string := "%s%s" % [String.num(divided), SUFFIXES[i]]
			return string
	return str(number)
