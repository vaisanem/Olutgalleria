class Place < OpenStruct
  def self.rendered_fields
    [:id, :name, :status, :street, :phone, :city, :zip, :country, :overall]
  end

  def self.contact_info
    [:street, :phone, :city, :zip, :country]
  end
end
