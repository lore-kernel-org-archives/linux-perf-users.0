From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/7] perf tools: Handle TOPOLOGY headers with no CPU
Date: Mon, 21 Jan 2019 15:35:05 -0300
Message-ID: <20190121183507.23490-6-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This patch fixes an issue in cpumap.c when used with the TOPOLOGY
header. In some configurations, some NUMA nodes may have no CPU (empty
cpulist). Yet a cpumap map must be created otherwise perf abort with an
error. This patch handles this case by creating a dummy map.

  Before:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  0x6e8 [0x6c]: failed to process type: 80

  After:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  noploop for 2 seconds

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547885559-1657-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1ccbd3342069..383674f448fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -134,7 +134,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 	if (!cpu_list)
 		return cpu_map__read_all_cpu_map();
 
-	if (!isdigit(*cpu_list))
+	/*
+	 * must handle the case of empty cpumap to cover
+	 * TOPOLOGY header for NUMA nodes with no CPU
+	 * ( e.g., because of CPU hotplug)
+	 */
+	if (!isdigit(*cpu_list) && *cpu_list != '\0')
 		goto out;
 
 	while (isdigit(*cpu_list)) {
@@ -181,8 +186,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
+	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
+	else
+		cpus = cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
-- 
2.20.1
