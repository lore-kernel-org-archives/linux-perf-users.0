From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/57] perf script: Fix --reltime with --time
Date: Mon, 21 Oct 2019 10:37:39 -0300
Message-ID: <20191021133834.25998-3-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

My earlier patch to just enable --reltime with --time was a little too
optimistic.  The --time parsing would accept absolute time, which is
very confusing to the user.

Support relative time in --time parsing too. This only works with recent
perf record that records the first sample time. Otherwise we error out.

Fixes: 3714437d3fcc ("perf script: Allow --time with --reltime")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191011182140.8353-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c  |  5 +++--
 tools/perf/util/time-utils.c | 27 ++++++++++++++++++++++++---
 tools/perf/util/time-utils.h |  5 +++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1c797a948ada..f86c5cce5b2c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3864,10 +3864,11 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 
 	if (script.time_str) {
-		err = perf_time__parse_for_ranges(script.time_str, session,
+		err = perf_time__parse_for_ranges_reltime(script.time_str, session,
 						  &script.ptime_range,
 						  &script.range_size,
-						  &script.range_num);
+						  &script.range_num,
+						  reltime);
 		if (err < 0)
 			goto out_delete;
 
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 9796a2e43f67..302443921681 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -458,10 +458,11 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	return true;
 }
 
-int perf_time__parse_for_ranges(const char *time_str,
+int perf_time__parse_for_ranges_reltime(const char *time_str,
 				struct perf_session *session,
 				struct perf_time_interval **ranges,
-				int *range_size, int *range_num)
+				int *range_size, int *range_num,
+				bool reltime)
 {
 	bool has_percent = strchr(time_str, '%');
 	struct perf_time_interval *ptime_range;
@@ -471,7 +472,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (!ptime_range)
 		return -ENOMEM;
 
-	if (has_percent) {
+	if (has_percent || reltime) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
@@ -479,7 +480,9 @@ int perf_time__parse_for_ranges(const char *time_str,
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
 			goto error;
 		}
+	}
 
+	if (has_percent) {
 		num = perf_time__percent_parse_str(
 				ptime_range, size,
 				time_str,
@@ -492,6 +495,15 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (num < 0)
 		goto error_invalid;
 
+	if (reltime) {
+		int i;
+
+		for (i = 0; i < num; i++) {
+			ptime_range[i].start += session->evlist->first_sample_time;
+			ptime_range[i].end += session->evlist->first_sample_time;
+		}
+	}
+
 	*range_size = size;
 	*range_num = num;
 	*ranges = ptime_range;
@@ -504,6 +516,15 @@ int perf_time__parse_for_ranges(const char *time_str,
 	return ret;
 }
 
+int perf_time__parse_for_ranges(const char *time_str,
+				struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num)
+{
+	return perf_time__parse_for_ranges_reltime(time_str, session, ranges,
+					range_size, range_num, false);
+}
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 {
 	u64  sec = timestamp / NSEC_PER_SEC;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 4f42988eb2f7..1142b0bddd5e 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -26,6 +26,11 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 
 struct perf_session;
 
+int perf_time__parse_for_ranges_reltime(const char *str, struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num,
+				bool reltime);
+
 int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
 				struct perf_time_interval **ranges,
 				int *range_size, int *range_num);
-- 
2.21.0
