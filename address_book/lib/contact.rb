class Contact
  attr_reader :full_name, :phone, :address, :email, :type, :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @full_name = first_name + " " + last_name
  end

  def edit_first_name(first_name)
    @first_name = first_name
    @full_name = first_name + " " + last_name
  end

  def edit_last_name(last_name)
    @last_name = last_name
  end

  def add_phone(number)
    @phone = number
  end

  def add_address(street_address)
    @address = street_address
  end

  def add_email(email_address)
    @email = email_address
  end

  def define_type(contact_type)
    type_list = {1=> "Family", 2=> "Business"}
    @type = type_list[contact_type]
  end  
end
