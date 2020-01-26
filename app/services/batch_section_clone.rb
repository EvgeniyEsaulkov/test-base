class BatchSectionClone
  def self.clone(sections, target)
    sections.map do |section|
      SectionClone.new(section, target).clone
    end
  end
end
