module Highlightable
  extend ActiveSupport::Concern
  included do
    validate :single_highlight

    def single_highlight
      any_entity = has_any_other_highlighted?(Movie)
      any_entity ||= has_any_other_highlighted?(Serie)

      errors.add(:base, 'Only one highlighted entity is permitted') if highlighted && any_entity
    end

    def has_any_other_highlighted?(model)
      records = model.where(highlighted: true)
      return records.where.not(id: id).any? if instance_of?(model)

      records.any?
    end
  end
end
