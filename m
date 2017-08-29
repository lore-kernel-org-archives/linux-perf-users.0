From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/18] perf values: Fix thread index bug
Date: Tue, 29 Aug 2017 16:42:42 -0300
Message-ID: <20170829194254.1338-7-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are taking wrong index (+1) for first thread, which leaves thread
with index 0 unused and uninitialized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170824162737.7813-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/values.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index 5de2e15e2eda..9ac36bf2c438 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -98,7 +98,7 @@ static int perf_read_values__findnew_thread(struct perf_read_values *values,
 			return i;
 	}
 
-	i = values->threads + 1;
+	i = values->threads;
 	values->value[i] = malloc(values->counters_max * sizeof(**values->value));
 	if (!values->value[i]) {
 		pr_debug("failed to allocate read_values counters array");
@@ -106,7 +106,7 @@ static int perf_read_values__findnew_thread(struct perf_read_values *values,
 	}
 	values->pid[i] = pid;
 	values->tid[i] = tid;
-	values->threads = i;
+	values->threads = i + 1;
 
 	return i;
 }
-- 
2.13.5
