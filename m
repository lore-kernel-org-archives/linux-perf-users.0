From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/86] perf probe: Allow placing uprobes in alternate namespaces.
Date: Wed, 19 Jul 2017 11:29:00 -0300
Message-ID: <20170719142950.3747-37-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

Teaches perf how to place a uprobe on a file that's in a different mount
namespace.  The user must add the probe using the --target-ns argument
to perf probe.  Once it has been placed, it may be recorded against
without further namespace-specific commands.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
[ PPC build fixed by Ravi: ]
Link: http://lkml.kernel.org/r/1500287542-6219-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
[ Fix !HAVE_DWARF_SUPPORT build ]
Link: http://lkml.kernel.org/r/1499305693-1599-4-git-send-email-kjlx@templeofstupid.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-probe.txt     |  9 ++++
 tools/perf/arch/powerpc/util/sym-handling.c |  2 +-
 tools/perf/builtin-probe.c                  | 43 ++++++++++++++--
 tools/perf/util/namespaces.c                | 13 +++++
 tools/perf/util/namespaces.h                |  2 +
 tools/perf/util/probe-event.c               | 80 +++++++++++++++++++----------
 tools/perf/util/probe-event.h               | 10 ++--
 7 files changed, 125 insertions(+), 34 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index 165c2b1d4317..a42aabc2b082 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -130,6 +130,11 @@ OPTIONS
 --max-probes=NUM::
 	Set the maximum number of probe points for an event. Default is 128.
 
+--target-ns=PID:
+	Obtain mount namespace information from the target pid.  This is
+	used when creating a uprobe for a process that resides in a
+	different mount namespace from the perf(1) utility.
+
 -x::
 --exec=PATH::
 	Specify path to the executable or shared library file for user
@@ -264,6 +269,10 @@ Add probes at malloc() function on libc
 
  ./perf probe -x /lib/libc.so.6 malloc or ./perf probe /lib/libc.so.6 malloc
 
+Add a uprobe to a target process running in a different mount namespace
+
+ ./perf probe --target-ns <target pid> -x /lib64/libc.so.6 malloc
+
 SEE ALSO
 --------
 linkperf:perf-trace[1], linkperf:perf-record[1], linkperf:perf-buildid-cache[1]
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index bf9a2594572c..9c4e23d8c8ce 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -126,7 +126,7 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 	struct rb_node *tmp;
 	int i = 0;
 
-	map = get_target_map(pev->target, pev->uprobes);
+	map = get_target_map(pev->target, pev->nsi, pev->uprobes);
 	if (!map || map__load(map) < 0)
 		return;
 
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index cf9f9e9c2fc0..3fb98d59cd27 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -58,6 +58,7 @@ static struct {
 	struct line_range line_range;
 	char *target;
 	struct strfilter *filter;
+	struct nsinfo *nsi;
 } params;
 
 /* Parse an event definition. Note that any error must die. */
@@ -80,6 +81,9 @@ static int parse_probe_event(const char *str)
 		params.target_used = true;
 	}
 
+	if (params.nsi)
+		pev->nsi = nsinfo__get(params.nsi);
+
 	/* Parse a perf-probe command into event */
 	ret = parse_perf_probe_command(str, pev);
 	pr_debug("%d arguments\n", pev->nargs);
