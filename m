From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/26] perf record: Add support for AUX area sampling
Date: Fri, 22 Nov 2019 11:56:58 -0300
Message-ID: <20191122145711.3171-14-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a 'perf record' option '--aux-sample' to request AUX area sampling.
AUX area sampling uses an overwriting buffer much like snapshot mode, so
adjust the AUX buffer mmapping accordingly. To make it easy to queue
samples for decoding, synthesize an ID index.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  6 ++++++
 tools/perf/builtin-record.c              | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ebcba1f95513..e216d7b529c9 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -433,6 +433,12 @@ can be specified in a string that follows this option:
 In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
 and on exit if the above 'e' option is given.
 
+--aux-sample[=OPTIONS]::
+Select AUX area sampling. At least one of the events selected by the -e option
+must be an AUX area event. Samples on other events will be created containing
+data from the AUX area. Optionally sample size may be specified, otherwise it
+defaults to 4KiB.
+
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
 because the file may be huge. A time out is needed in such cases.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ab3110b4035..b5063d3b6fd0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -680,6 +680,11 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
+	err = auxtrace_parse_sample_options(rec->itr, rec->evlist, &rec->opts,
+					    rec->opts.auxtrace_sample_opts);
+	if (err)
+		return err;
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
@@ -752,6 +757,8 @@ static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
 	struct record_opts *opts = &rec->opts;
+	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
+				  opts->auxtrace_sample_mode;
 	char msg[512];
 
 	if (opts->affinity != PERF_AFFINITY_SYS)
@@ -759,7 +766,7 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode,
+				 auxtrace_overwrite,
 				 opts->nr_cblocks, opts->affinity,
 				 opts->mmap_flush, opts->comp_level) < 0) {
 		if (errno == EPERM) {
@@ -1046,6 +1053,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
+		    !rec->opts.auxtrace_sample_mode &&
 		    record__auxtrace_mmap_read(rec, map) != 0) {
 			rc = -1;
 			goto out;
@@ -1321,6 +1329,15 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err)
 		goto out;
 
+	/* Synthesize id_index before auxtrace_info */
+	if (rec->opts.auxtrace_sample_mode) {
+		err = perf_event__synthesize_id_index(tool,
+						      process_synthesized_event,
+						      session->evlist, machine);
+		if (err)
+			goto out;
+	}
+
 	if (rec->opts.full_auxtrace) {
 		err = perf_event__synthesize_auxtrace_info(rec->itr, tool,
 					session, process_synthesized_event);
@@ -2329,6 +2346,8 @@ static struct option __record_options[] = {
 	parse_clockid),
 	OPT_STRING_OPTARG('S', "snapshot", &record.opts.auxtrace_snapshot_opts,
 			  "opts", "AUX area tracing Snapshot Mode", ""),
+	OPT_STRING_OPTARG(0, "aux-sample", &record.opts.auxtrace_sample_opts,
+			  "opts", "sample AUX area", ""),
 	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
-- 
2.21.0
