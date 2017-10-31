# rogpe [ Cart ]

Create a car

Exemplo da aplicação: https://cartest.herokuapp.com/

[www.about.me/rodolfopeixoto](http://www.about.me/rodolfopeixoto) 

Versão do Projeto 0.1
================

Version
---------------------
Site desenvolvido:
Utilizei: 
 - Bootstrap 3.2
 - Ruby on Rails 5.1
 - Redis
 

WARNING
---------------------



Pré-Requisito
---------------------

- Docker
- Docker-Compose




Install
---------------------
[Install Docker - Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-16-04)


Command
--------------------
After installing just generate the commands inside the folder:

Build image in docker
```
docker-compose build
```

Start Server
```
docker-compose up
```

Generate database
```
docker-compose run --rm web rails db:create db:migrate db:seed
```

Documentation
----------------------

### Links diretos:


Desenvolvimento
---------------------
-   [Rodolfo Peixoto](http://www.rogpe.me)
