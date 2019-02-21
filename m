From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/17] perf session: Don't report zero period samples for slave events
Date: Wed, 20 Feb 2019 22:25:44 -0300
Message-ID: <20190221012549.4069-13-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no reason to deliver a sample with zero period.  It means there
was no value for slave event since its last group leader sample.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 18fb9c8cbf9c..c764bbc91009 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1202,6 +1202,13 @@ static int deliver_sample_value(struct perf_evlist *evlist,
 		return 0;
 	}
 
+	/*
+	 * There's no reason to deliver sample
+	 * for zero period, bail out.
+	 */
+	if (!sample->period)
+		return 0;
+
 	return tool->sample(tool, event, sample, sid->evsel, machine);
 }
 
-- 
2.19.1
