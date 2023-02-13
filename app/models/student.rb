class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    # validates :age, presence: true
    validate :age_greater_than_or_equal_to_eighteen
    validates :instructor_id, presence: true
    validates_associated :instructor
    validate :instructor_id_blank

    private 

    def instructor_id_blank
        if instructor_id == nil
            return errors.add(:instructor_id, "Instructor ID cannot be blank!")
        end
    end

    def age_greater_than_or_equal_to_eighteen
        if age == nil
            return errors.add(:age, "age cannot be blank!")
        end
        unless age >= 18
            errors.add(:age, "age must be greater than or equal to 18!")
        end
    end
end
