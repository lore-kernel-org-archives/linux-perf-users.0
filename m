From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/33] libperf: Add PERF_RECORD_SAMPLE 'struct sample_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:29 -0300
Message-ID: <20190827013634.3173-29-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_SAMPLE event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 tools/perf/util/evlist.c            | 2 +-
 tools/perf/util/evsel.c             | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 585c9d82dba3..e768a2dfbe53 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -104,4 +104,9 @@ struct bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct sample_event {
+	struct perf_event_header header;
+	__u64			 array[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 091a0690a280..dee0ee57efc2 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -37,11 +37,6 @@
 /* perf sample has 16 bits size limit */
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
-struct sample_event {
-	struct perf_event_header        header;
-	u64 array[];
-};
-
 struct regs_dump {
 	u64 abi;
 	u64 mask;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ff415680fe0a..47bc54111f57 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -587,7 +587,7 @@ struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
 static int perf_evlist__event2id(struct evlist *evlist,
 				 union perf_event *event, u64 *id)
 {
-	const u64 *array = event->sample.array;
+	const __u64 *array = event->sample.array;
 	ssize_t n;
 
 	n = (event->header.size - sizeof(event->header)) >> 3;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9fadd5857ccc..778262f68d5c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2009,7 +2009,7 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 				       struct perf_sample *sample)
 {
 	u64 type = evsel->core.attr.sample_type;
-	const u64 *array = event->sample.array;
+	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
 
@@ -2099,7 +2099,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 {
 	u64 type = evsel->core.attr.sample_type;
 	bool swapped = evsel->needs_swap;
-	const u64 *array;
+	const __u64 *array;
 	u16 max_size = event->header.size;
 	const void *endp = (void *)event + max_size;
 	u64 sz;
@@ -2378,7 +2378,7 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 				       u64 *timestamp)
 {
 	u64 type = evsel->core.attr.sample_type;
-	const u64 *array;
+	const __u64 *array;
 
 	if (!(type & PERF_SAMPLE_TIME))
 		return -1;
@@ -2529,7 +2529,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 				  u64 read_format,
 				  const struct perf_sample *sample)
 {
-	u64 *array;
+	__u64 *array;
 	size_t sz;
 	/*
 	 * used for cross-endian analysis. See git commit 65014ab3
-- 
2.21.0
