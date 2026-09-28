Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE86502799;
	Mon, 28 Sep 2026 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633216; cv=none; b=GzeN4nTljk8NjagKyJUrycs1DEc/5MBmW4F8I+59LDHQyojTbw0eBM6+gK1LdCTv56lJ3xG2PKFGwEl93GMvjgzKaEnzJ5MkIEQ/hUQMPus7kKkWyeqGs3QL9Q/g78jFmmNxCB1i/erjFttNgni6Vc4ERDo2bCsrTIagIf80Oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633216; c=relaxed/simple;
	bh=rycPy6zuu6kEkxBbdGMUizyUoo2kOUNEVvG//6uPwNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGuT4xMmLZ6WHcOk4Xl/8NX8Z1Q4wQg/rha4x6YvOkyjK4Do4r8HHqVM0HvZFPtjd9ihwN6NGwu59SHg04LsQzl3d7noZCmmfXOHT1IAla29kgqRVwG1vG3yuTrFEE+tdXha2LUQzu2ilWQJ+SqJLfJAd+73THbSeMEWoqpxPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlYbb3Yv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlYbb3Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E21F00893;
	Mon, 28 Sep 2026 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633213;
	bh=V3Pe/yQkv3g8i6Pm756o8Nsv16xyarpub5ZGWhJSwzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MlYbb3Yvdo7wBNSorxT3EP78tx5dZMP1AN4tcLukf/ya8mhSBYfk1cmsX0UqX0Ubu
	 nIsVMRMP/TOq8ZtWYzk3UtEzjCD9+ERUr4lYSghWQng8Bk4l2/TOw+8hHMscr9+g0e
	 cyXiUs/iACR45XjZzezsvKmEvcYZB66BasdD2+QwaRkRWw7NW/9FixuQ2ke39lltYD
	 SHcljflNcunxLjZiv4PK9hYsiDqRHNluLAdJQmR/48Fnkt/6neDWz/Nc3+KQVPIT1b
	 4RwAvnkxrNU/9WKkLnFiJ/sK938X80+uK2gRQz0FC8a+K4jEf37d0ZK6o77WUVJXFg
	 NL4BxfZ/aOtLw==
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
Subject: [PATCH 3/4] perf scripts: Add perf-stuck, to tell where a running perf is stuck
Date: Tue, 29 Sep 2026 00:06:33 +0200
Message-ID: <20260928220634.2451784-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928220634.2451784-1-acme@kernel.org>
References: <20260928220634.2451784-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A perf that takes forever is hard to tell apart from one stuck in a
loop, and there is no way to see where without attaching gdb.
perf-stuck.sh samples a running process' /proc entries and its progress
line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
the perf-die-chain command) when no progress is made across two
samples, printing the DIE chain a DWARF type chase is stuck in.

It is a prototype: the plan is to turn it into a first class 'perf
stuck' command.  The process name is resolved with pgrep among the
caller's own processes only, as root an unscoped one would attach gdb
to the first process of any user with a matching name.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/perf-stuck.gdb | 109 ++++++++++++++++++
 tools/perf/scripts/perf-stuck.sh  | 184 ++++++++++++++++++++++++++++++
 2 files changed, 293 insertions(+)
 create mode 100644 tools/perf/scripts/perf-stuck.gdb
 create mode 100755 tools/perf/scripts/perf-stuck.sh

diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-stuck.gdb
new file mode 100644
index 0000000000000000..2022f83c6bfdc646
--- /dev/null
+++ b/tools/perf/scripts/perf-stuck.gdb
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# gdb commands for a stuck perf, used by perf-stuck.sh -g and usable directly:
+#
+#   gdb -p $(pgrep -x perf) -batch -x perf-stuck.gdb -ex bt
+#
+# PROTOTYPE: part of the perf-stuck.sh stopgap, wants to become a first
+# class 'perf stuck' command printing these DIE chains without gdb.
+#
+# The commands are for the DWARF type chasers in util/dwarf-aux.c:
+#
+#   perf-die-chain <function> <die variable> [iterations]
+#   perf-die-chain-all [iterations]
+#   perf-dso
+#
+# For each iteration of the chasing loop they print the DIE address, the
+# CU, its file offset, tag and name: a cycle shows as the same (addr, cu)
+# pairs repeating, and a CU changing between iterations means the chase
+# hops between a debug file and its dwz common file.
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
+      # Pointer type DIEs have no DW_AT_name, so dwarf_diename() can
+      # return NULL: printf %s of it would error out and abort this
+      # batch script, handle it.
+      set $perf_die_chain_name = (char *) dwarf_diename($arg1)
+      printf "chain[%d] die=%p addr=%p cu=%p off=0x%lx tag=%d name=", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off) dwarf_dieoffset($arg1)), ((int) dwarf_tag($arg1))
+      if $perf_die_chain_name == 0
+	printf "(null)\n"
+      else
+	printf "%s\n", $perf_die_chain_name
+      end
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
+    # REFCNT_CHECKING, implied by an ASan/LSan build, wraps struct map and
+    # struct dso in a proxy keeping the real object in ->orig, so there the
+    # dso is map->orig->dso->orig, giving map->orig->dso->orig->name here;
+    # struct symbol is not wrapped, so sym->name needs no ->orig.
+    printf "dso=%s ip=0x%lx sym=%s\n", dloc->ms->map->dso->name, dloc->ip, dloc->ms->sym ? dloc->ms->sym->name : "(no symbol)"
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
index 0000000000000000..5622a6e0742988c3
--- /dev/null
+++ b/tools/perf/scripts/perf-stuck.sh
@@ -0,0 +1,184 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# perf-stuck - tell a spinning perf apart from a blocked or recursing one
+#
+# Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# PROTOTYPE: wants to become a first class 'perf stuck' command, sampling
+# a process from inside perf, with the knowledge of perf's phases and of
+# the DWARF type chasing loops built in, instead of poking /proc and
+# shelling out to gdb.
+#
+# Samples /proc/<pid> at a fixed interval and prints the CPU time used
+# since the previous sample, the [stack] mapping start and size, and the
+# last line of a progress log when one is given, e.g. the stderr of
+# 'perf report --progress': burning a full interval with a constant
+# stack is a loop, a [stack] start moving down is runaway recursion.
+#
+# With -g it runs gdb (perf-stuck.gdb) when no progress is made for two
+# consecutive samples, printing the DIE chain a DWARF type chase is
+# walking.
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
+	# Resolve the name against the caller's own processes: as root,
+	# unscoped pgrep picks the first match of any user, e.g. one planted
+	# to get gdb attached to it, use an explicit pid to look at a perf of
+	# another user.
+	pid=$(pgrep -x -u "$(id -u)" -- "$1" | head -1)
+	[ -n "$pid" ] || { echo "no process named '$1' owned by $(id -un)"; exit 1; }
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
+	# spaces, so drop it together with the pid before splitting so the
+	# fields line up.  %d keeps the CPU time out of scientific
+	# notation, that bash arithmetic can't parse past six digits.
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
+	[ -n "$progress_log" ] && [ -s "$progress_log" ] && progress=$(tail -1 -- "$progress_log")
+
+	if [ -n "$prev_cpu" ]; then
+		cpu_delta=$(( cpu - prev_cpu ))
+		# No progress log, or one with nothing written to it yet, leaves
+		# no progress to look at, so count the samples that show none:
+		# -g then looks at where the process is after two intervals.
+		# Otherwise count the repeats of the same last line.
+		if [ -z "$progress" ] || [ "$progress" = "$prev_progress" ]; then
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
+		# The gdb script makes inferior calls, and a call into a perf
+		# wedged in a loop never returns, so bound the run; SIGINT
+		# releases the inferior instead of leaving perf stopped.
+		timeout --signal=INT 30 gdb -p "$pid" -batch -x "$gdb_cmds" -ex bt \
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

