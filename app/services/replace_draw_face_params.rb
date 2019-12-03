class ReplaceDrawFaceParams
  def self.process(upload_params)
    obj = new(upload_params)
    obj.run
  end

  def initialize(upload_params)
    @file_data = JSON.parse(upload_params[:data])
    @new_file_name = upload_params[:new_name]
    @old_file_name = upload_params[:old_name]
    @new_index = upload_params[:new_face_index]
    @old_index = upload_params[:old_face_index]
  end

  def run
    @file_data['events'].each do |event|
      next if event.nil? || event.blank?
      event['pages'].each do |page|
        page['list'].each do |item|
          if matching_code_and_parameters?(item)
            item['parameters'][0] = @new_file_name
            item['parameters'][1] = @new_index
          end
        end
      end
    end
    JSON.generate(@file_data)
  end

  private

  def matching_code_and_parameters?(item)
    item['code'] == 101 &&
      item['parameters'][0] == @old_file_name &&
      item['parameters'][1].to_i == @old_index.to_i
  end
end