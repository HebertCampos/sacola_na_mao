# 🛍️ Sacola na Mão

O **Sacola na Mão** é um aplicativo desenvolvido em Flutter projetado para facilitar a gestão de compras e controle de estoque doméstico. O objetivo principal é ajudar o usuário a saber exatamente o que precisa comprar, evitando desperdícios e esquecimentos.

## 🚀 Proposta do Projeto

A proposta do projeto é criar uma ferramenta intuitiva onde o usuário possa cadastrar seus produtos, definir quantidades mínimas de estoque e monitorar a disponibilidade de cada item em tempo real. O aplicativo identifica automaticamente quais produtos atingiram ou estão abaixo do nível crítico, gerando a lista de compras de forma inteligente.

## 🛠️ Como Funciona

O funcionamento do aplicativo baseia-se em três pilares:

1.  **Gestão de Inventário:** O usuário cadastra seus produtos com nome, categoria e a quantidade atual em estoque.
2.  **Alerta de Estoque Mínimo:** Para cada produto, é definido um "Estoque Mínimo". Quando a quantidade atual é menor ou igual a esse limite, o sistema sinaliza que o item deve ser adquirido.
3.  **Lista de Compras Automática:** O app filtra todos os produtos em falta, apresentando ao usuário a quantidade exata que precisa ser comprada para retornar ao nível de segurança do estoque.

## 💻 Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento da interface multiplataforma.
- **SQLite**: Banco de dados local para persistência de dados, garantindo que as informações estejam disponíveis offline.
- **Dart**: Linguagem de programação utilizada no desenvolvimento.

---

**Autoria:** [Hebert Campos](https://github.com/hebertcampos)  
