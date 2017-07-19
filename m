From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/86] perf tests attr: Fix stat sample_type setup
Date: Wed, 19 Jul 2017 11:29:18 -0300
Message-ID: <20170719142950.3747-55-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

From following commit:

  commit 4979d0c7d0c7 ("perf stat record: Add record command")

we started to assign PERF_SAMPLE_IDENTIFIER to sample_type.

Fixing the attr stat tests accordingly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/base-stat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index ff9b33d4ae9e..4d0c2e42b64e 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -8,7 +8,7 @@ type=0
 size=112
 config=0
 sample_period=0
-sample_type=0
+sample_type=65536
 read_format=3
 disabled=1
 inherit=1
-- 
2.9.4
