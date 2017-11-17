From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 76/83] perf evlist: Add perf_evlist__parse_sample_timestamp function
Date: Fri, 17 Nov 2017 17:15:54 -0300
Message-ID: <20171117201601.24110-77-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_evlist__parse_sample_timestamp to retrieve the timestamp of the
sample.

The idea is to use this function instead of the full sample parsing
before we queue the sample. At that time only the timestamp is needed
and we parse the sample once again later on delivery.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-o7syqo8lipj4or7renpu8e8y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 11 ++++++++
 tools/perf/util/evlist.h |  4 +++
 tools/perf/util/evsel.c  | 65 +++++++++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/evsel.h  |  4 +++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b62e523a7035..199bb82efbcd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1582,6 +1582,17 @@ int perf_evlist__parse_sample(struct perf_evlist *evlist, union perf_event *even
 	return perf_evsel__parse_sample(evsel, event, sample);
 }
 
+int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
+					union perf_event *event,
+					u64 *timestamp)
+{
+	struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+
+	if (!evsel)
+		return -EFAULT;
+	return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
+}
+
 size_t perf_evlist__fprintf(struct perf_evlist *evlist, FILE *fp)
 {
 	struct perf_evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 491f69542920..4e8131dacbd7 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -205,6 +205,10 @@ u16 perf_evlist__id_hdr_size(struct perf_evlist *evlist);
 int perf_evlist__parse_sample(struct perf_evlist *evlist, union perf_event *event,
 			      struct perf_sample *sample);
 
+int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
+					union perf_event *event,
+					u64 *timestamp);
+
 bool perf_evlist__valid_sample_type(struct perf_evlist *evlist);
 bool perf_evlist__valid_sample_id_all(struct perf_evlist *evlist);
 bool perf_evlist__valid_read_format(struct perf_evlist *evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 03d7abcdc6b7..95853c51c0ca 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1962,6 +1962,20 @@ static inline bool overflow(const void *endp, u16 max_size, const void *offset,
 #define OVERFLOW_CHECK_u64(offset) \
 	OVERFLOW_CHECK(offset, sizeof(u64), sizeof(u64))
 
+static int
+perf_event__check_size(union perf_event *event, unsigned int sample_size)
+{
+	/*
+	 * The evsel's sample_size is based on PERF_SAMPLE_MASK which includes
+	 * up to PERF_SAMPLE_PERIOD.  After that overflow() must be used to
+	 * check the format does not go past the end of the event.
+	 */
+	if (sample_size + sizeof(event->header) > event->header.size)
+		return -EFAULT;
+
+	return 0;
+}
+
 int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 			     struct perf_sample *data)
 {
@@ -1994,12 +2008,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 
 	array = event->sample.array;
 
-	/*
-	 * The evsel's sample_size is based on PERF_SAMPLE_MASK which includes
-	 * up to PERF_SAMPLE_PERIOD.  After that overflow() must be used to
-	 * check the format does not go past the end of the event.
-	 */
-	if (evsel->sample_size + sizeof(event->header) > event->header.size)
+	if (perf_event__check_size(event, evsel->sample_size))
 		return -EFAULT;
 
 	if (type & PERF_SAMPLE_IDENTIFIER) {
@@ -2232,6 +2241,50 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	return 0;
 }
 
+int perf_evsel__parse_sample_timestamp(struct perf_evsel *evsel,
+				       union perf_event *event,
+				       u64 *timestamp)
+{
+	u64 type = evsel->attr.sample_type;
+	const u64 *array;
+
+	if (!(type & PERF_SAMPLE_TIME))
+		return -1;
+
+	if (event->header.type != PERF_RECORD_SAMPLE) {
+		struct perf_sample data = {
+			.time = -1ULL,
+		};
+
+		if (!evsel->attr.sample_id_all)
+			return -1;
+		if (perf_evsel__parse_id_sample(evsel, event, &data))
+			return -1;
+
+		*timestamp = data.time;
+		return 0;
+	}
+
+	array = event->sample.array;
+
+	if (perf_event__check_size(event, evsel->sample_size))
+		return -EFAULT;
+
+	if (type & PERF_SAMPLE_IDENTIFIER)
+		array++;
+
+	if (type & PERF_SAMPLE_IP)
+		array++;
+
+	if (type & PERF_SAMPLE_TID)
+		array++;
+
+	if (type & PERF_SAMPLE_TIME)
+		*timestamp = *array;
+
+	return 0;
+}
+
 size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 				     u64 read_format)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0688880227e1..c3663a70c9b9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -338,6 +338,10 @@ static inline int perf_evsel__read_on_cpu_scaled(struct perf_evsel *evsel,
 int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 			     struct perf_sample *sample);
 
+int perf_evsel__parse_sample_timestamp(struct perf_evsel *evsel,
+				       union perf_event *event,
+				       u64 *timestamp);
+
 static inline struct perf_evsel *perf_evsel__next(struct perf_evsel *evsel)
 {
 	return list_entry(evsel->node.next, struct perf_evsel, node);
-- 
2.13.6
