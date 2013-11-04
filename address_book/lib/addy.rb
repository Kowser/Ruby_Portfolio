class AddressBook
  def initialize
    @list = []
  end

  attr_reader :list

  def add_contact(contact)
    @list << contact
  end

  def delete_contact_by_index(contact_index)
    @list.delete_at(contact_index - 1)
  end

  def delete_contact_by_name(full_name)
    @list.each_with_index do |contact, index| 
      @list.delete_at(index) if contact.full_name == full_name
    end
  end

  def search_list(search_term)
    results = []
    @list.each do |contact|
      results << contact.full_name if contact.full_name.downcase.include?(search_term)
    end
    results
  end
end
