From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/17] libperf: Fix arch include paths
Date: Tue, 20 Aug 2019 16:27:33 -0300
Message-ID: <20190820192733.19180-18-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Guenter Roeck reported problem with compilation when the ARCH is
specified:

  $ make ARCH=x86_64
  In file included from tools/include/asm/atomic.h:6:0,
                   from include/linux/atomic.h:5,
                   from tools/include/linux/refcount.h:41,
                   from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
  fatal error: asm/cmpxchg.h: No such file or directory

The problem is that we don't use SRCARCH (the sanitized ARCH version)
and we don't get the proper include path.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 314350491810 ("libperf: Make libperf.a part of the perf build")
Link: http://lkml.kernel.org/r/20190820124624.GG24105@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 8a9ae50818e4..a67efb8d9d39 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -59,7 +59,7 @@ else
   CFLAGS := -g -Wall
 endif
 
-INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/ -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
+INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
-- 
2.21.0
