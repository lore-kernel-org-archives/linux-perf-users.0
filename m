From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/28] perf top: Do not use overwrite mode by default
Date: Wed, 31 Oct 2018 13:44:51 -0300
Message-ID: <20181031164508.4784-12-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Enabling --overwrite mode allows us to to use just the most recent
records, which helps in high core count machines such as Knights
Landing/Mill, but right now is being disabled by default as the pausing
used in this technique is leading to loss of metadata events such as
PERF_RECORD_MMAP which makes 'perf top' unable to resolve samples,
leading to lots of unknown samples appearing on the UI.

Enabling this may be useful if you are in such machines and profiling a
workload that doesn't creates short lived threads and/or doesn't uses
many executable mmap operations.

Work is being planed to solve this situation, till then, this will
remain disabled by default.

Reported-by: David Miller <davem@davemloft.net>
Acked-by: Kan Liang <kan.liang@intel.com>
Link: https://lkml.kernel.org/r/4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: https://lkml.kernel.org/n/tip-ehvf77vi1si9409r7p4wx788@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 11 ++++++++---
 tools/perf/builtin-top.c              | 11 +++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index d4be6061fe1c..808b664343c9 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -243,9 +243,14 @@ Default is to monitor all CPUS.
 	Enable hierarchy output.
 
 --overwrite::
-	This is the default, but for investigating problems with it or any other strange
-	behaviour like lots of unknown samples, we may want to disable this mode by using
-	--no-overwrite.
+	Enable this to use just the most recent records, which helps in high core count
+	machines such as Knights Landing/Mill, but right now is disabled by default as
+	the pausing used in this technique is leading to loss of metadata events such
+	as PERF_RECORD_MMAP which makes 'perf top' unable to resolve samples, leading
+	to lots of unknown samples appearing on the UI. Enable this if you are in such
+	machines and profiling a workload that doesn't creates short lived threads and/or
+	doesn't uses many executable mmap operations. Work is being planed to solve
+	this situation, till then, this will remain disabled by default.
 
 --force::
 	Don't do ownership validation.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 214fad747b04..8e29e0cc8626 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1257,7 +1257,14 @@ int cmd_top(int argc, const char **argv)
 				.uses_mmap   = true,
 			},
 			.proc_map_timeout    = 500,
-			.overwrite	= 1,
+			/*
+			 * FIXME: This will lose PERF_RECORD_MMAP and other metadata
+			 * when we pause, fix that and reenable. Probably using a
+			 * separate evlist with a dummy event, i.e. a non-overwrite
+			 * ring buffer just for metadata events, while PERF_RECORD_SAMPLE
+			 * stays in overwrite mode. -acme
+			 * */
+			.overwrite	= 0,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
@@ -1373,7 +1380,7 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
-		    "Use a backward ring buffer, default: yes"),
+		    "Use a backward ring buffer, default: no"),
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
-- 
2.14.4
