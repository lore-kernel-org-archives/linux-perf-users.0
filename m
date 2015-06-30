From: Benjamin King <benjaminking@web.de>
Subject: Re: perf probe an addr without debuginfo
Date: Tue, 30 Jun 2015 08:44:57 +0200
Message-ID: <20150630064457.GA20873@localhost>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
 <20150628154651.GA3953@localhost>
 <20150629150038.GA1225@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:54490 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbbF3GpI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 02:45:08 -0400
Content-Disposition: inline
In-Reply-To: <20150629150038.GA1225@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 29, 2015 at 12:00:38PM -0300, Arnaldo Carvalho de Melo wrote:
>Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>> >Is there a trick to getting perf to probe a user-level address without
>> >debuginfo? Eg (on Linux 4.0):
>> >[...]
>> >I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>> >works. Thanks,
>>
>> Not quite what you have asked for, but you can add the probe via ftrace and
>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>> will show up in 'perf list' as well.
>
>Masami,
>
>	Is this already possible?

Hi Arnaldo,

for me this works in 3.19.0. I'm using the attached script to help me add
probes to /sys/kernel/debug/tracing/uprobe_events which I can then see with
'sudo perf list' and use from the other perf subcommands. Tracing arguments is
also working fine:

--- snip ---
$ uprobe /lib/x86_64-linux-gnu/libc.so.6 malloc %di
$ sudo perf stat  -e uprobes:* ls
...
 Performance counter stats for 'ls':
...
               218      uprobes:malloc_1                                            
$ sudo perf record -euprobes:malloc_1 ls >/dev/null 2>&1
$ sudo perf script
              ls 21084 [003] 10825.526815: uprobes:malloc_1: (7f772bfc2700) arg1=0x238
              ls 21084 [003] 10825.526917: uprobes:malloc_1: (7f772bfc2700) arg1=0x238
              ls 21084 [003] 10825.526968: uprobes:malloc_1: (7f772bfc2700) arg1=0x78
              ls 21084 [003] 10825.527089: uprobes:malloc_1: (7f772bfc2700) arg1=0x5
              ls 21084 [003] 10825.527132: uprobes:malloc_1: (7f772bfc2700) arg1=0x78
...
--- snip ---

This is superuseful to me, so thank you all for working on perf!

I failed to manage placing proper probes in C++-Code with perf probe, so I
hacked the script together after reading Brendans ftrace article on LWN.

Cheers,
  Benjamin

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=uprobe

#!/bin/bash

usage() {
  cat <<EOF
Add and remove uprobes

USAGE
  $0 [options] <library or executable> <regexp for function/address> [<additional arguments to uprobe>]
  
  This will try to find a matching symbol in the executable and add a probe at its entry point with the given arguments.

OPTIONS
  -C  Clear uprobe_events, then exit
  -r  Probe on return rather than function entry
  -n  dry-run, only show what would be done, rather than doing it. Implies -v
  -v  verbose, show commands
  -D  demangle symbol names before checking the regexp

SEE ALSO
  https://www.kernel.org/doc/Documentation/trace/uprobetracer.txt
EOF
  exit 1
}

fail() {
  echo "$@"
  exit 1
}

log() {
  VERBOSITY=$1
  shift
  (( $VERBOSITY <= $VERBOSE )) && echo "$@"
}

CLEAR=0
DEMANGLER=cat
PROBETYPE=p:
DRYRUN=0
VERBOSE=0
[[ $# == 0 ]] && usage
while getopts "CDrnvh" flag
do
  case $flag in
    C ) CLEAR=1;;
    D ) DEMANGLER=c++filt;;
    r ) PROBETYPE=r:;;
    n ) DRYRUN=1;;
    v ) VERBOSE=$((VERBOSE + 1));;
    * ) usage;;
  esac
done
shift $(($OPTIND - 1 ))

if (( $CLEAR ))
then
  echo "" | sudo tee /sys/kernel/debug/tracing/uprobe_events
  exit 0
fi

(( $# < 2 )) && usage

DSO=$1
REGEXP=$2
shift 2
ADDITIONAL_ARGUMENTS="$@"

#echo $DEMANGLER
#echo $PROBETYPE
#echo $DRYRUN
#echo $VERBOSE
#echo $DSO
#echo $REGEXP
#echo $ADDITIONAL_ARGUMENTS

[[ -f "$DSO" ]] || fail "Not found: '$DSO'"

# Build string to pipe into uprobe_events
TODO=$( ( eu-readelf -S "$DSO" | sed 's/^\[ */[/'; eu-readelf -s "$DSO" | $DEMANGLER ) |
          grep -- "^\[\|$REGEXP" |
          grep -v UNDEF |
          awk -vADDITIONAL_ARGUMENTS="$ADDITIONAL_ARGUMENTS" \
              -vPROBETYPE=$PROBETYPE \
              -vDSO="$DSO" \
              -vPROBENAME=$(echo "$REGEXP" | tr -cd "0-9a-zA-Z") \
              '/^\[/ {
                 # First eu-readelf checks segments. We need the offset that
                 # maps adresses to file offsets
                 seg=$1
                 fileoffset[seg]=strtonum("0x"$4)-strtonum("0x"$5)
                 #print seg, fileoffset[seg]
               }
               $4 == "FUNC" {
                 addr = $2
                 seg = $7
                 $1 = ""; $2 = ""; $3 = ""; $4 = ""; $5 = ""; $6 = ""; $7 = ""
                 symbol[addr]=$0
                 segment[addr]=seg
               }
               END {
                 for ( addr in symbol )
                 {
                   #print segment[addr], fileoffset["["segment[addr]"]"], addr, symbol[addr]
                   printf "%s%s %s:0x%x %s\n", PROBETYPE, PROBENAME"_"(++num), DSO, strtonum("0x"addr)-fileoffset["["segment[addr]"]"], ADDITIONAL_ARGUMENTS
                 }
               }' )

log 1 "Would do this:
echo
$TODO | sudo tee -a /sys/kernel/debug/tracing/uprobe_events"
(( $DRYRUN )) || echo "$TODO" | sudo tee -a /sys/kernel/debug/tracing/uprobe_events
log 1 "
You now have this in uprobe_events:
$( sudo cat /sys/kernel/debug/tracing/uprobe_events )"

--4Ckj6UjgE2iN1+kY--
