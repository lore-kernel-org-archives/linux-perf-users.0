From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/75] perf top: Display slow reader warning when droping samples
Date: Thu,  6 Dec 2018 18:25:42 -0300
Message-ID: <20181206212602.20474-56-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we display the "Too slow to read ring buffer.." helpline only
in the slow reader thread. This patch triggers it also when the
processing thread drops samples, because it has the same reason, which
is too many data on input.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-bnev2mloavyurmgchcr3o24o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9166f6087e3f..f22c531be366 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -571,7 +571,7 @@ static void perf_top__sort_new_samples(void *arg)
 	hists__collapse_resort(hists, NULL);
 	perf_evsel__output_resort(evsel, NULL);
 
-	if (t->lost)
+	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
 
 	perf_top__reset_sample_counters(t);
-- 
2.19.2
