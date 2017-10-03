From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/8] perf top: Add option to set the number of thread for event synthesize
Date: Tue,  3 Oct 2017 09:55:39 -0300
Message-ID: <20171003125540.331-8-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753963AbdJCM4X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Oct 2017 08:56:23 -0400
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <kan.liang@intel.com>

Using UINT_MAX to indicate the default thread#, which is the max number
of online CPU.

Committer testing:

  # perf trace --no-inherit -e clone -o /tmp/output perf top --num-thread-synthesize 9
  # cat /tmp/output
         ? (     ?   ):  ... [continued]: clone()) = 26651 (perf)
     0.059 ( 0.010 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5bfac44f30, parent_tidptr: 0x7f5bfac459d0, child_tidptr: 0x7f5bfac459d0, tls: 0x7f5bfac45700) = 26652 (perf)
     0.116 ( 0.014 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5bfa443f30, parent_tidptr: 0x7f5bfa4449d0, child_tidptr: 0x7f5bfa4449d0, tls: 0x7f5bfa444700) = 26653 (perf)
     0.141 ( 0.009 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5bf9c42f30, parent_tidptr: 0x7f5bf9c439d0, child_tidptr: 0x7f5bf9c439d0, tls: 0x7f5bf9c43700) = 26654 (perf)
     0.160 ( 0.012 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5bf9441f30, parent_tidptr: 0x7f5bf94429d0, child_tidptr: 0x7f5bf94429d0, tls: 0x7f5bf9442700) = 26655 (perf)
     0.232 ( 0.013 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5bf8c40f30, parent_tidptr: 0x7f5bf8c419d0, child_tidptr: 0x7f5bf8c419d0, tls: 0x7f5bf8c41700) = 26656 (perf)
     0.393 ( 0.011 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5be3ffef30, parent_tidptr: 0x7f5be3fff9d0, child_tidptr: 0x7f5be3fff9d0, tls: 0x7f5be3fff700) = 26657 (perf)
     0.802 ( 0.012 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5be37fdf30, parent_tidptr: 0x7f5be37fe9d0, child_tidptr: 0x7f5be37fe9d0, tls: 0x7f5be37fe700) = 26658 (perf)
     1.411 ( 0.022 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5be2ffcf30, parent_tidptr: 0x7f5be2ffd9d0, child_tidptr: 0x7f5be2ffd9d0, tls: 0x7f5be2ffd700) = 26659 (perf)
   246.422 ( 0.042 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f5be2ffcf30, parent_tidptr: 0x7f5be2ffd9d0, child_tidptr: 0x7f5be2ffd9d0, tls: 0x7f5be2ffd700) = 26660 (perf)
  #

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1506696477-146932-5-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt |  3 +++
 tools/perf/builtin-top.c              | 11 ++++++++---
 tools/perf/util/event.c               |  5 ++++-
 tools/perf/util/top.h                 |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index d864ea6fd367..4353262bc462 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -240,6 +240,9 @@ Default is to monitor all CPUS.
 --force::
 	Don't do ownership validation.
 
+--num-thread-synthesize::
+	The number of threads to run when synthesizing events for existing processes.
+	By default, the number of threads equals to the number of online CPUs.
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index bc31b93cc1d8..477a8699f0b5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -958,14 +958,16 @@ static int __cmd_top(struct perf_top *top)
 	if (perf_session__register_idle_thread(top->session) < 0)
 		goto out_delete;
 
-	perf_set_multithreaded();
+	if (top->nr_threads_synthesize > 1)
+		perf_set_multithreaded();
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false,
 				    opts->proc_map_timeout,
-				    (unsigned int)sysconf(_SC_NPROCESSORS_ONLN));
+				    top->nr_threads_synthesize);
 
-	perf_set_singlethreaded();
+	if (top->nr_threads_synthesize > 1)
+		perf_set_singlethreaded();
 
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
@@ -1118,6 +1120,7 @@ int cmd_top(int argc, const char **argv)
 		},
 		.max_stack	     = sysctl_perf_event_max_stack,
 		.sym_pcnt_filter     = 5,
+		.nr_threads_synthesize = UINT_MAX,
 	};
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
@@ -1227,6 +1230,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
+	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
+			"number of thread to run event synthesize"),
 	OPT_END()
 	};
 	const char * const top_usage[] = {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0e678dd6bdbe..47eff4767edb 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -790,7 +790,10 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	if (n < 0)
 		return err;
 
-	thread_nr = nr_threads_synthesize;
+	if (nr_threads_synthesize == UINT_MAX)
+		thread_nr = sysconf(_SC_NPROCESSORS_ONLN);
+	else
+		thread_nr = nr_threads_synthesize;
 
 	if (thread_nr <= 1) {
 		err = __perf_event__synthesize_threads(tool, process,
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 9bdfb78a9a35..f4296e1e3bb8 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -37,6 +37,7 @@ struct perf_top {
 	int		   sym_pcnt_filter;
 	const char	   *sym_filter;
 	float		   min_percent;
+	unsigned int	   nr_threads_synthesize;
 };
 
 #define CONSOLE_CLEAR "[H[2J"
-- 
2.13.6
