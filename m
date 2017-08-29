From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/18] perf values: Zero value buffers
Date: Tue, 29 Aug 2017 16:42:44 -0300
Message-ID: <20170829194254.1338-9-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to make sure the array of value pointers are zero initialized,
because we use them in realloc later on and uninitialized non zero value
will cause allocation error and aborted execution.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170824162737.7813-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/values.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index 2c4af02f08cd..3b56aeaa8cbb 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -12,7 +12,7 @@ int perf_read_values_init(struct perf_read_values *values)
 	values->threads_max = 16;
 	values->pid = malloc(values->threads_max * sizeof(*values->pid));
 	values->tid = malloc(values->threads_max * sizeof(*values->tid));
-	values->value = malloc(values->threads_max * sizeof(*values->value));
+	values->value = zalloc(values->threads_max * sizeof(*values->value));
 	if (!values->pid || !values->tid || !values->value) {
 		pr_debug("failed to allocate read_values threads arrays");
 		goto out_free_pid;
@@ -99,7 +99,8 @@ static int perf_read_values__findnew_thread(struct perf_read_values *values,
 	}
 
 	i = values->threads;
-	values->value[i] = malloc(values->counters_max * sizeof(**values->value));
+
+	values->value[i] = zalloc(values->counters_max * sizeof(**values->value));
 	if (!values->value[i]) {
 		pr_debug("failed to allocate read_values counters array");
 		return -ENOMEM;
@@ -130,12 +131,16 @@ static int perf_read_values__enlarge_counters(struct perf_read_values *values)
 
 	for (i = 0; i < values->threads; i++) {
 		u64 *value = realloc(values->value[i], counters_max * sizeof(**values->value));
+		int j;
 
 		if (!value) {
 			pr_debug("failed to enlarge read_values ->values array");
 			goto out_free_name;
 		}
 
+		for (j = values->counters_max; j < counters_max; j++)
+			value[j] = 0;
+
 		values->value[i] = value;
 	}
 
-- 
2.13.5
