Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE23D0BE7;
	Sun, 13 Sep 2026 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338536; cv=none; b=BjrCy5/Zc4kynWUpqNgBYXeuJWZsuNr5yKEwOA5j1a5a10vVpB1ldm022DawMlt8OFR9JXwXFVJDiyihlDmTsTaXzUtYhQMKlxKLp9uuoddc9LMrOhMFLaTMdVOWOdBqGNuTF9d6v++DoCFwsoYSeDlo8+3hnQn9ZiyUzRR+RWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338536; c=relaxed/simple;
	bh=9+wPnsQJMbrirVslNhqiSN1/XdqOyE2BZomNn1FIXEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGgahoYkEmtxX2uzGA842o6KY+zcVWIA2VoOogT/lqR5pRZlWT4XJi4SKorZFMEVVVu9+0SBn2axfuqPMPasdW08ECrxEhuQNxsc16nRA2EqlhKBImfgGjtQZBg3MhCfUc+JSu2lvylyPh1a4WWsJaDXP07M19EBfuRIphqf8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpYMtFMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpYMtFMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431961F000FF;
	Sun, 13 Sep 2026 22:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338531;
	bh=I4S08TAzzMuUGRQnsbZGRdDQUKkArvGQW3lnyHogvDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YpYMtFMdCW7uNCkfARrDN25wXZoNkeYuK8B56a/AUSMqH9k3bRJGyCe+YzmH1iPIj
	 SBB+gxvtArOSp5tJnEmDRSp3XNogfoicD4RBk1Crn21tJLdZeP8RxdbsfpHxCG5PI4
	 NmS4tVsdfd+424Me2+hj6NA24Vb9jOlLHrskfyfZZooDKfnlIgv76H0I1yvLjGkVfB
	 RbbjLqNeRu2FT9OU+Ewc9FgpR/UYJPLm6ZU0dSsKiJZjFoDNuu4KNRObVmd5sCdWrg
	 Zg0vv876Hoe+HPF2MYRgztHRx7hcaCbslWKOWTs0Cq+6VS8TetEwC0nMgJjSIGn70c
	 T52vcT9dqOa6A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/8] perf scripts: Add perf-stuck, to tell where a running perf is stuck
Date: Sun, 13 Sep 2026 19:28:18 -0300
Message-ID: <20260913222821.3353-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913222821.3353-1-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A perf that takes forever is hard to tell apart from one that is stuck
in a loop, and when it is stuck there is no way to know where without
attaching gdb to it and looking around, which is what this does, from
the outside, sampling /proc/<pid> at a fixed interval:

  ⬢ [acme@toolbx perf-tools-next]$ tools/perf/scripts/perf-stuck.sh -i 15 -n 4 -l ibs.log $(pgrep -x perf)
  watching 2297313 (perf report --progress -s type -i perf.data.ibs) every 15s
  09:39:34 state=R cpu=+0 (0.00s) rss=664295kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB  Merging related events... [ 39.0%] 197574 / 506686
  09:39:49 state=R cpu=+1496 (14.96s) rss=665383kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB stuck=1 Merging related events... [ 39.0%] 197574 / 506686
  09:40:04 state=R cpu=+1497 (14.97s) rss=665383kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB stuck=2 Merging related events... [ 39.0%] 197574 / 506686
  09:40:19 state=R cpu=+1497 (14.97s) rss=502250kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB stuck=0 Merging related events... [ 61.0%] 309026 / 506686

The CPU time used grows by a whole interval on every sample while the
[stack] mapping, that would be moving down if this was recursion, stays
put, so that one is spinning, and the last line of the progress log of
'perf report --progress' tells in which phase.

With -g it runs gdb when no progress is made for two consecutive
samples, using the perf-stuck.gdb that sits next to it, which adds the
perf-die-chain command used by the next patch, to print the DIE chain a
DWARF type chasing loop is walking when the perf being watched is stuck
in one of those.

It is a prototype: this wants to become a first class 'perf stuck'
command, sampling a running process from inside perf, instead of this
shell script poking at /proc and shelling out to gdb.

