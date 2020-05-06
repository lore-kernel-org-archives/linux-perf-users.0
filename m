From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/91] perf evsel: Rename perf_evsel__is_aux_event() to evsel__is_aux_event()
Date: Wed,  6 May 2020 12:21:55 -0300
Message-ID: <20200506152234.21977-53-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 6 +++---
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/pmu.c      | 2 +-
 tools/perf/util/record.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cddd1d36f724..bd27f73b6d60 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -686,7 +686,7 @@ static int auxtrace_validate_aux_sample_size(struct evlist *evlist,
 	evlist__for_each_entry(evlist, evsel) {
 		sz = evsel->core.attr.aux_sample_size;
 		if (perf_evsel__is_group_leader(evsel)) {
-			has_aux_leader = perf_evsel__is_aux_event(evsel);
+			has_aux_leader = evsel__is_aux_event(evsel);
 			if (sz) {
 				if (has_aux_leader)
 					pr_err("Cannot add AUX area sampling to an AUX area event\n");
@@ -760,7 +760,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 	/* Set aux_sample_size based on --aux-sample option */
 	evlist__for_each_entry(evlist, evsel) {
 		if (perf_evsel__is_group_leader(evsel)) {
-			has_aux_leader = perf_evsel__is_aux_event(evsel);
+			has_aux_leader = evsel__is_aux_event(evsel);
 		} else if (has_aux_leader) {
 			evsel->core.attr.aux_sample_size = sz;
 		}
@@ -769,7 +769,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 	aux_evsel = NULL;
 	/* Override with aux_sample_size from config term */
 	evlist__for_each_entry(evlist, evsel) {
-		if (perf_evsel__is_aux_event(evsel))
+		if (evsel__is_aux_event(evsel))
 			aux_evsel = evsel;
 		term = perf_evsel__get_config_term(evsel, AUX_SAMPLE_SIZE);
 		if (term) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 868e2be434c4..6187dba21298 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -159,7 +159,7 @@ int perf_evsel__object_config(size_t object_size,
 			      void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
-bool perf_evsel__is_aux_event(struct evsel *evsel);
+bool evsel__is_aux_event(struct evsel *evsel);
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2dd3d6be1a61..5642de7f8be7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -898,7 +898,7 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 	return pmu;
 }
 
-bool perf_evsel__is_aux_event(struct evsel *evsel)
+bool evsel__is_aux_event(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index c2c8cce506b4..97e2c0cedc12 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -24,7 +24,7 @@ static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
 {
 	struct evsel *leader = evsel->leader;
 
-	if (perf_evsel__is_aux_event(leader)) {
+	if (evsel__is_aux_event(leader)) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->leader == leader && evsel != evsel->leader)
 				return evsel;
-- 
2.21.1
