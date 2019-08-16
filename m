From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/17] perf evswitch: Introduce OPTS_EVSWITCH() for cmd line processing
Date: Fri, 16 Aug 2019 17:16:44 -0300
Message-ID: <20190816201653.19332-9-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Weimer <fweimer@redhat.com>, William Cohen <wcohen@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All tools will want those, so provide a convenient way to get them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-v16pe3sbf3wjmn152u18f649@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 7 +------
 tools/perf/util/evswitch.h  | 8 ++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 177e4e91b199..2a5b8af80e6b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3543,12 +3543,7 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
-	OPT_STRING(0, "switch-on", &script.evswitch.on_name,
-		   "event", "Consider events after the ocurrence of this event"),
-	OPT_STRING(0, "switch-off", &script.evswitch.off_name,
-		   "event", "Stop considering events after the ocurrence of this event"),
-	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
-		    "Show the on/off switch events, used with --switch-on"),
+	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
 	const char * const script_subcommands[] = { "record", "report", NULL };
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index 891164504080..94220d1bb479 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -16,4 +16,12 @@ struct evswitch {
 
 bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
 
+#define OPTS_EVSWITCH(evswitch)								  \
+	OPT_STRING(0, "switch-on", &(evswitch)->on_name,				  \
+		   "event", "Consider events after the ocurrence of this event"),	  \
+	OPT_STRING(0, "switch-off", &(evswitch)->off_name,				  \
+		   "event", "Stop considering events after the ocurrence of this event"), \
+	OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_events,		  \
+		    "Show the on/off switch events, used with --switch-on and --switch-off")
+
 #endif /* __PERF_EVSWITCH_H */
-- 
2.21.0
