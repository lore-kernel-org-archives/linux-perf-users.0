From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/53] perf tests pmu: Add missing headers
Date: Wed,  6 Feb 2019 15:48:25 -0300
Message-ID: <20190206184903.24054-16-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It needs the definitions for PATH_MAX and snprintf, was getting it
by luck from headers it included and that are now being sanitized.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7bbh3kk0h5mywvfqm64nhv28@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 7bedf8608fdd..14a78898d79e 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -4,7 +4,9 @@
 #include "util.h"
 #include "tests.h"
 #include <errno.h>
+#include <stdio.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 
 /* Simulated format definitions. */
 static struct test_format {
-- 
2.20.1
