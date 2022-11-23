frg() {
    # TEST: ESC first menu to skip file selection/filtering and rg all files
    # TEST: open files containing spaces
    # TEST: do not crash on empty files

    local fzf_file_names
    local RG_PREFIX
    local FZF_DEFAULT_OPTS
    local FZF_DEFAULT_COMMAND
    local FZF_BIND_COMMAND
    local all_files_empty

    # filter by filename and select list of files
    IFS=$'\n' readarray -t fzf_file_names <<< "$(fzf --multi)"

    # search content within selected list of files
    RG_PREFIX="rg --no-heading --with-filename --line-number --color=always --smart-case --no-messages"
    FZF_DEFAULT_OPTS="--height 75% --layout=reverse --border --preview-window 'up,60%,border-top'"

    # throw error message and exit frg() if all selected files are empty (prevents rg from crashing)
    # TEST: empty file first
    # TEST: all empty files
    # TEST: at least one non-empty file
    # TEST: pressing ESC at fzf (first) menu, drops to rg (second) menu

    all_files_empty=1
    for file in "${fzf_file_names[@]}"; do
      if [ -s "${file}" ]; then
        all_files_empty=0
        break # found a non-empty file
      fi
    done

    # exit if at least one file was selected but all files are empty
    if [ ${#fzf_file_names} -gt 0 ] && [ ${all_files_empty} -eq 1 ]; then
        printf '%s\n' "All selected files are empty. Exiting."
        return
    fi

    # set FZF_DEFAULT_COMMAND based on whether any files were selected in the first menu
    # no files selected (i.e., esc'ed out of first filter)
    # when ESC is pressed, the length of #fzf_file_names[@] is 1, and fzf_file_names[0] is empty
    if [ ${#fzf_file_names[@]} -eq 1 ] && [ -z "${fzf_file_names[0]}" ]; then
      FZF_DEFAULT_COMMAND="$RG_PREFIX ''"
      FZF_BIND_COMMAND="$RG_PREFIX {q}"

    # files selected files (i.e., rg only selected files)
    else
      FZF_DEFAULT_COMMAND="$RG_PREFIX '' ""$(printf "%q " "${fzf_file_names[@]}")"
      FZF_BIND_COMMAND="$RG_PREFIX {q} ""$(printf "%q " "${fzf_file_names[@]}")"
    fi

    # FIXED: if no files are selected (ESC), --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    # keep second (rg) menu open until ESC or Ctrl + C
    while true; do
            IFS=: read -ra selected < <(
              fzf --ansi \
                  --disabled \
                  --bind "change:reload:sleep 0.1; ""$FZF_BIND_COMMAND"" || true" \
                  --delimiter : \
                  --preview 'batcat --highlight-line {2} --color=always {1} ' \
                  --preview-window 'up,60%,border-bottom,~3,+{2}+3/2'
            )
            # open file to selected line
            [ -n "${selected[0]}" ] && subl "${selected[0]}:${selected[1]}" || break # exit program on ESC or Ctrl + C
    done
}

