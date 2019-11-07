From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/63] perf data: Support single perf.data file directory
Date: Thu,  7 Nov 2019 15:59:13 -0300
Message-ID: <20191107190011.23924-6-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Support directory output that contains a regular perf.data file, named
"data". By default the directory is named perf.data i.e.
	perf.data
	└── data

Most of the infrastructure to support a directory is already there. This
patch makes the changes needed to support the format above.

Presently there is no 'perf record' option to output a directory.

This is preparation for adding support for putting a copy of /proc/kcore in
the directory.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf.data-directory-format.txt            | 28 +++++++++++++++++++
 tools/perf/builtin-record.c                   |  2 +-
 tools/perf/util/data.c                        |  9 +++++-
 tools/perf/util/data.h                        |  6 ++++
 4 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt

diff --git a/tools/perf/Documentation/perf.data-directory-format.txt b/tools/perf/Documentation/perf.data-directory-format.txt
new file mode 100644
index 000000000000..4bf08908178d
--- /dev/null
+++ b/tools/perf/Documentation/perf.data-directory-format.txt
@@ -0,0 +1,28 @@
+perf.data directory format
+
+DISCLAIMER This is not ABI yet and is subject to possible change
+           in following versions of perf. We will remove this
+           disclaimer once the directory format soaks in.
+
+
+This document describes the on-disk perf.data directory format.
+
+The layout is described by HEADER_DIR_FORMAT feature.
+Currently it holds only version number (0):
+
+  HEADER_DIR_FORMAT = 24
+
+  struct {
+     uint64_t version;
+  }
+
+The current only version value 0 means that:
+  - there is a single perf.data file named 'data' within the directory.
+  e.g.
+
+    $ tree -ps perf.data
+    perf.data
+    └── [-rw-------       25912]  data
+
+Future versions are expected to describe different data files
+layout according to special needs.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2fb83aabbef5..e402459752e7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -537,7 +537,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
+	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index df173f0bf654..964ea101dba6 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	/*
+	 * Directory containing a single regular perf data file which is already
+	 * open, means there is nothing more to do here.
+	 */
+	if (perf_data__is_single_file(data))
+		return 0;
+
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
 
@@ -406,7 +413,7 @@ unsigned long perf_data__size(struct perf_data *data)
 	u64 size = data->file.size;
 	int i;
 
-	if (!data->is_dir)
+	if (perf_data__is_single_file(data))
 		return size;
 
 	for (i = 0; i < data->dir.nr; i++) {
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 218fe9a16801..f68815f7e428 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -10,6 +10,7 @@ enum perf_data_mode {
 };
 
 enum perf_dir_version {
+	PERF_DIR_SINGLE_FILE	= 0,
 	PERF_DIR_VERSION	= 1,
 };
 
@@ -54,6 +55,11 @@ static inline bool perf_data__is_dir(struct perf_data *data)
 	return data->is_dir;
 }
 
+static inline bool perf_data__is_single_file(struct perf_data *data)
+{
+	return data->dir.version == PERF_DIR_SINGLE_FILE;
+}
+
 static inline int perf_data__fd(struct perf_data *data)
 {
 	return data->file.fd;
-- 
2.21.0
