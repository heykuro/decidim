# frozen_string_literal: true

module Decidim
  # Helpers related to icons
  module IconHelper
    include Decidim::LayoutHelper

    DEFAULT_RESOURCE_TYPE_ICONS = {
      "all" => "apps-2-line",
      "Decidim::Proposals::CollaborativeDraft" => "draft-line",
      "Decidim::Comments::Comment" => "chat-1-line",
      "Decidim::Debates::Debate" => "discuss-line",
      "Decidim::Initiative" => "lightbulb-flash-line",
      "Decidim::Meetings::Meeting" => "map-pin-line",
      "Decidim::Blogs::Post" => "pen-nib-line",
      "Decidim::Proposals::Proposal" => "chat-new-line",
      "Decidim::Consultations::Question" => "question-mark",
      "Decidim::Budgets::Order" => "check-double-line",
      "Decidim::Assembly" => "government-line",
      "Decidim::ParticipatoryProcess" => "treasure-map-line",
      "other" => "question-line"
    }.freeze

    # Public: Returns an icon given an instance of a Component. It defaults to
    # a question mark when no icon is found.
    #
    # component - The component to generate the icon for.
    # options - a Hash with options
    #
    # Returns an HTML tag with the icon.
    def component_icon(component, options = {})
      manifest_icon(component.manifest, options)
    end

    # Public: Returns an icon given an instance of a Manifest. It defaults to
    # a question mark when no icon is found.
    #
    # manifest - The manifest to generate the icon for.
    # options - a Hash with options
    #
    # Returns an HTML tag with the icon.
    def manifest_icon(manifest, options = {})
      if manifest.icon
        external_icon manifest.icon, options
      else
        icon "question-mark", options
      end
    end

    # Public: Finds the correct icon for the given resource. If the resource has a
    # Component then it uses it to find the icon, otherwise checks for the resource
    # manifest to find the icon.
    #
    # resource - The resource to generate the icon for.
    # options - a Hash with options
    #
    # Returns an HTML tag with the icon.
    def resource_icon(resource, options = {})
      if resource.instance_of?(Decidim::Comments::Comment)
        icon "comment-square", options
      elsif resource.respond_to?(:component)
        component_icon(resource.component, options)
      elsif resource.respond_to?(:manifest)
        manifest_icon(resource.manifest, options)
      elsif resource.is_a?(Decidim::User)
        icon "person", options
      else
        icon "bell", options
      end
    end

    def resource_type_icon(resource_type, options = {})
      key = DEFAULT_RESOURCE_TYPE_ICONS.has_key?(resource_type.to_s) ? resource_type.to_s : "other"
      icon DEFAULT_RESOURCE_TYPE_ICONS[key], options
    end
  end
end
