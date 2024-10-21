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
~/status_nginx$ ./script.sh
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
*/5 * * * * cd /home/ubuntu/status_nginx && ./script.sh
```

Basicamente, estamos dizendo pro `cron` que ele precisa entrar no nosso diretório do projeto e executar o script, a cada 5 minutos.
Pra finalizar, precisamos dar as permisões de leitura / escrita / execução (read / write / execute ) para o arquivo, afim de fazê-lo
funcionar normalmente.

```bash
~/status_nginx$ sudo chmod 777 script.sh
```

Se o seu serviço `NGINX` estiver **online**, o script gerará um arquivo como `online.log`. Para testar se o script gera o arquivo
`offline.log`, precisamos desligar o serviço. Para isso, execute o seguinte comando e aguarde até a próxima execução do script.

```bash
~$ sudo systemctl stop nginx
```

Se tudo estiver funcionando, temos o foco do projeto feito, restando apenas o versionamento.

## Versionamento

Para o versionamento, usaremos o **Git** e **GitHub**. Precisaremos nos identificar pro Git, criar uma chave SSH, conectar o Git da
máquina com o GitHub, criar um repositório no GitHub e cloná-lo na nossa máquina Linux, fazer as alterações e ajustes e subir os arquivos
no repositório remoto, ou seja, no GitHub.

### Fazendo o cadastro

Para realizarmos esse processo, precisamos primeiro nos identificar. Por isso, dois comandos são necessários: um para nome e outro para email.
Neste caso, use os seus dados do Github.

```bash
~$ git config --global user.name usuario_feliz
```

```bash
~$ git config --global user.name email_do_bem@gmail.com
```
*Substitua a ironia do `usuario_feliz` pelo seu nome de usuário do GitHub e também o `email_do_bem@gmail.com` pelo seu email, também do GitHub.*

### Geração da Chave SSH

Precisamos gerar uma chave SSH para fazer a conexão remotamente O comando abaixo gerará um par de chaves, pública e privada,
onde usaremos a chave pública no GitHub.

```bash
~$ ssh-keygen -t ed25519 -C "email_do_bem@gmail.com"
```
*Substitua o `email_do_bem@gmail.com` pelo seu email do GitHub. Isso é apenas um comentário ou descrição para a sua chave SSH, mas normalmente é
usado um email.*

O sistema vai pedir um caminho para salvar o arquivo e uma frase-passe (uma senha, basicamente), mas você não precisa fornecer nada.
Apenas deixe em branco apertando Enter em todas as vezes que lhe for pedido. Vai parecer uma frase como: `Your identification has been saved in /home/gabriel/.ssh/id_ed25519`. Você precisa ir no seu diretório home, depois no diretório oculto `.ssh` e pegar a chave pública.

```bash
~$ cat /home/usuario_feliz/.ssh/id_ed25519.pub
```
*Substitua a ironia do `usuario_feliz` pelo seu nome de usuário.*

Copie o texto que será exibido (exceto o email no final).

### Registrando Nova Chave SSH

No seu navegador, entre no [gitHub.com](https://github.com/), clique na sua foto de perfil no canto superior direito e clique em
**Configurações**. Logo após, clique em **SSH and GPG Keys*, localizado no menu à esquerda, na seção *Access*. Na página, clique no
botão verde **New SSH Key**. Dê um título para a chave, cole a chave copiada anteriormente no campo **Key** e salve clicando em
**Add SSH Key**. Insira sua senha ou realize a verificação em duas etapas do GitHub.
Sua chave vai estar registrada. No topo, deve aparecer uma mensagem como: `You have successfully added the key 'teste_ssh'.`, informando
que a chave com o nome escolhido foi adicionada.

Agora precisamos testar essa conexão. Na máquina linux digite o seguinte comando:

```bash
~$ ssh -T git@github.com
```

Uma mensagem deve aparecer:

```bash
The authenticity of host 'github.com (20.201.28.151)' can't be established.
ECDSA key fingerprint is SHA256:<hash da chave pública do servidor>.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Quando você tenta conectar ao GitHub via SSH pela primeira vez, o sistema mostra essa mensagem por conta da autenticidade do host, como medida
de segurança. Digite `yes` para darmos continuidade.

### Clonando um repositório

Agora, no seu GitHub, crie um repositório e adicione um README vazio à ele.
Na página do seu repositório, aperte no botão verde **<> Code**. No tab Local na seção Clone, aperte em **SSH** e copie o texto informado.
O formato deve ser esse:

```
git@github.com:ctrl-brokencode/git_teste.git
``` 

De volta no terminal, no seu diretório home, execute o seguinte comando para fazer uma cópia do repositório remoto na sua máquina:

```bash
~$ git clone git@github.com:ctrl-brokencode/git_teste.git
```

Se você der um `ls`, você vai ver um novo diretório, que é o repositório clonado.

**⚠ ATENÇÃO**: Como vamos subir esse mesmo diretório remotamente, precisamos passar tudo que temos no nosso diretório local pro repositório
clonado. OU SEJA, os arquivos, como o do script e os dos logs, precisam ser copiados ou movidos do diretório que criamos no começo da atividade
(no meu caso o `status_nginx`) para o repositório que clonamos agora (no meu caso, o `git_teste`). Você também precisará alterar o *crontab*
com o novo caminho do arquivo.

## Subindo os novos arquivos

Para subir os arquivos, precisamos primeiro realizar as alterações. Se você der um `git status`, você verá que o arquivo do script está como
*untracked*. Se você alterar o texto do `README.md`, vai ver que este vai estar como *modified*. Precisamos atualizar essas modificações com
`git add .` Isso fará com que as alterações estejam prontas para serem "commitadas". Para commitar, dê um `git commit -m` e a mensagem da sua
preferência, entre aspas. Exemplo:

```bash
~/git_teste$ git add .
```
```bash
~/git_teste$ git commit -m "subindo o script e alterando o README"
```

Para finalizar, o comando seguinte irá subir os arquivos locais para o repositório no GitHub.

```bash
~$ git push
```


## Conclusão

Essa foi minha participação e explicação da atividade! Aprendi muito sobre como usar o Linux, como agendamento de tarefas e criação de scripts,
bem como reforcei meus conhementos de Git e GitHub! Foi uma experiência bem bacana e desafiadora, principalmente para um iniciante no Linux como eu.
Obrigado por ler e tenha bons estudos!
