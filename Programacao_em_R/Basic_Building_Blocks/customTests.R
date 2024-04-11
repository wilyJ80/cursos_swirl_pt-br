# Get the swirl state
getState <- function() {
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

# Get the value which a user either entered directly or was computed
# by the command he or she entered.
getVal <- function() {
  getState()$val
}

# Get the last expression which the user entered at the R console.
getExpr <- function() {
  getState()$expr
}

coursera_on_demand <- function() {
  selection <- getState()$val
  if (selection == "Yes") {
    email <- readline("Qual o seu endereço de email?")
    token <- readline("Qual o token da sua tarefa?")

    payload <- sprintf('{
      "assignmentKey": "ZRVmbK5hEeW24RJH5gkutw",
      "submitterEmail": "%s",
      "secret": "%s",
      "parts": {
        "fyjXt": {
          "output": "correct"
        }
      }
    }', email, token)
    url <- "https://www.coursera.org/api/onDemandProgrammingScriptSubmissions.v1"

    respone <- httr::POST(url, body = payload)
    if (respone$status_code >= 200 && respone$status_code < 300) {
      message("Submissão de nota aceita!")
    } else {
      message("Submissão de nota falhada.")
      message("Pressione ESC se desejar sair dessa lição e")
      message("quiser tentar submeter sua nota numa data posterior.")
      return(FALSE)
    }
  }
  TRUE
}
