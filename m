From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/11] perf tools: Fix resource leak of closedir() on the error paths
Date: Thu, 17 Oct 2019 13:02:53 -0300
Message-ID: <20191017160301.20888-4-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Feilong Lin <linfeilong@huawei.com>, Hu Shiyuan <hushiyuan@huawei.com>, Igor Lubashev <ilubashe@akamai.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Martin KaFai Lau <kafai@fb.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Arnaldo
List-Id: linux-perf-users.vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

Both build_mem_topology() and rm_rf_depth_pat() have resource leaks of
closedir() on the error paths.

Fix this by calling closedir() before function returns.

Fixes: e2091cedd51b ("perf tools: Add MEM_TOPOLOGY feature to perf data file")
Fixes: cdb6b0235f17 ("perf tools: Add pattern name checking to rm_rf")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lore.kernel.org/lkml/cd5f7cd2-b80d-6add-20a1-32f4f43e0744@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 tools/perf/util/util.c   | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 86d9396cb131..becc2d109423 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1296,8 +1296,10 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 			continue;
 
 		if (WARN_ONCE(cnt >= size,
-			      "failed to write MEM_TOPOLOGY, way too many nodes\n"))
+			"failed to write MEM_TOPOLOGY, way too many nodes\n")) {
+			closedir(dir);
 			return -1;
+		}
 
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5eda6e19c947..ae56c766eda1 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (!match_pat(d->d_name, pat))
-			return -2;
+		if (!match_pat(d->d_name, pat)) {
+			ret =  -2;
+			break;
+		}
 
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
-- 
2.21.0
