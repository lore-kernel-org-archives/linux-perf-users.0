From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/41] perf top: Add --namespaces option
Date: Wed, 29 May 2019 10:35:44 -0300
Message-ID: <20190529133605.21118-21-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Krister Johansen <kjlx@templeofstupid.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Since 'perf record' already have this option, let's have it for 'perf top'
as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190522053250.207156-4-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 44d89fb9c788..cfea87c6f38e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -262,6 +262,11 @@ Default is to monitor all CPUS.
 	The number of threads to run when synthesizing events for existing processes.
 	By default, the number of threads equals to the number of online CPUs.
 
+--namespaces::
+	Record events of type PERF_RECORD_NAMESPACES and display it with the
+	'cgroup_id' sort key.
+
+
 INTERACTIVE PROMPTING KEYS
 --------------------------
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fbbb0da43abb..31d78d874fc7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1208,6 +1208,9 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
+	if (opts->record_namespaces)
+		top->tool.namespace_events = true;
+
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
@@ -1500,6 +1503,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
+	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
+		    "Record namespaces events"),
 	OPT_END()
 	};
 	struct perf_evlist *sb_evlist = NULL;
-- 
2.20.1
