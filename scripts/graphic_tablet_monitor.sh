#!/usr/bin/env bash

# exit on error or on use of undeclared variable or pipe error:
set -o errexit -o errtrace -o nounset -o pipefail
# optionally debug output by supplying TRACE=1
[[ "${TRACE:-0}" == "1" ]] && set -o xtrace

shopt -s inherit_errexit
PS4='+\t '
IFS=$'\n\t'

error_handler() {
  echo >&2 "Error: In ${BASH_SOURCE[0]}, Lines $1 and $2, Command $3 exited with Status $4"
  pr -tn "${BASH_SOURCE[0]}" | tail -n+$(($1 - 3)) | head -n7 | sed '4s/^\s*/>> /' >&2
  exit "$4"
}
trap 'error_handler $LINENO "$BASH_LINENO" "$BASH_COMMAND" $?' ERR

usage() {
  cat << EOF
Usage: $0 <Monitor>

Map all Wacom Devices to Monitor <Monitor>.
For example, to map to Monitor VGA-1:

  $0 VGA-1

If <Monitor> is NEXT, then to the next monitor
as listed by xrandr. Useful, for example, to bind, 
say by xbindkeys, a key to
  
  notify-send "\$($0 NEXT)"

EOF
  exit 1
}

next() {
  [ -n "$TMPDIR" ] || TMPDIR=/tmp
  WFILE="$TMPDIR/wacom2mon"

  # Since
  #   xsetwacom --get "Wacom Pad pad" MapToOutput
  # returns
  #   'MapToOutput' is a write-only option.
  # we store the output device in a temp file.
  # This, woefully, cannot detect output device changes;
  # for example, after a reboot.

  if [ -f "$WFILE" ]; then
    current_monitor="$(cat "$WFILE")"
  else
    current_monitor=""
  fi

  if [ -z "$current_monitor" ]; then
    # no mapping known, just use the first monitor
    next_monitor=$(xrandr --listactivemonitors | sed -n 2p | awk '{print $4}')
  else
    # duplicate the output in case the current monitor is the last one, so we automatically cycle
    # through. head after grep takes the first match and sed afterwards drops the match and keeps
    # only the next monitor
    next_monitor=$(xrandr --listactivemonitors | sed 1d | awk '{print $4}' | tee /dev/stdout | grep -A 1 "$current_monitor" | sed -n 2p)
  fi

  echo "$next_monitor" >$WFILE
  echo "$next_monitor"
}

command -v xsetwacom >/dev/null 2>&1 || exit 1
command -v xrandr >/dev/null 2>&1 || exit 1

if [[ $# == 0 ]]; then
  usage
else
  screen="$1"
fi

[ "$screen" = "NEXT" ] && screen="$(next)"

devices="$(xsetwacom --list devices | cut -f 1)"
[ -z "$devices" ] && exit 1

while read -r d; do
  # instead of `while IFS=$' \n\t'`; from https://stackoverflow.com/a/15398846
  d=$(echo $d | xargs echo -n)
  xsetwacom --set "$d" MapToOutput "$screen"
  echo "$d was mapped to:    $screen"
done <<< $devices

