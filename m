From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/43] perf ctype: Remove now unused 'spaces' variable
Date: Mon,  1 Jul 2019 23:25:47 -0300
Message-ID: <20190702022616.1259-15-acme@kernel.org>
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

We can left justify just fine using the 'field width' modifier in %s
printf, ditch this variable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2td8u86mia7143lbr5ttl0kf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ctype.c      | 4 ----
 tools/perf/util/sane_ctype.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index 8d90bf8d0d70..75c0da59c230 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -35,10 +35,6 @@ const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------";
-const char *spaces =
-	"                                                                     "
-	"                                                                     "
-	"                                                                     ";
 const char *dots =
 	"....................................................................."
 	"....................................................................."
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index 894594fdedfb..a2bb3890864f 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -3,7 +3,6 @@
 #define _PERF_SANE_CTYPE_H
 
 extern const char *graph_dotted_line;
-extern const char *spaces;
 extern const char *dots;
 
 /* Sane ctype - no locale, and works with signed chars */
-- 
2.20.1
