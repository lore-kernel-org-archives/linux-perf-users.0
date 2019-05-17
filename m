From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/73] perf tools: Introduce Zstd streaming based compression API
Date: Fri, 17 May 2019 16:35:49 -0300
Message-ID: <20190517193611.4974-52-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Implemented functions are based on Zstd streaming compression API.

The functions are used in runtime to compress data that come from mmaped
kernel buffer. zstd_init(), zstd_fini() are used for initialization and
finalization to allocate and deallocate internal zstd objects.
zstd_compress_stream_to_records() is used to convert parts of mmaped
kernel buffer into an array of PERF_RECORD_COMPRESSED records.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/18bf36f3-b85a-1fe2-dd83-10e0c6069568@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build      |  2 ++
 tools/perf/util/compress.h | 42 +++++++++++++++++++++++
 tools/perf/util/zstd.c     | 70 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 tools/perf/util/zstd.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dd3102301ea..6d5bbc8b589b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -145,6 +145,8 @@ perf-y += scripting-engines/
 
 perf-$(CONFIG_ZLIB) += zlib.o
 perf-$(CONFIG_LZMA) += lzma.o
+perf-$(CONFIG_ZSTD) += zstd.o
+
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
 
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 892e92e7e7fc..1041a4fd81e2 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -2,6 +2,11 @@
 #ifndef PERF_COMPRESS_H
 #define PERF_COMPRESS_H
 
+#include <stdbool.h>
+#ifdef HAVE_ZSTD_SUPPORT
+#include <zstd.h>
+#endif
+
 #ifdef HAVE_ZLIB_SUPPORT
 int gzip_decompress_to_file(const char *input, int output_fd);
 bool gzip_is_compressed(const char *input);
@@ -12,4 +17,41 @@ int lzma_decompress_to_file(const char *input, int output_fd);
 bool lzma_is_compressed(const char *input);
 #endif
 
+struct zstd_data {
+#ifdef HAVE_ZSTD_SUPPORT
+	ZSTD_CStream	*cstream;
+#endif
+};
+
+#ifdef HAVE_ZSTD_SUPPORT
+
+int zstd_init(struct zstd_data *data, int level);
+int zstd_fini(struct zstd_data *data);
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
+				       void *src, size_t src_size, size_t max_record_size,
+				       size_t process_header(void *record, size_t increment));
+#else /* !HAVE_ZSTD_SUPPORT */
+
+static inline int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
+{
+	return 0;
+}
+
+static inline int zstd_fini(struct zstd_data *data __maybe_unused)
+{
+	return 0;
+}
+
+static inline
+size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
+				       void *dst __maybe_unused, size_t dst_size __maybe_unused,
+				       void *src __maybe_unused, size_t src_size __maybe_unused,
+				       size_t max_record_size __maybe_unused,
+				       size_t process_header(void *record, size_t increment) __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
new file mode 100644
index 000000000000..359ec9a9d306
--- /dev/null
+++ b/tools/perf/util/zstd.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+
+#include "util/compress.h"
+#include "util/debug.h"
+
+int zstd_init(struct zstd_data *data, int level)
+{
+	size_t ret;
+
+	data->cstream = ZSTD_createCStream();
+	if (data->cstream == NULL) {
+		pr_err("Couldn't create compression stream.\n");
+		return -1;
+	}
+
+	ret = ZSTD_initCStream(data->cstream, level);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+int zstd_fini(struct zstd_data *data)
+{
+	if (data->cstream) {
+		ZSTD_freeCStream(data->cstream);
+		data->cstream = NULL;
+	}
+
+	return 0;
+}
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
+				       void *src, size_t src_size, size_t max_record_size,
+				       size_t process_header(void *record, size_t increment))
+{
+	size_t ret, size, compressed = 0;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output;
+	void *record;
+
+	while (input.pos < input.size) {
+		record = dst;
+		size = process_header(record, 0);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+		output = (ZSTD_outBuffer){ dst, (dst_size > max_record_size) ?
+						max_record_size : dst_size, 0 };
+		ret = ZSTD_compressStream(data->cstream, &output, &input);
+		ZSTD_flushStream(data->cstream, &output);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to compress %ld bytes: %s\n",
+				(long)src_size, ZSTD_getErrorName(ret));
+			memcpy(dst, src, src_size);
+			return src_size;
+		}
+		size = output.pos;
+		size = process_header(record, size);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+	}
+
+	return compressed;
+}
-- 
2.20.1
