From: Tony Jones <tonyj@suse.de>
Subject: [PATCH] perf script: fix crash when processing recorded stat data
Date: Sun, 20 Jan 2019 11:14:14 -0800
Message-ID: <20190120191414.12925-1-tonyj@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Tony Jones <tonyj@suse.de>, acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, jolsa@redhat.com, ak@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

While updating Perf to work with Python3 and Python2 I noticed that the 
stat-cpi script was dumping core.

$ perf  stat -e cycles,instructions record -o /tmp/perf.data /bin/false

 Performance counter stats for '/bin/false':

           802,148      cycles

           604,622      instructions                                                       802,148      cycles
           604,622      instructions

       0.001445842 seconds time elapsed

$ perf script -i /tmp/perf.data -s scripts/python/stat-cpi.py
Segmentation fault (core dumped)
...
...
    rblist=rblist@entry=0xb2a200 <rt_stat>,
    new_entry=new_entry@entry=0x7ffcb755c310) at util/rblist.c:33
    ctx=<optimized out>, type=<optimized out>, create=<optimized out>,
    cpu=<optimized out>, evsel=<optimized out>) at util/stat-shadow.c:118
    ctx=<optimized out>, type=<optimized out>, st=<optimized out>)
    at util/stat-shadow.c:196
    count=count@entry=727442, cpu=cpu@entry=0, st=0xb2a200 <rt_stat>)
    at util/stat-shadow.c:239
    config=config@entry=0xafeb40 <stat_config>,
    counter=counter@entry=0x133c6e0) at util/stat.c:372
...
...

The issue is that since 1fcd03946b52 perf_stat__update_shadow_stats now calls
update_runtime_stat passing rt_stat rather than calling update_stats but
perf_stat__init_shadow_stats has never been called to initialize rt_stat in
the script path processing recorded stat data.

Since I can't see any reason why perf_stat__init_shadow_stats() is presently
initialized like it is in builtin-script.c::perf_sample__fprint_metric()
[4bd1bef8bba2f] I'm proposing it instead be initialized once in __cmd_script

Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
Signed-off-by: Tony Jones <tonyj@suse.de>
---
 tools/perf/builtin-script.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d079f36d342d..9a6dd86e606f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1681,13 +1681,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 		.force_header = false,
 	};
 	struct perf_evsel *ev2;
-	static bool init;
 	u64 val;
 
-	if (!init) {
-		perf_stat__init_shadow_stats();
-		init = true;
-	}
 	if (!evsel->stats)
 		perf_evlist__alloc_stats(script->session->evlist, false);
 	if (evsel_script(evsel->leader)->gnum++ == 0)
@@ -2359,6 +2354,8 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
+	perf_stat__init_shadow_stats();
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
-- 
2.18.0
