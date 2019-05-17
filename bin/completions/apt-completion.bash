_apt_complete()
{
   local commands="autoclean autoremove build-dep changelog clean 
   depends dist-upgrade download edit-sources full-upgrade help
   install list moo policy purge rdepends remove search
   show showsrc source update upgrade"

   local GENERIC_APT_GET_OPTIONS="
   -d --download-only -y --assume-yes
   --assume-no -u --show-upgraded
   -m --ignore-missing -t --target-release
   --download --fix-missing --ignore-hold
   --upgrade --only-upgrade
   --allow-change-held-packages
   --allow-remove-essential --allow-downgrades
   --print-uris --trivial-only --remove
   --arch-only --allow-unauthenticated
   --allow-insecure-repositories
   --install-recommends --install-suggests
   --fix-policy"

   if [ $COMP_CWORD -eq 1 ]; then
      COMPREPLY=($(compgen -W "$commands" "'${COMP_WORDS[1]}'"))
   else
      local options
      case ${COMP_WORDS[1]} in
         install|*remove|purge|*upgrade )
            options="
            --show-progress
            --fix-broken
            --purge
            --verbose-versions
            --auto-remove
            -s --simulate --dry-run
            --download
            --fix-missing
            --fix-policy
            --ignore-hold
            --force-yes
            --trivial-only
            --reinstall
            --solver
            -t --target-release" ;;

         update )
            options="
            --list-cleanup
            --print-uris
            --allow-insecure-repositories" ;;

         list )
            options="
            --installed
            --upgradable 
            --manual-installed
            -v --verbose
            -a --all-versions
            -t --target-release" ;;

         show )
            options="-a --all-versions" ;;

         depends|rdepends )
            options="-i
            --important
            --installed
            --pre-depends
            --depends
            --recommends
            --suggests
            --replaces
            --breaks
            --conflicts
            --enhances
            --recurse
            --implicit" ;;

         search )
            options="
            -n --names-only
            -f --full" ;;

         showsrc )
            options="--only-source" ;;

         source )
            options="
            -s --simulate --dry-run
            -b --compile --build
            -P --build-profiles
            --diff-only --debian-only
            --tar-only
            --dsc-only
            -t --target-release
            $GENERIC_APT_GET_OPTIONS" ;;

         build-dep )
            options="-a --host-architecture
            -s --simulate --dry-run
            -P --build-profiles
            -t --target-release
            --purge --solver
            $GENERIC_APT_GET_OPTIONS" ;;

         moo )
            options=--color ;;

         clean|autoclean )
            options="-s --simulate --dry-run" ;;
      esac

      local cword=${COMP_WORDS[$COMP_CWORD]}

      if [[ $cword =~ ^- ]]; then
         options=$options
      elif [ -z $cword ] || [[ $cword =~ ^[a-zA-Z_-]+$ ]]; then
         options="$(apt-cache --no-generate pkgnames "$cword")"
      fi
      COMPREPLY=($(compgen -W "$options" "'$cword'"))
   fi
} 

complete -F _apt_complete apt
