require 'helper'

class ProtectiveTest < Test::Unit::TestCase
  load_schema
 
  class Subject < ActiveRecord::Base
    has_many :attachments
    
    protect_if :attachments, "Still has attachments"
    protect_if :marked
  end
 
  class Attachment < ActiveRecord::Base
    belongs_to :subjects
  end
  
  def test_setup
    assert_equal [], Subject.all
    assert_equal 2, Subject.protect_if_methods.size
  end
  
  def test_empty_subject_may_be_destroyed
    s = Subject.create! :name => 'test'
    assert !s.protected?
    assert s.destroy
  end
  
  def test_marked_subject_may_not_be_destroyed
    s = Subject.create! :name => 'test', :marked => true
    assert s.protected?
    assert !s.destroy
    assert_equal 0, s.errors.count
  end
  
  def test_subject_may_not_be_destroyed_with_attachements
    s = Subject.create! :name => 'test'
    s.attachments.create! :name => 'att'
    assert s.attachments.respond_to?(:empty?)
    assert_equal 1, s.attachments.count
    assert s.protected?
    assert !s.destroy
    assert_equal ["Still has attachments"], Array(s.errors[:base])    
    assert !s.destruction_allowed?
  end
  
  def teardown
    Subject.delete_all
    Attachment.delete_all
  end
  
end
