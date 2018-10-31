From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/28] perf top: Allow disabling the overwrite mode
Date: Wed, 31 Oct 2018 13:44:50 -0300
Message-ID: <20181031164508.4784-11-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In ebebbf082357 ("perf top: Switch default mode to overwrite mode") we
forgot to leave a way to disable that new default, add a --overwrite
option that can be disabled using --no-overwrite, since the code already
in such a way that we can readily disable this mode.

This is useful when investigating bugs with this mode like the recent
report from David Miller where lots of unknown symbols appear due to
disabling the events while processing them which disables all record
types, not just PERF_RECORD_SAMPLE, which makes it impossible to resolve
maps when we lose PERF_RECORD_MMAP records.

This can be easily seen while building a kernel, when there are lots of
short lived processes.

Reported-by: David Miller <davem@davemloft.net>
Acked-by: Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: https://lkml.kernel.org/n/tip-oqgsz2bq4kgrnnajrafcdhie@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 114fda12aa49..d4be6061fe1c 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -242,6 +242,11 @@ Default is to monitor all CPUS.
 --hierarchy::
 	Enable hierarchy output.
 
+--overwrite::
+	This is the default, but for investigating problems with it or any other strange
+	behaviour like lots of unknown samples, we may want to disable this mode by using
+	--no-overwrite.
+
 --force::
 	Don't do ownership validation.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d8751e749..214fad747b04 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1372,6 +1372,8 @@ int cmd_top(int argc, const char **argv)
 		    "Show raw trace event output (do not use print fmt or plugins)"),
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
+	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
+		    "Use a backward ring buffer, default: yes"),
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
-- 
2.14.4
