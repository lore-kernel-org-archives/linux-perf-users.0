From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/86] perf tests attr: Fix cpu test disabled term setup
Date: Wed, 19 Jul 2017 11:29:15 -0300
Message-ID: <20170719142950.3747-52-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The stat command creates all events disabled and enables them either
manualy or via the enable_on_exec bit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-stat-C0 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/test-stat-C0 b/tools/perf/tests/attr/test-stat-C0
index aa835950751f..67717fe6a65d 100644
--- a/tools/perf/tests/attr/test-stat-C0
+++ b/tools/perf/tests/attr/test-stat-C0
@@ -4,6 +4,6 @@ args    = -e cycles -C 0 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-stat]
-# events are enabled by default when attached to cpu
-disabled=0
+# events are disabled by default when attached to cpu
+disabled=1
 enable_on_exec=0
-- 
2.9.4
