From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/35] perf hist: Fix memory leak of srcline
Date: Thu,  7 Mar 2019 14:44:29 -0300
Message-ID: <20190307174433.28819-32-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Nageswara R Sastry <nasastry@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

We can't allocate he->srcline unconditionaly, only when new hist_entry
is created. Moving he->srcline allocation into hist_entry__init
function.

Original-patch-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 74e307d17c49..f9eb95bf3938 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -419,6 +419,13 @@ static int hist_entry__init(struct hist_entry *he,
 		if (he->raw_data == NULL)
 			goto err_infos;
 	}
+
+	if (he->srcline) {
+		he->srcline = strdup(he->srcline);
+		if (he->srcline == NULL)
+			goto err_rawdata;
+	}
+
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
@@ -429,6 +436,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_rawdata:
+	free(he->raw_data);
+
 err_infos:
 	if (he->branch_info) {
 		map__put(he->branch_info->from.map);
@@ -605,7 +615,7 @@ __hists__add_entry(struct hists *hists,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.socket	 = al->socket,
 		.cpu	 = al->cpu,
 		.cpumode = al->cpumode,
@@ -962,7 +972,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			.map = al->map,
 			.sym = al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.parent = iter->parent,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
-- 
2.20.1
