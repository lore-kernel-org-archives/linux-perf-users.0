From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/43] perf probe: Use skip_spaces() for argv handling
Date: Mon,  1 Jul 2019 23:26:00 -0300
Message-ID: <20190702022616.1259-28-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The skip_sep() routine has the same implementation as skip_spaces(),
recently adopted from the kernel, sources, switch to it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0ix211a81z2016dl5nmtdci4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/string.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 084c3e4e9400..d28e723e2790 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -69,18 +69,6 @@ s64 perf_atoll(const char *str)
 	return -1;
 }
 
-/*
- * Helper function for splitting a string into an argv-like array.
- * originally copied from lib/argv_split.c
- */
-static const char *skip_sep(const char *cp)
-{
-	while (*cp && isspace(*cp))
-		cp++;
-
-	return cp;
-}
-
 static const char *skip_arg(const char *cp)
 {
 	while (*cp && !isspace(*cp))
@@ -94,7 +82,7 @@ static int count_argc(const char *str)
 	int count = 0;
 
 	while (*str) {
-		str = skip_sep(str);
+		str = skip_spaces(str);
 		if (*str) {
 			count++;
 			str = skip_arg(str);
@@ -148,7 +136,7 @@ char **argv_split(const char *str, int *argcp)
 	argvp = argv;
 
 	while (*str) {
-		str = skip_sep(str);
+		str = skip_spaces(str);
 
 		if (*str) {
 			const char *p = str;
-- 
2.20.1
