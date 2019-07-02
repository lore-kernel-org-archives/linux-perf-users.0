From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/43] perf ctype: Remove unused 'graph_line' variable
Date: Mon,  1 Jul 2019 23:25:45 -0300
Message-ID: <20190702022616.1259-13-acme@kernel.org>
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

Not being used at all anywhere.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1e567f8tn8m4ii7dy1w9dp39@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ctype.c      | 4 ----
 tools/perf/util/sane_ctype.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index ee4c1e8ed54b..8d90bf8d0d70 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -31,10 +31,6 @@ unsigned char sane_ctype[256] = {
 	/* Nothing in the 128.. range */
 };
 
-const char *graph_line =
-	"_____________________________________________________________________"
-	"_____________________________________________________________________"
-	"_____________________________________________________________________";
 const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------"
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index c2b42ff9ff32..894594fdedfb 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -2,7 +2,6 @@
 #ifndef _PERF_SANE_CTYPE_H
 #define _PERF_SANE_CTYPE_H
 
-extern const char *graph_line;
 extern const char *graph_dotted_line;
 extern const char *spaces;
 extern const char *dots;
-- 
2.20.1
