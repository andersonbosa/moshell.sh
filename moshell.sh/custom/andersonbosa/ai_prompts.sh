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
  cat <<EOF | cat
Ask a series of challenge-related questions related to $USER_INPUT to test my knowledge and improve my long term memory
EOF
}

function ai_create_history_from_topic() {
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat
Turn central topics about $USER_INPUT into interesting stories or narratives so that I can remember and better understand this subject
EOF
}

function ai_create_activities_routine() {
  local USER_INPUT=$1 # matéria
  cat <<EOF | cat
Develop a routine of practical tasks for my $USER_INPUT studies, so as to focus on my weaknesses and with constant feedback for my evolution
EOF
}
