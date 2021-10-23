# Acessando uma API pública e vendo se vai chover :cloud_with_rain: :rainbow: 

Antes de mais nada o que é uma API (Application Process Interface), é uma forma de se pegar informações disponíveis na internet ou em outras redes de computadores, através do envio de uma requisição HTTP.

As requisições são formas de comunicação do protocolo HTTP (Hyper Text Transfer Protocol), com outros servidores ou como gosto de chamar 'máquinas' que fazem a ponte ou elo de ligação com o nosso sistema, essas requisições acontecem toda vez que acessamos a   web e podem ser de diferentes tipos.

Nesse breve tutorial vamos utilizar a linguagem de programação Ruby, pois ela é amiga d@ programador@, para acessar uma API pública do Centro de Previsão do Tempo e Estudos Climáticos do Instituto Nacional de Pesquisas Espacias ( CPTEC/INPE ) e assim conseguirmos predizer se vai chover ou não. Olha que coisa legal, seu próprio aplicativo de previsão do tempo, bacana demais , né!! :smile: :tada:

As API's normalmente possuem regras para utilização, abaixo as regras da API que vamos utilizar.

![CPTEC/INPE](/home/adalberto/github/challenges-back-end/tutoriais/api/images/termosusocptec.png)

1- Vamos utilizar a linguagem amiga d@ programador@ a Ruby versão 3.0. Você pode acessar e instalar a mesma na sua máquina ou utilizar alguma IDE online. https://www.ruby-lang.org/pt/

2- Depois de instalar a Ruby, devemos instalar algumas 'gems' , que são as bibliotecas que facilitam a nossa vida e assim conseguimos rodar a nossa aplicação CLI ( command-line interface ) ou programa de interface da linha de comando ou então app do terminal, sim o terminal :computer:, com aquela tela e o prompt, prontas para lhe dar as boas vindas e fazer :100: utilidades por você.

3- Segue a nossa listinha de super gems :gem:

:floppy_disk:rake ,:floppy_disk:nokogiri, :floppy_disk:rest-client, :floppy_disk:httparty, :floppy_disk:activesupport-core-ext, :floppy_disk:json

