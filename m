From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/31] perf test: Fix spelling mistake "allos" -> "allocate"
Date: Fri, 20 Sep 2019 11:25:39 -0300
Message-ID: <20190920142542.12047-29-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Mukesh Ojha <mojha@codeaurora.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a TEST_ASSERT_VAL message. Fix it.

Signed-off-by: Colin King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lore.kernel.org/lkml/20190911152148.17031-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/event_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 4bb772e2b73d..0497d900ced2 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -94,7 +94,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("failed to allos ids",
+	TEST_ASSERT_VAL("failed to allocate ids",
 			!perf_evsel__alloc_id(evsel, 1, 1));
 
 	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
-- 
2.21.0
