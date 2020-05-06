From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/91] libperf: Add NULL pointer check for cpu_map iteration and NULL assignment for all_cpus.
Date: Wed,  6 May 2020 12:21:35 -0300
Message-ID: <20200506152234.21977-33-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Zhe <zhe.he@windriver.com>, Andi Kleen <ak@linux.intel.com>, Kyle Meyer <meyerk@hpe.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

A NULL pointer may be passed to perf_cpu_map__cpu and then cause a
crash, such as the one commit cb71f7d43ece ("libperf: Setup initial
evlist::all_cpus value") fix.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kyle Meyer <meyerk@hpe.com>
Link: http://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c | 2 +-
 tools/lib/perf/evlist.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index f93f4e703e4c..ca0215047c32 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 
 int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
-	if (idx < cpus->nr)
+	if (cpus && idx < cpus->nr)
 		return cpus->map[idx];
 
 	return -1;
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index def55054c55b..c481b62f2ce4 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -125,6 +125,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
 	perf_cpu_map__put(evlist->cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
+	evlist->all_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
-- 
2.21.1
