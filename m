From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/24] perf session: Get rid of file_size variable
Date: Mon, 21 Jan 2019 20:56:45 -0300
Message-ID: <20190121235706.20005-4-acme@kernel.org>
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

It's not needed and removing it makes the code a little simpler for the
upcoming changes.

It's safe to replace file_size with data_size, because the
perf_data__size() value is never smaller than data_offset + data_size.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ad14192db811..c8c2069fb01e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1825,7 +1825,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	int fd = perf_data__fd(session->data);
-	u64 file_size = perf_data__size(session->data);
 	u64 data_offset = session->header.data_offset;
 	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
@@ -1845,14 +1844,13 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (data_size == 0)
 		goto out;
 
-	if (data_offset + data_size < file_size)
-		file_size = data_offset + data_size;
+	ui_progress__init_size(&prog, data_size, "Processing events...");
 
-	ui_progress__init_size(&prog, file_size, "Processing events...");
+	data_size += data_offset;
 
 	mmap_size = MMAP_SIZE;
-	if (mmap_size > file_size) {
-		mmap_size = file_size;
+	if (mmap_size > data_size) {
+		mmap_size = data_size;
 		session->one_mmap = true;
 	}
 
@@ -1917,7 +1915,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (session_done())
 		goto out;
 
-	if (file_pos < file_size)
+	if (file_pos < data_size)
 		goto more;
 
 out:
-- 
2.20.1
