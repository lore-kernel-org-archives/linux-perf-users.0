From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 74/86] perf header: Make write_pmu_mappings pipe-mode friendly
Date: Wed, 19 Jul 2017 11:29:38 -0300
Message-ID: <20170719142950.3747-75-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

In pipe-mode, we will operate over a buffer instead of a file descriptor
but write_pmu_mappings uses lseek to move over the perf.data file.

Refactor write_pmu_mappings to avoid the usage of lseek and allow
reusing the same logic in pipe-mode (next patch).

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
Link: http://lkml.kernel.org/r/20170718042549.145161-12-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 14db9f204b0a..d5359e3384e3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -797,11 +797,19 @@ static int write_pmu_mappings(struct feat_fd *ff,
 			      struct perf_evlist *evlist __maybe_unused)
 {
 	struct perf_pmu *pmu = NULL;
-	off_t offset = lseek(ff->fd, 0, SEEK_CUR);
-	__u32 pmu_num = 0;
+	u32 pmu_num = 0;
 	int ret;
 
-	/* write real pmu_num later */
+	/*
+	 * Do a first pass to count number of pmu to avoid lseek so this
+	 * works in pipe mode as well.
+	 */
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name)
+			continue;
+		pmu_num++;
+	}
+
 	ret = do_write(ff, &pmu_num, sizeof(pmu_num));
 	if (ret < 0)
 		return ret;
@@ -809,7 +817,6 @@ static int write_pmu_mappings(struct feat_fd *ff,
 	while ((pmu = perf_pmu__scan(pmu))) {
 		if (!pmu->name)
 			continue;
-		pmu_num++;
 
 		ret = do_write(ff, &pmu->type, sizeof(pmu->type));
 		if (ret < 0)
@@ -820,12 +827,6 @@ static int write_pmu_mappings(struct feat_fd *ff,
 			return ret;
 	}
 
-	if (pwrite(ff->fd, &pmu_num, sizeof(pmu_num), offset) != sizeof(pmu_num)) {
-		/* discard all */
-		lseek(ff->fd, offset, SEEK_SET);
-		return -1;
-	}
-
 	return 0;
 }
 
-- 
2.9.4
