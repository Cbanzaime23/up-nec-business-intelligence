library("caret")

heisenbergimbalanced = heisenberg[2:6,]
heisenbergdown = downSample(heisenbergimbalanced,heisenbergimbalanced$trial)
heisenbergup = upSample(heisenbergimbalanced,heisenbergimbalanced$trial)

heisenbergdown
heisenbergup
