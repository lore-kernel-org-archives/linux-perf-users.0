From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/37] perf data: Add perf_data__(create_dir|close_dir) functions
Date: Mon, 25 Feb 2019 18:20:22 -0300
Message-ID: <20190225212035.24781-25-acme@kernel.org>
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

Add perf_data__create_dir() to create nr files inside 'struct perf_data'
path directory:

  int perf_data__create_dir(struct perf_data *data, int nr);

and function to close that data:

  void perf_data__close_dir(struct perf_data *data);

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  8 +++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d008c3973012..005b3909d1dc 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -7,11 +7,58 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
+#include <asm/bug.h>
 
 #include "data.h"
 #include "util.h"
 #include "debug.h"
 
+static void close_dir(struct perf_data_file *files, int nr)
+{
+	while (--nr >= 1) {
+		close(files[nr].fd);
+		free(files[nr].path);
+	}
+	free(files);
+}
+
+void perf_data__close_dir(struct perf_data *data)
+{
+	close_dir(data->dir.files, data->dir.nr);
+}
+
+int perf_data__create_dir(struct perf_data *data, int nr)
+{
+	struct perf_data_file *files = NULL;
+	int i, ret = -1;
+
+	files = zalloc(nr * sizeof(*files));
+	if (!files)
+		return -ENOMEM;
+
+	data->dir.files = files;
+	data->dir.nr    = nr;
+
+	for (i = 0; i < nr; i++) {
+		struct perf_data_file *file = &files[i];
+
+		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
+			goto out_err;
+
+		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
+		if (ret < 0)
+			goto out_err;
+
+		file->fd = ret;
+	}
+
+	return 0;
+
+out_err:
+	close_dir(files, i);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 2bce28117ccf..2d0d015a7d4d 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -21,6 +21,11 @@ struct perf_data {
 	bool			 is_pipe;
 	bool			 force;
 	enum perf_data_mode	 mode;
+
+	struct {
+		struct perf_data_file	*files;
+		int			 nr;
+	} dir;
 };
 
 static inline bool perf_data__is_read(struct perf_data *data)
@@ -64,4 +69,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
 			   size_t pos, bool at_exit);
+
+int perf_data__create_dir(struct perf_data *data, int nr);
+void perf_data__close_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.20.1
