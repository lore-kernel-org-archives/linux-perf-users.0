From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/69] perf trace: Generalize the syscall_fmt find routines
Date: Fri, 11 Oct 2019 17:04:56 -0300
Message-ID: <20191011200559.7156-7-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow them to be used with other stuff, such as tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-od3gzg77ppqgnnrxqv40fvgx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cb853434d761..313dfc1cefc5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -966,24 +966,35 @@ static int syscall_fmt__cmp(const void *name, const void *fmtp)
 	return strcmp(name, fmt->name);
 }
 
+static struct syscall_fmt *__syscall_fmt__find(struct syscall_fmt *fmts, const int nmemb, const char *name)
+{
+	return bsearch(name, fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
+}
+
 static struct syscall_fmt *syscall_fmt__find(const char *name)
 {
 	const int nmemb = ARRAY_SIZE(syscall_fmts);
-	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
+	return __syscall_fmt__find(syscall_fmts, nmemb, name);
 }
 
-static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+static struct syscall_fmt *__syscall_fmt__find_by_alias(struct syscall_fmt *fmts, const int nmemb, const char *alias)
 {
-	int i, nmemb = ARRAY_SIZE(syscall_fmts);
+	int i;
 
 	for (i = 0; i < nmemb; ++i) {
-		if (syscall_fmts[i].alias && strcmp(syscall_fmts[i].alias, alias) == 0)
-			return &syscall_fmts[i];
+		if (fmts[i].alias && strcmp(fmts[i].alias, alias) == 0)
+			return &fmts[i];
 	}
 
 	return NULL;
 }
 
+static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+{
+	const int nmemb = ARRAY_SIZE(syscall_fmts);
+	return __syscall_fmt__find_by_alias(syscall_fmts, nmemb, alias);
+}
+
 /*
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
-- 
2.21.0
