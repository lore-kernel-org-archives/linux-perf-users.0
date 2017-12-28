From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/35] perf annotate: Get the cpuid from evsel->evlist->env in symbol__annotate()
Date: Thu, 28 Dec 2017 11:30:10 -0300
Message-ID: <20171228143027.30547-19-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce its function signature, since we get this from 'evsel' which
is already one of its arguments.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-070eap7t6uicg9c3w086xy2z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c          | 2 +-
 tools/perf/ui/browsers/annotate.c | 4 +---
 tools/perf/ui/gtk/annotate.c      | 2 +-
 tools/perf/util/annotate.c        | 7 ++++---
 tools/perf/util/annotate.h        | 2 +-
 tools/perf/util/evsel.c           | 6 +++---
 tools/perf/util/evsel.h           | 2 +-
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 540461f5e345..c6ccda52117d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -138,7 +138,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, NULL);
 	if (err == 0) {
 out_assign:
 		top->sym_filter_entry = he;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 03b7363a49c9..286427975112 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1116,9 +1116,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
 
-	err = symbol__annotate(sym, map, evsel,
-			       sizeof(struct browser_line), &browser.arch,
-			       perf_evsel__env_cpuid(evsel));
+	err = symbol__annotate(sym, map, evsel, sizeof(struct browser_line), &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index cdb5ecf91666..aeeaf15029f0 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,7 +169,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index facad1e279a8..bc34b28373f4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1622,13 +1622,14 @@ void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
-		     struct arch **parch, char *cpuid)
+		     struct arch **parch)
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.map		= map,
 		.evsel		= evsel,
 	};
+	struct perf_env *env = perf_evsel__env(evsel);
 	const char *arch_name = NULL;
 	struct arch *arch;
 	int err;
@@ -1648,7 +1649,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		*parch = arch;
 
 	if (arch->init) {
-		err = arch->init(arch, cpuid);
+		err = arch->init(arch, env ? env->cpuid : NULL);
 		if (err) {
 			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
 			return err;
@@ -1999,7 +2000,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(sym, map, evsel, 0, NULL, NULL) < 0)
+	if (symbol__annotate(sym, map, evsel, 0, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6d7289e88fa3..ce427445671f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -179,7 +179,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
-		     struct arch **parch, char *cpuid);
+		     struct arch **parch);
 
 enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__SUCCESS		= 0,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 95853c51c0ca..541897049c6c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2842,9 +2842,9 @@ char *perf_evsel__env_arch(struct perf_evsel *evsel)
 	return NULL;
 }
 
-char *perf_evsel__env_cpuid(struct perf_evsel *evsel)
+struct perf_env *perf_evsel__env(struct perf_evsel *evsel)
 {
-	if (evsel && evsel->evlist && evsel->evlist->env)
-		return evsel->evlist->env->cpuid;
+	if (evsel && evsel->evlist)
+		return evsel->evlist->env;
 	return NULL;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c3663a70c9b9..0e961ce60a9c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -447,6 +447,6 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv);
 
 char *perf_evsel__env_arch(struct perf_evsel *evsel);
-char *perf_evsel__env_cpuid(struct perf_evsel *evsel);
+struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
 
 #endif /* __PERF_EVSEL_H */
-- 
2.13.6
