# NGINX Server Check: Monitoramento do Serviço

## Introdução

Esse projeto organizado no Programa de Bolsas da **Compass UOL** tem como objetivo monitorar o serviço `NGINX` a cada 5 minutos em uma
máquina Linux, no WSL. A minha atividade foi feita no Ubuntu 22.04, no qual a instalação será explicada brevemente. O único requisito
é saber o básico de Linux.

## Índice

Se encontre no passo a passo para se guiar!

- [Atividade](#atividade)
- [Instalação do WSL](#instalação-do-wsl)
- [Configurando o ambiente](#configurando-o-ambiente)
- [Criação do Script de Monitoramento](#criação-do-script-de-monitoramento)
- [Automatizando a verificação](#automatizando-a-verificação)
- [Versionamento](#versionamento)

## Atividade

A atividade que foi passada requer que a gente atualize o serviço `NGINX` a cada 5 minutos, informando data e hora e seu status, Online
ou Offline, gerando um arquivo de log para cada.

## Instalação do WSL

### O que é WSL?

O WSL *(não a liga mundial de surfe)* é um **Subsistema do Windows** que disponibiliza um ambiente Linux compatível com o sistema da Microsoft.
Existem duas versões, o WSL 1 e o WSL 2, onde a segunda aumenta o desempenho do sistema de arquivos e é a versão padrão atual para instalar
uma distribuição Linux no Windows.

### Como instalar o WSL em uma máquina Windows?

- Clique no botão do Windows, digite **Powershell** e execute o programa. Você deve ver uma interface de linha de comando.
- Primeiro vamos ver as versões disponíveis. Digite `wsl --list --online` e aperte enter. Vai aparecer uma lista das distribuições Linux
na loja online.
- Queremos uma versão do Ubuntu superior ao 20.04, como requisitado na atividade. Digite e execute `wsl --install Ubuntu-22.04` ou a
versão desejada.

## Configurando o ambiente

### Atualizando e instalando pacotes

Com o Linux instalado na máquina e acessando o terminal, antes de tudo, precisamos atualizar nosso ambiente. Para isso, dois comandos são
necessários:

```bash
~$ sudo apt update
```
```bash
~$ sudo apt upgrade
```

Agora faremos a instalação do NGINX, que é o serviço que vamos utilizar.

```bash
~$ sudo apt install nginx
```

### O que é NGINX?

O NGINX (se pronuncia *engine-ex*) é um serviço de servidor web open source que responde requisições web, atua como proxy reverso e hospeda
serviços como sites e apps.

## Criação do Script de Monitoramento

### Criando um diretório e o script

Agora com o ambiente configurado, vamos para o foco da atividade. Primeiramente, precisamos de uma pasta do projeto. No seu diretório home,
crie um diretório com o nome que desejar e entre nele.

```bash
~$ mkdir status_nginx && cd status_nginx
```
*Comando para criar o diretório e acessá-lo.*

Crie um arquivo com o nome da sua escolha, mas precisa terminar com **.sh**.

```bash
~/status_nginx$ touch script.sh
```

Agora com um editor de arquivos, como o **vim** ou **nano**, edite o arquivo para escrevermos o script nele.

```bash
~/status_nginx$ nano script.sh
```

*O script pode ser visto aqui no repostório, no arquivo [script.sh](https://github.com/ctrl-brokencode/nginx_server_check/blob/main/script.sh)*

Teste executar o script manualmente, para verificar se funciona.

```bash
~/status_nginx$ bash script.sh
```

## Automatizando a verificação

Não queremos ficar executando `bash script.sh` a cada 5 minutos manualmente, certo? Então precisamos automatizar isso, e é super simples.
A ferramenta `cron` permite que possa ser agendado tarefas para ser executadas em momentos específicos. Vamos acessar a tabela do cron,
pelo `crontab`. O comando pode ser usado em qualquer diretório.

```bash
$ crontab -e
```

Quando executado pela primeira vez, o sistema pergunta qual editor de texto deseja usar. Eu escolhi o *nano*, mas fica a seu critério.
Agora adicione a seguinte linha no editor:

```bash
*/5 * * * * cd /home/ubuntu/status_nginx && bash script.sh
```

Basicamente, estamos dizendo pro `cron` que ele precisa entrar no nosso diretório do projeto e executar o script, a cada 5 minutos.
Com isso, temos o foco do projeto feito, restando apenas o versionamento.

## Versionamento

*Para o versionamento, usaremos o **Git** e **GitHub**, mas não entrarei em detalhes aqui, pois é um outro escopo e exige um certo procedimento
de configuração do Git no ambiente.*

Com o Git instalado, inicie um repositório com `git init` no diretório do projeto. Salve todos os arquivos com `git add .` e commite as
alterações com `git commit -m "Initial commit"`. Por fim, o `git push -u origin main` vai subir os seus arquivos locais pro repositório
no GitHub.

## Conclusão

Essa foi minha participação e explicação da atividade. Obrigado por ler e tenha bons estudos!
