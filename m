From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/17] perf evswitch: Add the names of on/off events
Date: Fri, 16 Aug 2019 17:16:43 -0300
Message-ID: <20190816201653.19332-8-acme@kernel.org>
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

So that we can have macros for the OPT_ entries and also for finding
those in an evlist, this way other tools will use this very easily.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-q0og1xoqqi0w38ve5u0a43k2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 18 ++++++++----------
 tools/perf/util/evswitch.h  |  1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e7b950e977a9..177e4e91b199 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3400,8 +3400,6 @@ int cmd_script(int argc, const char **argv)
 	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
-	const char *event_switch_on  = NULL,
-		   *event_switch_off = NULL;
 	int i, j, err = 0;
 	struct perf_script script = {
 		.tool = {
@@ -3545,9 +3543,9 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
-	OPT_STRING(0, "switch-on", &event_switch_on,
+	OPT_STRING(0, "switch-on", &script.evswitch.on_name,
 		   "event", "Consider events after the ocurrence of this event"),
-	OPT_STRING(0, "switch-off", &event_switch_off,
+	OPT_STRING(0, "switch-off", &script.evswitch.off_name,
 		   "event", "Stop considering events after the ocurrence of this event"),
 	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
 		    "Show the on/off switch events, used with --switch-on"),
@@ -3875,20 +3873,20 @@ int cmd_script(int argc, const char **argv)
 						  script.range_num);
 	}
 
-	if (event_switch_on) {
-		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, event_switch_on);
+	if (script.evswitch.on_name) {
+		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.on_name);
 		if (script.evswitch.on == NULL) {
-			fprintf(stderr, "switch-on event not found (%s)\n", event_switch_on);
+			fprintf(stderr, "switch-on event not found (%s)\n", script.evswitch.on_name);
 			err = -ENOENT;
 			goto out_delete;
 		}
 		script.evswitch.discarding = true;
 	}
 
-	if (event_switch_off) {
-		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, event_switch_off);
+	if (script.evswitch.off_name) {
+		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.off_name);
 		if (script.evswitch.off == NULL) {
-			fprintf(stderr, "switch-off event not found (%s)\n", event_switch_off);
+			fprintf(stderr, "switch-off event not found (%s)\n", script.evswitch.off_name);
 			err = -ENOENT;
 			goto out_delete;
 		}
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index bae3a22ad719..891164504080 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -9,6 +9,7 @@ struct evsel;
 
 struct evswitch {
 	struct evsel *on, *off;
+	const char   *on_name, *off_name;
 	bool	     discarding;
 	bool	     show_on_off_events;
 };
-- 
2.21.0
