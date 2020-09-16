class TrefleApiService
  require 'json'
  require 'open-uri'

  def initialize(keyword)
    @keyword = keyword
  end

  def separate_synonyms(synonyms_array)
    synonyms_array.first(3).map do |synonym|
      synonym == synonyms_array.first(3).last ? synonym.to_s : synonym.to_s + ", "
    end
  end

  def if_no_synonym(synonyms)
    if synonyms.size == 0
      "Il n'y a pas de synonyme"
    else
      separate_synonyms(synonyms)
    end
  end

  def delete_family_mention(family_common_name)
    family_common_name.chomp("family") if family_common_name != nil
  end

  def if_no_value(value)
    if value.nil?
      "Non répertorié"
    else
      value.downcase.capitalize
    end
  end

  def if_no_image(image)
    if image.nil? || image == ""
      "https://via.placeholder.com/200x200?text=Pas+d'image+disponible"
    else
      image
    end
  end


  def search_plants
    url = "https://trefle.io/api/v1/species/search?token=#{trefle_key}&q=#{@keyword}&limit=5"

    results = JSON.parse(open(url).read)["data"]
    results.map do |result|
      {
        id: result["id"],
        common_name: if_no_value(result["common_name"]),
        scientific_name: if_no_value(result["scientific_name"]),
        family: if_no_value(result["family"]),
        family_common_name: if_no_value(delete_family_mention(result["family_common_name"])),
        synonyms: if_no_synonym(result["synonyms"]),
        image_url: if_no_image(result["image_url"])
      }
    end
  end

  private

  def trefle_key
    Rails.application.credentials.trefle_access_key
  end
end
