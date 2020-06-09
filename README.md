# Pet Stuffs MVC

[en]

This project is a part of my article serie "Design Patters iOS", the purpouse of article serie is show differents design patters implemented in iOS and take the reader to see advantages and disadvantes each one. I not used external frameworks and create a simple views so that the focus in only design pattern.

In this project you will see MVC pattern implemented, it's a basic pattern on iOS apps and the best to start learn others design patters.

## About project

This project is a simple tools to management stufs of your pets, you can Create, Read, Update and Delete(CRUD) the pets and, for each pet, you can make the CRUD of the pet stuffs.

## About directory struct

The principal directory is the `features`, in this folder you will see the features of this project organized by screen. In each feature folder you can see the ViewController, View storyboard, Models (if needed) and auxiliary files of the corresponding feature like ViewCells and Delegates.

In `Supporting Files` directory I put iOS configuration files like `AppDelegate` and `info.plist`.

And in `Commons` folder has services, utils and others auxiliary classes independent of the features.

The `Supporting Files` and `Commons` directory will be equal in others design patters project to facilitate the focus only the real differente between patterns.

[pt]

Esse projeto é parte da minha série de artivos "Design Patters iOS", o propósito dessa série é mostrar a diferena entre os pardrões de projetos implemento no iOS e levar o leitor a ver as vantagens e desvantagens de cada uma. Não fiz o uso de bibliotecas externas e crie telas simples para que o foco seja apenas nos padrões de projeto.

Nesse projeto você irá ver o padrão MVC implementado, ele é o padrão mais básico do apps iOS e o melhor para começar a aprender os outros padrões.

## Sobre o proejto

Esse projeto é uma simples ferramenta para gerenciar os suplementos dos seus animais de estimação, você pode Criar, Ler, Atualizar e Deletar (CRUD em inglês) os seus animais e, para cada animal, você pode fazer o CRUD dos suplementos do animal.

## Sobre a estrutura do projeto

A principal pasta é a `features`, nessa pasta você podré ver as funcionalidades do projeto separado por tela. Na pasta de cada funcionalidade você irá ver o ViewController, View storyboard, Models (se necessário) e arquivos auxiliares da funcionalidade correspondente como ViewCells and Delegates.

Na pasta `Supporting Files` eu coloquei os arquivos de configuração do iOS como `AppDelegate` e `info.plist`.

E no diretório `Commons` tems os seriviços, utilidades e outros arquivos auxiliares independente das funcionlidades.

As pastas `Supporting Files` e `Commons` será igual nos projetos dos outros padrões para facilitar o foco apenas na real diferença entre os padrões de projeto.
