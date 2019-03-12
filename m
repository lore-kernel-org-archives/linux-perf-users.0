From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/30] perf data: Support having perf.data stored as a directory
Date: Mon, 11 Mar 2019 23:01:42 -0300
Message-ID: <20190312020204.22092-9-acme@kernel.org>
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

The caller needs to set 'struct perf_data::is_dir flag and the path will
be treated as a directory.

The 'struct perf_data::file' is initialized and open as 'path/header'
file.

Add a check to the direcory interface functions to check the is_dir flag.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-2-jolsa@kernel.org
[ Be consistent on how to signal failure, i.e. use -1 and let users check errno ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c    | 49 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/data.h    |  6 +++++
 tools/perf/util/session.c |  4 ++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e098e189f93e..18fa8d4614eb 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	struct perf_data_file *files = NULL;
 	int i, ret = -1;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	files = zalloc(nr * sizeof(*files));
 	if (!files)
 		return -ENOMEM;
@@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
@@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
 	return 0;
 }
 
+static bool is_dir(struct perf_data *data)
+{
+	struct stat st;
+
+	if (stat(data->path, &st))
+		return false;
+
+	return (st.st_mode & S_IFMT) == S_IFDIR;
+}
+
 static int open_file_read(struct perf_data *data)
 {
 	struct stat st;
@@ -254,6 +270,30 @@ static int open_file_dup(struct perf_data *data)
 	return open_file(data);
 }
 
+static int open_dir(struct perf_data *data)
+{
+	int ret;
+
+	/*
+	 * So far we open only the header, so we can read the data version and
+	 * layout.
+	 */
+	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+		return -1;
+
+	if (perf_data__is_write(data) &&
+	    mkdir(data->path, S_IRWXU) < 0)
+		return -1;
+
+	ret = open_file(data);
+
+	/* Cleanup whatever we managed to create so far. */
+	if (ret && perf_data__is_write(data))
+		rm_rf_perf_data(data->path);
+
+	return ret;
+}
+
 int perf_data__open(struct perf_data *data)
 {
 	if (check_pipe(data))
@@ -265,11 +305,18 @@ int perf_data__open(struct perf_data *data)
 	if (check_backup(data))
 		return -1;
 
-	return open_file_dup(data);
+	if (perf_data__is_read(data))
+		data->is_dir = is_dir(data);
+
+	return perf_data__is_dir(data) ?
+	       open_dir(data) : open_file_dup(data);
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	if (perf_data__is_dir(data))
+		perf_data__close_dir(data);
+
 	zfree(&data->file.path);
 	close(data->file.fd);
 }
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 14b47be2bd69..06aefeda311f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -19,6 +19,7 @@ struct perf_data {
 	const char		*path;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
+	bool			 is_dir;
 	bool			 force;
 	enum perf_data_mode	 mode;
 
@@ -43,6 +44,11 @@ static inline int perf_data__is_pipe(struct perf_data *data)
 	return data->is_pipe;
 }
 
+static inline bool perf_data__is_dir(struct perf_data *data)
+{
+	return data->is_dir;
+}
+
 static inline int perf_data__fd(struct perf_data *data)
 {
 	return data->file.fd;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index db643f3c2b95..de777bdc0ed3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -152,6 +152,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			}
 
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
+
+			/* Open the directory data. */
+			if (data->is_dir && perf_data__open_dir(data))
+				goto out_delete;
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
-- 
2.20.1
