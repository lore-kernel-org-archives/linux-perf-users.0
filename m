From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/35] perf tools: Return all events as auto-completions after comma
Date: Thu, 28 Dec 2017 11:30:26 -0300
Message-ID: <20171228143027.30547-35-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It's a follow up for one previous patch "perf tool: Improve bash command
line auto-complete for multiple events with comma."

It fixes an issue that no events are displayed when <TAB> is directly
typed after comma.

With this patch, now the result is:

  root@skl:/tmp# perf stat -e cpu-cycles,<TAB>
  Display all 2389 possibilities? (y or n)
  alarmtimer:alarmtimer_cancel
  alarmtimer:alarmtimer_fired
  alarmtimer:alarmtimer_start
  alarmtimer:alarmtimer_suspend
  alignment-faults
  arith.divider_active
  BAClear_Cost
  baclears.any
  block:block_bio_backmerge
  block:block_bio_bounce
  block:block_bio_complete
  block:block_bio_frontmerge
  block:block_bio_queue
  block:block_bio_remap
  block:block_dirty_buffer
  block:block_getrq
  block:block_plug
  block:block_rq_complete
  block:block_rq_insert
  block:block_rq_issue
  block:block_rq_remap
  block:block_rq_requeue
  block:block_sleeprq
  --More--

One remaining issue is that the auto-completions doesn't work well
for the event with ':'. For example, clk:clk_enable.

Because ':' is set as WORDBREAK by default in bash. Need more work
for this case.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1513940255-16528-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-completion.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index d8310830a18b..90206413f4d7 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -183,12 +183,16 @@ __perf_main ()
 				fi
 			done
 
-			evts=${result}+$(ls /sys/bus/event_source/devices/cpu/events)
+			evts=${result}" "$(ls /sys/bus/event_source/devices/cpu/events)
 		else
-			evts=${raw_evts}+$(ls /sys/bus/event_source/devices/cpu/events)
+			evts=${raw_evts}" "$(ls /sys/bus/event_source/devices/cpu/events)
 		fi
 
-		__perfcomp_colon "$evts" "$cur1"
+		if [[ "$cur1" == , ]]; then
+			__perfcomp_colon "$evts" ""
+		else
+			__perfcomp_colon "$evts" "$cur1"
+		fi
 	else
 		# List subcommands for perf commands
 		if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
-- 
2.13.6
