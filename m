From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/15] perf tools: Add perf_evsel__read_size function
Date: Fri, 28 Jul 2017 17:00:07 -0300
Message-ID: <20170728200021.11389-2-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we use the size of struct perf_counts_values to read the
event, which prevents us to put any new member to the struct.

Adding perf_evsel__read_size to return size of the buffer needed for
event read.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170726120206.9099-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 450b5fadf8cb..4dd0fcc06db9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1261,15 +1261,42 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 		*pscaled = scaled;
 }
 
+static int perf_evsel__read_size(struct perf_evsel *evsel)
+{
+	u64 read_format = evsel->attr.read_format;
+	int entry = sizeof(u64); /* value */
+	int size = 0;
+	int nr = 1;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_GROUP) {
+		nr = evsel->nr_members;
+		size += sizeof(u64);
+	}
+
+	size += entry * nr;
+	return size;
+}
+
 int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 		     struct perf_counts_values *count)
 {
+	size_t size = perf_evsel__read_size(evsel);
+
 	memset(count, 0, sizeof(*count));
 
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
 
-	if (readn(FD(evsel, cpu, thread), count, sizeof(*count)) <= 0)
+	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
 		return -errno;
 
 	return 0;
-- 
2.9.4
