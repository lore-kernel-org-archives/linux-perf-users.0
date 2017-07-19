From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/86] perf annotate: Check for fused instructions
Date: Wed, 19 Jul 2017 10:55:52 -0300
Message-ID: <20170719135717.1285-2-acme@kernel.org>
References: <20170719135717.1285-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719135717.1285-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Macro fusion merges two instructions to a single micro-op. Intel core
platform performs this hardware optimization under limited
circumstances.

For example, CMP + JCC can be "fused" and executed /retired together.
While with sampling this can result in the sample sometimes being on the
JCC and sometimes on the CMP.  So for the fused instruction pair, they
could be considered together.

On Nehalem, fused instruction pairs:

  cmp/test + jcc.

On other new CPU:

  cmp/test/add/sub/and/inc/dec + jcc.

This patch adds an x86-specific function which checks if 2 instructions
are in a "fused" pair. For non-x86 arch, the function is just NULL.

Changelog:

v4: Move the CPU model checking to symbol__disassemble and save the CPU
    family/model in arch structure.

    It avoids checking every time when jump arrow printed.

v3: Add checking for Nehalem (CMP, TEST). For other newer Intel CPUs
    just check it by default (CMP, TEST, ADD, SUB, AND, INC, DEC).

v2: Remove the original weak function. Arnaldo points out that doing it
    as a weak function that will be overridden by the host arch doesn't
    work. So now it's implemented as an arch-specific function.

Committer fix:

Do not access evsel->evlist->env->cpuid, ->env can be null, introduce
perf_evsel__env_cpuid(), just like perf_evsel__env_arch(), also used in
this function call.

The original patch was segfaulting 'perf top' + annotation.

But this essentially disables this fused instructions augmentation in
'perf top', the right thing is to get the cpuid from the running kernel,
left for a later patch tho.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1499403995-19857-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 46 +++++++++++++++++++++++++++++
 tools/perf/builtin-top.c                    |  2 +-
 tools/perf/ui/browsers/annotate.c           |  4 ++-
 tools/perf/ui/gtk/annotate.c                |  2 +-
 tools/perf/util/annotate.c                  | 22 ++++++++++++--
 tools/perf/util/annotate.h                  |  3 +-
 tools/perf/util/evsel.c                     |  7 +++++
 tools/perf/util/evsel.h                     |  1 +
 8 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index c1625f256df3..d84b72063a30 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -76,3 +76,49 @@ static struct ins x86__instructions[] = {
 	{ .name = "xbeginq",	.ops = &jump_ops, },
 	{ .name = "retq",	.ops = &ret_ops,  },
 };
