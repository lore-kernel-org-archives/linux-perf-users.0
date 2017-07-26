From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/40] perf hists: Pass perf_sample to __symbol__inc_addr_samples()
Date: Wed, 26 Jul 2017 11:17:09 -0300
Message-ID: <20170726141730.30750-20-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

To pave the way to use perf_sample fields in the annotate code, storing
sample->period in sym_hist->addr->period and its sum in
sym_hist->period.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1500500215-16646-1-git-send-email-treeze.taeung@gmail.com
[ split and adjusted from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  2 +-
 tools/perf/builtin-report.c   | 15 ++++++++-------
 tools/perf/builtin-top.c      |  5 +++--
 tools/perf/util/annotate.c    | 18 +++++++++++-------
 tools/perf/util/annotate.h    |  6 ++++--
 5 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5205408e795b..96fe1a88c1e5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -184,7 +184,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	if (he == NULL)
 		return -ENOMEM;
 
-	ret = hist_entry__inc_addr_samples(he, evsel->idx, al->addr);
+	ret = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
 	hists__inc_nr_samples(hists, true);
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index cea25d03f4dd..983b238d5eea 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -115,37 +115,38 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	struct report *rep = arg;
 	struct hist_entry *he = iter->he;
 	struct perf_evsel *evsel = iter->evsel;
+	struct perf_sample *sample = iter->sample;
 	struct mem_info *mi;
 	struct branch_info *bi;
 
 	if (!ui__has_annotation())
 		return 0;
 
-	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
+	hist__account_cycles(sample->branch_stack, al, sample,
 			     rep->nonany_branch_mode);
 
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
-		err = addr_map_symbol__inc_samples(&bi->from, evsel->idx);
+		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
 		if (err)
 			goto out;
 
-		err = addr_map_symbol__inc_samples(&bi->to, evsel->idx);
+		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
 
 	} else if (rep->mem_mode) {
 		mi = he->mem_info;
-		err = addr_map_symbol__inc_samples(&mi->daddr, evsel->idx);
+		err = addr_map_symbol__inc_samples(&mi->daddr, sample, evsel->idx);
 		if (err)
 			goto out;
 
-		err = hist_entry__inc_addr_samples(he, evsel->idx, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
 
 	} else if (symbol_conf.cumulate_callchain) {
 		if (single)
-			err = hist_entry__inc_addr_samples(he, evsel->idx,
+			err = hist_entry__inc_addr_samples(he, sample, evsel->idx,
 							   al->addr);
 	} else {
-		err = hist_entry__inc_addr_samples(he, evsel->idx, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
 	}
 
 out:
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 022486dc67f5..e5a8f249077f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -183,6 +183,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 
 static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
+					struct perf_sample *sample,
 					int counter, u64 ip)
 {
 	struct annotation *notes;
@@ -199,7 +200,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 	if (pthread_mutex_trylock(&notes->lock))
 		return;
 
-	err = hist_entry__inc_addr_samples(he, counter, ip);
+	err = hist_entry__inc_addr_samples(he, sample, counter, ip);
 
 	pthread_mutex_unlock(&notes->lock);
 
@@ -671,7 +672,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, he, evsel->idx, al->addr);
+		perf_top__record_precise_ip(top, he, iter->sample, evsel->idx, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 58c6b63ff049..c2fe16d5e473 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -697,7 +697,8 @@ static int __symbol__account_cycles(struct annotation *notes,
 }
 
 static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				      struct annotation *notes, int evidx, u64 addr)
+				      struct annotation *notes, int evidx, u64 addr,
+				      struct perf_sample *sample __maybe_unused)
 {
 	unsigned offset;
 	struct sym_hist *h;
@@ -738,7 +739,8 @@ static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles
 }
 
 static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				    int evidx, u64 addr)
+				    int evidx, u64 addr,
+				    struct perf_sample *sample)
 {
 	struct annotation *notes;
 
@@ -747,7 +749,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	notes = symbol__get_annotation(sym, false);
 	if (notes == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes, evidx, addr);
+	return __symbol__inc_addr_samples(sym, map, notes, evidx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
@@ -811,14 +813,16 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	return err;
 }
 
-int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, int evidx)
+int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
+				 int evidx)
 {
-	return symbol__inc_addr_samples(ams->sym, ams->map, evidx, ams->al_addr);
+	return symbol__inc_addr_samples(ams->sym, ams->map, evidx, ams->al_addr, sample);
 }
 
-int hist_entry__inc_addr_samples(struct hist_entry *he, int evidx, u64 ip)
+int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
+				 int evidx, u64 ip)
 {
-	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evidx, ip);
+	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evidx, ip, sample);
 }
 
 static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map *map)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e8c246ec53df..720f18195046 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -154,13 +154,15 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
 	return (void *)sym - symbol_conf.priv_size;
 }
 
-int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, int evidx);
+int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
+				 int evidx);
 
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
 				    unsigned cycles);
 
-int hist_entry__inc_addr_samples(struct hist_entry *he, int evidx, u64 addr);
+int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
+				 int evidx, u64 addr);
 
 int symbol__alloc_hist(struct symbol *sym);
 void symbol__annotate_zero_histograms(struct symbol *sym);
-- 
2.9.4
