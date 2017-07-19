From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 66/86] perf header: Fail on write_padded error
Date: Wed, 19 Jul 2017 11:29:30 -0300
Message-ID: <20170719142950.3747-67-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Do not proceed if write_padded() error failed.

Also, add comments to remind that the return value of write_* functions
in util/header.c is an errno code and not the number of bytes written.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-4-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3b833f06c4e7..8dda19b68ac4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -74,6 +74,7 @@ bool perf_header__has_feat(const struct perf_header *header, int feat)
 	return test_bit(feat, header->adds_features);
 }
 
+/* Return: 0 if succeded, -ERR if failed. */
 static int do_write(int fd, const void *buf, size_t size)
 {
 	while (size) {
@@ -89,6 +90,7 @@ static int do_write(int fd, const void *buf, size_t size)
 	return 0;
 }
 
+/* Return: 0 if succeded, -ERR if failed. */
 int write_padded(int fd, const void *bf, size_t count, size_t count_aligned)
 {
 	static const char zero_buf[NAME_ALIGN];
@@ -103,6 +105,7 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned)
 #define string_size(str)						\
 	(PERF_ALIGN((strlen(str) + 1), NAME_ALIGN) + sizeof(u32))
 
+/* Return: 0 if succeded, -ERR if failed. */
 static int do_write_string(int fd, const char *str)
 {
 	u32 len, olen;
@@ -3200,7 +3203,8 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
 	 */
 	tracing_data_put(tdata);
 
-	write_padded(fd, NULL, 0, padding);
+	if (write_padded(fd, NULL, 0, padding))
+		return -1;
 
 	return aligned_size;
 }
-- 
2.9.4
