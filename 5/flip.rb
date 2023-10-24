require 'chunky_png'

def transform_to_square(image_path, output_path)
  image = ChunkyPNG::Image.from_file(image_path)

  original_width = image.width
  original_height = image.height
  
  # Calculate side of square
  square_side = Math.sqrt(original_width * original_height).ceil
  
  # Create a new square image with a transparent background
  square_image = ChunkyPNG::Image.new(square_side, square_side, ChunkyPNG::Color::TRANSPARENT)
  
  source_x = original_width - 1
  source_y = original_height - 1
  dest_x = 0
  dest_y = 0

  while source_y >= 0
    pixel = image[source_x, source_y]

    square_image[dest_x, dest_y] = pixel

    # Increment destination coordinates and decrement source coordinates
    dest_x += 1
    source_x -= 1

    # If we've moved past the leftmost edge of the original image, move up a row and start from the rightmost pixel
    if source_x < 0
      source_x = original_width - 1
      source_y -= 1
    end

    # If we've filled an entire row of the square image, move to the next row
    if dest_x >= square_side
      dest_x = 0
      dest_y += 1
    end
  end
  
  square_image.save(output_path)
end

# Usage
transform_to_square('matt2016-2.png', 'output.png')
    