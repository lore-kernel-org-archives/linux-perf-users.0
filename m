From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/43] perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'
Date: Thu, 14 Feb 2019 21:45:38 -0300
Message-ID: <20190215004539.23571-43-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Not used at all.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f1508adefc16..61ce197c5362 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -563,7 +563,6 @@ static int write_cmdline(struct feat_fd *ff,
 	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 
 struct cpu_topo {
-	u32 cpu_nr;
 	u32 core_sib;
 	u32 thread_sib;
 	char **core_siblings;
@@ -679,7 +678,6 @@ static struct cpu_topo *build_cpu_topology(void)
 		goto out_free;
 
 	tp = addr;
-	tp->cpu_nr = nr;
 	addr += sizeof(*tp);
 	tp->core_siblings = addr;
 	addr += sz;
-- 
2.19.1
