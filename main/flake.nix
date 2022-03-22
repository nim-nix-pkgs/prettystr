{
  description = ''Small library for working with strings'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-prettystr-main.flake = false;
  inputs.src-prettystr-main.owner = "prettybauble";
  inputs.src-prettystr-main.ref   = "main";
  inputs.src-prettystr-main.repo  = "prettystr";
  inputs.src-prettystr-main.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-prettystr-main"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-prettystr-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}