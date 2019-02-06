From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/53] perf pmu: Remove needless evsel.h include, only needs one fwd decl
Date: Wed,  6 Feb 2019 15:48:26 -0300
Message-ID: <20190206184903.24054-17-acme@kernel.org>
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

To reduce the header dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rc389o1z0htwukqv6ni1viun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..ffed23fb920a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -6,9 +6,10 @@
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
 #include <stdbool.h>
-#include "evsel.h"
 #include "parse-events.h"
 
+struct perf_evsel_config_term;
+
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
-- 
2.20.1
