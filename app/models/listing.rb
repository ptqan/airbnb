class Listing < ActiveRecord::Base
	AMENITIES = ["Essentials", "Towels", "Soap", "Toilet paper", "Wifi", "TV", "Heat", "Air conditioning", "Breakfast, coffee, tea", "Workspace", "Iron", "Hair dryer"]

	RULES = ["Smoking", "Pets", "House party"]

	PROPERTY_TYPES = ['Apartment', 'House', 'Cabin', 'Villa', 'Castle']
	ROOM_TYPES = ['Entire place', 'Private room', 'Shared room']

	after_save :update_tags
	before_validation :add_schedule, if: "new_record?"

	belongs_to :user
	validates :name, :property_type, :room_type, :price, :min_stay, :address, :capacity, :schedule, presence: true
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	belongs_to :city
	has_many :photos, dependent: :destroy
	has_many :reservations

	acts_as_bookable preset: :room

	mount_uploaders :photos, PhotoUploader

	attr_accessor :amenity_list
	attr_accessor :rule_list

	def amenity_list
		if @amenity_list
			return @amenity_list
		else
			return self.taggings.where(context: "amenity").joins(:tag).pluck(:name)
		end
	end

	def rule_list
		if @rule_list
			return @rule_list
		else
			return self.taggings.where(context: "rule").joins(:tag).pluck(:name)
		end
	end

	private
	def update_tags
		self.taggings.destroy_all
		if @amenity_list
			@amenity_list.each do |a|
			tag = Tag.find_or_create_by(name: a)
      tagging = self.taggings.create(tag_id: tag.id, context: "amenity")
    	end
    end
    if @rule_list
	    @rule_list.each do |a|
				tag = Tag.find_or_create_by(name: a)
	      tagging = self.taggings.create(tag_id: tag.id, context: "rule")
	    end
	  end
	end

	def add_schedule
		self.schedule = IceCube::Schedule.new(Date.today, duration: 1.day)
    self.schedule.add_recurrence_rule IceCube::Rule.daily
	end
end
