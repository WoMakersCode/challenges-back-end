require "nokogiri"
require "restclient"
require "httparty"
require "active_support/core_ext/hash"
require "json"

# Um dia vai chover aqui na minha terra
# E essa chuva, vai ser muito boa
# Vai trazer felicidades e alegrias
# E como antigamente, todos nós vamos dançar na chuva 
# Ensopados até a alma de felicidades
# Por mais um hacktoberfest conquistado.

# Acessando uma API pública e vendo a chuva já chegar de longe
# API nada mais é do que acessar informações guardadas em outro local pela internet utilizando um aplicativo (programa).
# primeiro vamos declarar quais os pacotes (gems) que precisamos para a mágica do acesso a API acontecer



# objeto previsão do tempo
class PrevisaoTempo 
  include HTTParty
  base_uri "http://servicos.cptec.inpe.br/XML/cidade"

  def getClimaCidade4dias(cidade)
    url =  "servicos.cptec.inpe.br/XML/"
    cidades = Nokogiri::HTML(RestClient.get(url+"/listaCidades?city=#{cidade}"))
    id = cidades.css("id")[0].text
    xml = self.class.get("/#{id}/previsao.xml").to_s
    xmlToJson = Hash.from_xml(xml).to_json
    #JSON.pretty_generate(xmlToJson) => deixa o arquivo json com mais espaços pode ser bom para visualização ou não, depende do gosto
  end
end

