From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v6 02/11] perf tools report: Parse time quantum
Date: Mon, 11 Mar 2019 07:44:53 -0700
Message-ID: <20190311144502.15423-3-andi@firstfloor.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311144502.15423-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Many workloads change over time. perf report currently aggregates
the whole time range reported in perf.data.

This patch adds an option for a time quantum to quantisize the
perf.data over time.

This just adds the option, will be used in follow on patches
for a time sort key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Move time_quantum to symbol_conf. check for zero time quantum
v3:
Document s unit
v4:
Use _NSEC defines
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 6b73a0eeb6a1..967066d4d899 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -30,6 +30,7 @@
 #include <elf.h>
 #include <limits.h>
 #include <symbol/kallsyms.h>
+#include <linux/time64.h>
 #include <sys/utsname.h>
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
-- 
2.20.1
