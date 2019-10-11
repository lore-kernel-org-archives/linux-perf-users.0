From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/69] perf env: Add routine to read the env->cpuid from the running machine
Date: Fri, 11 Oct 2019 17:04:51 -0300
Message-ID: <20191011200559.7156-2-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 'perf top' we use that cpuid when initializing the per arch
annotation init routines (e.g. x86__annotate_init()) and in that case
(live mode, 'perf top') we need to obtain it from the running machine,
not from a perf.data file header.

Provide a means to do that. Will be used by 'perf top' in a followup
patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h2wb3sx7u7znx6lqfezrh7ca@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 16 ++++++++++++++++
 tools/perf/util/env.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 3baca06786fb..2a91a10ccfcc 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -2,6 +2,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
+#include "util/header.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include "bpf-event.h"
@@ -256,6 +257,21 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	return 0;
 }
 
+int perf_env__read_cpuid(struct perf_env *env)
+{
+	char cpuid[128];
+	int err = get_cpuid(cpuid, sizeof(cpuid));
+
+	if (err)
+		return err;
+
+	free(env->cpuid);
+	env->cpuid = strdup(cpuid);
+	if (env->cpuid == NULL)
+		return ENOMEM;
+	return 0;
+}
+
 static int perf_env__read_arch(struct perf_env *env)
 {
 	struct utsname uts;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index db40906e2937..a3059dc1abe5 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -104,6 +104,7 @@ void perf_env__exit(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
+int perf_env__read_cpuid(struct perf_env *env);
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
-- 
2.21.0
