require 'active_record'

module Protective

  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
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
  
    def protected?
      protect_if_methods.keys.any? do |method|
        !method_allows_destruction(method)
      end
    end
  
    def destruction_allowed?
      protect_if_methods.all? do |method, message|
        unless allowed = method_allows_destruction(method)
          errors.add(:base, message) if message
        end
        allowed
      end
    end
    
    private
    
    def method_allows_destruction(method)
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