@@ -189,7 +193,7 @@ static int opt_set_target(const struct option *opt, const char *str,
 
 		/* Expand given path to absolute path, except for modulename */
 		if (params.uprobes || strchr(str, '/')) {
-			tmp = realpath(str, NULL);
+			tmp = nsinfo__realpath(str, params.nsi);
 			if (!tmp) {
 				pr_warning("Failed to get the absolute path of %s: %m\n", str);
 				return ret;
@@ -208,6 +212,34 @@ static int opt_set_target(const struct option *opt, const char *str,
 	return ret;
 }
 
+static int opt_set_target_ns(const struct option *opt __maybe_unused,
+			     const char *str, int unset __maybe_unused)
+{
+	int ret = -ENOENT;
+	pid_t ns_pid;
+	struct nsinfo *nsip;
+
+	if (str) {
+		errno = 0;
+		ns_pid = (pid_t)strtol(str, NULL, 10);
+		if (errno != 0) {
+			ret = -errno;
+			pr_warning("Failed to parse %s as a pid: %s\n", str,
+				   strerror(errno));
+			return ret;
+		}
+		nsip = nsinfo__new(ns_pid);
+		if (nsip && nsip->need_setns)
+			params.nsi = nsinfo__get(nsip);
+		nsinfo__put(nsip);
+
+		ret = 0;
+	}
+
+	return ret;
+}
+
+
 /* Command option callbacks */
 
 #ifdef HAVE_DWARF_SUPPORT
@@ -299,6 +331,7 @@ static void cleanup_params(void)
 	line_range__clear(&params.line_range);
 	free(params.target);
 	strfilter__delete(params.filter);
+	nsinfo__put(params.nsi);
 	memset(&params, 0, sizeof(params));
 }
 
@@ -554,6 +587,8 @@ __cmd_probe(int argc, const char **argv)
 	OPT_BOOLEAN(0, "cache", &probe_conf.cache, "Manipulate probe cache"),
 	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
 		   "Look for files with symbols relative to this directory"),
+	OPT_CALLBACK(0, "target-ns", NULL, "pid",
+		     "target pid for namespace contexts", opt_set_target_ns),
 	OPT_END()
 	};
 	int ret;
@@ -634,15 +669,15 @@ __cmd_probe(int argc, const char **argv)
 			pr_err_with_code("  Error: Failed to show event list.", ret);
 		return ret;
 	case 'F':
-		ret = show_available_funcs(params.target, params.filter,
-					params.uprobes);
+		ret = show_available_funcs(params.target, params.nsi,
+					   params.filter, params.uprobes);
 		if (ret < 0)
 			pr_err_with_code("  Error: Failed to show functions.", ret);
 		return ret;
 #ifdef HAVE_DWARF_SUPPORT
 	case 'L':
 		ret = show_line_range(&params.line_range, params.target,
-				      params.uprobes);
+				      params.nsi, params.uprobes);
 		if (ret < 0)
 			pr_err_with_code("  Error: Failed to show lines.", ret);
 		return ret;
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index fc5f398779a4..a58e91197729 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -11,6 +11,7 @@
 #include "event.h"
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <limits.h>
 #include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -233,3 +234,15 @@ void nsinfo__mountns_exit(struct nscookie *nc)
 		nc->newns = -1;
 	}
 }
+
+char *nsinfo__realpath(const char *path, struct nsinfo *nsi)
+{
+	char *rpath;
+	struct nscookie nsc;
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	rpath = realpath(path, NULL);
+	nsinfo__mountns_exit(&nsc);
+
+	return rpath;
+}
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index f19aa41119ae..05d82601c9a6 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -49,6 +49,8 @@ void nsinfo__put(struct nsinfo *nsi);
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
 void nsinfo__mountns_exit(struct nscookie *nc);
 