+
+static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
+			      const char *ins2)
+{
+	if (arch->family != 6 || arch->model < 0x1e || strstr(ins2, "jmp"))
+		return false;
+
+	if (arch->model == 0x1e) {
+		/* Nehalem */
+		if ((strstr(ins1, "cmp") && !strstr(ins1, "xchg")) ||
+		     strstr(ins1, "test")) {
+			return true;
+		}
+	} else {
+		/* Newer platform */
+		if ((strstr(ins1, "cmp") && !strstr(ins1, "xchg")) ||
+		     strstr(ins1, "test") ||
+		     strstr(ins1, "add") ||
+		     strstr(ins1, "sub") ||
+		     strstr(ins1, "and") ||
+		     strstr(ins1, "inc") ||
+		     strstr(ins1, "dec")) {
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static int x86__cpuid_parse(struct arch *arch, char *cpuid)
+{
+	unsigned int family, model, stepping;
+	int ret;
+
+	/*
+	 * cpuid = "GenuineIntel,family,model,stepping"
+	 */
+	ret = sscanf(cpuid, "%*[^,],%u,%u,%u", &family, &model, &stepping);
+	if (ret == 3) {
+		arch->family = family;
+		arch->model = model;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6052376634c0..022486dc67f5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -134,7 +134,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__disassemble(sym, map, NULL, 0, NULL);
+	err = symbol__disassemble(sym, map, NULL, 0, NULL, NULL);
 	if (err == 0) {
 out_assign:
 		top->sym_filter_entry = he;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 27f41f28dcb4..c4336138b673 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -9,6 +9,7 @@
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
 #include "../../util/config.h"
+#include "../../util/evlist.h"
 #include <inttypes.h>
 #include <pthread.h>
 #include <linux/kernel.h>
@@ -1074,7 +1075,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	}
 
 	err = symbol__disassemble(sym, map, perf_evsel__env_arch(evsel),
-				  sizeof_bdl, &browser.arch);
+				  sizeof_bdl, &browser.arch,
+				  perf_evsel__env_cpuid(evsel));
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index d903fd493416..87e3760624f2 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,7 +169,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 		return -1;
 
 	err = symbol__disassemble(sym, map, perf_evsel__env_arch(evsel),
-				  0, NULL);
+				  0, NULL, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index be1caabb9290..8748ebb3f932 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -47,7 +47,12 @@ struct arch {
 	bool		sorted_instructions;
 	bool		initialized;
 	void		*priv;
+	unsigned int	model;
+	unsigned int	family;
 	int		(*init)(struct arch *arch);
+	bool		(*ins_is_fused)(struct arch *arch, const char *ins1,
+					const char *ins2);
+	int		(*cpuid_parse)(struct arch *arch, char *cpuid);
 	struct		{
 		char comment_char;
 		char skip_functions_char;
@@ -129,6 +134,8 @@ static struct arch architectures[] = {
 		.name = "x86",
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
+		.ins_is_fused = x86__ins_is_fused,
+		.cpuid_parse = x86__cpuid_parse,
 		.objdump =  {
 			.comment_char = '#',
 		},
@@ -171,6 +178,14 @@ int ins__scnprintf(struct ins *ins, char *bf, size_t size,
 	return ins__raw_scnprintf(ins, bf, size, ops);
 }
 
+bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2)
+{
+	if (!arch || !arch->ins_is_fused)
+		return false;
+
+	return arch->ins_is_fused(arch, ins1, ins2);
+}
+
 static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *map)
 {
 	char *endptr, *tok, *name;
@@ -1381,7 +1396,7 @@ static const char *annotate__norm_arch(const char *arch_name)
 
 int symbol__disassemble(struct symbol *sym, struct map *map,
 			const char *arch_name, size_t privsize,
-			struct arch **parch)
+			struct arch **parch, char *cpuid)
 {
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
@@ -1418,6 +1433,9 @@ int symbol__disassemble(struct symbol *sym, struct map *map,
 		}
 	}
 
+	if (arch->cpuid_parse && cpuid)
+		arch->cpuid_parse(arch, cpuid);
+
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
 		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
 		 map->unmap_ip(map, sym->end));
@@ -1907,7 +1925,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	u64 len;
 
 	if (symbol__disassemble(sym, map, perf_evsel__env_arch(evsel),
-				0, NULL) < 0)
+				0, NULL, NULL) < 0)
 		return -1;
 
 	len = symbol__size(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 21055034aedd..72d72728a0fc 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -53,6 +53,7 @@ bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
+bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
 struct annotation;
 
@@ -160,7 +161,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__disassemble(struct symbol *sym, struct map *map,
 			const char *arch_name, size_t privsize,
-			struct arch **parch);
+			struct arch **parch, char *cpuid);
 
 enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__SUCCESS		= 0,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 413f74df08de..0e4cd6092564 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2610,3 +2610,10 @@ char *perf_evsel__env_arch(struct perf_evsel *evsel)
 		return evsel->evlist->env->arch;
 	return NULL;
 }
+
+char *perf_evsel__env_cpuid(struct perf_evsel *evsel)
+{
+	if (evsel && evsel->evlist && evsel->evlist->env)
+		return evsel->evlist->env->cpuid;
+	return NULL;
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d101695c482c..219ad0cdb9f4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -436,5 +436,6 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv);
 
 char *perf_evsel__env_arch(struct perf_evsel *evsel);
+char *perf_evsel__env_cpuid(struct perf_evsel *evsel);
 
 #endif /* __PERF_EVSEL_H */
-- 
2.9.4
