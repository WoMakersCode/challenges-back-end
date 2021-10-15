# Tutorial de como criar um crud usando java e spring

## Nessa tutorial vamos utilizar as tecnologias:

- java 11
- Spring web
- H2 database
- Spring data
- Lombok

Primeiramente vamos criar a nossa classe model:

```java
@Entity
@Table(name = "meetup")
@Setter
@Getter
@ToString
public class Meetup {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private LocalDateTime date;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private  LocalDateTime updatedAt;

}

```

Essa classe será responsável por ser a nossa tabela, agora vamos configurar o acesso ao banco de dados no arquivo aplication.properties:

```java

#spring.h2.console.enabled=true
#
#spring.datasource.url=jdbc:h2:mem:meetup
#spring.datasource.driverClassName=org.h2.Driver
#spring.datasource.username=sa
#spring.datasource.password=
#
#spring.jpa.show-sql=true
#spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect
#spring.jpa.hibernate.ddl-auto=update

```

Para o Spring Data se comunicar com o banco de dados vamos criar uma nova classe que será a nossa Repository:

```java
@Repository
public interface MeetupRepository extends JpaRepository<Meetup, Long> {
}

```
Também vamos precisar de uma Service, que será responsável por ser intermediária entre a Controller (classe onde criamos o endpoint de fato) e a repository:

Nela teremos métodos para todas as operações CRUD:

```java
@Service
@AllArgsConstructor
public class MeetupService {

    private MeetupRepository meetupRepository;

    public Meetup createMeetup (Meetup meetup){
        return meetupRepository.save(meetup);
    }

    public List<Meetup> listAllmeetups(){
        return meetupRepository.findAll();
    }

    public ResponseEntity<Meetup> findmeetupById(Long id){
        return  meetupRepository.findById(id)
                .map(meetup -> ResponseEntity.ok().body(meetup))
                .orElse(ResponseEntity.notFound().build());
    }

    public ResponseEntity<Meetup> updatemeetupById(meetup meetup, Long id){
        return meetupRepository.findById(id)
                .map(meetupToUpdate ->{
                    meetupToUpdate.setTitle(meetup.getTitle());
                    meetupToUpdate.setDescription(meetup.getDescription());
                    meetupToUpdate.setDeadLine(meetup.getDeadLine());
                    meetup updated = meetupRepository.save(meetupToUpdate);
                    return ResponseEntity.ok().body(updated);
                }).orElse(ResponseEntity.notFound().build());
    }

    public ResponseEntity<Object> deleteById (Long id){
        return meetupRepository.findById(id)
                .map(meetupToDelete ->{
                    meetupRepository.deleteById(id);
                    return ResponseEntity.noContent().build();
                }).orElse(ResponseEntity.notFound().build());

    }

}

```

e por útlimo vamos expor os endpoints na nossa controller para que você possa executar todas as operações CRUD

```java 

@RestController
@RequestMapping("/api/v1")
public class MeetupController {

    @Autowired
    MeetupService meetupService;


    @PostMapping("/meetups")
    @ResponseStatus(HttpStatus.CREATED)
    public meetup createmeetup(@RequestBody Meetup meetup) {
        return meetupService.createmeetup(meetup);
    }

    @GetMapping("/meetups")
    @ResponseStatus(HttpStatus.OK)
    public List<Meetup> getAllmeetups() {
        return meetupService.listAllmeetups();
    }

    @GetMapping("/meetups/{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Meetup> getmeetupById(@PathVariable (value = "id") Long id) {
        return meetupService.findmeetupById(id);
    }

    @PutMapping("/meetups/{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Meetup> updatemeetupById(@PathVariable (value = "id") Long id, @RequestBody meetup meetup) {
        return meetupService.updatemeetupById(meetup,id);
    }

    @DeleteMapping("/meetups/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public ResponseEntity<Object> deletemeetupById(@PathVariable (value = "id") Long id) {
        return meetupService.deleteById(id);
    }

````


[Referência](https://github.com/Kamilahsantos/serie-todo-list-youtube)