extends RichTextLabel

#TODO: Criar singleton para armazenar e obter game seed para os geradores de operações
var sumGenerator = SumGenerator.new(null)

enum operation_types {
	one_digit_res,
	one_digit_unres,
	two_digit_res,
	two_digit_unres,
	three_digit_res,
	three_digit_unres
}

func generate_questions(operation_type):
	pass