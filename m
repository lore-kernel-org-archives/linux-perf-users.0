From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/69] perf trace: Make evlist__set_evsel_handler() affect just entries without a handler
Date: Fri, 11 Oct 2019 17:04:54 -0300
Message-ID: <20191011200559.7156-5-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Renaming it to evlist__set_default_evsel_handler(), to better reflect
what we want to do, which is to set a default handler for events we
still haven't set a custom handler, like the ones for "msr:write_msr",
etc that are coming soon.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-e1bit7upnpmtsayh8039kfuw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bb5130d02155..ee330f50b450 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3858,12 +3858,14 @@ static int parse_pagefaults(const struct option *opt, const char *str,
 	return 0;
 }
 
-static void evlist__set_evsel_handler(struct evlist *evlist, void *handler)
+static void evlist__set_default_evsel_handler(struct evlist *evlist, void *handler)
 {
 	struct evsel *evsel;
 
-	evlist__for_each_entry(evlist, evsel)
-		evsel->handler = handler;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->handler == NULL)
+			evsel->handler = handler;
+	}
 }
 
 static int evlist__set_syscall_tp_fields(struct evlist *evlist)
@@ -4287,7 +4289,7 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 	if (trace.evlist->core.nr_entries > 0) {
-		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
+		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
 		if (evlist__set_syscall_tp_fields(trace.evlist)) {
 			perror("failed to set syscalls:* tracepoint fields");
 			goto out;
-- 
2.21.0
