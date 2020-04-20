From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/60] perf evsel: Rearrange perf_evsel__config_leader_sampling()
Date: Mon, 20 Apr 2020 08:52:55 -0300
Message-ID: <20200420115316.18781-40-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for adding support for leader sampling with AUX area events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/record.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8870ae451cac..32aeeb8a8d00 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -172,24 +172,24 @@ static void perf_evsel__config_leader_sampling(struct evsel *evsel)
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
 
+	if (leader == evsel || !leader->sample_read)
+		return;
+
 	/*
 	 * Disable sampling for all group members other
 	 * than leader in case leader 'leads' the sampling.
 	 */
-	if (leader != evsel && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
+	attr->freq           = 0;
+	attr->sample_freq    = 0;
+	attr->sample_period  = 0;
+	attr->write_backward = 0;
 
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
+	/*
+	 * We don't get a sample for slave events, we make them when delivering
+	 * the group leader sample. Set the slave event to follow the master
+	 * sample_type to ease up reporting.
+	 */
+	attr->sample_type = leader->core.attr.sample_type;
 }
 
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
-- 
2.21.1
