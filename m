From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/53] perf arm pmu: Add missing linux/string.h header
Date: Wed,  6 Feb 2019 15:48:12 -0300
Message-ID: <20190206184903.24054-3-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Kim Phillips <kim.phillips@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses strstarts(), that is defined in linux/string.h but that was
being including by sheer luck, indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-vub5lp82wb7vy5wssfad0xu8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index e047571e6080..64a677b518d0 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <linux/coresight-pmu.h>
 #include <linux/perf_event.h>
+#include <linux/string.h>
 
 #include "cs-etm.h"
 #include "arm-spe.h"
-- 
2.20.1