+char *nsinfo__realpath(const char *path, struct nsinfo *nsi);
+
 static inline void __nsinfo__zput(struct nsinfo **nsip)
 {
 	if (nsip) {
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a2670e9d652d..a80895a7e611 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -184,13 +184,19 @@ static struct map *kernel_get_module_map(const char *module)
 	return NULL;
 }
 
-struct map *get_target_map(const char *target, bool user)
+struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 {
 	/* Init maps of given executable or kernel */
-	if (user)
-		return dso__new_map(target);
-	else
+	if (user) {
+		struct map *map;
+
+		map = dso__new_map(target);
+		if (map && map->dso)
+			map->dso->nsinfo = nsinfo__get(nsi);
+		return map;
+	} else {
 		return kernel_get_module_map(target);
+	}
 }
 
 static int convert_exec_to_group(const char *exec, char **result)
@@ -366,7 +372,8 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 static int find_alternative_probe_point(struct debuginfo *dinfo,
 					struct perf_probe_point *pp,
 					struct perf_probe_point *result,
-					const char *target, bool uprobes)
+					const char *target, struct nsinfo *nsi,
+					bool uprobes)
 {
 	struct map *map = NULL;
 	struct symbol *sym;
@@ -377,7 +384,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 	if (!pp->function || pp->file)
 		return -ENOTSUP;
 
-	map = get_target_map(target, uprobes);
+	map = get_target_map(target, nsi, uprobes);
 	if (!map)
 		return -EINVAL;
 
@@ -421,8 +428,8 @@ static int get_alternative_probe_event(struct debuginfo *dinfo,
 
 	memcpy(tmp, &pev->point, sizeof(*tmp));
 	memset(&pev->point, 0, sizeof(pev->point));
-	ret = find_alternative_probe_point(dinfo, tmp, &pev->point,
-					   pev->target, pev->uprobes);
+	ret = find_alternative_probe_point(dinfo, tmp, &pev->point, pev->target,
+					   pev->nsi, pev->uprobes);
 	if (ret < 0)
 		memcpy(&pev->point, tmp, sizeof(*tmp));
 
@@ -444,7 +451,7 @@ static int get_alternative_line_range(struct debuginfo *dinfo,
 	if (lr->end != INT_MAX)
 		len = lr->end - lr->start;
 	ret = find_alternative_probe_point(dinfo, &pp, &result,
-					   target, user);
+					   target, NULL, user);
 	if (!ret) {
 		lr->function = result.function;
 		lr->file = result.file;
@@ -457,12 +464,14 @@ static int get_alternative_line_range(struct debuginfo *dinfo,
 }
 
 /* Open new debuginfo of given module */
-static struct debuginfo *open_debuginfo(const char *module, bool silent)
+static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
+					bool silent)
 {
 	const char *path = module;
 	char reason[STRERR_BUFSIZE];
 	struct debuginfo *ret = NULL;
 	struct dso *dso = NULL;
+	struct nscookie nsc;
 	int err;
 
 	if (!module || !strchr(module, '/')) {
@@ -480,6 +489,7 @@ static struct debuginfo *open_debuginfo(const char *module, bool silent)
 		}
 		path = dso->long_name;
 	}
+	nsinfo__mountns_enter(nsi, &nsc);
 	ret = debuginfo__new(path);
 	if (!ret && !silent) {
 		pr_warning("The %s file has no debug information.\n", path);
@@ -489,6 +499,7 @@ static struct debuginfo *open_debuginfo(const char *module, bool silent)
 			pr_warning("Rebuild with -g, ");
 		pr_warning("or install an appropriate debuginfo package.\n");
 	}
+	nsinfo__mountns_exit(&nsc);
 	return ret;
 }
 
@@ -516,7 +527,7 @@ static struct debuginfo *debuginfo_cache__open(const char *module, bool silent)
 		goto out;
 	}
 
-	debuginfo_cache = open_debuginfo(module, silent);
+	debuginfo_cache = open_debuginfo(module, NULL, silent);
 	if (!debuginfo_cache)
 		zfree(&debuginfo_cache_path);
 out:
@@ -531,14 +542,18 @@ static void debuginfo_cache__exit(void)
 }
 
 
