From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/69] perf trace: Postpone parsing .perfconfig trace.add_events to after --verbose is processed
Date: Fri, 11 Oct 2019 17:04:57 -0300
Message-ID: <20191011200559.7156-8-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we add events via the '[trace]' section in perfconfig the command
line options are not yet processed, so when something goes wrong with
parsing those events and using --verbose is advised, we end up not
getting any more verbosity by doing so.

So just copy the trace.add_events string for later processing, after we
processed --verbose and the other command line options.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-d6wbnz85ftqljdll6ynjyjd8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 313dfc1cefc5..3d54316639a4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -162,6 +162,7 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
+	char			*perfconfig_events;
 	struct {
 		struct ordered_events	data;
 		u64			last;
@@ -4044,15 +4045,11 @@ static int trace__config(const char *var, const char *value, void *arg)
 	int err = 0;
 
 	if (!strcmp(var, "trace.add_events")) {
-		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
-					       "event selector. use 'perf list' to list available events",
-					       parse_events_option);
-		/*
-		 * We can't propagate parse_event_option() return, as it is 1
-		 * for failure while perf_config() expects -1.
-		 */
-		if (parse_events_option(&o, value, 0))
-			err = -1;
+		trace->perfconfig_events = strdup(value);
+		if (trace->perfconfig_events == NULL) {
+			pr_err("Not enough memory for %s\n", "trace.add_events");
+			return -1;
+		}
 	} else if (!strcmp(var, "trace.show_timestamp")) {
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
@@ -4224,6 +4221,21 @@ int cmd_trace(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
 				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	/*
+	 * Now that we have --verbose figured out, lets see if we need to parse
+	 * events from .perfconfig, so that if those events fail parsing, say some
+	 * BPF program fails, then we'll be able to use --verbose to see what went
+	 * wrong in more detail.
+	 */
+	if (trace.perfconfig_events != NULL) {
+		struct parse_events_error parse_err = { .idx = 0, };
+
+		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
+		if (err) {
+			parse_events_print_error(&parse_err, trace.perfconfig_events);
+			goto out;
+		}
+	}
 
 	if ((nr_cgroups || trace.cgroup) && !trace.opts.target.system_wide) {
 		usage_with_options_msg(trace_usage, trace_options,
@@ -4441,5 +4453,6 @@ int cmd_trace(int argc, const char **argv)
 	if (output_name != NULL)
 		fclose(trace.output);
 out:
+	zfree(&trace.perfconfig_events);
 	return err;
 }
-- 
2.21.0
