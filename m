From: Cheng Jian <cj.chengjian@huawei.com>
Subject: [PATCH] perf/evsel: Fix missing close fd when ignore_missing_thread
Date: Sat, 30 May 2020 06:15:35 +0000
Message-ID: <20200530061535.36360-1-cj.chengjian@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: cj.chengjian@huawei.com, bobo.shaobowang@huawei.com, huawei.libin@huawei.com, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

While monitoring a multithread process with pid option, if any of the
threads exit before we open the event fd, we can ignore the missing
thread.

We use perf_evsel__remove_fd() to remove the FD of the missing thread,
but we missed to close these fds. This patch explicitly closes the fd
before remove it.

Fixes: ca8000684ec4 ("perf evsel: Enable ignore_missing_thread for pid option")
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 tools/perf/util/evsel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eb880efbce16..cbb04a18839c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1489,9 +1489,13 @@ static void perf_evsel__remove_fd(struct evsel *pos,
 				  int nr_cpus, int nr_threads,
 				  int thread_idx)
 {
-	for (int cpu = 0; cpu < nr_cpus; cpu++)
-		for (int thread = thread_idx; thread < nr_threads - 1; thread++)
+	for (int cpu = 0; cpu < nr_cpus; cpu++) {
+		for (int thread = thread_idx;
+		     thread < nr_threads - 1; thread++) {
+			close(FD(pos, cpu, thread));
 			FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
+		}
+	}
 }
 
 static int update_fds(struct evsel *evsel,
-- 
2.17.1
