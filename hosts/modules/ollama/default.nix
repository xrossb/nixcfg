{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    host = "[::]";
    port = 11434;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "128000";
    };
  };
}
