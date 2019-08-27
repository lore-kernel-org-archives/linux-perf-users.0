From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/33] perf cpumap: No need to include perf.h, ditch it
Date: Mon, 26 Aug 2019 22:36:02 -0300
Message-ID: <20190827013634.3173-2-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From a quick look this was never needed and just polluted the build,
needlessly making things including cpumap.h to be rebuild if perf.h or
anything it includes gets changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x10p8slllqkn3fc3bntjx3n0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index d0c5bbfd91af..c2519e7ea958 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,8 +7,6 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
-#include "perf.h"
-
 struct cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-- 
2.21.0
