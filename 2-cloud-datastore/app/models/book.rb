# Copyright 2015, Google, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START book_class]
require "google/cloud/datastore"

class Book

  attr_accessor :id, :title, :author, :published_on, :description

  # Return a Google::Cloud::Datastore::Dataset for the configured dataset.
  # The dataset is used to create, read, update, and delete entity objects.
  def self.dataset
    @dataset ||= Google::Cloud::Datastore.new(
      project: Rails.application.config.
                     database_configuration[Rails.env]["dataset_id"]
    )
  end

  # [START query]
  # Query Book entities from Cloud Datastore.
  #
  # returns an array of Book query results and a cursor
  # that can be used to query for additional results.
  def self.query options = {}
    query = Google::Cloud::Datastore::Query.new
    query.kind "Book"
    query.limit options[:limit]   if options[:limit]
    query.cursor options[:cursor] if options[:cursor]

    results = dataset.run query
    books   = results.map {|entity| Book.from_entity entity }

    if options[:limit] && results.size == options[:limit]
      next_cursor = results.cursor
    end

    return books, next_cursor
  end
  # [END query]

  def self.all
    query = Google::Cloud::Datastore::Query.new
    query.kind "Book"

    results = dataset.run query
    results.map {|entity| Book.from_entity entity }
  end

  # [START from_entity]
  def self.from_entity entity
    book = Book.new
    book.id = entity.key.id
    entity.properties.to_hash.each do |name, value|
      book.send "#{name}=", value if book.respond_to? "#{name}="
    end
    book
  end
  # [END from_entity]

  # [START find]
  # Lookup Book by ID.  Returns Book or nil.
  def self.find id
    query    = Google::Cloud::Datastore::Key.new "Book", id.to_i
    entities = dataset.lookup query

    from_entity entities.first if entities.any?
  end
  # [END find]

  # Add Active Model support.
  # Provides constructor that takes a Hash of attribute values.
  include ActiveModel::Model

  # [START save]
  # Save the book to Datastore.
  # @return true if valid and saved successfully, otherwise false.
  def save
    if valid?
      entity = to_entity
      Book.dataset.save entity
      self.id = entity.key.id
      true
    else
      false
    end
  end
  # [END save]

  # [START to_entity]
  # ...
  def to_entity
    entity                 = Google::Cloud::Datastore::Entity.new
    entity.key             = Google::Cloud::Datastore::Key.new "Book", id
    entity["title"]        = title
    entity["author"]       = author       if author
    entity["published_on"] = published_on if published_on
    entity["description"]  = description  if description
    entity
  end
  # [END to_entity]

  # [START validations]
  # Add Active Model validation support to Book class.
  include ActiveModel::Validations

  validates :title, presence: true
  # [END validations]

  # [START update]
  # Set attribute values from provided Hash and save to Datastore.
  def update attributes
    attributes.each do |name, value|
      send "#{name}=", value if respond_to? "#{name}="
    end
    save
  end
  # [END update]

  # [START destroy]
  def destroy
    Book.dataset.delete Google::Cloud::Datastore::Key.new "Book", id
  end
  # [END destroy]

##################

  def persisted?
    id.present?
  end
end
# [END book_class]