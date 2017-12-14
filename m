From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/34] perf env: Adopt perf_env__arch() from the annotate code
Date: Thu, 14 Dec 2017 14:42:33 -0300
Message-ID: <20171214174247.16841-21-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And use it in the libunwind case, with both passing a valid perf_env to
extract the arch to be normalized from and passing NULL with the same
semantic as in the annotate code: to get it from uname() uts.machine.

Now the code to generate per arch errno translation tables (int/string)
can use it to decode perf.data files recorded in a different arch than
that where 'perf trace' (or any other analysis tool) runs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p2epffgash69w38kvj3ntpc9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c           | 44 +++--------------------------------
 tools/perf/arch/common.h           |  1 -
 tools/perf/util/annotate.c         | 16 -------------
 tools/perf/util/env.c              | 47 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h              |  2 ++
 tools/perf/util/unwind-libunwind.c |  4 ++--
 6 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 8c0cfeb55f8e..c6f373508a4f 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
-#include <sys/utsname.h>
 #include "common.h"
+#include "../util/env.h"
 #include "../util/util.h"
 #include "../util/debug.h"
 
-#include "sane_ctype.h"
-
 const char *const arm_triplets[] = {
 	"arm-eabi-",
 	"arm-linux-androideabi-",
@@ -120,55 +118,19 @@ static int lookup_triplets(const char *const *triplets, const char *name)
 	return -1;
 }
 
-/*
- * Return architecture name in a normalized form.
- * The conversion logic comes from the Makefile.
- */
-const char *normalize_arch(char *arch)
-{
-	if (!strcmp(arch, "x86_64"))
-		return "x86";
-	if (arch[0] == 'i' && arch[2] == '8' && arch[3] == '6')
-		return "x86";
-	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
-		return "sparc";
-	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
-		return "arm64";
-	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
-		return "arm";
-	if (!strncmp(arch, "s390", 4))
-		return "s390";
-	if (!strncmp(arch, "parisc", 6))
-		return "parisc";
-	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
-		return "powerpc";
-	if (!strncmp(arch, "mips", 4))
-		return "mips";
-	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
-		return "sh";
-
-	return arch;
-}
-
 static int perf_env__lookup_binutils_path(struct perf_env *env,
 					  const char *name, const char **path)
 {
 	int idx;
-	const char *arch, *cross_env;
-	struct utsname uts;
+	const char *arch = perf_env__arch(env), *cross_env;
 	const char *const *path_list;
 	char *buf = NULL;
 
-	arch = normalize_arch(env->arch);
-
-	if (uname(&uts) < 0)
-		goto out;
-
 	/*
 	 * We don't need to try to find objdump path for native system.
 	 * Just use default binutils path (e.g.: "objdump").
 	 */
-	if (!strcmp(normalize_arch(uts.machine), arch))
+	if (!strcmp(perf_env__arch(NULL), arch))
 		goto out;
 
 	cross_env = getenv("CROSS_COMPILE");
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index a1546509ad24..2d875baa92e6 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -7,6 +7,5 @@
 extern const char *objdump_path;
 
 int perf_env__lookup_objdump(struct perf_env *env);
-const char *normalize_arch(char *arch);
 
 #endif /* ARCH_PERF_COMMON_H */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index eac45ccd5c32..68e687d1bf99 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -26,7 +26,6 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
-#include <sys/utsname.h>
 
 #include "sane_ctype.h"
 
@@ -1420,21 +1419,6 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
-static const char *perf_env__arch(struct perf_env *env)
-{
-	struct utsname uts;
-	char *arch_name;
-
-	if (!env) { /* Assume local operation */
-		if (uname(&uts) < 0)
-			return NULL;
-		arch_name = uts.machine;
-	} else
-		arch_name = env->arch;
-
-	return normalize_arch(arch_name);
-}
-
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct map *map = args->map;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6276b340f893..6d311868d850 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "cpumap.h"
 #include "env.h"
+#include "sane_ctype.h"
 #include "util.h"
 #include <errno.h>
+#include <sys/utsname.h>
 
 struct perf_env perf_env;
 
@@ -93,3 +95,48 @@ void cpu_cache_level__free(struct cpu_cache_level *cache)
 	free(cache->map);
 	free(cache->size);
 }
+
+/*
+ * Return architecture name in a normalized form.
+ * The conversion logic comes from the Makefile.
+ */
+static const char *normalize_arch(char *arch)
+{
+	if (!strcmp(arch, "x86_64"))
+		return "x86";
+	if (arch[0] == 'i' && arch[2] == '8' && arch[3] == '6')
+		return "x86";
+	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
+		return "sparc";
+	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
+		return "arm64";
+	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
+		return "arm";
+	if (!strncmp(arch, "s390", 4))
+		return "s390";
+	if (!strncmp(arch, "parisc", 6))
+		return "parisc";
+	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
+		return "powerpc";
+	if (!strncmp(arch, "mips", 4))
+		return "mips";
+	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
+		return "sh";
+
+	return arch;
+}
+
+const char *perf_env__arch(struct perf_env *env)
+{
+	struct utsname uts;
+	char *arch_name;
+
+	if (!env) { /* Assume local operation */
+		if (uname(&uts) < 0)
+			return NULL;
+		arch_name = uts.machine;
+	} else
+		arch_name = env->arch;
+
+	return normalize_arch(arch_name);
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 1eb35b190b34..bf970f57dce0 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -65,4 +65,6 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
+
+const char *perf_env__arch(struct perf_env *env);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 647a1e6b4c7b..b029a5e9ae49 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -3,7 +3,7 @@
 #include "thread.h"
 #include "session.h"
 #include "debug.h"
-#include "arch/common.h"
+#include "env.h"
 
 struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
@@ -39,7 +39,7 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 	if (dso_type == DSO__TYPE_UNKNOWN)
 		return 0;
 
-	arch = normalize_arch(thread->mg->machine->env->arch);
+	arch = perf_env__arch(thread->mg->machine->env);
 
 	if (!strcmp(arch, "x86")) {
 		if (dso_type != DSO__TYPE_64BIT)
-- 
2.13.6
