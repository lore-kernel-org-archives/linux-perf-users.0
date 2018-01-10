From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/27] perf header: Add infrastructure to record first and last sample time
Date: Wed, 10 Jan 2018 18:28:24 -0300
Message-ID: <20180110212844.12441-8-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

perf report/script/... have a --time option to limit the time range of
output. That's very useful to slice large traces, e.g. when processing
the output of perf script for some analysis.

But right now --time only supports absolute time. Also there is no fast
way to get the start/end times of a given trace except for looking at
it.  This makes it hard to e.g. only decode the first half of the trace,
which is useful for parallelization of scripts

Another problem is that perf records are variable size and there is no
synchronization mechanism. So the only way to find the last sample
reliably would be to walk all samples. But we want to avoid that in perf
report/...  because it is already quite expensive. That is why storing
the first sample time and last sample time in perf record is better.

This patch creates a new header feature type HEADER_SAMPLE_TIME and
related ops. Save the first sample time and the last sample time to the
feature section in perf file header. That will be done when, for
instance, processing build-ids, where we already have to process all
samples to create the build-id table, take advantage of that to further
amortize that processing by storing HEADER_SAMPLE_TIME to make 'perf
report/script' faster when using --time.

Committer testing:

After this patch is applied the header is written with zeroes, we need
the next patch, for "perf record" to actually write the timestamps:

  # perf report -D | grep PERF_RECORD_SAMPLE\(
  22501155244406 0x44f0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 25016/25016: 0xffffffffa21be8c5 period: 1 addr: 0
  <SNIP>
  22501155793625 0x4a30 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 25016/25016: 0xffffffffa21ffd50 period: 2828043 addr: 0
  # perf report --header | grep "time of "
  # time of first sample : 0.000000
  # time of last sample : 0.000000
  #

Changelog:

v7: 1. Rebase to latest perf/core branch.

    2. Add following clarification in patch description according to
       Arnaldo's suggestion.

       "That will be done when, for instance, processing build-ids,
	where we already have to process all samples to create the
	build-id table, take advantage of that to further amortize
	that processing by storing HEADER_SAMPLE_TIME to make
	'perf report/script' faster when using --time."

v4: Use perf script time style for timestamp printing. Also add with
    the printing of sample duration.

v3: Remove the definitions of first_sample_time/last_sample_time from
    perf_session. Just define them in perf_evlist

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512738826-2628-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt |  4 ++
 tools/perf/util/evlist.h                           |  2 +
 tools/perf/util/header.c                           | 60 ++++++++++++++++++++++
 tools/perf/util/header.h                           |  1 +
 4 files changed, 67 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 15e8b48077ba..f7d85e89a98a 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -261,6 +261,10 @@ struct {
 	struct perf_header_string map;
 }[number_of_cache_levels];
 
+	HEADER_SAMPLE_TIME = 21,
+
+Two uint64_t for the time of first sample and the time of last sample.
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 75160666d305..e7fbca69cbac 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -50,6 +50,8 @@ struct perf_evlist {
 	struct perf_evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
+	u64		first_sample_time;
+	u64		last_sample_time;
 };
 
 struct perf_evsel_str_handler {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ca73aa7be708..a326e0d8b5b6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -16,6 +16,7 @@
 #include <linux/stringify.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
+#include <linux/time64.h>
 
 #include "evlist.h"
 #include "evsel.h"
@@ -35,6 +36,7 @@
 #include <api/fs/fs.h>
 #include "asm/bug.h"
 #include "tool.h"
+#include "time-utils.h"
 
 #include "sane_ctype.h"
 
@@ -1180,6 +1182,20 @@ static int write_stat(struct feat_fd *ff __maybe_unused,
 	return 0;
 }
 
+static int write_sample_time(struct feat_fd *ff,
+			     struct perf_evlist *evlist)
+{
+	int ret;
+
+	ret = do_write(ff, &evlist->first_sample_time,
+		       sizeof(evlist->first_sample_time));
+	if (ret < 0)
+		return ret;
+
+	return do_write(ff, &evlist->last_sample_time,
+			sizeof(evlist->last_sample_time));
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1505,6 +1521,28 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_sample_time(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_session *session;
+	char time_buf[32];
+	double d;
+
+	session = container_of(ff->ph, struct perf_session, header);
+
+	timestamp__scnprintf_usec(session->evlist->first_sample_time,
+				  time_buf, sizeof(time_buf));
+	fprintf(fp, "# time of first sample : %s\n", time_buf);
+
+	timestamp__scnprintf_usec(session->evlist->last_sample_time,
+				  time_buf, sizeof(time_buf));
+	fprintf(fp, "# time of last sample : %s\n", time_buf);
+
+	d = (double)(session->evlist->last_sample_time -
+		session->evlist->first_sample_time) / NSEC_PER_MSEC;
+
+	fprintf(fp, "# sample duration : %10.3f ms\n", d);
+}
+
 static int __event_process_build_id(struct build_id_event *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -2146,6 +2184,27 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	return -1;
 }
 
+static int process_sample_time(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_session *session;
+	u64 first_sample_time, last_sample_time;
+	int ret;
+
+	session = container_of(ff->ph, struct perf_session, header);
+
+	ret = do_read_u64(ff, &first_sample_time);
+	if (ret)
+		return -1;
+
+	ret = do_read_u64(ff, &last_sample_time);
+	if (ret)
+		return -1;
+
+	session->evlist->first_sample_time = first_sample_time;
+	session->evlist->last_sample_time = last_sample_time;
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2203,6 +2262,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(AUXTRACE,	auxtrace,	false),
 	FEAT_OPN(STAT,		stat,		false),
 	FEAT_OPN(CACHE,		cache,		true),
+	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 317fb901e47f..f28aaaa3a440 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -35,6 +35,7 @@ enum {
 	HEADER_AUXTRACE,
 	HEADER_STAT,
 	HEADER_CACHE,
+	HEADER_SAMPLE_TIME,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.14.3
