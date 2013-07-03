if Rails.env.development?
  %w[item book essay].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end
