From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/12] perf evsel: Disable write_backward for leader sampling group events
Date: Wed, 25 Apr 2018 13:00:02 -0300
Message-ID: <20180425160008.3407-7-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

.. and other related fields that do not need to be enabled
for events that have sampling leader.

It fixes the perf top usage Ingo reported broken:

  # perf top -e '{cycles,msr/aperf/}:S'

The 'msr/aperf/' event is configured for write_back sampling, which is
not allowed by the MSR PMU, so it fails to create the event.

Adjusting related attr test.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-record-group-sampling | 3 +++
 tools/perf/util/evsel.c                          | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index f906b793196f..8a33ca4f9e1f 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -35,3 +35,6 @@ inherit=0
 # sampling disabled
 sample_freq=0
 sample_period=0
+freq=0
+write_backward=0
+sample_id_all=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7eb1e9850abf..26bdeecc0452 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -930,8 +930,11 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	 * than leader in case leader 'leads' the sampling.
 	 */
 	if ((leader != evsel) && leader->sample_read) {
-		attr->sample_freq   = 0;
-		attr->sample_period = 0;
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+		attr->write_backward = 0;
+		attr->sample_id_all  = 0;
 	}
 
 	if (opts->no_samples)
-- 
2.14.3
