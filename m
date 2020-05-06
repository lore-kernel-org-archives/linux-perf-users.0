From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 83/91] perf annotate: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:26 -0300
Message-ID: <20200506152234.21977-84-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index b0e5a30755ce..d3e5a84f87a2 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -212,11 +212,9 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int perf_evsel__add_sample(struct evsel *evsel,
-				  struct perf_sample *sample,
-				  struct addr_location *al,
-				  struct perf_annotate *ann,
-				  struct machine *machine)
+static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
+			     struct addr_location *al, struct perf_annotate *ann,
+			     struct machine *machine)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he;
@@ -278,7 +276,7 @@ static int process_sample_event(struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    perf_evsel__add_sample(evsel, sample, &al, ann, machine)) {
+	    evsel__add_sample(evsel, sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.21.1
