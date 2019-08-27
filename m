From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/33] perf evsel: Rename perf_missing_features::bpf_event to ::bpf
Date: Mon, 26 Aug 2019 22:36:34 -0300
Message-ID: <20190827013634.3173-34-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need for that _event suffix, do just like all the other meta events
and do away with that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-bvc83f380dva83wlg52yd10t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 9 ++++-----
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b3cfe120d097..fa676355559e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1072,8 +1072,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
-	attr->bpf_event = track && !opts->no_bpf_event &&
-		!perf_missing_features.bpf_event;
+	attr->bpf_event = track && !opts->no_bpf_event && !perf_missing_features.bpf;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1803,7 +1802,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
 	if (perf_missing_features.ksymbol)
 		evsel->core.attr.ksymbol = 0;
-	if (perf_missing_features.bpf_event)
+	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
@@ -1920,8 +1919,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		perf_missing_features.aux_output = true;
 		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
-	} else if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
-		perf_missing_features.bpf_event = true;
+	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
+		perf_missing_features.bpf = true;
 		pr_debug2("switching off bpf_event\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 77e07f2486d3..fd60caced4fc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -194,7 +194,7 @@ struct perf_missing_features {
 	bool write_backward;
 	bool group_read;
 	bool ksymbol;
-	bool bpf_event;
+	bool bpf;
 	bool aux_output;
 };
 
-- 
2.21.0
