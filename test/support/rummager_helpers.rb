module RummagerHelpers
  def stub_most_recent_content(reject_link, taxon_content_ids, content_link_count, supergroup)
    results = generate_search_results(content_link_count, supergroup)
    stub_for_taxon_and_supergroup(reject_link, taxon_content_ids, results, supergroup, "-public_timestamp")
  end

  def stub_most_popular_content(reject_link, taxon_content_ids, content_link_count, supergroup)
    results = generate_search_results(content_link_count, supergroup)
    stub_for_taxon_and_supergroup(reject_link, taxon_content_ids, results, supergroup, "-popularity")
  end

  def stub_for_taxon_and_supergroup(reject_link, content_ids, results, filter_content_purpose_supergroup, order_by)
    fields = %w(title
                link
                description
                content_store_document_type
                public_timestamp
                organisations)

    params = {
        start: 0,
        count: 5,
        fields: fields,
        filter_part_of_taxonomy_tree: content_ids,
        order: order_by,
        filter_content_purpose_supergroup: filter_content_purpose_supergroup,
        reject_link: reject_link,
    }

    Services.rummager.stubs(:search)
        .with(params)
        .returns(
          "results" => results,
          "start" => 0,
          "total" => results.size
        )
  end

  def generate_search_results(count, supergroup)
    count.times.map do |number|
      rummager_document_for_supergroup_section("content-item-#{number}", supergroup)
    end
  end

  def rummager_document_for_supergroup_section(slug, content_store_document_type)
    {
        'title'                       => slug.titleize.humanize.to_s,
        'link'                        => "/#{slug}",
        'description'                 => 'A discription about tagged content',
        'content_store_document_type' => content_store_document_type,
        'public_timestamp'            => 1.hour.ago.iso8601,
        'organisations'               => [{ 'title' => "#{content_store_document_type.humanize} Organisation Title" }]
    }
  end

  def assert_includes_params(expected_params)
    search_results = {
        'results' => [
          {
              'title' => 'Doc 1'
          },
          {
              'title' => 'Doc 2'
          }
        ]
    }

    Services.
        rummager.
        stubs(:search).
        with { |params| assert_includes_subhash(expected_params, params) }.
        returns(search_results)

    results = yield

    assert_equal(results.count, 2)

    assert_equal(results.first["title"], 'Doc 1')
    assert_equal(results.last["title"], 'Doc 2')
  end
end