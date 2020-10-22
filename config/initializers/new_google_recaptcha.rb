if Object.const_defined?('NewGoogleRecaptcha')
  NewGoogleRecaptcha.setup do |config|
    config.site_key   = "6LdjjNYZAAAAABAxg9NTDqySNzRvTABmWepuzDZg"
    config.secret_key = "6LdjjNYZAAAAAMiVK0zE-tR9j4naNMC2iWupOqFM"
    config.minimum_score = 0.5
  end
end
