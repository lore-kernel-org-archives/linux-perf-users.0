From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/37] perf data: Move size to struct perf_data_file
Date: Mon, 25 Feb 2019 18:20:15 -0300
Message-ID: <20190225212035.24781-18-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are about to add support for multiple files, so we need each file to
keep its size.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190221094145.9151-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 5 ++---
 tools/perf/util/data.c      | 2 +-
 tools/perf/util/data.h      | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6c3719ac901d..e5e9900c9039 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -660,10 +660,9 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int process_buildids(struct record *rec)
 {
-	struct perf_data *data = &rec->data;
 	struct perf_session *session = rec->session;
 
-	if (data->size == 0)
+	if (perf_data__size(&rec->data) == 0)
 		return 0;
 
 	/*
@@ -851,7 +850,7 @@ record__finish_output(struct record *rec)
 		return;
 
 	rec->session->header.data_size += rec->bytes_written;
-	data->size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 
 	if (!rec->no_buildid) {
 		process_buildids(rec);
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d8cfc19ddb10..09eceda17fc2 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -82,7 +82,7 @@ static int open_file_read(struct perf_data *data)
 		goto out_close;
 	}
 
-	data->size = st.st_size;
+	data->file.size = st.st_size;
 	return fd;
 
  out_close:
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 4828f7feea89..85f9c0dbf982 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -12,13 +12,13 @@ enum perf_data_mode {
 struct perf_data_file {
 	const char	*path;
 	int		 fd;
+	unsigned long	 size;
 };
 
 struct perf_data {
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 force;
-	unsigned long		 size;
 	enum perf_data_mode	 mode;
 };
 
@@ -44,7 +44,7 @@ static inline int perf_data__fd(struct perf_data *data)
 
 static inline unsigned long perf_data__size(struct perf_data *data)
 {
-	return data->size;
+	return data->file.size;
 }
 
 int perf_data__open(struct perf_data *data);
-- 
2.20.1
