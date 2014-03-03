module FormHelper
  def setup_wiki(wiki)
    wiki.biocard ||= Biocard.new
    2.times { wiki.sections.build }
    wiki
  end
end
 