-static int get_text_start_address(const char *exec, unsigned long *address)
+static int get_text_start_address(const char *exec, unsigned long *address,
+				  struct nsinfo *nsi)
 {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	GElf_Shdr shdr;
 	int fd, ret = -ENOENT;
+	struct nscookie nsc;
 
+	nsinfo__mountns_enter(nsi, &nsc);
 	fd = open(exec, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
 	if (fd < 0)
 		return -errno;
 
@@ -582,7 +597,7 @@ static int find_perf_probe_point_from_dwarf(struct probe_trace_point *tp,
 			ret = -EINVAL;
 			goto error;
 		}
-		ret = get_text_start_address(tp->module, &stext);
+		ret = get_text_start_address(tp->module, &stext, NULL);
 		if (ret < 0)
 			goto error;
 		addr += stext;
@@ -659,7 +674,7 @@ post_process_offline_probe_trace_events(struct probe_trace_event *tevs,
 
 	/* Prepare a map for offline binary */
 	map = dso__new_map(pathname);
-	if (!map || get_text_start_address(pathname, &stext) < 0) {
+	if (!map || get_text_start_address(pathname, &stext, NULL) < 0) {
 		pr_warning("Failed to get ELF symbols for %s\n", pathname);
 		return -EINVAL;
 	}
@@ -676,7 +691,8 @@ post_process_offline_probe_trace_events(struct probe_trace_event *tevs,
 }
 
 static int add_exec_to_probe_trace_events(struct probe_trace_event *tevs,
-					  int ntevs, const char *exec)
+					  int ntevs, const char *exec,
+					  struct nsinfo *nsi)
 {
 	int i, ret = 0;
 	unsigned long stext = 0;
@@ -684,7 +700,7 @@ static int add_exec_to_probe_trace_events(struct probe_trace_event *tevs,
 	if (!exec)
 		return 0;
 
-	ret = get_text_start_address(exec, &stext);
+	ret = get_text_start_address(exec, &stext, nsi);
 	if (ret < 0)
 		return ret;
 
@@ -715,7 +731,7 @@ post_process_module_probe_trace_events(struct probe_trace_event *tevs,
 	if (!module)
 		return 0;
 
-	map = get_target_map(module, false);
+	map = get_target_map(module, NULL, false);
 	if (!map || debuginfo__get_text_offset(dinfo, &text_offs, true) < 0) {
 		pr_warning("Failed to get ELF symbols for %s\n", module);
 		return -EINVAL;
@@ -802,7 +818,8 @@ static int post_process_probe_trace_events(struct perf_probe_event *pev,
 	int ret;
 
 	if (uprobe)
-		ret = add_exec_to_probe_trace_events(tevs, ntevs, module);
+		ret = add_exec_to_probe_trace_events(tevs, ntevs, module,
+						     pev->nsi);
 	else if (module)
 		/* Currently ref_reloc_sym based probe is not for drivers */
 		ret = post_process_module_probe_trace_events(tevs, ntevs,
@@ -825,7 +842,7 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 	struct debuginfo *dinfo;
 	int ntevs, ret = 0;
 
-	dinfo = open_debuginfo(pev->target, !need_dwarf);
+	dinfo = open_debuginfo(pev->target, pev->nsi, !need_dwarf);
 	if (!dinfo) {
 		if (need_dwarf)
 			return -ENOENT;
@@ -945,7 +962,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	char sbuf[STRERR_BUFSIZE];
 
 	/* Search a line range */
-	dinfo = open_debuginfo(module, false);
+	dinfo = open_debuginfo(module, NULL, false);
 	if (!dinfo)
 		return -ENOENT;
 
@@ -1021,14 +1038,18 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	return ret;
 }
 
-int show_line_range(struct line_range *lr, const char *module, bool user)
+int show_line_range(struct line_range *lr, const char *module,
+		    struct nsinfo *nsi, bool user)
 {
 	int ret;
+	struct nscookie nsc;
 
 	ret = init_probe_symbol_maps(user);
 	if (ret < 0)
 		return ret;
+	nsinfo__mountns_enter(nsi, &nsc);
 	ret = __show_line_range(lr, module, user);
+	nsinfo__mountns_exit(&nsc);
 	exit_probe_symbol_maps();
 
 	return ret;
@@ -1111,7 +1132,7 @@ int show_available_vars(struct perf_probe_event *pevs, int npevs,
 	if (ret < 0)
 		return ret;
 
-	dinfo = open_debuginfo(pevs->target, false);
+	dinfo = open_debuginfo(pevs->target, pevs->nsi, false);
 	if (!dinfo) {
 		ret = -ENOENT;
 		goto out;
@@ -1155,6 +1176,7 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 
 int show_line_range(struct line_range *lr __maybe_unused,
 		    const char *module __maybe_unused,
+		    struct nsinfo *nsi __maybe_unused,
 		    bool user __maybe_unused)
 {
 	pr_warning("Debuginfo-analysis is not supported.\n");
@@ -2703,6 +2725,7 @@ static int __add_probe_trace_events(struct perf_probe_event *pev,
 	struct probe_trace_event *tev = NULL;
 	struct probe_cache *cache = NULL;
 	struct strlist *namelist[2] = {NULL, NULL};
+	struct nscookie nsc;
 
 	up = pev->uprobes ? 1 : 0;
 	fd[up] = __open_probe_file_and_namelist(up, &namelist[up]);
@@ -2729,7 +2752,9 @@ static int __add_probe_trace_events(struct perf_probe_event *pev,
 		if (ret < 0)
 			break;
 
+		nsinfo__mountns_enter(pev->nsi, &nsc);
 		ret = probe_file__add_event(fd[up], tev);
+		nsinfo__mountns_exit(&nsc);
 		if (ret < 0)
 			break;
 
@@ -2805,7 +2830,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	int ret, i, j, skipped = 0;
 	char *mod_name;
 
-	map = get_target_map(pev->target, pev->uprobes);
+	map = get_target_map(pev->target, pev->nsi, pev->uprobes);
 	if (!map) {
 		ret = -EINVAL;
 		goto out;
@@ -3345,13 +3370,16 @@ int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 {
 	int i, j;
+	struct perf_probe_event *pev;
 
 	/* Loop 3: cleanup and free trace events  */
 	for (i = 0; i < npevs; i++) {
+		pev = &pevs[i];
 		for (j = 0; j < pevs[i].ntevs; j++)
 			clear_probe_trace_event(&pevs[i].tevs[j]);
 		zfree(&pevs[i].tevs);
 		pevs[i].ntevs = 0;
+		nsinfo__zput(pev->nsi);
 		clear_perf_probe_event(&pevs[i]);
 	}
 }
@@ -3409,8 +3437,8 @@ int del_perf_probe_events(struct strfilter *filter)
 	return ret;
 }
 
-int show_available_funcs(const char *target, struct strfilter *_filter,
-					bool user)
+int show_available_funcs(const char *target, struct nsinfo *nsi,
+			 struct strfilter *_filter, bool user)
 {
         struct rb_node *nd;
 	struct map *map;
@@ -3421,7 +3449,7 @@ int show_available_funcs(const char *target, struct strfilter *_filter,
 		return ret;
 
 	/* Get a symbol map */
-	map = get_target_map(target, user);
+	map = get_target_map(target, nsi, user);
 	if (!map) {
 		pr_err("Failed to get a map for %s\n", (target) ? : "kernel");
 		return -EINVAL;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 5812947418dd..078681d12168 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -4,6 +4,7 @@
 #include <linux/compiler.h>
 #include <stdbool.h>
 #include "intlist.h"
+#include "namespaces.h"
 
 /* Probe related configurations */
 struct probe_conf {
@@ -92,6 +93,7 @@ struct perf_probe_event {
 	struct perf_probe_arg	*args;	/* Arguments */
 	struct probe_trace_event *tevs;
 	int			ntevs;
+	struct nsinfo		*nsi;	/* Target namespace */
 };
 
 /* Line range */
@@ -163,10 +165,12 @@ int show_perf_probe_event(const char *group, const char *event,
 			  struct perf_probe_event *pev,
 			  const char *module, bool use_stdout);
 int show_perf_probe_events(struct strfilter *filter);
-int show_line_range(struct line_range *lr, const char *module, bool user);
+int show_line_range(struct line_range *lr, const char *module,
+		    struct nsinfo *nsi, bool user);
 int show_available_vars(struct perf_probe_event *pevs, int npevs,
 			struct strfilter *filter);
-int show_available_funcs(const char *module, struct strfilter *filter, bool user);
+int show_available_funcs(const char *module, struct nsinfo *nsi,
+			 struct strfilter *filter, bool user);
 void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 			     struct probe_trace_event *tev, struct map *map,
 			     struct symbol *sym);
@@ -180,7 +184,7 @@ int e_snprintf(char *str, size_t size, const char *format, ...) __printf(3, 4);
 int copy_to_probe_trace_arg(struct probe_trace_arg *tvar,
 			    struct perf_probe_arg *pvar);
 
-struct map *get_target_map(const char *target, bool user);
+struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user);
 
 void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 					   int ntevs);
-- 
2.9.4
