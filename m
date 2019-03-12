From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/30] perf data: Make perf_data__size() work over directory
Date: Mon, 11 Mar 2019 23:01:45 -0300
Message-ID: <20190312020204.22092-12-acme@kernel.org>
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

Make perf_data__size() return proper size for directory data, summing up
all the individual file sizes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 17 +++++++++++++++++
 tools/perf/util/data.h |  6 +-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 5d0f26aef77f..b71c441cafbb 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -393,3 +393,20 @@ int perf_data__switch(struct perf_data *data,
 	free(new_filepath);
 	return ret;
 }
+
+unsigned long perf_data__size(struct perf_data *data)
+{
+	u64 size = data->file.size;
+	int i;
+
+	if (!data->is_dir)
+		return size;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+
+		size += file->size;
+	}
+
+	return size;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 0deeb1af9f54..d342469bdfda 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -54,11 +54,6 @@ static inline int perf_data__fd(struct perf_data *data)
 	return data->file.fd;
 }
 
-static inline unsigned long perf_data__size(struct perf_data *data)
-{
-	return data->file.size;
-}
-
 int perf_data__open(struct perf_data *data);
 void perf_data__close(struct perf_data *data);
 ssize_t perf_data__write(struct perf_data *data,
@@ -80,4 +75,5 @@ int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
+unsigned long perf_data__size(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.20.1
