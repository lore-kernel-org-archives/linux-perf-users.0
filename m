From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/60] perf evlist: Move leader-sampling configuration
Date: Mon, 20 Apr 2020 08:52:54 -0300
Message-ID: <20200420115316.18781-39-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Move leader-sampling configuration in preparation for adding support for
leader sampling with AUX area events.

Committer notes:

It only makes sense when configuring an evsel that is part of an evlist,
so the only case where it is called outside perf_evlist__config(), in
some 'perf test' entry, is safe, and even there we should just use
perf_evlist__config(), but since in that case we have just one evsel in
the evlist, it is equivalent.

Also fixed up this problem:

  util/record.c: In function ‘perf_evlist__config’:
  util/record.c:223:3: error: too many arguments to function ‘perf_evsel__config_leader_sampling’
    223 |   perf_evsel__config_leader_sampling(evsel, evlist);
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/record.c:170:13: note: declared here
    170 | static void perf_evsel__config_leader_sampling(struct evsel *evsel)
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 19 -------------------
 tools/perf/util/record.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f320adaf1326..8300e8c7aea8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1002,25 +1002,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		}
 	}
 
-	/*
-	 * Disable sampling for all group members other
-	 * than leader in case leader 'leads' the sampling.
-	 */
-	if ((leader != evsel) && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
-
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
-
 	if (opts->no_samples)
 		attr->sample_freq = 0;
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 7def66168503..8870ae451cac 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -167,6 +167,31 @@ bool perf_can_aux_sample(void)
 	return true;
 }
 
+static void perf_evsel__config_leader_sampling(struct evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	struct evsel *leader = evsel->leader;
+
+	/*
+	 * Disable sampling for all group members other
+	 * than leader in case leader 'leads' the sampling.
+	 */
+	if (leader != evsel && leader->sample_read) {
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, we make them
+		 * when delivering group leader sample. Set the slave
+		 * event to follow the master sample_type to ease up
+		 * report.
+		 */
+		attr->sample_type = leader->core.attr.sample_type;
+	}
+}
+
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
@@ -193,6 +218,10 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			evsel->core.attr.comm_exec = 1;
 	}
 
+	/* Configure leader sampling here now that the sample type is known */
+	evlist__for_each_entry(evlist, evsel)
+		perf_evsel__config_leader_sampling(evsel);
+
 	if (opts->full_auxtrace) {
 		/*
 		 * Need to be able to synthesize and parse selected events with
-- 
2.21.1
