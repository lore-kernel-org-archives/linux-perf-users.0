From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/8] perf evsel: Do not rely on errno values for precise_ip fallback
Date: Mon,  8 Jul 2019 12:42:03 -0300
Message-ID: <20190708154207.11403-5-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Kharlamov <Hi-Angel@yandex.ru>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Quentin Monnet <quentin.monnet@netronome.com>, Kim Phillips <kim.phillips@amd.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Konstantin reported problem with default perf record command, which
fails on some AMD servers, because of the default maximum precise
config.

The current fallback mechanism counts on getting ENOTSUP errno for
precise_ip fails, but that's not the case on some AMD servers.

We can fix this by removing the errno check completely, because the
precise_ip fallback is separated. We can just try  (if requested by
evsel->precise_max) all possible precise_ip, and if one succeeds we win,
if not, we continue with standard fallback.

Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Link: http://lkml.kernel.org/r/20190703080949.10356-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a5947625c5c..69beb9f80f07 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1785,14 +1785,8 @@ static int perf_event_open(struct perf_evsel *evsel,
 		if (fd >= 0)
 			break;
 
-		/*
-		 * Do quick precise_ip fallback if:
-		 *  - there is precise_ip set in perf_event_attr
-		 *  - maximum precise is requested
-		 *  - sys_perf_event_open failed with ENOTSUP error,
-		 *    which is associated with wrong precise_ip
-		 */
-		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
+		/* Do not try less precise if not requested. */
+		if (!evsel->precise_max)
 			break;
 
 		/*
-- 
2.20.1
