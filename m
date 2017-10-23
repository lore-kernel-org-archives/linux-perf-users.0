From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/24] perf annotate: Remove arch::cpuid_parse callback
Date: Mon, 23 Oct 2017 20:47:28 -0300
Message-ID: <20171023234736.5335-17-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need for extra cpuid_parse arch callback, it can be handled
directly in init callback.

Adding the init function to x86 to cover the cpuid initialization.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/annotate/instructions.c     |  3 ++-
 tools/perf/arch/arm64/annotate/instructions.c   |  3 ++-
 tools/perf/arch/powerpc/annotate/instructions.c |  4 +++-
 tools/perf/arch/s390/annotate/instructions.c    |  4 +++-
 tools/perf/arch/x86/annotate/instructions.c     | 14 ++++++++++++++
 tools/perf/util/annotate.c                      | 10 +++-------
 6 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index 1ce0872b1726..6dfec7c23696 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -1,3 +1,4 @@
+#include <linux/compiler.h>
 #include <sys/types.h>
 #include <regex.h>
 
@@ -23,7 +24,7 @@ static struct ins_ops *arm__associate_instruction_ops(struct arch *arch, const c
 	return ops;
 }
 
-static int arm__annotate_init(struct arch *arch)
+static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	struct arm_annotate *arm;
 	int err;
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 8f1908756cb6..a2c32be4132a 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -1,3 +1,4 @@
+#include <linux/compiler.h>
 #include <sys/types.h>
 #include <regex.h>
 
@@ -25,7 +26,7 @@ static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const
 	return ops;
 }
 
-static int arm64__annotate_init(struct arch *arch)
+static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	struct arm64_annotate *arm;
 	int err;
diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index 3c4004db81b9..b6b0ef5952d0 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -1,3 +1,5 @@
+#include <linux/compiler.h>
+
 static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	int i;
@@ -46,7 +48,7 @@ static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, con
 	return ops;
 }
 
-static int powerpc__annotate_init(struct arch *arch)
+static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->initialized = true;
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 745b4b1b8b21..b8676ccbed76 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -1,3 +1,5 @@
+#include <linux/compiler.h>
+
 static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
 {
 	struct ins_ops *ops = NULL;
@@ -19,7 +21,7 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 	return ops;
 }
 
-static int s390__annotate_init(struct arch *arch)
+static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->initialized = true;
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index d84b72063a30..563cd4564041 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -122,3 +122,17 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
 
 	return -1;
 }
+
+static int x86__annotate_init(struct arch *arch, char *cpuid)
+{
+	int err = 0;
+
+	if (arch->initialized)
+		return 0;
+
+	if (cpuid)
+		err = x86__cpuid_parse(arch, cpuid);
+
+	arch->initialized = true;
+	return err;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4397a8b6e6cd..08164162c345 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -49,10 +49,9 @@ struct arch {
 	void		*priv;
 	unsigned int	model;
 	unsigned int	family;
-	int		(*init)(struct arch *arch);
+	int		(*init)(struct arch *arch, char *cpuid);
 	bool		(*ins_is_fused)(struct arch *arch, const char *ins1,
 					const char *ins2);
-	int		(*cpuid_parse)(struct arch *arch, char *cpuid);
 	struct		{
 		char comment_char;
 		char skip_functions_char;
@@ -132,10 +131,10 @@ static struct arch architectures[] = {
 	},
 	{
 		.name = "x86",
+		.init = x86__annotate_init,
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
 		.ins_is_fused = x86__ins_is_fused,
-		.cpuid_parse = x86__cpuid_parse,
 		.objdump =  {
 			.comment_char = '#',
 		},
@@ -1447,16 +1446,13 @@ int symbol__disassemble(struct symbol *sym, struct map *map,
 		*parch = arch;
 
 	if (arch->init) {
-		err = arch->init(arch);
+		err = arch->init(arch, cpuid);
 		if (err) {
 			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
 			return err;
 		}
 	}
 
-	if (arch->cpuid_parse && cpuid)
-		arch->cpuid_parse(arch, cpuid);
-
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
 		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
 		 map->unmap_ip(map, sym->end));
-- 
2.13.6
