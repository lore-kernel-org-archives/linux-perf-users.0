From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 84/91] perf inject: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:27 -0300
Message-ID: <20200506152234.21977-85-acme@kernel.org>
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

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index aad007bfb581..53932db97a79 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -561,8 +561,7 @@ static void sig_handler(int sig __maybe_unused)
 	session_done = 1;
 }
 
-static int perf_evsel__check_stype(struct evsel *evsel,
-				   u64 sample_type, const char *sample_msg)
+static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	const char *name = evsel__name(evsel);
@@ -625,7 +624,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			const char *name = evsel__name(evsel);
 
 			if (!strcmp(name, "sched:sched_switch")) {
-				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
+				if (evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
 					return -EINVAL;
 
 				evsel->handler = perf_inject__sched_switch;
-- 
2.21.1
