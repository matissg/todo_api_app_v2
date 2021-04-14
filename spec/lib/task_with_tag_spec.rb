require 'rails_helper'

describe TaskWithTag do
  subject(:save) { instance.save }

  let(:instance) { described_class.new(Task) }

  include_examples 'a resource with tags save', Task
end
