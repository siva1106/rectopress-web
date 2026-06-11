(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using TempApp
const UserApp = TempApp
TempApp.main()
