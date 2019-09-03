From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH] Add input file_name support for perf sched {map|latency|replay|timehist}
Date: Tue,  3 Sep 2019 16:55:35 +0800
Message-ID: <20190903085535.23913-1-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, windyu@tencent.com, adrian.hunter@intel.com, wangnan0@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

From: YuZhoujian <windyu@tencent.com>

Just add '-i' option for perf sched {map|latency|replay|timehist}

Signed-off-by: YuZhoujian <windyu@tencent.com>
---
 tools/perf/Documentation/perf-sched.txt | 7 +++++++
 tools/perf/builtin-sched.c              | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 63f938b887dd..182c223d3d9b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -80,6 +80,9 @@ OPTIONS
 
 OPTIONS for 'perf sched map'
 ----------------------------
+-i::
+--input=<file>::
+        Input file name. (default: perf.data unless stdin is a fifo)
 
 --compact::
 	Show only CPUs with activity. Helps visualizing on high core
@@ -96,6 +99,10 @@ OPTIONS for 'perf sched map'
 
 OPTIONS for 'perf sched timehist'
 ---------------------------------
+-i::
+--input=<file>::
+        Input file name. (default: perf.data unless stdin is a fifo)
+
 -k::
 --vmlinux=<file>::
     vmlinux pathname
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 025151dcb651..8e51fbb88549 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3374,6 +3374,7 @@ int cmd_sched(int argc, const char **argv)
 	const struct option latency_options[] = {
 	OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
 		   "sort by key(s): runtime, switch, avg, max"),
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_INTEGER('C', "CPU", &sched.profile_cpu,
 		    "CPU to profile on"),
 	OPT_BOOLEAN('p', "pids", &sched.skip_merge,
@@ -3381,11 +3382,13 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option replay_options[] = {
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
 		     "repeat the workload replay N times (-1: infinite)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option map_options[] = {
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN(0, "compact", &sched.map.comp,
 		    "map output in compact mode"),
 	OPT_STRING(0, "color-pids", &sched.map.color_pids_str, "pids",
@@ -3397,6 +3400,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
-- 
2.23.0.37.g745f681
