RailsAdmin.config do |config|

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin == true
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  # partial :category_items_multiselect

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                      # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    #excluding/hiding table
    config.current_user_method(&:current_user)

    config.excluded_models << "State"
    config.excluded_models << "City"
    config.excluded_models << "Zip"
    config.excluded_models << "Country"
    config.excluded_models << "LoanHistory"

    #listing Item model with their actuall name
    config.model 'Item' do
      list do
        # only add these fields to display
        # on the list action
        # vendor_name
        field :vendor do
          # by default belongs_to/has_many association
          # is not queryable, so for references we add
          # this flag if field needs to be searchable
          queryable true
        end

        field :item_status do
          queryable true
        end

        field :item_category do
          queryable true
        end

        field :building do
          queryable true
        end

        field :serial_number

      end
      # list do
      #   field :vendor_name do
      #     searchable :vendor
      #   end
      #   field :status_of_item
      #   field :type_of_tag
      #   field :category
      #   field :building_name
      #   field :serial_number
      # end
    end


    #rearranging column
    if Building.table_exists?
      RailsAdmin.config Building do
        list do
          # simply adding fields by their names (order will be maintained)
          include_fields :id, :building_name, :building_number, :building_code, :created_at, :updated_at
        end
      end
    end


    if Vendor.table_exists?
      RailsAdmin.config Vendor do
        list do
          # simply adding fields by their names (order will be maintained)
          include_fields :id, :vendor_name, :email
        end
      end
    end


    # will only call `vendor_name` if model is a Vendor
    config.model 'Vendor' do
      object_label_method do
        :vendor_name
      end
    end



    # will only call `Item_status` if model is a Vendor
    config.model 'ItemStatus' do
      object_label_method do
        :availability
      end
    end

    # will only call `tag_types`
    config.model 'TagType' do
      object_label_method do
        :tag_type
      end
    end



    # will only call `item_category` if model is a Vendor
    config.model 'ItemCategory' do
      object_label_method do
        :category
      end
    end



    # will only call `building` if model is a Vendor
    config.model 'Building' do
      object_label_method do
        :building_name
      end
    end


    config.model 'PackageRequest' do
      object_label_method do
        :package_request_describer
      end
    end

    config.model ItemLocation do
      object_label_method do
        :item_location_describer
      end
    end

    config.model ItemCategory do
      edit do
        # field :category
        # field :description
        # field :items do
        #   partial :category_items_multiselect
        # end
      end
    end

    config.model Item do
      object_label_method do
        :item_describer
      end


      # list do
      #   filter [:item_name, ]
      # end
    end



    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.main_app_name = ["Concave Consultant"]
  # or something more dynamic
end