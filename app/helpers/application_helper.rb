# frozen_string_literal: true

module ApplicationHelper
  def dynamic_fields_for(f, association, name = 'Add', &block)
    # stimulus:      controller v
    tag.div data: { controller: 'dynamic-fields' } do
      safe_join([
                  # render existing fields
                  f.fields_for(association, &block),

                  # render "Add" button that will call `add()` function
                  # stimulus:         `add(event)` v
                  button_tag(name, data: { action: 'dynamic-fields#add' }),

                  # render "<template>"
                  # stimulus:           `this.templateTarget` v
                  tag.template(data: { dynamic_fields_target: 'template' }) do
                    f.fields_for association, association.to_s.classify.constantize.new,
                                 child_index: '__CHILD_INDEX__', &block
                  end
                ])
    end
  end

  def button_to_add_fields(f, type)
    new_object = f.object.send(:"build_#{type}")
    name = "#{type}_fields"

    tag.span data: { controller: 'dynamic-fields' } do
      safe_join([
                  button_tag(button_label[type], data: { action: 'dynamic-fields#add' }),

                  tag.template(data: { dynamic_fields_target: 'template' }) do
                    f.send(name, new_object, child_index: '__CHILD_INDEX__') do |builder|
                      render(name, f: builder)
                    end
                  end
                ])
    end
  end

  def button_to_remove_fields
    button_tag('Remove', data: { action: 'remove-field#remove' })
  end

  def button_label
    {
      value: 'Add Value',
      condition: 'Add Condition',
      sort: 'Add Sort',
      grouping: 'Add Condition Group'
    }.freeze
  end

  def condition_fields
    %w[fields condition].freeze
  end

  def value_fields
    %w[fields value].freeze
  end
end
