From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/83] perf annotate: Add evsel into struct annotation_line_args
Date: Fri, 17 Nov 2017 17:14:49 -0300
Message-ID: <20171117201601.24110-12-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935667AbdKQUQy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:54 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add evsel into struct annotate_args to reduce the number of arguments
that need to travel all the way to line allocation.

This change also allow us to move the arch name initialization under
symbol__annotate function.

Link: http://lkml.kernel.org/n/tip-a9ok53rrgt1s5e8uglyvy6qt@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/ui/gtk/annotate.c      |  3 +--
 tools/perf/util/annotate.c        | 11 ++++++++---
 tools/perf/util/annotate.h        |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d77994c1cba9..3b72519c085f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1120,7 +1120,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		  (nr_pcnt - 1);
 	}
 
-	err = symbol__annotate(sym, map, perf_evsel__env_arch(evsel),
+	err = symbol__annotate(sym, map, evsel,
 			       sizeof_bdl, &browser.arch,
 			       perf_evsel__env_cpuid(evsel));
 	if (err) {
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index b498f1a92bb1..5e0a56df0b4c 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,8 +169,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(sym, map, perf_evsel__env_arch(evsel),
-			       0, NULL, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, NULL, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 681c9c4ce9f9..75f54eab22c8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -882,6 +882,7 @@ struct annotate_args {
 	size_t			 privsize;
 	struct arch		*arch;
 	struct map		*map;
+	struct perf_evsel	*evsel;
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
@@ -1570,16 +1571,21 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 }
 
 int symbol__annotate(struct symbol *sym, struct map *map,
-		     const char *arch_name, size_t privsize,
+		     struct perf_evsel *evsel, size_t privsize,
 		     struct arch **parch, char *cpuid)
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.map		= map,
+		.evsel		= evsel,
 	};
+	const char *arch_name = NULL;
 	struct arch *arch;
 	int err;
 
+	if (evsel)
+		arch_name = perf_evsel__env_arch(evsel);
+
 	arch_name = annotate__norm_arch(arch_name);
 	if (!arch_name)
 		return -1;
@@ -1975,8 +1981,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct rb_root source_line = RB_ROOT;
 	u64 len;
 
-	if (symbol__annotate(sym, map, perf_evsel__env_arch(evsel),
-			     0, NULL, NULL) < 0)
+	if (symbol__annotate(sym, map, evsel, 0, NULL, NULL) < 0)
 		return -1;
 
 	len = symbol__size(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e577f9d13a58..baf34032504a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -174,7 +174,7 @@ int symbol__alloc_hist(struct symbol *sym);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
-		     const char *arch_name, size_t privsize,
+		     struct perf_evsel *evsel, size_t privsize,
 		     struct arch **parch, char *cpuid);
 
 enum symbol_disassemble_errno {
-- 
2.13.6
