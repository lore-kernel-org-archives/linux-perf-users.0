From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/86] perf tests attr: Fix no-delay test
Date: Wed, 19 Jul 2017 11:29:13 -0300
Message-ID: <20170719142950.3747-50-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Following commit:
  commit 509051ea8427 ("perf record: Rename --no-delay to --no-buffering")

removed '-D' option and renamed --no-delay into --no-buffering.
Fixing that in the attr tests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Fixes: 509051ea8427 ("perf record: Rename --no-delay to --no-buffering")
Link: http://lkml.kernel.org/r/20170703145030.12903-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/attr/{test-record-no-delay => test-record-no-buffering}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/tests/attr/{test-record-no-delay => test-record-no-buffering} (70%)

diff --git a/tools/perf/tests/attr/test-record-no-delay b/tools/perf/tests/attr/test-record-no-buffering
similarity index 70%
rename from tools/perf/tests/attr/test-record-no-delay
rename to tools/perf/tests/attr/test-record-no-buffering
index f253b78cdbf2..0b0355af013a 100644
--- a/tools/perf/tests/attr/test-record-no-delay
+++ b/tools/perf/tests/attr/test-record-no-buffering
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -D kill >/dev/null 2>&1
+args    = --no-buffering kill >/dev/null 2>&1
 
 [event:base-record]
 sample_period=4000
-- 
2.9.4
