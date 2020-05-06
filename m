From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/91] perf tools: Fix reading new topology attribute "core_cpus"
Date: Wed,  6 May 2020 12:21:40 -0300
Message-ID: <20200506152234.21977-38-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Andi Kleen <ak@linux.intel.com>, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Check if access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK)
fails, which will happen unless the current directory is "/sys".

Simply try to read this file first.

Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/158817718710.747528.11009278875028211991.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/smt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 3b791ef2cd50..8481842e9edb 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -24,13 +24,13 @@ int smt_on(void)
 
 		snprintf(fn, sizeof fn,
 			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-		if (access(fn, F_OK) == -1) {
+		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
 				"devices/system/cpu/cpu%d/topology/thread_siblings",
 				cpu);
+			if (sysfs__read_str(fn, &str, &strlen) < 0)
+				continue;
 		}
-		if (sysfs__read_str(fn, &str, &strlen) < 0)
-			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
 		siblings = strtoull(str, NULL, 16);
 		free(str);
-- 
2.21.1
