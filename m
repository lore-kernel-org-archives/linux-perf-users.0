From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/25] perf kvm s390: Add missing string.h header
Date: Thu, 22 Aug 2019 18:00:41 -0300
Message-ID: <20190822210100.3461-7-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses strstr(), needs to include string.h or its not going to build
when we remove string.h from the place it is getting from indirectly, by
luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-72y0i0uiaqght5b83e3ae7p4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index dac78441338c..0fd4e9f49ed0 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -7,6 +7,7 @@
  */
 
 #include <errno.h>
+#include <string.h>
 #include "../../util/kvm-stat.h"
 #include "../../util/evsel.h"
 #include <asm/sie.h>
-- 
2.21.0
