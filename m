From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/17] perf evswitch: Move struct to a separate header to use in other tools
Date: Fri, 16 Aug 2019 17:16:41 -0300
Message-ID: <20190816201653.19332-6-acme@kernel.org>
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

Now that we see that the simple userspace-based "slicing" of events
using delimiter events ("markers") works, lets move it to a separate
header to make it available to other tools, next step will be having
the switch on/off check done at the PERF_RECORD_SAMPLE processing
function moved too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-z0cyi9ifzlr37cedr9xztc1k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c |  8 +-------
 tools/perf/util/evswitch.h  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/evswitch.h

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6eed0f7e835..fff02e0d70c4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -16,6 +16,7 @@
 #include "util/trace-event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evswitch.h"
 #include "util/sort.h"
 #include "util/data.h"
 #include "util/auxtrace.h"
@@ -1616,13 +1617,6 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	return 0;
 }
 
-struct evswitch {
-	struct evsel *on,
-		     *off;
-	bool	     discarding;
-	bool	     show_on_off_events;
-};
-
 struct perf_script {
 	struct perf_tool	tool;
 	struct perf_session	*session;
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
new file mode 100644
index 000000000000..bb88e8002f39
--- /dev/null
+++ b/tools/perf/util/evswitch.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#ifndef __PERF_EVSWITCH_H
+#define __PERF_EVSWITCH_H 1
+
+#include <stdbool.h>
+
+struct evsel;
+
+struct evswitch {
+	struct evsel *on, *off;
+	bool	     discarding;
+	bool	     show_on_off_events;
+};
+
+#endif /* __PERF_EVSWITCH_H */
-- 
2.21.0
