Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1A17BA7;
	Thu,  4 Jul 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058294; cv=none; b=pXbEUzlv9jaOtHjsvlLTVFGyFsJyuycBPj2HJCukXB1/j+laH4ovls+/E8ggpvBH7hik+XQ+uhEesGtHuySaOSCL2UtKjtq8SBF068VKT+H5DNR0g1RsMTtGMZvL2M6rrfxla1nYildw+Qc1nSEe/b9Tul7TfTBD71Hc5gzi4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058294; c=relaxed/simple;
	bh=9jF6F3MMNeVOPesJEW+yzmMWdqItusb8YjWwWgBcPss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uz0Q2taoTb33ZN9wo93MifE7+kptVviqZipsAkqXprqIx+WysJyOSAbyvuKg7B/AuwbE4zVJL+U1Sc5SzLPLb9jBtYsuK3QHAFHMPS/wCg35zBw57NPmIe8xojh85bpS88MYwDNCGYojTraoV4rpk2JFFVQhlLG2ubNhYdktjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBxb/Rvq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBxb/Rvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB9AC2BD10;
	Thu,  4 Jul 2024 01:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720058293;
	bh=9jF6F3MMNeVOPesJEW+yzmMWdqItusb8YjWwWgBcPss=;
	h=From:To:Cc:Subject:Date:From;
	b=jBxb/Rvq6sWLA18P1lrzAW64f6aslM/crrOfE4dFhYAawZctCYncugVzrujGoNJZs
	 hAuk6Lvf9R7W3v5tR/gt/kGzVo/aUv8QPzu9c1ivFl4VZIPMkmjfwN9tLzk+eQkeCR
	 B6pmeewBuQUNldXFC1jtL5ua0mKA9+RPJ3XkxtIsZE/36qZoXknOi8E34CkBIT6E6u
	 ZIFZVDTaRlj99KY2Rw9o+GoLv6mYCJjM35Wi5sCq45CxaSDxBMi3KocttorFsTAvsV
	 MnyionQGEb4gxn7g0Z/mG1H8/ngJYG3s3uPn5l0FxFkzYZwuOpBLOSx/AcdupdHu82
	 oqNNGpm6Ei0cQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH] perf annotate: Cache debuginfo for data type profiling
Date: Wed,  3 Jul 2024 18:58:12 -0700
Message-ID: <20240704015812.2119457-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In find_data_type(), it creates and deletes a debug info whenver it
tries to find data type for a sample.  This is inefficient and it most
likely accesses the same binary again and again.

Let's add a single entry cache the debug info structure for the last DSO.
Depending on sample data, it usually gives me 2~3x (and sometimes more)
speed ups.

Note that this will introduce a little difference in the output due to
the order of checking stack operations.  It used to check the stack ops
before checking the availability of debug info but I moved it after the
symbol check.  So it'll report stack operations in DSOs without debug
info as unknown.  But I think it's ok and better to have the checking
near the caching logic.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 15 ++-------------
 tools/perf/util/annotate-data.h |  2 +-
 tools/perf/util/annotate.c      | 29 +++++++++++++++++++++++++++++
 tools/perf/util/annotate.h      |  2 ++
 tools/perf/util/session.c       |  2 ++
 5 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 965da6c0b542..24c03475b3f2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1764,16 +1764,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
  */
 struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
-	struct annotated_data_type *result = NULL;
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
 
-	dloc->di = debuginfo__new(dso__long_name(dso));
-	if (dloc->di == NULL) {
-		pr_debug_dtp("cannot get the debug info\n");
-		return NULL;
-	}
-
 	/*
 	 * The type offset is the same as instruction offset by default.
 	 * But when finding a global variable, the offset won't be valid.
@@ -1783,13 +1776,9 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	dloc->fbreg = -1;
 
 	if (find_data_type_die(dloc, &type_die) < 0)
-		goto out;
-
-	result = dso__findnew_data_type(dso, &type_die);
+		return NULL;
 
-out:
-	debuginfo__delete(dloc->di);
-	return result;
+	return dso__findnew_data_type(dso, &type_die);
 }
 
 static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_entries)
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 0a57d9f5ee78..40c9377fa1a5 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -100,9 +100,9 @@ struct data_loc_info {
 	u64 var_addr;
 	u8 cpumode;
 	struct annotated_op_loc *op;
+	struct debuginfo *di;
 
 	/* These are used internally */
-	struct debuginfo *di;
 	int fbreg;
 	bool fb_cfa;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1451caf25e77..821e4b2c3bcd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -25,6 +25,7 @@
 #include "srcline.h"
 #include "units.h"
 #include "debug.h"
+#include "debuginfo.h"
 #include "annotate.h"
 #include "annotate-data.h"
 #include "evsel.h"
@@ -2313,6 +2314,20 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 	return map__rip_2objdump(ms->map, addr);
 }
 
+static struct debuginfo_cache {
+	struct dso *dso;
+	struct debuginfo *dbg;
+} di_cache;
+
+void debuginfo_cache__delete(void)
+{
+	dso__put(di_cache.dso);
+	di_cache.dso = NULL;
+
+	debuginfo__delete(di_cache.dbg);
+	di_cache.dbg = NULL;
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -2347,6 +2362,19 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
+	if (map__dso(ms->map) != di_cache.dso) {
+		dso__put(di_cache.dso);
+		di_cache.dso = dso__get(map__dso(ms->map));
+
+		debuginfo__delete(di_cache.dbg);
+		di_cache.dbg = debuginfo__new(dso__long_name(di_cache.dso));
+	}
+
+	if (di_cache.dbg == NULL) {
+		ann_data_stat.no_dbginfo++;
+		return NULL;
+	}
+
 	/* Make sure it has the disasm of the function */
 	if (symbol__annotate(ms, evsel, &arch) < 0) {
 		ann_data_stat.no_insn++;
@@ -2391,6 +2419,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			.ip = ms->sym->start + dl->al.offset,
 			.cpumode = he->cpumode,
 			.op = op_loc,
+			.di = di_cache.dbg,
 		};
 
 		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d5c821c22f79..0686af637ed9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -540,4 +540,6 @@ struct annotated_basic_block {
 int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
 			      struct list_head *head);
 
+void debuginfo_cache__delete(void);
+
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5596bed1b8c8..f9072e003367 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -36,6 +36,7 @@
 #include "util.h"
 #include "arch/common.h"
 #include "units.h"
+#include "annotate.h"
 #include <internal/lib.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
@@ -304,6 +305,7 @@ void perf_session__delete(struct perf_session *session)
 		return;
 	auxtrace__free(session);
 	auxtrace_index__free(&session->auxtrace_index);
+	debuginfo_cache__delete();
 	perf_session__destroy_kernel_maps(session);
 	perf_decomp__release_events(session->decomp_data.decomp);
 	perf_env__exit(&session->header.env);
-- 
2.45.2.803.g4e1b14247a-goog

