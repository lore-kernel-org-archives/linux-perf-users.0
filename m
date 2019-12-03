From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/23] perf stat: Use affinity for closing file descriptors
Date: Tue,  3 Dec 2019 10:55:48 -0300
Message-ID: <20191203135606.24902-6-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Closing a perf fd can also trigger an IPI to the target CPU.

Use the same affinity technique as we use for reading/enabling events to
closing to optimize the CPU transitions.

Before on a large test case with 94 CPUs:

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
   32.56    3.085463          50     61483           close

  After:

   10.54    0.735704          11     61485           close

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-8-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dae6e846b2f8..2e8d38a324be 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -18,6 +18,7 @@
 #include "debug.h"
 #include "units.h"
 #include <internal/lib.h> // page_size
+#include "affinity.h"
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
@@ -1169,9 +1170,35 @@ void perf_evlist__set_selected(struct evlist *evlist,
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct affinity affinity;
+	int cpu, i;
 
-	evlist__for_each_entry_reverse(evlist, evsel)
-		evsel__close(evsel);
+	/*
+	 * With perf record core.cpus is usually NULL.
+	 * Use the old method to handle this for now.
+	 */
+	if (!evlist->core.cpus) {
+		evlist__for_each_entry_reverse(evlist, evsel)
+			evsel__close(evsel);
+		return;
+	}
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+	evlist__for_each_cpu(evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry_reverse(evlist, evsel) {
+			if (evsel__cpu_iter_skip(evsel, cpu))
+			    continue;
+			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
+	evlist__for_each_entry_reverse(evlist, evsel) {
+		perf_evsel__free_fd(&evsel->core);
+		perf_evsel__free_id(&evsel->core);
+	}
 }
 
 static int perf_evlist__create_syswide_maps(struct evlist *evlist)
-- 
2.21.0
