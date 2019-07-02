From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/43] perf strfilter: Use skip_spaces()
Date: Mon,  1 Jul 2019 23:26:01 -0300
Message-ID: <20190702022616.1259-29-acme@kernel.org>
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

No change in behaviour.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p9rtamq7lvre9zhti70azfwe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strfilter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/strfilter.c b/tools/perf/util/strfilter.c
index 2c3a2904ebcd..90ea2b209cbb 100644
--- a/tools/perf/util/strfilter.c
+++ b/tools/perf/util/strfilter.c
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 /* Operators */
 static const char *OP_and	= "&";	/* Logical AND */
@@ -37,8 +38,7 @@ static const char *get_token(const char *s, const char **e)
 {
 	const char *p;
 
-	while (isspace(*s))	/* Skip spaces */
-		s++;
+	s = skip_spaces(s);
 
 	if (*s == '\0') {
 		p = s;
-- 
2.20.1