Example:

  ⬢ [acme@toolbx perf-tools-next]$ tools/perf/scripts/perf-stuck.sh -i 1 -n 3 -g $(pgrep -x sleep)
  watching 2342826 (sleep 45 ) every 1s
  11:58:36 state=S cpu=+0 (0.00s) rss=492kB stack=7ffe21f89000-7ffe21faa000 size=132kB stuck=2 (no progress log)
  ... gdb output of 2342826 in /tmp/perf-stuck-gdb.Uz9i5p
  ⬢ [acme@toolbx perf-tools-next]$ tail -4 /tmp/perf-stuck-gdb.Uz9i5p
  #3  0x0000555bc6ddc28f in main ()
  not in a DWARF type chaser, try: bt
  not in find_data_type()
  [Inferior 1 (process 2342826) detached]
  ⬢ [acme@toolbx perf-tools-next]$

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/perf-stuck.gdb | 104 ++++++++++++++++
 tools/perf/scripts/perf-stuck.sh  | 194 ++++++++++++++++++++++++++++++
 2 files changed, 298 insertions(+)
 create mode 100644 tools/perf/scripts/perf-stuck.gdb
 create mode 100755 tools/perf/scripts/perf-stuck.sh

diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-stuck.gdb
new file mode 100644
index 0000000000000000..53e9019828b6ef62
--- /dev/null
+++ b/tools/perf/scripts/perf-stuck.gdb
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# gdb commands for a perf that is stuck, used by perf-stuck.sh -g and usable
+# directly:
+#
+#   gdb -p $(pgrep -x perf) -batch -x perf-stuck.gdb -ex bt
+#
+# PROTOTYPE: part of the perf-stuck.sh stopgap, see the note at the start of
+# that script: this wants to move into a first class 'perf stuck' command,
+# which would print these DIE chains by itself, without gdb.
+#
+# The settings are the ones that keep a batch attach from stopping to ask
+# questions (debuginfod, pagination) and that make the output readable.
+#
+# The commands are for the DWARF type chasers in util/dwarf-aux.c, the
+# functions a data type profiling 'perf report -s type' spins in when a
+# debug info file has a type chain that got into a cycle:
+#
+#   perf-die-chain <function> <die variable> [iterations]
+#   perf-die-chain-all [iterations]
+#   perf-dso
+#
+# For each iteration of the chasing loop they print the DIE address, the
+# CU it came from, its offset in the debug file, its tag and its name: a
+# cycle shows up as the same handful of (addr, cu) pairs repeating, and a
+# CU that changes from one iteration to the next means the chase is
+# hopping between a debug file and its dwz common file.
+
+set pagination off
+set confirm off
+set debuginfod enabled off
+set print pretty on
+set height 0
+set width 0
+
+define perf-die-chain
+  if $argc < 2
+    printf "usage: perf-die-chain <function> <die variable> [iterations]\n"
+  else
+    frame function $arg0
+    if $argc == 3
+      set $perf_die_chain_n = $arg2
+    else
+      set $perf_die_chain_n = 10
+    end
+    set $perf_die_chain_head = $pc
+    set $perf_die_chain_i = 0
+    while $perf_die_chain_i < $perf_die_chain_n
+      printf "chain[%d] die=%p addr=%p cu=%p off=0x%lx tag=%d name=%s\n", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off) dwarf_dieoffset($arg1)), ((int) dwarf_tag($arg1)), ((char *) dwarf_diename($arg1))
+      until *$perf_die_chain_head
+      set $perf_die_chain_i = $perf_die_chain_i + 1
+    end
+  end
+end
+
+document perf-die-chain
+Print the DIE chain being walked by a DWARF type chasing loop.
+usage: perf-die-chain <function> <die variable> [iterations]
+  perf-die-chain die_get_pointer_type type_die
+  perf-die-chain __die_get_real_type vr_die
+  perf-die-chain die_get_real_type vr_die
+end
+
+define perf-die-chain-all
+  if $argc == 0
+    set $perf_die_chain_n = 10
+  else
+    set $perf_die_chain_n = $arg0
+  end
+  if $_any_caller_is("die_get_pointer_type", 20)
+    printf "stuck in die_get_pointer_type():\n"
+    perf-die-chain die_get_pointer_type type_die $perf_die_chain_n
+  else
+    if $_any_caller_is("__die_get_real_type", 20)
+      printf "stuck in __die_get_real_type():\n"
+      perf-die-chain __die_get_real_type vr_die $perf_die_chain_n
+    else
+      if $_any_caller_is("die_get_real_type", 20)
+        printf "stuck in die_get_real_type():\n"
+        perf-die-chain die_get_real_type vr_die $perf_die_chain_n
+      else
+        printf "not in a DWARF type chaser, try: bt\n"
+      end
+    end
+  end
+end
+
+document perf-die-chain-all
+Find which DWARF type chaser the process is in and print the DIE chain.
+usage: perf-die-chain-all [iterations]
+end
+
+define perf-dso
+  if $_any_caller_is("find_data_type", 20)
+    frame function find_data_type
+    printf "dso=%s ip=0x%lx sym=%s\n", dloc->ms->map->dso->name, dloc->ip, dloc->ms->sym->name
+  else
+    printf "not in find_data_type()\n"
+  end
+end
+
+document perf-dso
+Print the dso, ip and symbol of the data location being resolved.
+end
diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-stuck.sh
new file mode 100755
index 0000000000000000..70e59192b1d9658e
--- /dev/null
+++ b/tools/perf/scripts/perf-stuck.sh
@@ -0,0 +1,194 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# perf-stuck - tell a spinning perf apart from a blocked or recursing one
+#
+# Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# PROTOTYPE: this wants to become a first class 'perf stuck' command, that
+# samples a running perf, or any other process, from inside perf, with the
+# knowledge of the phases perf goes through and of the DWARF type chasing
+# loops built in, instead of this shell script poking at /proc and shelling
+# out to gdb.  It is here as a stopgap, to be able to tell where a perf is
+# stuck while looking at hangs such as the one 'perf report -s type' hits
+# on dwz compressed debug info.
+#
+# Samples /proc/<pid> at a fixed interval and prints, for each sample:
+#
+#   the CPU time used since the previous sample, so a process burning a
+#   full interval's worth of ticks is spinning, while one using none is
+#   blocked
+#
+#   the [stack] mapping start, which moves down as the stack grows, the
+#   giveaway for runaway recursion, together with its size
+#
+#   the last line of a progress log, when one is given, e.g. the stderr
+#   of 'perf report --progress', to see which phase is stuck
+#
+# A process that burns CPU with a constant stack and no progress is in an
+# unbounded loop, e.g. a die_get_pointer_type() chain that got into a
+# cycle, while one whose [stack] start keeps moving down is recursing.
+#
+# With -g it runs gdb, using the perf-stuck.gdb that sits next to this
+# script, when no progress is made for two consecutive samples, which for
+# a perf in a DWARF type chasing loop prints the DIE chain it is walking.
+#
+# usage: perf-stuck.sh [options] <pid|process-name>
+
+set -u
+
+usage() {
+	cat <<-EOF
+	usage: perf-stuck.sh [options] <pid|process-name>
+
+	  -i <secs>   sampling interval (default: 10)
+	  -n <count>  stop after this many samples (default: watch till it exits)
+	  -l <file>   progress log, its last line is printed with every sample
+	  -g          run gdb with perf-stuck.gdb when no progress is made for
+	              two consecutive samples, writing the output to a temp file
+	  -x <file>   use this gdb command file instead of perf-stuck.gdb
+	  -h          this help
+	EOF
+	exit "${1:-0}"
+}
+
+interval=10
+count=0
+progress_log=
+use_gdb=
+gdb_cmds=
+
+while getopts "i:n:l:gx:h" opt; do
+	case "$opt" in
+	i) interval=$OPTARG ;;
+	n) count=$OPTARG ;;
+	l) progress_log=$OPTARG ;;
+	g) use_gdb=1 ;;
+	x) gdb_cmds=$OPTARG ;;
+	h) usage 0 ;;
+	*) usage 1 ;;
+	esac
+done
+shift $((OPTIND - 1))
+
+[ $# -eq 1 ] || usage 1
+
+if [[ "$1" =~ ^[0-9]+$ ]]; then
+	pid=$1
+else
+	pid=$(pgrep -x "$1" | head -1)
+	[ -n "$pid" ] || { echo "no process named '$1'"; exit 1; }
+fi
+
+[ -d /proc/"$pid" ] || { echo "no process $pid"; exit 1; }
+
+if [ -n "$use_gdb" ] && [ -z "$gdb_cmds" ]; then
+	gdb_cmds=$(dirname "$0")/perf-stuck.gdb
+	[ -r "$gdb_cmds" ] || { echo "cannot read $gdb_cmds"; exit 1; }
+fi
+
+hz=$(getconf CLK_TCK)
+psz=$(getconf PAGESIZE)
+prev_cpu=
+prev_stack=
+prev_progress=
+stuck=0
+gdb_done=
+nsample=0
+
+# The command line is whatever the process was started with, so drop the
+# control characters from it: a process started with escape sequences in
+# its arguments, e.g. one replaying a log line, would otherwise get them
+# replayed on the terminal of whoever runs this.
+cmdline=$(tr '\0' ' ' < /proc/"$pid"/cmdline | tr -d '[:cntrl:]')
+
+echo "watching $pid ($cmdline) every ${interval}s"
+
+while :; do
+	if [ ! -d /proc/"$pid" ]; then
+		echo "$(date +%T) process gone"
+		break
+	fi
+
+	# Field 2, the command name, is in parentheses and can contain
+	# spaces, so drop it together with the pid before splitting: the
+	# fields after it then line up, with the state, the utime+stime
+	# pair and the RSS landing where they are read below.  Printing the
+	# CPU time with %d instead of relying on awk's default output format
+	# keeps it out of scientific notation, that bash arithmetic cannot
+	# parse, once it goes past six digits, i.e. some 16 minutes of CPU
+	# at 100 Hz.
+	if ! stat_line=$(awk '{ sub(/^[^ ]+ \(.*\) /, "");
+			       printf "%s %d %d\n", $1, $12 + $13, $22 }' \
+			 /proc/"$pid"/stat 2>/dev/null); then
+		echo "$(date +%T) process gone"
+		break
+	fi
+
+	# The process can be gone between the check above and this read, in
+	# which case there is nothing to report: 'set -u' would otherwise
+	# turn the unbound fields into an aborted script.
+	if [ -z "$stat_line" ]; then
+		echo "$(date +%T) process gone"
+		break
+	fi
+
+	stat=($stat_line)
+	state=${stat[0]}
+	cpu=${stat[1]}
+	# field 24 of /proc/<pid>/stat, the resident set size in pages
+	rss=$(( stat[2] * psz / 1024 ))
+
+	stack=$(awk '/\[stack\]/{print $1; exit}' /proc/"$pid"/maps 2>/dev/null)
+	if [ -n "$stack" ]; then
+		stack_start=0x${stack%-*}
+		stack_size=$(( 0x${stack#*-} - stack_start ))
+		stack_txt="$stack size=$((stack_size / 1024))kB"
+	else
+		stack_start=
+		stack_txt="-"
+	fi
+
+	progress=
+	[ -n "$progress_log" ] && [ -s "$progress_log" ] && progress=$(tail -1 "$progress_log")
+
+	if [ -n "$prev_cpu" ]; then
+		cpu_delta=$(( cpu - prev_cpu ))
+		# With a progress log, count the samples that show no progress,
+		# without one there is no progress to look at, so count them all:
+		# -g then looks at where the process is after two intervals.
+		if [ -z "$progress_log" ] ||
+		   { [ -n "$progress" ] && [ "$progress" = "$prev_progress" ]; }; then
+			stuck=$((stuck + 1))
+		else
+			stuck=0
+		fi
+		stuck_txt="stuck=${stuck}"
+		[ "$stack_start" != "$prev_stack" ] && stuck_txt="$stuck_txt STACK"
+	else
+		cpu_delta=0
+		stuck_txt=""
+	fi
+
+	printf '%s state=%s cpu=+%d (%d.%02ds) rss=%dkB stack=%s %s %s\n' \
+	       "$(date +%T)" "$state" "$cpu_delta" \
+	       $(( cpu_delta / hz )) $(( (cpu_delta % hz) * 100 / hz )) \
+	       "$rss" "$stack_txt" "$stuck_txt" "${progress:-(no progress log)}"
+
+	if [ -n "$use_gdb" ] && [ -z "$gdb_done" ] && [ "$stuck" -ge 2 ]; then
+		gdb_log=$(mktemp /tmp/perf-stuck-gdb.XXXXXX)
+		gdb -p "$pid" -batch -x "$gdb_cmds" -ex bt \
+		    -ex 'perf-die-chain-all' -ex perf-dso -ex detach > "$gdb_log" 2>&1
+		gdb_done=1
+		echo "... gdb output of $pid in $gdb_log"
+	fi
+
+	prev_cpu=$cpu
+	prev_stack=$stack_start
+	prev_progress=$progress
+
+	nsample=$((nsample + 1))
+	[ "$count" -gt 0 ] && [ "$nsample" -ge "$count" ] && break
+
+	sleep "$interval"
+done
-- 
2.55.0

