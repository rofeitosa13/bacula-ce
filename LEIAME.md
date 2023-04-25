## Descrição

Este é o Bacula Community Edition 13.0.2 implantado na imagem oficial do Debian Bullseye Docker. A imagem do Catálogo Bacula está usando a imagem oficial do Postgresql 13 Docker.
O fuso horário nos contêineres é herdado do fuso horário local no host do docker.

**Requisitos**

Você precisa de um sistema host Linux baseado em x86-64 com mecanismo docker instalado e docker-compose.

**Atualizações**

- Bacula 11.0.5 para 13.0.2

Desde a última atualização dessa imagem pelo 'ixxoid', o Bacula foi atualizado e sua versão mais recente é a 13.0.2 (abril/2023). Portanto, tomamos a liberdade de atualizar essas imagens.

- Atualização do comando 'apt-key'

O comando apt-key será descontinuado após as versões Debian 11 e Ubuntu 22.04, conforme indicado abaixo.
"The apt-key man page mentions that the "use of apt-key is deprecated, except for the use of apt-key del in maintainer scripts to remove existing keys from the main keyring". What's more, "apt-key will last be available in Debian 11 and Ubuntu 22.04."" (https://www.linuxuprising.com/2021/01/apt-key-is-deprecated-how-to-add.html)


**Baixe as imagens do Docker**

```
git clone https://github.com/rofeitosa/bacula-ce
cd bacula-ce
docker-compose up -d
```

## Configuração

**Configuração da API do Baculum**

Abra o site da API Baculum em http://<docker-host>:9096
O login padrão é:

- nome de usuário = admin
- senha = admin

Os dados de login podem ser alterados na interface gráfica.
Você precisa selecionar o "Assistente de configuração".
Todos os formulários serão preenchidos com uma configuração de trabalho.
Na etapa 5 - "autenticação para API" você precisa escolher "Usar autenticação básica HTTP".
Para obter mais detalhes sobre a configuração da API do Baculum, consulte a documentação vinculada abaixo.

**Configuração web do Baculum**

Abra a página da Web do Baculum em http://<docker-host>:9095
Você precisa passar pelos formulários de configuração.
Na página "Add API host" adicione "baculum-api" no campo "IP-Address/Hostname", este é o padrão definido no docker-compose.yaml.

Caso apareça a mensagem "Bacula-dir invalid.", faça o logout e login novamente na aplicação.

**![baculum01.png](capturas de tela/baculum01.png)**

Se você inserir o nome de host errado por engano e salvar a configuração, poderá obter uma falha irrecuperável. Nesse caso, você precisa recriar o contêiner do Baculum Web.
Isso parece ser um bug do Baculum Web.

**Configuração do Bacula**

A configuração de exemplo incluída usa um volume para compartilhar o diretório de trabalho do bacula /opt/bacula/working. Isso permite fazer backup dos despejos de banco de dados do catálogo.
Para adaptar a configuração às suas necessidades pessoais, você pode editar os arquivos de configuração em /etc ou alterar a configuração no Baculum Web Gui.

**Configuração do Bacula Client**

Para o funcionamento correto do Bacula nos clientes, é necessário configurar o DNS para o Bacula Storage Daemon (bacula-sd) ou o arquivo /etc/hosts no cliente Linux ou C:/Windows/System32/Drivers/etc/hosts no Windows.

## Testes

Faça login na página da Web do Baculum em http://<docker-host>:9095
Abra o Console do Bacula clicando em ">_".
Digite "status all" e clique em "Enter".
Verifique a saída quanto a falhas.

**![teste01.png](capturas de tela/teste01.png)**

## Segurança

Você pode querer limitar o acesso à porta 5432 do banco de dados.
Para habilitar a criptografia SSL para o acesso baculum-api e baculum-web, você pode adicionar um proxy reverso ao docker-compose.yaml

## Personalizar / Construir as imagens

Se você quiser personalizar ou criar as imagens por conta própria, precisará obter sua chave de acesso em https://www.bacula.org/bacula-binary-package-download/ . Depois de obter sua própria chave de acesso, você precisa substituir "ACCESS_KEY"  no arquivo  "bacula-ce/bacula-base/files/Bacula-Community.list" por sua própria chave.

O PostgreSQL 15.2 (versão mais nova em abrl/2023) é plenamente compatível com o Bacula 13.0.2. Porém, para o funcionamento do Baculum 11.0.2, deve ser usado como catálogo do sistema o PostgreSQL versão 13 ou anteriores devido a imcompatibilidades da biblioteca PHP-PDO utilizada pelo Baculum.

## Links

Página inicial do Bacula:
https://www.bacula.org/

Bacula (bacula-gui):
https://baculum.app/doc/index.html

**PostgreSQL**
https://hub.docker.com/_/postgres/