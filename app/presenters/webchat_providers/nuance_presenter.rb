module WebchatProviders
  class NuancePresenter
    def initialize(base_path)
      @base_path = base_path
    end

    def availability_url
      # "https://www.tax.service.gov.uk/csp-partials/availability/#{webchat_id}"
      "https://hmrc-uk.digital.nuance.com/tagserver/launch/agentAvailability?agentGroupID=#{webchat_id}&businessUnitID=19001214&siteID=10006719"
    end

    def open_url
      #{}"https://www.tax.service.gov.uk/csp-partials/open/#{webchat_id}"
      "/contact#{@base_path.split('/contact')[1]}"
    end

    def redirect_url
      "http://www.qa.tax.service.gov.uk/ask-hmrc/webchat"
    end

    def config
      {
        "open-url": open_url,
        "availability-url": availability_url,
        "redirect-url": redirect_url,
      }
    end

  private

    def webchat_ids
      {
        "/government/organisations/hm-revenue-customs/contact/child-benefit" => "BAC-TC",
        "/government/organisations/hm-revenue-customs/contact/income-tax-enquiries-for-individuals-pensioners-and-employees" => "PTO-PAYE",
        "/government/organisations/hm-revenue-customs/contact/vat-online-services-helpdesk" => "BTAC-VAT",
        "/government/organisations/hm-revenue-customs/contact/national-insurance-numbers" => "PTO-NI",
        "/government/organisations/hm-revenue-customs/contact/self-assessment" => "PTO-SA",
        "/government/organisations/hm-revenue-customs/contact/tax-credits-enquiries" => "BAC-TC",
        "/government/organisations/hm-revenue-customs/contact/vat-enquiries" => "BTAC-VAT",
        "/government/organisations/hm-revenue-customs/contact/customs-international-trade-and-excise-enquiries" => "BTAC-EXC",
        "/government/organisations/hm-revenue-customs/contact/employer-enquiries" => "PTO-EHL",
        "/government/organisations/hm-revenue-customs/contact/online-services-helpdesk" => "PTO-OSH",
        "/government/organisations/hm-revenue-customs/contact/charities-and-community-amateur-sports-clubs-cascs" => 1087,
        "/government/organisations/hm-revenue-customs/contact/enquiries-from-employers-with-expatriate-employees" => 1089,
        "/government/organisations/hm-revenue-customs/contact/share-schemes-for-employees" => 1088,
        "/government/organisations/hm-revenue-customs/contact/non-uk-expatriate-employees-expats" => 1089,
        "/government/organisations/hm-revenue-customs/contact/non-resident-landlords" => 1086,
      }
    end

    def webchat_id
      webchat_ids[@base_path].presence
    end
  end
end
