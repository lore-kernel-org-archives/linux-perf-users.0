From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/30] perf header: Add DIR_FORMAT feature to describe directory data
Date: Mon, 11 Mar 2019 23:01:46 -0300
Message-ID: <20190312020204.22092-13-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The data files layout is described by HEADER_DIR_FORMAT feature.
Currently it holds only version number (1):

     uint64_t version;

The current version holds only version value (1) means that data files:

  - Follow the 'data.*' name format.

  - Contain raw events data in standard perf format as read from kernel
    (and need to be sorted)

Future versions are expected to describe different data files layout
according to special needs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/util/data.c      | 10 +++++++--
 tools/perf/util/data.h      |  1 +
 tools/perf/util/header.c    | 44 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h    |  5 +++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e983c8d71a79..a468d882e74f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -837,6 +837,8 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index b71c441cafbb..c6b67efea11a 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -14,6 +14,7 @@
 #include "data.h"
 #include "util.h"
 #include "debug.h"
+#include "header.h"
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
@@ -41,8 +42,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	if (!files)
 		return -ENOMEM;
 
-	data->dir.files = files;
-	data->dir.nr    = nr;
+	data->dir.version = PERF_DIR_VERSION;
+	data->dir.files   = files;
+	data->dir.nr      = nr;
 
 	for (i = 0; i < nr; i++) {
 		struct perf_data_file *file = &files[i];
@@ -75,6 +77,10 @@ int perf_data__open_dir(struct perf_data *data)
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
 
+	/* The version is provided by DIR_FORMAT feature. */
+	if (WARN_ON(data->dir.version != PERF_DIR_VERSION))
+		return -1;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index d342469bdfda..6aef8746469f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -24,6 +24,7 @@ struct perf_data {
 	enum perf_data_mode	 mode;
 
 	struct {
+		u64			 version;
 		struct perf_data_file	*files;
 		int			 nr;
 	} dir;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 01b324c275b9..b0683bf4d9f3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -861,6 +861,21 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_dir_format(struct feat_fd *ff,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1341,6 +1356,17 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_dir_format(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2373,6 +2399,21 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_dir_format(struct feat_fd *ff,
+			      void *_data __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_read_u64(ff, &data->dir.version);
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2432,7 +2473,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,	clockid,	false),
+	FEAT_OPN(DIR_FORMAT,	dir_format,	false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..6a231340238d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,7 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_DIR_FORMAT,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
@@ -48,6 +49,10 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_file_section {
 	u64 offset;
 	u64 size;
-- 
2.20.1
