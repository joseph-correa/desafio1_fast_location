# fast_location

Descrição

Este aplicativo foi desenvolvido para o projeto de Desenvolvimento Mobile. O objetivo é otimizar a localização de endereços para entregadores através da consulta de CEP, permitindo salvar um histórico local e abrir a rota diretamente no GPS do celular.

Funcionalidades Principais

Consulta de Endereço: Busca automática via API ViaCEP.
Histórico Offline: Armazenamento dos endereços consultados no banco de dados local (Hive).
Navegação: Botão que abre o Google Maps ou Waze com o endereço selecionado.

Validação: Aviso visual caso o CEP digitado não exista.

Tecnologias e Bibliotecas
Linguagem: Dart / Framework: Flutter.
Gerência de Estado: MobX (Reatividade).
Banco de Dados: Hive (NoSQL).
Comunicação API: Dio (HTTP Client).
Mapas: Map Launcher.
