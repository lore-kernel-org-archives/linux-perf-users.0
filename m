From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/17] perf header: Fix wrong node write in NUMA_TOPOLOGY feature
Date: Wed, 20 Feb 2019 22:25:34 -0300
Message-ID: <20190221012549.4069-3-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are currently passing the node index instead of the real node number.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: fbe96f29ce4b ("perf tools: Make perf.data more self-descriptive (v8)"
Link: http://lkml.kernel.org/r/20190219095815.15931-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 61ce197c5362..c66f26ec557a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -879,7 +879,7 @@ static int write_numa_topology(struct feat_fd *ff,
 		if (ret < 0)
 			break;
 
-		ret = write_topo_node(ff, i);
+		ret = write_topo_node(ff, j);
 		if (ret < 0)
 			break;
 	}
-- 
2.19.1
