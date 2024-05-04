alias copy=clipcopy

function ai_pareto() {
  # source: https://www.linkedin.com/feed/update/urn:li:activity:7079481200431480832?utm_source=share&utm_medium=member_desktop
  # 1. Tire proveito do principio de Pareto na hora de estudar. Comando:
  local USER_INPUT=$1 # tópico ou habilidade
  cat <<EOF | cat
Identify the 20% of |That you need to learn about $USER_INPUT that you can provide 80% of the results and create a study plan focused on this goal.
EOF
}

function ai_feynman() {
  # 2. Use a técnica Feynman para aprofundar seu entendimento.
  local USER_INPUT=$1 # tópico ou habilidade
  cat <<EOF | cat
Explain $USER_INPUT as simple as possible, as if teaching for a complete beginner.Also identify gaps in my understanding and suggest resources to fill them.
EOF
}

function ai_interdisciplinarity_learn() {
  # 3. Otimize seu aprendizado com a interdisciplinaridade.
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat
Create a study plan that combines different topics about $USER_INPUT to help me develop a more complete understanding and facilitate connections in my reasoning.
EOF
}

function ai_expanded_repetition() {
  # 4. Implemente a repeticao espaçaada para lembrar da materia
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat
Develop a studied schedule with repetition spaced so that I poossa review $USER_INPUT in an efficient way over time to remember more easily.
EOF
}

function ai_mental_models() {
  # 5. Desenvolva modelos mentais para entender conceitos difíceis.
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat
Help me create mental models or analogies to better understand key concepts about $USER_INPUT
EOF
}

function ai_different_studies() {
  # 6. Experimente com modalidades diferentes de estudo.
  local USER_INPUT=$1 # tópico ou matéria
  cat <<EOF | cat
Suggest several different sources (videos, podcast books, practical exercises) so that I can learn $USER_INPUT, considering different learning styles
EOF
}

function ai_study_partner() {
  local USER_INPUT=$1 # matéria ou tópico
  cat <<EOF | cat | copy
Ask a series of challenge-related questions related to $USER_INPUT to test my knowledge and improve my long term memory
EOF
}

function ai_create_history_from_topic() {
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat | copy
Turn central topics about $USER_INPUT into interesting stories or narratives so that I can remember and better understand this subject
EOF
}

function ai_create_activities_routine() {
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat | copy
Develop a routine of practical tasks for my $USER_INPUT studies, so as to focus on my weaknesses and with constant feedback for my evolution
EOF
}

function ai_git_commit() {
  cat <<EOF | cat | copy

You are to act as the author of a commit message in git. Your mission is to create clean and comprehensive commit messages in the conventional commit convention (based on https://www.conventionalcommits.org/en/v1.0.0/) and explain WHAT were the changes and WHY the changes were done. I'll send you an output of 'git diff --staged' command, and you convert it into a commit message.

For you to generate the correct output, also follow these rules:
  - Do not preface the commit with anything.
  * Add a short description of WHY the changes are done after the commit message. Don't start it with "This commit", just describe the changes.
  * Use the present tense.
  * Use the Conventional Commits specification (https://www.conventionalcommits.org/en/v1.0.0/)
  * Lines must not be longer than 100 characters.
  * The total output must have at the maximum 200 characters"
  # * Create a list of bullet items with the main changes
  * Output in a block of markdown code

\`\`\`diff
$(git diff --staged)
\`\`\`

EOF
}




function ai_git_commit_v2() {
  cat <<EOF | cat | copy

You are to act as the author of a commit message in git. I'll send you an output of 'git diff --staged' command, and you convert it into a commit message. Your mission is to create clean and comprehensive commit message in the conventional commit convention (based on https://www.conventionalcommits.org/en/v1.0.0/) written in present tense for the following code diff with the given specifications below:
  - Use the Conventional Commits specification (https://www.conventionalcommits.org/en/v1.0.0/)
  - Message language: English (US)
  - Commit message must be a maximum of 100 characters.
  - Exclude anything unnecessary such as translation. Your entire response will be passed directly into git commit.

About the commit format, choose a type from the type-to-description items below that best describes the git diff:
  - docs: 'Documentation only changes'
  - style: 'Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)'
  - refactor: 'A code change that neither fixes a bug nor adds a feature'
  - perf: 'A code change that improves performance'
  - test: 'Adding missing tests or correcting existing tests'
  - build: 'Changes that affect the build system or external dependencies'
  - ci: 'Changes to our CI configuration files and scripts'
  - chore: "Other changes that don't modify src or test files",
  - revert: 'Reverts a previous commit'
  - feat: 'A new feature'
  - fix: 'A bug fix'

\`\`\`diff
$(git diff --staged)
\`\`\`

EOF
}