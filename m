From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/24] perf session: Add reader object
Date: Mon, 21 Jan 2019 20:56:46 -0300
Message-ID: <20190121235706.20005-5-acme@kernel.org>
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

Add a session private reader object to encapsulate the reading of the
event data block. Starting with a 'fd' field.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c8c2069fb01e..06379cc87f59 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1820,11 +1820,17 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
+struct reader {
+	int	fd;
+};
+
 static int __perf_session__process_events(struct perf_session *session)
 {
+	struct reader rd = {
+		.fd		= perf_data__fd(session->data),
+	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-	int fd = perf_data__fd(session->data);
 	u64 data_offset = session->header.data_offset;
 	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
@@ -1864,7 +1870,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, fd,
+	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd.fd,
 		   file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
-- 
2.20.1
