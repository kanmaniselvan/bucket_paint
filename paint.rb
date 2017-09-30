class Paint
  def initialize(input_2d_array, x_index, y_index, color)
    if !input_2d_array.is_a?(Array) || input_2d_array.length.zero? || input_2d_array.first.length.zero?
      raise 'Please provide a valid 2d array'
    end

    if color.length.zero?
      raise 'Please provide a valid color value'
    end

    y_index_size = input_2d_array.first.size - 1
    x_index_size = input_2d_array.size - 1
    x_index = x_index.to_i
    y_index = y_index.to_i

    if x_index > x_index_size || y_index > y_index_size
      raise "X and Y values should be within #{x_index_size} and #{y_index_size} respectively"
    end

    @input_2d_array = input_2d_array
    @x_index = x_index
    @y_index = y_index
    @new_color = color
    @input_2d_array_old = input_2d_array.dup
    @old_color = @input_2d_array[x_index][y_index]
  end

  # Recursively paints right, bottom, left and top sides.
  def bucket_paint(x_index = nil, y_index = nil)
    if x_index.nil? || y_index.nil?
      x_index = @x_index
      y_index = @y_index
    end

    # Checks if the adjacent cell's color is same the current cell.
    # On success, it paints the current cell and moves to the next adjacent cells.
    return if @input_2d_array[x_index].nil? || @input_2d_array[x_index][y_index] != @old_color

    @input_2d_array[x_index][y_index] = @new_color

    # Paint right
    bucket_paint(x_index+1, y_index)
    # Paint bottom
    bucket_paint(x_index, y_index+1)
    # Paint left
    bucket_paint(x_index-1, y_index) if x_index-1 >= 0
    # Paint top
    bucket_paint(x_index, y_index-1) if y_index-1 >= 0
  end

  # Displays the output
  def show_image(output_text)
    output_image = "#{output_text}: \n"
    @input_2d_array.each do |x_row_arr|
      output_image += "\t#{x_row_arr.join('')}\n"
    end

    puts output_image, "\n"
  end
end

# Examples:-
input_2d_array = [
    [0, 1, 1, 0],
    [1, 1, 1, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 0]
]


paint = Paint.new(input_2d_array, 0, 1, 'C')
paint.show_image('Input')
paint.bucket_paint
paint.show_image('Output')