Mais detalhes no site [https://rubygems.org](https://rubygems.org).

4- Agora dentro do nosso super teminal linux, vamos criar um diretório para começar a escrever a nossa CLI, vou nomear a minha de vaichover, mas você :family_woman_woman_girl_girl: pode colocar o nome que quiser.

```bash
mkdir vaichover
```

5- E agora finalmente vamos codar :keyboard::keyboard:

6- Abra a sua IDE, ou chame o Vi ou VIM, recomendo o VSCode e crie um arquivo com extensão rb que é o tipo de arquivo que a Ruby lê.

7- Dê um nome para a sua aplicação a minha vai se chamar vaichover.rb, pois esta muito calor :hot_pepper::sunny:

8- Bom de cara, precisamos declarar aquelas gems do passo 3, mas espera... __você não explicou como eu vou instalar elas no meu pc...__ops, calma, foi proposital, você pode instalar todas as gemas ou pacotes através do comando:

```bash
gem install nome_da_gema
```

9- Feito isso estamos prontas para fazer a mágica acontecer...

Vamos começar digitando as nossas famosas gems, dentro do arquivo vaichover.rb

![](/home/adalberto/github/challenges-back-end/tutoriais/api/images/gemasrequire.png)

10- Bom já estamos com a primeira parte, ok e se você chegou até aqui,  meu Muito Obrigado!!:cake::confetti_ball:

11- Precisamos agora criar a nossa classe PrevisaoTempo, você pode escolher o nome que quiser. Lembre de usar letras Maiúsculas para ficar diferenciada a aplicação, apenas uma boa prática.

A estrutura em Ruby de uma classe seria assim: 

```ruby
class PrevisãoTempo
    def initialize()
    end
end
```

Mas não precisamos de tudo isso, visto que vamos apenas que acessar uma api pública e não vamos inicializar nenhuma variável no começo então nosso programa vaichover.rb ficará incialmente assim:

```ruby
class PrevisaoTempo
   include HTTParty
   base_uri "http://servicos.cptec.inpe.br/XML/cidade"
end
```

O include HTTParty e o base_uri servem para que possamos acessar o site onde esta a nossa API, para mais informações você pode consutar tanto o site da API do CPTEC/INPE bem como a gem httparty, mas basicamente estamos preparando as fundações de nosso app.

12- Esse passo aqui é muito importante, pois devemos nos hidratar  :droplet:, então que tal uma pausa? Feche um pouco os olhos, respire a flor profundamente e solte o ar pela boca (minha avó fazia a gente fazer isso e funciona...não precisa ter uma flor viu), mas como eu tenho essa aqui, vai pra você :rose:, continuando ...

Vamos agora criar o nosso método que vai chamar, não uma vez  mais duas vezes a mesma API e usando duas gems diferentes, eita que coisa né, e ainda por cima vai transformar a resposta da API que é XML em JSON, se não sabe esses termos vou deixar links nas referências para aprofundar os estudos, aprender nunca é demais.

```ruby
require "nokogiri"
require "restclient"
require "httparty"
require "active_support/core_ext/hash"
require "json"

class PrevisaoTempo
    include HTTParty
    base_uri "http://servicos.cptec.inpe.br/XML/cidade"
    def getClimaCidade4dias(cidade) # método que recebe a variável cidade
        url =  "servicos.cptec.inpe.br/XML/" 
        cidades = Nokogiri::HTML(RestClient.get(url+"/listaCidades?city=#{cidade}"))
        id = cidades.css("id")[0].text
        xml = self.class.get("/#{id}/previsao.xml").to_s # utiliza a base_uri
        xmlToJson = Hash.from_xml(xml).to_json
        #JSON.pretty_generate(xmlToJson) => deixa o arquivo json com mais espaços pode ser bom para visualização ou não, depende do gosto
        end
end
```

Tivemos que acessar duas vezes apenas para tratar de maneira bem fácil a id, visto que no primeiro acesso a API pegamos a lista de cidade e vemos se a nossa cidade esta presente, retornando assim a id da mesma que depois retorna o clima da cidade.

13- Pronto esta aí a nossa API de chamada para o nosso CLI, agora temos duas opções, podemos criar um novo arquivo e usando o comando require_relative "vaichover", rodar a nossa aplicação criando um objeto, esse arquivo deve estar no mesmo diretória do programa vaichover.rb

```ruby
require_relative "vaichover"

previsao = PrevisaoTempo.new
puts previsao.getClimaCidade4dias('nomeDaCidade') # imprime a previsão da cidade em formato json
```

14- Outra forma é no terminal do linux digitarmos o programa irb e testarmos o arquivo vaichover.rb

![](/home/adalberto/github/challenges-back-end/tutoriais/api/images/irb.png)

15- Muitas coisas podem ser melhoradas, nesse singelo acesso a API, tais como tratamento dos acentos, imprimir de uma maneira mais bonita e legal o resultado, mas aí deixo como vocês, grandes amigas usando o poder :battery: realizar as melhorias, inclusive nesse 'pequeno' tutorial. Ufa conseguimos acessar a API e agora vamos ficar na torcida pela chuva :cloud_with_lightning_and_rain: porque depois sempre tem o :rainbow:

Grande abraço e muito obrigado pela oportunidade de contribuir.

Referências:

1- Guias de instalação de gemas em ruby => https://guides.rubygems.org/rubygems-basics/#installing-gems

2- Guia de utização da API do CPTEC /INPE => http://servicos.cptec.inpe.br/XML/

3- Site de instalação da Linguagem Amiga d@ Programador@ => https://www.ruby-lang.org/pt/

Ps: Vou deixar o meu programa pronto, caso queira executar ele no terminal, após instalar o ruby você pode usar o bundle install para instalar todas as gemas de uma só vez.

```bash
bundle install
```

+++++++ Fim.

