#!/usr/bin/env bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
flatpak install flathub app.drey.Warp
flatpak install com.github.tchx84.Flatseal
flatpak install com.heroicgameslauncher.hgl
flatpak install com.plexamp.Plexamp
flatpak install com.usebottles.bottles
flatpak install hu.kramo.Cartridges
flatpak install md.obsidian.Obsidian
flatpak install org.libreoffice.LibreOffice
flatpak install tv.plex.PlexDesktop
flatpak install xyz.tytanium.DoorKnocker

