From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/41] tools lib api: Fix make DEBUG=1 build
Date: Tue, 12 Sep 2017 12:10:05 -0300
Message-ID: <20170912151029.6612-18-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Do not use -D_FORTIFY_SOURCE=2 for DEBUG build as it seems to mess up
with debuginfo, which results in bad gdb experience.

We already do that for tools/perf/.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908084621.31595-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 4563ba7ede6f..1e83e3c07448 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -17,13 +17,19 @@ MAKEFLAGS += --no-print-directory
 LIBFILE = $(OUTPUT)libapi.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
+CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -fPIC
 
+ifeq ($(DEBUG),0)
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
 endif
+endif
+
+ifeq ($(DEBUG),0)
+  CFLAGS += -D_FORTIFY_SOURCE
+endif
 
 # Treat warnings as errors unless directed not to
 ifneq ($(WERROR),0)
-- 
2.13.5
