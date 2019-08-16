From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/17] perf evswitch: Move enoent error message printing to separate function
Date: Fri, 16 Aug 2019 17:16:46 -0300
Message-ID: <20190816201653.19332-11-acme@kernel.org>
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

Allows adding hints there, will be done in followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-1kvrdi7weuz3hxycwvarcu6v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evswitch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index b57b5f0816f5..71daed615a2c 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -31,12 +31,17 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 	return false;
 }
 
+static int evswitch__fprintf_enoent(FILE *fp, const char *evtype, const char *evname)
+{
+	return fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+}
+
 int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
 {
 	if (evswitch->on_name) {
 		evswitch->on = perf_evlist__find_evsel_by_str(evlist, evswitch->on_name);
 		if (evswitch->on == NULL) {
-			fprintf(fp, "switch-on event not found (%s)\n", evswitch->on_name);
+			evswitch__fprintf_enoent(fp, "on", evswitch->on_name);
 			return -ENOENT;
 		}
 		evswitch->discarding = true;
@@ -45,7 +50,7 @@ int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
 	if (evswitch->off_name) {
 		evswitch->off = perf_evlist__find_evsel_by_str(evlist, evswitch->off_name);
 		if (evswitch->off == NULL) {
-			fprintf(fp, "switch-off event not found (%s)\n", evswitch->off_name);
+			evswitch__fprintf_enoent(fp, "off", evswitch->off_name);
 			return -ENOENT;
 		}
 	}
-- 
2.21.0
