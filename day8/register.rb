class Memory
  OPERATOR_MAPPING = {
    "inc" => :+,
    "dec" => :-,
  }

  def initialize
    @registers = Hash.new { 0 }
  end

  def apply(instruction)
    register, operation, amount, _, cond_register, cond_operator, cond_operand = instruction.split

    ruby_operation = OPERATOR_MAPPING[operation]

    if @registers[cond_register].send(cond_operator.to_sym, cond_operand.to_i)
      @registers[register] = @registers[register].send(ruby_operation, amount.to_i)
    end
  end

  def value_at(register_name)
    @registers[register_name]
  end

  def largest_register
    @registers
      .values
      .reduce { |max, x| max > x ? max : x }
  end
end

def largest_register(input)
  mem = Memory.new
  input.split("\n").each { |line| mem.apply(line) }
  mem.largest_register
end
