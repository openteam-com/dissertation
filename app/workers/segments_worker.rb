class SegmentsWorker < ResearchItemsWorker
  def perform(grouping_id)
    @grouping = Grouping.find(grouping_id)
    @current_segment_number = 0
    recalculate_segments()
  end

  private

  def recalculate_segments(previous_segment = nil, grouping_parameter = nil, level = 0)
    grouping_parameter ||= @grouping.grouping_parameters.first
    grouping_parameter.grouping_values.each do |value|
      segment_title = value.title
      segment = Segment.create! :title => segment_title, :grouping_value => value, :parent => previous_segment, :grouping => @grouping
      @current_segment_number +=1
      at index_to_percent(@grouping.segments_count, @current_segment_number)
      recalculate_segments(segment, @grouping.grouping_parameters[level+1], level+1) if level+1 < @grouping.grouping_parameters.count
    end
  end
end
