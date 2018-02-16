From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/41] perf report: Add support to display group output for non group events
Date: Fri, 16 Feb 2018 16:17:13 -0300
Message-ID: <20180216191746.11095-9-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Add support to display group output for if non grouped events are
detected and user forces --group option. Now for non-group events
recorded like:

  $ perf record -e 'cycles,instructions' ls

you can still get group output by using --group option
in report:

  $ perf report --group --stdio
  ...
  #         Overhead  Command  Shared Object     Symbol
  # ................  .......  ................  ......................
  #
      17.67%   0.00%  ls       libc-2.25.so      [.] _IO_do_write@@GLIB
      15.59%  25.94%  ls       ls                [.] calculate_columns
      15.41%  31.35%  ls       libc-2.25.so      [.] __strcoll_l
  ...

Committer note:

We should improve on this by making sure that the first line states that
this is not a group, but since the user doesn't have to force group view
when really using grouped events (e.g. '{cycles,instructions}'), the
user better know what is being done...

Requested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180209092734.GB20449@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 3 ++-
 tools/perf/builtin-report.c              | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 907e505b6309..a76b871f78a6 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -354,7 +354,8 @@ OPTIONS
         Path to objdump binary.
 
 --group::
-	Show event group information together.
+	Show event group information together. It forces group output also
+	if there are no groups defined in data file.
 
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8ef71669e7a0..1eedb1815c4c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -938,6 +938,7 @@ int cmd_report(int argc, const char **argv)
 		"perf report [<options>]",
 		NULL
 	};
+	bool group_set = false;
 	struct report report = {
 		.tool = {
 			.sample		 = process_sample_event,
@@ -1057,7 +1058,7 @@ int cmd_report(int argc, const char **argv)
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
-	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
+	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &group_set,
 		    "Show event group information together"),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
@@ -1174,6 +1175,9 @@ int cmd_report(int argc, const char **argv)
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
 
+	if (group_set && !session->evlist->nr_groups)
+		perf_evlist__set_leader(session->evlist);
+
 	if (itrace_synth_opts.last_branch)
 		has_br_stack = true;
 
-- 
2.14.3
