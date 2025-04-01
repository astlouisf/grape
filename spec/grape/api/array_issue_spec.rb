# frozen_string_literal: true

describe Grape::API::Helpers do
  subject do
    Class.new(Grape::API) do
      params do
        optional :z, type: Array do
          requires :a, type: Integer
        end
      end
      post do
        pp params
        declared_params = declared(params, include_missing: false)
        status 200
      end
    end
  end

  def app
    subject
  end

  it 'defines parameters' do
    post '/', { "z": [] }
    expect(last_response.status).to eq 200
  end
end