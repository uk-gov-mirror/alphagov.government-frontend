Rails.application.routes.draw do
  unless Rails.env.production?
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get "random/:schema" => "randomly_generated_content_item#show"
  end

  root to: "development#index"

  mount GovukPublishingComponents::Engine, at: "/component-guide"

  get "/healthcheck",
      to: GovukHealthcheck.rack_response(
        GovukHealthcheck::RailsCache,
      )

  get "/healthcheck/live", to: proc { [200, {}, %w[OK]] }
  get "/healthcheck/ready", to: GovukHealthcheck.rack_response(
    GovukHealthcheck::RailsCache,
  )

  get "/government/uploads/*path" => "asset_manager_redirect#show", format: false

  # Testing guides as a single page so we redirect parts to the default page
  get "/how-to-vote/:chapter", to: redirect("/how-to-vote#%{chapter}")

  get "*path/:variant" => "content_items#show",
      constraints: {
        variant: /print/,
      }

  get "*path(.:locale)(.:format)" => "content_items#show",
      constraints: {
        format: /atom/,
        locale: /\w{2}(-[\d\w]{2,3})?/,
      }

  post "*path" => "content_items#service_sign_in_options"
end
