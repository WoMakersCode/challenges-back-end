# Tutorial de como consumir a API pública do star wars utilizando o webclient do Spring webflux

## Nessa tutorial vamos utilizar as tecnologias:

- java 11
- Spring web flux
- [API do star wars](https://swapi.dev/)


Nessa tutorial você vai aprender como realizar o consumo de informações de outra API utilizando um serviço desenvolvido com Java 11 e Spring Webflux.


Como não utilizaremos nenhuma base de dados só será necessária a dependência do Spring Webflux.


Primeiramente vamos criar a nossa classe PeopleResponse que será responsável por mapear os campos que temos interesse em exibir na nossa aplicação quando for feita a requisição para [https://swapi.dev/api/people/{id}]:

```java
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)


public class PeopleResponse {

    private String name;
    private String hair_color;
    private String birth_year;
    private String homeworld;



}


```

Apesar de termos vários atributos na response desse endpoint como só mapeamos na classe de response aqueles que estamos interessadas em ter acesso no nosso serviço.

Agora vamos criar a classe StarWarsClient que será onde faremos a comunicação entre a nossa aplicação e a API do star Wars.

```java
@Service
public class StarWarsClient {

    private final WebClient webClient;

    public StarWarsClient(WebClient.Builder builder) {
        webClient = builder.baseUrl("https://swapi.dev/api/").build();
    }


    public Mono<PeopleResponse> findPeopleById(String id) {
        return webClient.get()
                .uri("people/" + id)
                .accept(APPLICATION_JSON)
                .retrieve()
                .bodyToMono(PeopleResponse.class);
    }

}
```
O webclient é nativo do webflux com ele podemos facilmente nos comunicar com outras aplicações utilizandos todos os métodos HTTP.


Agora vamos fazer a última classe da nossa aplicação, a StarWarsController:


```java

@RestController
@RequestMapping("/webclient")
public class StarWarsController {

    @Autowired
    StarWarsClient starWarsClient;


    @GetMapping("/people/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Mono<PeopleResponse> getPeopleById(@PathVariable String id) {
        return starWarsClient.findPeopleById(id);

    }


}

```
Para testar basta fazer uma requisição para o endpoint do nosso serviço [http://localhost:8080/webclient/people/{id}] passando o id da pessoa que você deseja consultar na API do star wars, dessa forma o webclient vai receber esse id fazer a consulta lá e retornar para nós a pessoa solicitada com a infos que mapeamos na classe de response.


Até a próxima tutorial :)
