From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/14] perf tests: Fix out of bounds access on array fd when cnt is 100
Date: Mon, 19 Mar 2018 16:01:24 -0300
Message-ID: <20180319190136.7441-3-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when cnt is 100 an array bounds overflow occurs on the
assignment of fd[cnt]. Fix this by performing the bounds check on cnt
before writing to fd.

Detected by cppcheck:

tools/perf/tests/bp_account.c:115: (warning) Either the condition
'cnt==100' is redundant or the array 'fd[100]' is accessed at index 100,
which is out of bounds.

Signed-off-by: Colin King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")
Link: http://lkml.kernel.org/r/20180314173354.11250-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 2f75fa0c4fef..9e88d7608951 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -107,16 +107,14 @@ static int detect_cnt(bool is_x)
 	int fd[100], cnt = 0, i;
 
 	while (1) {
-		fd[cnt] = __event(is_x, addr, &attr);
-
-		if (fd[cnt] < 0)
-			break;
-
 		if (cnt == 100) {
 			pr_debug("way too many debug registers, fix the test\n");
 			return 0;
 		}
+		fd[cnt] = __event(is_x, addr, &attr);
 
+		if (fd[cnt] < 0)
+			break;
 		cnt++;
 	}
 
-- 
2.14.3
