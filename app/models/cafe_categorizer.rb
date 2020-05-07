class CafeCategorizer
  def initialize(cafe)
    @cafe = cafe
  end

  def categorize_cafe(cafes_ordered_by_chairs_in_ls2)
    prefix = @cafe.post_code.split(' ').first.downcase

    case prefix
    when 'ls1'
      categorize_by_number_of_chairs(prefix)
    when 'ls2'
      categorize_by_chair_percentile(prefix, cafes_ordered_by_chairs_in_ls2)
    else
      @cafe.category = "other"
    end
    
    @cafe.save
  end

  private

  def categorize_by_number_of_chairs(prefix)
    if @cafe.number_of_chairs < 10
      @cafe.category = "#{prefix} small"
    elsif @cafe.number_of_chairs >= 10 && @cafe.number_of_chairs < 100
      @cafe.category = "#{prefix} medium"
    else
      @cafe.category = "#{prefix} large"
    end
  end

  def categorize_by_chair_percentile(prefix, cafes_ordered_by_chairs_in_ls2)
    position = cafes_ordered_by_chairs_in_ls2.index(@cafe) + 1
    percentile  = (position.to_f / cafes_ordered_by_chairs_in_ls2.count) * 100

    if percentile < 50
      @cafe.category = "#{prefix} small"
    elsif percentile >= 50
      @cafe.category = "#{prefix} large"
    end
  end
end
