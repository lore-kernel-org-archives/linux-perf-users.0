From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/57] perf string: Export asprintf__tp_filter_pids()
Date: Mon, 21 Oct 2019 10:37:53 -0300
Message-ID: <20191021133834.25998-17-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used directly in 'perf trace' for setting up the command line
argv array to pass to cmd_record, as this was how 'perf trace record'
was implemented, following the model used in 'perf kvm record', 'perf
sched record', etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w3cuwjs63lxf5zpryy3145uv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c  | 3 ++-
 tools/perf/util/string2.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8793b4e322b0..0f9cd703e725 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -21,6 +21,7 @@
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
+#include "util/string2.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -959,7 +960,7 @@ int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
-static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
+char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
 	size_t i;
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 708805f5573e..73df616ced43 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -4,6 +4,7 @@
 
 #include <linux/string.h>
 #include <linux/types.h>
+#include <sys/types.h> // pid_t
 #include <stddef.h>
 #include <string.h>
 
@@ -32,6 +33,8 @@ static inline char *asprintf_expr_not_in_ints(const char *var, size_t nints, int
 	return asprintf_expr_inout_ints(var, false, nints, ints);
 }
 
+char *asprintf__tp_filter_pids(size_t npids, pid_t *pids);
+
 char *strpbrk_esc(char *str, const char *stopset);
 char *strdup_esc(const char *str);
 
-- 
2.21.0
