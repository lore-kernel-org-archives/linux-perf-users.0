From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 18/22] perf stat: Fix cmd_stat to release cpu_map
Date: Wed, 09 Dec 2015 11:11:27 +0900
Message-ID: <20151209021127.10245.93697.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Fix cmd_stat() to release cpu_map objects (aggr_map and
cpus_aggr_map) afterwards.

refcnt debugger shows that the cmd_stat initializes cpu_map
but not puts it.
  ----
  # ./perf stat -v ls
  ....
  REFCNT: BUG: Unreclaimed objects found.
  ==== [0] ====
  Unreclaimed cpu_map@0x29339c0
  Refcount +1 => 1 at
    ./perf(cpu_map__empty_new+0x6d) [0x4e64bd]
    ./perf(cmd_stat+0x5fe) [0x43594e]
    ./perf() [0x47b785]
    ./perf(main+0x617) [0x422587]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2dff420af5]
    ./perf() [0x4226fd]
  REFCNT: Total 1 objects are not reclaimed.
    "cpu_map" leaks 1 objects
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/builtin-stat.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e74712d..eb6da8f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1094,6 +1094,16 @@ static int perf_stat_init_aggr_mode(void)
 	return cpus_aggr_map ? 0 : -ENOMEM;
 }
 
+static void perf_stat_exit_aggr_mode(void)
+{
+	if (aggr_map)
+		cpu_map__put(aggr_map);
+	if (cpus_aggr_map)
+		cpu_map__put(cpus_aggr_map);
+	aggr_map = NULL;
+	cpus_aggr_map = NULL;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1442,6 +1452,7 @@ int cmd_stat(int argc, const char **argv, const char *prefix __maybe_unused)
 	if (!forever && status != -1 && !interval)
 		print_counters(NULL, argc, argv);
 
+	perf_stat_exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
 	perf_evlist__delete(evsel_list);
