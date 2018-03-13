From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/31] perf env: Free memory nodes data
Date: Tue, 13 Mar 2018 09:04:38 -0300
Message-ID: <20180313120508.29327-2-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Forgot to free env's memory nodes, adding needed code to perf_env__exit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6d311868d850..4c842762e3f2 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -32,6 +32,10 @@ void perf_env__exit(struct perf_env *env)
 	for (i = 0; i < env->caches_cnt; i++)
 		cpu_cache_level__free(&env->caches[i]);
 	zfree(&env->caches);
+
+	for (i = 0; i < env->nr_memory_nodes; i++)
+		free(env->memory_nodes[i].set);
+	zfree(&env->memory_nodes);
 }
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
-- 
2.14.3
