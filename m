From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/24] perf session: Add reader__process_events function
Date: Mon, 21 Jan 2019 20:56:49 -0300
Message-ID: <20190121235706.20005-8-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The reader object is defined by file's fd, data offset and data size.

Now we can simply define a reader object for an arbitrary file data
portion and pass it to reader__process_events().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 62 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 173cf445475c..d6f41611f504 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1826,36 +1826,25 @@ struct reader {
 	u64	data_offset;
 };
 
-static int __perf_session__process_events(struct perf_session *session)
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
 {
-	struct reader rd = {
-		.fd		= perf_data__fd(session->data),
-		.data_size	= session->header.data_size,
-		.data_offset	= session->header.data_offset,
-	};
-	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
-	u64 data_size = rd.data_size;
+	u64 data_size = rd->data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
-	int err, mmap_prot, mmap_flags, map_idx = 0;
+	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
 	char *buf, *mmaps[NUM_MMAPS];
 	union perf_event *event;
-	struct ui_progress prog;
 	s64 skip;
 
-	perf_tool__fill_defaults(tool);
-
-	page_offset = page_size * (rd.data_offset / page_size);
+	page_offset = page_size * (rd->data_offset / page_size);
 	file_offset = page_offset;
-	head = rd.data_offset - page_offset;
+	head = rd->data_offset - page_offset;
 
-	if (data_size == 0)
-		goto out;
+	ui_progress__init_size(prog, data_size, "Processing events...");
 
-	ui_progress__init_size(&prog, data_size, "Processing events...");
-
-	data_size += rd.data_offset;
+	data_size += rd->data_offset;
 
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > data_size) {
@@ -1873,12 +1862,12 @@ static int __perf_session__process_events(struct perf_session *session)
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd.fd,
+	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
 		   file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
 		err = -errno;
-		goto out_err;
+		goto out;
 	}
 	mmaps[map_idx] = buf;
 	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
@@ -1910,7 +1899,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		       file_offset + head, event->header.size,
 		       event->header.type);
 		err = -EINVAL;
-		goto out_err;
+		goto out;
 	}
 
 	if (skip)
@@ -1919,7 +1908,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	head += size;
 	file_pos += size;
 
-	ui_progress__update(&prog, size);
+	ui_progress__update(prog, size);
 
 	if (session_done())
 		goto out;
@@ -1928,6 +1917,31 @@ static int __perf_session__process_events(struct perf_session *session)
 		goto more;
 
 out:
+	return err;
+}
+
+static int __perf_session__process_events(struct perf_session *session)
+{
+	struct reader rd = {
+		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+	};
+	struct ordered_events *oe = &session->ordered_events;
+	struct perf_tool *tool = session->tool;
+	struct ui_progress prog;
+	int err;
+
+	perf_tool__fill_defaults(tool);
+
+	if (rd.data_size == 0)
+		return -1;
+
+	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
+
+	err = reader__process_events(&rd, session, &prog);
+	if (err)
+		goto out_err;
 	/* do the final flush for ordered samples */
 	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
 	if (err)
-- 
2.20.1
