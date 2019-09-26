From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/66] libperf: Move 'ids' from 'struct evsel' to 'struct perf_evsel'
Date: Wed, 25 Sep 2019 21:32:17 -0300
Message-ID: <20190926003244.13962-40-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move 'ids' from 'struct evsel' to libperf's 'struct perf_evsel'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/evlist.c                |  2 +-
 tools/perf/util/evsel.c                 |  2 +-
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 14 +++++++-------
 tools/perf/util/intel-bts.c             |  2 +-
 tools/perf/util/intel-pt.c              |  2 +-
 tools/perf/util/synthetic-events.c      |  6 +++---
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index e7171948c347..385766f06591 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -19,6 +19,7 @@ struct perf_evsel {
 	struct xyarray		*fd;
 	struct xyarray		*sample_id;
 	u64			*id;
+	u32			 ids;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 24f03f245525..5e43fb9da359 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -482,7 +482,7 @@ void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->core.id[evsel->ids++] = id;
+	evsel->core.id[evsel->core.ids++] = id;
 }
 
 int perf_evlist__id_add_fd(struct evlist *evlist,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c1b4f4a5fa3..55638eb9299c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1254,7 +1254,7 @@ static void perf_evsel__free_id(struct evsel *evsel)
 	xyarray__delete(evsel->core.sample_id);
 	evsel->core.sample_id = NULL;
 	zfree(&evsel->core.id);
-	evsel->ids = 0;
+	evsel->core.ids = 0;
 }
 
 static void perf_evsel__free_config_terms(struct evsel *evsel)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0d2aa933ceb3..ed64395ec340 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,7 +119,6 @@ struct evsel {
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
 	int			idx;
-	u32			ids;
 	unsigned long		max_events;
 	unsigned long		nr_events_printed;
 	char			*name;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2b0681ab08aa..498f6a825656 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -516,7 +516,7 @@ static int write_event_desc(struct feat_fd *ff,
 		 * copy into an nri to be independent of the
 		 * type of ids,
 		 */
-		nri = evsel->ids;
+		nri = evsel->core.ids;
 		ret = do_write(ff, &nri, sizeof(nri));
 		if (ret < 0)
 			return ret;
@@ -530,7 +530,7 @@ static int write_event_desc(struct feat_fd *ff,
 		/*
 		 * write unique ids for this event
 		 */
-		ret = do_write(ff, evsel->core.id, evsel->ids * sizeof(u64));
+		ret = do_write(ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (ret < 0)
 			return ret;
 	}
@@ -1656,7 +1656,7 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		id = calloc(nr, sizeof(*id));
 		if (!id)
 			goto error;
-		evsel->ids = nr;
+		evsel->core.ids = nr;
 		evsel->core.id = id;
 
 		for (j = 0 ; j < nr; j++) {
@@ -1699,9 +1699,9 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
 	for (evsel = events; evsel->core.attr.size; evsel++) {
 		fprintf(fp, "# event : name = %s, ", evsel->name);
 
-		if (evsel->ids) {
+		if (evsel->core.ids) {
 			fprintf(fp, ", id = {");
-			for (j = 0, id = evsel->core.id; j < evsel->ids; j++, id++) {
+			for (j = 0, id = evsel->core.id; j < evsel->core.ids; j++, id++) {
 				if (j)
 					fputc(',', fp);
 				fprintf(fp, " %"PRIu64, *id);
@@ -3068,7 +3068,7 @@ int perf_session__write_header(struct perf_session *session,
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
-		err = do_write(&ff, evsel->core.id, evsel->ids * sizeof(u64));
+		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
 			return err;
@@ -3082,7 +3082,7 @@ int perf_session__write_header(struct perf_session *session,
 			.attr = evsel->core.attr,
 			.ids  = {
 				.offset = evsel->id_offset,
-				.size   = evsel->ids * sizeof(u64),
+				.size   = evsel->core.ids * sizeof(u64),
 			}
 		};
 		err = do_write(&ff, &f_attr, sizeof(f_attr));
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index c94360cd9c00..34cb380d19a3 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -768,7 +768,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == bts->pmu_type && evsel->ids) {
+		if (evsel->core.attr.type == bts->pmu_type && evsel->core.ids) {
 			found = true;
 			break;
 		}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 24ca5d5908ca..a1c9eb6d4f40 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2735,7 +2735,7 @@ static struct evsel *intel_pt_evsel(struct intel_pt *pt,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == pt->pmu_type && evsel->ids)
+		if (evsel->core.attr.type == pt->pmu_type && evsel->core.ids)
 			return evsel;
 	}
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 907ac3971959..96ed008c2775 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1413,7 +1413,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
 		 sizeof(struct id_index_entry);
 
 	evlist__for_each_entry(evlist, evsel)
-		nr += evsel->ids;
+		nr += evsel->core.ids;
 
 	n = nr > max_nr ? max_nr : nr;
 	sz = sizeof(struct perf_record_id_index) + n * sizeof(struct id_index_entry);
@@ -1428,7 +1428,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
 	evlist__for_each_entry(evlist, evsel) {
 		u32 j;
 
-		for (j = 0; j < evsel->ids; j++) {
+		for (j = 0; j < evsel->core.ids; j++) {
 			struct id_index_entry *e;
 			struct perf_sample_id *sid;
 
@@ -1595,7 +1595,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist,
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
-		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
+		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->core.ids,
 						  evsel->core.id, process);
 		if (err) {
 			pr_debug("failed to create perf header attribute\n");
-- 
2.21.0
