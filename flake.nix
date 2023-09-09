{
  description = "Ben's NixOS Flake";
  inputs = {
    # There are many ways to reference flake inputs.
    # The most widely used is `github:owner/name/reference`,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    #Home-manager manages user packages and dotfiles declaratively
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

 outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
        "nixosPlayground" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
       ./hosts/nixos-playground 
       home-manager.nixosModules.home-manager
       {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ben = import ./home;
       }
      ];
   };
};
};

}
