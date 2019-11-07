From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/63] perf tools: Fix cross compile for ARM64
Date: Thu,  7 Nov 2019 15:59:47 -0300
Message-ID: <20191107190011.23924-40-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Currently when cross compiling perf tool for ARM64 on my x86 machine I
get this error:

  arch/arm64/util/sym-handling.c:9:10: fatal error: gelf.h: No such file or directory
   #include <gelf.h>

For the build, libelf is reported off:

  Auto-detecting system features:
  ...
  ...                        libelf: [ OFF ]

Indeed, test-libelf is not built successfully:

  more ./build/feature/test-libelf.make.output
  test-libelf.c:2:10: fatal error: libelf.h: No such file or directory
   #include <libelf.h>
          ^~~~~~~~~~
  compilation terminated.

I have no such problems natively compiling on ARM64, and I did not
previously have this issue for cross compiling. Fix by relocating the
gelf.h include.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lore.kernel.org/lkml/1573045254-39833-1-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/sym-handling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
index 5df788985130..8dfa3e5229f1 100644
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ b/tools/perf/arch/arm64/util/sym-handling.c
@@ -6,9 +6,10 @@
 
 #include "symbol.h" // for the elf__needs_adjust_symbols() prototype
 #include <stdbool.h>
-#include <gelf.h>
 
 #ifdef HAVE_LIBELF_SUPPORT
+#include <gelf.h>
+
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 {
 	return ehdr.e_type == ET_EXEC ||
-- 
2.21.0
