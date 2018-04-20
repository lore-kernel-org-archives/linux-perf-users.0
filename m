From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/17] perf mem: Allow all record/report options
Date: Fri, 20 Apr 2018 11:32:20 -0300
Message-ID: <20180420143227.16030-11-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For perf mem report / perf mem record, pass all unknown options
through to the underlying report/record commands. This makes things
like

perf mem record -a sleep 1

work. Matches how c2c and other tools work.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 3 +++
 tools/perf/builtin-mem.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index b0211410969b..8806ed5f3802 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -67,6 +67,9 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+In addition, for report all perf report options are valid, and for record
+all perf record options.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 506564651cda..57393e94d156 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -83,7 +83,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	};
 
 	argc = parse_options(argc, argv, options, record_mem_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_KEEP_UNKNOWN);
 
 	rec_argc = argc + 9; /* max number of arguments */
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
@@ -436,7 +436,7 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
-					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!argc || !(strncmp(argv[0], "rec", 3) || mem.operation))
 		usage_with_options(mem_usage, mem_options);
-- 
2.14.3
