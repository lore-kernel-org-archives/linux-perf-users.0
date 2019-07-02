From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/43] perf header: Use skip_spaces() in __write_cpudesc()
Date: Mon,  1 Jul 2019 23:25:58 -0300
Message-ID: <20190702022616.1259-26-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Stephane Eranian <eranian@google.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour.

Cc: Stephane Eranian <eranian@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0dbfpi70aa66s6mtd8z6p391@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fca9dbaf61ae..1eb15f7517b0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
@@ -416,10 +417,8 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 	while (*p) {
 		if (isspace(*p)) {
 			char *r = p + 1;
-			char *q = r;
+			char *q = skip_spaces(r);
 			*p = ' ';
-			while (*q && isspace(*q))
-				q++;
 			if (q != (p+1))
 				while ((*r++ = *q++));
 		}
-- 
2.20.1
