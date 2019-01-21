From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/24] perf session: Add 'data_offset' member to reader object
Date: Mon, 21 Jan 2019 20:56:48 -0300
Message-ID: <20190121235706.20005-7-acme@kernel.org>
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

Add 'data_offset' member to reader object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9f29ed743425..173cf445475c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1823,6 +1823,7 @@ fetch_mmaped_event(struct perf_session *session,
 struct reader {
 	int	fd;
 	u64	data_size;
+	u64	data_offset;
 };
 
 static int __perf_session__process_events(struct perf_session *session)
@@ -1830,10 +1831,10 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
 		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-	u64 data_offset = session->header.data_offset;
 	u64 data_size = rd.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
@@ -1845,16 +1846,16 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	perf_tool__fill_defaults(tool);
 
-	page_offset = page_size * (data_offset / page_size);
+	page_offset = page_size * (rd.data_offset / page_size);
 	file_offset = page_offset;
-	head = data_offset - page_offset;
+	head = rd.data_offset - page_offset;
 
 	if (data_size == 0)
 		goto out;
 
 	ui_progress__init_size(&prog, data_size, "Processing events...");
 
-	data_size += data_offset;
+	data_size += rd.data_offset;
 
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > data_size) {
-- 
2.20.1
