module Api::Pagination
  extend ActiveSupport::Concern

  def pagination_info(records)
    {
      total_count: records.total_count,
      limit_value: records.limit_value,
      total_pages: records.total_pages,
      current_page: records.current_page
    }
  end
end
