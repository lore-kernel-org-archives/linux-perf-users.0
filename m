From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/60] perf cs-etm: Implement ->evsel_is_auxtrace() callback
Date: Mon, 20 Apr 2020 08:52:45 -0300
Message-ID: <20200420115316.18781-30-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 62d2f9b9ce1b..3c802fde4954 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -631,6 +631,16 @@ static void cs_etm__free(struct perf_session *session)
 	zfree(&aux);
 }
 
+static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	return evsel->core.attr.type == aux->pmu_type;
+}
+
 static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 {
 	struct machine *machine;
@@ -2618,6 +2628,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace.flush_events = cs_etm__flush_events;
 	etm->auxtrace.free_events = cs_etm__free_events;
 	etm->auxtrace.free = cs_etm__free;
+	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
-- 
2.21.1
