From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/53] perf powerpc kvm-stat: Add missing evlist.h header
Date: Wed,  6 Feb 2019 15:48:28 -0300
Message-ID: <20190206184903.24054-19-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This header was being obtained indirectly, by sheer luck, add it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c3h8oyav16iu5ivput8n4wt6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 86e64c47d8ea..f9db341c47b6 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -4,6 +4,7 @@
 #include "util/parse-events.h"
 #include "util/debug.h"
 #include "util/evsel.h"
+#include "util/evlist.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
-- 
2.20.1
