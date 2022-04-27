class TemperaturesController < ApplicationController
  def set_offset
    if offset_value[:value].present?
      SystemConfig['offset'] = offset_value[:value]
      render status: 200
    else
      render json: {value: ["can't be blank"]}, status: 400
    end
  end

  def create_temperature
    tmp = Temperature.new(value: temperature_value[:value])
    if tmp.save
      render status: 200
    else
      render json: tmp.errors, status: 400
    end
  end

  def list_temps
    render json: Temperature.since(search_params[:since]).till(search_params[:till]), status: 200
  end

  private

  def temperature_value
    params.permit(:value)
  end

  def offset_value
    params.permit(:value)
  end

  def search_params
    params.permit(:since, :till)
  end
end
