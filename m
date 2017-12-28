From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/35] perf tool: Improve bash command line auto-complete for multiple events with comma
Date: Thu, 28 Dec 2017 11:30:25 -0300
Message-ID: <20171228143027.30547-34-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

perf has perf-completion.sh to define command line auto-completion in
bash/zsh.

For record/stat -e it works for single events, but isn't working when
specifying multiple events with comma.

It would be very useful if it could be fixed to make it easier by
supporting multiple events, comma separated.

With this patch, the result can be like this:

1. Support the events returned from 'perf list --raw-dump'

root@skl:/tmp# perf stat -e cpu/cache<TAB>
cpu/cache-misses/      cpu/cache-references/

root@skl:/tmp# perf stat -e cpu/cache-misses/,cpu/branch-<TAB>
cpu/branch-instructions/  cpu/branch-misses/

root@skl:/tmp# perf stat -e cpu/cache-misses/,cpu/branch-i<TAB>
root@skl:/tmp# perf stat -e cpu/cache-misses/,cpu/branch-instructions/

2. Support the events listed in /sys/bus/event_source/devices/cpu/events

root@skl:/tmp# perf stat -e cycle<TAB>
cycle_activity.cycles_l1d_miss  cycle_activity.stalls_l3_miss
cycle_activity.cycles_l2_miss   cycle_activity.stalls_mem_any
cycle_activity.cycles_l3_miss   cycle_activity.stalls_total
cycle_activity.cycles_mem_any   cycles-ct
cycle_activity.stalls_l1d_miss  cycles-t
cycle_activity.stalls_l2_miss

root@skl:/tmp# perf stat -e cycles-<TAB>
cycles-ct  cycles-t

root@skl:/tmp# perf stat -e cycles-t,cpu/c<TAB>
cpu/cache-misses/      cpu/cpu-cycles/        cpu/cycles-t/
cpu/cache-references/  cpu/cycles-ct/

root@skl:/tmp# perf stat -e cycles-t,cpu/cache-<TAB>
cpu/cache-misses/      cpu/cache-references/

root@skl:/tmp# perf stat -e cycles-t,cpu/cache-misses/

3. Support the uppercase event which is with prefix "cpu/"

root@skl:/tmp# perf stat -e cpu/c<TAB>
cpu/cache-misses/      cpu/cpu-cycles/        cpu/cycles-t/
cpu/cache-references/  cpu/cycles-ct/

root@skl:/tmp# perf stat -e cpu/cache-misses/,cpu/C<TAB>
cpu/CACHE-MISSES/      cpu/CPU-CYCLES/        cpu/CYCLES-T/
cpu/CACHE-REFERENCES/  cpu/CYCLES-CT/

root@skl:/tmp# perf stat -e cpu/cache-misses/,cpu/CACHE-REFERENCES/

Note that:

a) This patch only supports bash.

b) It doesn't support the cases like {},{} or {...,...}.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1513848370-8098-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-completion.sh | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 345f5d6e9ed5..d8310830a18b 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -162,8 +162,33 @@ __perf_main ()
 	# List possible events for -e option
 	elif [[ $prev == @("-e"|"--event") &&
 		$prev_skip_opts == @(record|stat|top) ]]; then
-		evts=$($cmd list --raw-dump)
-		__perfcomp_colon "$evts" "$cur"
+
+		local cur1=${COMP_WORDS[COMP_CWORD]}
+		local raw_evts=$($cmd list --raw-dump)
+		local arr s tmp result
+
+		if [[ "$cur1" == */* && ${cur1#*/} =~ ^[A-Z] ]]; then
+			OLD_IFS="$IFS"
+			IFS=" "
+			arr=($raw_evts)
+			IFS="$OLD_IFS"
+
+			for s in ${arr[@]}
+			do
+				if [[ "$s" == *cpu/* ]]; then
+					tmp=${s#*cpu/}
+					result=$result" ""cpu/"${tmp^^}
+				else
+					result=$result" "$s
+				fi
+			done
+
+			evts=${result}+$(ls /sys/bus/event_source/devices/cpu/events)
+		else
+			evts=${raw_evts}+$(ls /sys/bus/event_source/devices/cpu/events)
+		fi
+
+		__perfcomp_colon "$evts" "$cur1"
 	else
 		# List subcommands for perf commands
 		if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
@@ -246,11 +271,16 @@ fi
 type perf &>/dev/null &&
 _perf()
 {
+	if [[ "$COMP_WORDBREAKS" != *,* ]]; then
+		COMP_WORDBREAKS="${COMP_WORDBREAKS},"
+		export COMP_WORDBREAKS
+	fi
+
 	local cur words cword prev
 	if [ $preload_get_comp_words_by_ref = "true" ]; then
-		_get_comp_words_by_ref -n =: cur words cword prev
+		_get_comp_words_by_ref -n =:, cur words cword prev
 	else
-		__perf_get_comp_words_by_ref -n =: cur words cword prev
+		__perf_get_comp_words_by_ref -n =:, cur words cword prev
 	fi
 	__perf_main
 } &&
-- 
2.13.6
