From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 75/86] perf header: Add a buffer to struct feat_fd
Date: Wed, 19 Jul 2017 11:29:39 -0300
Message-ID: <20170719142950.3747-76-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Extend struct feat_fd to use a temporal buffer in pipe-mode, instead of
perf.data's file descriptor.

The header features build_id and aux_trace already have logic to print
in file-mode that heavily rely on lseek the file. For now, leave such
features inactive in pipe-mode and print a warning if their functions
are called in pipe-mode.

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
Link: http://lkml.kernel.org/r/20170718042549.145161-13-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 75 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d5359e3384e3..5e6d4d29a7a3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -62,6 +62,7 @@ struct perf_file_attr {
 struct feat_fd {
 	struct perf_header	*ph;
 	int			fd;
+	void			*buf;	/* Either buf != NULL or fd >= 0 */
 	ssize_t			offset;
 	size_t			size;
 };
@@ -81,19 +82,52 @@ bool perf_header__has_feat(const struct perf_header *header, int feat)
 	return test_bit(feat, header->adds_features);
 }
 
-/* Return: 0 if succeded, -ERR if failed. */
-int do_write(struct feat_fd *ff, const void *buf, size_t size)
+static int __do_write_fd(struct feat_fd *ff, const void *buf, size_t size)
 {
-	ssize_t ret;
+	ssize_t ret = writen(ff->fd, buf, size);
 
-	ret  = writen(ff->fd, buf, size);
 	if (ret != (ssize_t)size)
 		return ret < 0 ? (int)ret : -1;
+	return 0;
+}
+
+static int __do_write_buf(struct feat_fd *ff,  const void *buf, size_t size)
+{
+	/* struct perf_event_header::size is u16 */
+	const size_t max_size = 0xffff - sizeof(struct perf_event_header);
+	size_t new_size = ff->size;
+	void *addr;
+
+	if (size + ff->offset > max_size)
+		return -E2BIG;
+
+	while (size > (new_size - ff->offset))
+		new_size <<= 1;
+	new_size = min(max_size, new_size);
+
+	if (ff->size < new_size) {
+		addr = realloc(ff->buf, new_size);
+		if (!addr)
+			return -ENOMEM;
+		ff->buf = addr;
+		ff->size = new_size;
+	}
+
+	memcpy(ff->buf + ff->offset, buf, size);
+	ff->offset += size;
 
 	return 0;
 }
 
 /* Return: 0 if succeded, -ERR if failed. */
+int do_write(struct feat_fd *ff, const void *buf, size_t size)
+{
+	if (!ff->buf)
+		return __do_write_fd(ff, buf, size);
+	return __do_write_buf(ff, buf, size);
+}
+
+/* Return: 0 if succeded, -ERR if failed. */
 int write_padded(struct feat_fd *ff, const void *bf,
 		 size_t count, size_t count_aligned)
 {
@@ -126,7 +160,7 @@ static int do_write_string(struct feat_fd *ff, const char *str)
 	return write_padded(ff, str, olen, len);
 }
 
-static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
+static int __do_read_fd(struct feat_fd *ff, void *addr, ssize_t size)
 {
 	ssize_t ret = readn(ff->fd, addr, size);
 
@@ -135,6 +169,25 @@ static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
 	return 0;
 }
 
+static int __do_read_buf(struct feat_fd *ff, void *addr, ssize_t size)
+{
+	if (size > (ssize_t)ff->size - ff->offset)
+		return -1;
+
+	memcpy(addr, ff->buf + ff->offset, size);
+	ff->offset += size;
+
+	return 0;
+
+}
+
+static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
+{
+	if (!ff->buf)
+		return __do_read_fd(ff, addr, size);
+	return __do_read_buf(ff, addr, size);
+}
+
 static int do_read_u32(struct feat_fd *ff, u32 *addr)
 {
 	int ret;
@@ -189,6 +242,9 @@ static char *do_read_string(struct feat_fd *ff)
 static int write_tracing_data(struct feat_fd *ff,
 			      struct perf_evlist *evlist)
 {
+	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+		return -1;
+
 	return read_tracing_data(ff->fd, &evlist->entries);
 }
 
@@ -203,6 +259,9 @@ static int write_build_id(struct feat_fd *ff,
 	if (!perf_session__read_build_ids(session, true))
 		return -1;
 
+	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+		return -1;
+
 	err = perf_session__write_buildid_table(session, ff);
 	if (err < 0) {
 		pr_debug("failed to write buildid table\n");
@@ -912,6 +971,9 @@ static int write_auxtrace(struct feat_fd *ff,
 	struct perf_session *session;
 	int err;
 
+	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+		return -1;
+
 	session = container_of(ff->ph, struct perf_session, header);
 
 	err = auxtrace_index__write(ff->fd, &session->auxtrace_index);
@@ -2197,6 +2259,9 @@ static int do_write_feat(struct feat_fd *ff, int type,
 		if (!feat_ops[type].write)
 			return -1;
 
+		if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+			return -1;
+
 		(*p)->offset = lseek(ff->fd, 0, SEEK_CUR);
 
 		err = feat_ops[type].write(ff, evlist);
-- 
2.9.4
