require 'active_record'

# Protect active records from being destroyed in a declarative way.
module Protective

  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    # Protects a record from being destroyed if the passed method
    # evaluates to #present? upon destruction. If a messag is given,
    # it is added to the corresponding #errors object.
    def protect_if(method, message = nil)
      unless self < InstanceMethods
      	class_attribute :protect_if_methods
        self.protect_if_methods = {}

        before_destroy :destruction_allowed? 
        send :include, InstanceMethods
  	  end
      
      protect_if_methods[method] = message
  	end
  end
   
  module InstanceMethods
  
    # Returns true if this record cannot be destroyed.
    def protected?
      protect_if_methods.keys.any? do |method|
        !protect_method_allows_destruction(method)
      end
    end
  
    # Returns true if this record may be destroyed or
    # adds possible error messages to the #errors object otherwise.
    def destruction_allowed?
      protect_if_methods.all? do |method, message|
        unless allowed = protect_method_allows_destruction(method)
          errors.add(:base, message) if message
        end
        allowed
      end
    end
    
    private
    
    def protect_method_allows_destruction(method)
      value = send(method)
      if value.respond_to?(:empty?) # ar *_many association
        value.empty?
      else
        value.blank?
      end
    end
  end

end

ActiveRecord::Base.send :include, Protective