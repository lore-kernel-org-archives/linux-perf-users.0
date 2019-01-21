From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/24] perf session: Rearrange perf_session__process_events function
Date: Mon, 21 Jan 2019 20:56:44 -0300
Message-ID: <20190121235706.20005-3-acme@kernel.org>
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

To reduce function arguments and the code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5456c84c7dd1..ad14192db811 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1820,13 +1820,14 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
-static int __perf_session__process_events(struct perf_session *session,
-					  u64 data_offset, u64 data_size,
-					  u64 file_size)
+static int __perf_session__process_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	int fd = perf_data__fd(session->data);
+	u64 file_size = perf_data__size(session->data);
+	u64 data_offset = session->header.data_offset;
+	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
@@ -1944,20 +1945,13 @@ static int __perf_session__process_events(struct perf_session *session,
 
 int perf_session__process_events(struct perf_session *session)
 {
-	u64 size = perf_data__size(session->data);
-	int err;
-
 	if (perf_session__register_idle_thread(session) < 0)
 		return -ENOMEM;
 
-	if (!perf_data__is_pipe(session->data))
-		err = __perf_session__process_events(session,
-						     session->header.data_offset,
-						     session->header.data_size, size);
-	else
-		err = __perf_session__process_pipe_events(session);
+	if (perf_data__is_pipe(session->data))
+		return __perf_session__process_pipe_events(session);
 
-	return err;
+	return __perf_session__process_events(session);
 }
 
 bool perf_session__has_traces(struct perf_session *session, const char *msg)
-- 
2.20.1
