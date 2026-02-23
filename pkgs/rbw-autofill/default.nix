{
  writeShellApplication,
  bash,
  libsecret,
  zenity,
}:
writeShellApplication {
  name = "rbw-autofill";
  runtimeInputs = [bash libsecret zenity];
  text = builtins.readFile ./script.sh;
}
