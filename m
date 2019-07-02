From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/43] perf tools: Drop strxfrchar(), use strreplace() equivalent from kernel
Date: Mon,  1 Jul 2019 23:26:09 -0300
Message-ID: <20190702022616.1259-37-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour intended, just reducing the codebase and using
something available in tools/lib/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-oyi6zif3810nwi4uu85odnhv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c     |  3 ++-
 tools/perf/util/string.c  | 18 ------------------
 tools/perf/util/string2.h |  1 -
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1fb18292c2d3..c7fde04400f7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/bug.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/types.h>
@@ -394,7 +395,7 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 				return -ENOMEM;
 		}
 
-		strxfrchar(m->name, '-', '_');
+		strreplace(m->name, '-', '_');
 	}
 
 	return 0;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 93a5340424df..9b7fbb0cbecd 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -300,24 +300,6 @@ int strtailcmp(const char *s1, const char *s2)
 	return 0;
 }
 
-/**
- * strxfrchar - Locate and replace character in @s
- * @s:    The string to be searched/changed.
- * @from: Source character to be replaced.
- * @to:   Destination character.
- *
- * Return pointer to the changed string.
- */
-char *strxfrchar(char *s, char from, char to)
-{
-	char *p = s;
-
-	while ((p = strchr(p, from)) != NULL)
-		*p++ = to;
-
-	return s;
-}
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
 	/*
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 6da835ad8f5b..2696c3fcd780 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -21,7 +21,6 @@ static inline bool strisglob(const char *str)
 	return strpbrk(str, "*?[") != NULL;
 }
 int strtailcmp(const char *s1, const char *s2);
-char *strxfrchar(char *s, char from, char to);
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
-- 
2.20.1
