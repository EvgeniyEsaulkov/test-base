class Assessment
  delegate :impacts, :likelihoods, to: :@scale
  delegate :impact, :likelihood, to: :@risk

  def initialize(risk, scale)
    @risk, @scale = risk, scale
  end

  def score
    impact_score * likelihood_score
  end

  private

  def impact_score
    score = impacts.index(impact) || 0

    score + 1
  end

  def likelihood_score
    score = likelihoods.index(likelihood) || 0

    score + 1
  end
end
