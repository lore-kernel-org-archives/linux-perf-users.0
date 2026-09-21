Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51E4A5C3E;
	Mon, 21 Sep 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009327; cv=none; b=SJLRJIObr94PZwN9FIupUHleI8whBUlRPt2UIPrfHkLeopLb4t+FT5yJvbOn5NrLfmpWasp77OkPGwCBBJDoKg00hUCUPX0Pjox+yW8jKa+UfTNEu069HJl5k6eWhxD6JE3QPFI07fJeB//k7immyuNREcnJCh2vdvgSVMgcMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009327; c=relaxed/simple;
	bh=jSIo2cQH4eRJsgYm7AwASGoLuduUQ3LI13aOXJClEto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gbz/bEn/j//hQe8gwOBgfKPgNdj8JZyXO5E2goonu+Nyq6fsRHAhKk0VTEplsBWSuzL+UUm+rQ5G0Pb+SZasnpBr+VHakbx0ZA/ei9cFIGuSNk51oCshGzwX9EVjiq/h8eGugOJojREKwn4ZVCS+osoO31VKC6jPHI6H9rrXRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkz+TA8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkz+TA8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC181F000FF;
	Mon, 21 Sep 2026 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009324;
	bh=fveDyfm3Nkcs871mzBLgTxASv86CqYPhvvnqx/vjk38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkz+TA8daN3rqUu/F1DtGrTeDlmhDbUoljvPbPkKjz7NKQ3f6N3yFgHSaZfBix7dH
	 8oZbh8tavG4AbTrD06tE5JkKNmkPjok1OGiTatUEt1tG7kSCqIcoCvjHnu6tHeONc4
	 sRpgviUs6xIICEaUN5MpuC7kNQtYUX3dmRZULvUhStlGu+Orpb2U/wY9SK9JKI+yAa
	 oLjLFowmcIcpwUGGMRubY1S8YfGUK1flj9U6AeOETdHjGjxKWikSNQgGHPPYuKagO/
	 xxiR6UetwXldl9GqIaa/mkt5Dl0mLboNHfz+14C/583u4GOFnvXtbKDRpIVxBjYcgZ
	 mOPqtUwcnuUrA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/7] perf dwarf-aux: Add die_same_file() and die_get_type_die()
Date: Mon, 21 Sep 2026 18:48:08 +0200
Message-ID: <20260921164813.6727-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260921164813.6727-1-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dwarf_dieoffset() is relative to the file the DIE is in, so an offset
saved by die_collect_vars()/die_collect_global_vars() is only
meaningful in that file: add die_same_file(), comparing the Dwarf each
DIE's CU belongs to, to record which file that is, and
die_get_type_die() to resolve the offset in it, with the saved tag as a
sanity check.  Resolving the offset in the main file instead parses
whatever is at it when it came from the dwz common file.

dwarf_cu_getdwarf() is new in elfutils 0.160, so the libdw feature test
probes for it and Makefile.config says 0.160.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-libdw.c | 13 ++++++-
 tools/perf/Makefile.config       |  2 +-
 tools/perf/util/dwarf-aux.c      | 62 ++++++++++++++++++++++++++++++--
 tools/perf/util/dwarf-aux.h      | 17 +++++++++
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index aabd63ca76b4d7e6..0ebe7bb4adf9d0bc 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -49,8 +49,19 @@ int test_elfutils(void)
 	return 0;
 }
 
+/*
+ * dwarf_cu_getdwarf() needs elfutils 0.160: take its address only, so
+ * that older versions fail the probe instead of the link.
+ */
+int test_libdw_cu_getdwarf(void)
+{
+	void *sym = (void *)dwarf_cu_getdwarf;
+
+	return sym == NULL;
+}
+
 int main(void)
 {
 	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations() +
-	       test_libdw_getcfi() + test_elfutils();
+	       test_libdw_getcfi() + test_libdw_cu_getdwarf() + test_elfutils();
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4ee7393a39f91d85..0585d71e3182c6dd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -470,7 +470,7 @@ else
   else
     ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
-        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.157, disables dwarf support. Please install new elfutils-devel/libdw-dev)
+        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.160, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
       endif
     endif # Dwarf support
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b5ffeea54446408d..de14d18a9d2f87d8 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1680,6 +1680,16 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
 	return result;
 }
 
+/*
+ * Whether two DIEs live in the same debug file, i.e. whether their
+ * offsets have to be resolved in the same file: dwarf_dieoffset() is
+ * relative to the file the DIE is in.
+ */
+bool die_same_file(Dwarf_Die *die_a, Dwarf_Die *die_b)
+{
+	return dwarf_cu_getdwarf(die_a->cu) == dwarf_cu_getdwarf(die_b->cu);
+}
+
 static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 {
 	struct die_var_type **var_types = arg;
@@ -1724,6 +1734,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 			vt->is_reg_var_addr = true;
 
 		vt->die_off = dwarf_dieoffset(&type_die);
+		vt->die_tag = dwarf_tag(&type_die);
+		vt->from_alt = !die_same_file(die_mem, &type_die);
 		vt->addr = start;
 		vt->end = end;
 		vt->has_range = (end != 0 || start != 0);
@@ -1743,7 +1755,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
  *
  * Save all variables and parameters in the @sc_die and save them to @var_types.
  * The @var_types is a singly-linked list containing type and location info.
- * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
+ * Actual type can be retrieved using die_get_type_die() with 'die_off',
+ * 'die_tag' and 'from_alt' later.
  *
  * Callers should free @var_types.
  */
@@ -1789,6 +1802,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_END;
 
 	vt->die_off = dwarf_dieoffset(&type_die);
+	vt->die_tag = dwarf_tag(&type_die);
+	vt->from_alt = !die_same_file(die_mem, &type_die);
 	vt->addr = ops->number;
 	vt->end = 0;
 	vt->has_range = false;
@@ -1800,6 +1815,48 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	return DIE_FIND_CB_SIBLING;
 }
 
+/**
+ * die_get_type_die - Get a type DIE saved by die_collect_vars()
+ * @dbg: the main debug info
+ * @die_off: offset of the type DIE, from dwarf_dieoffset()
+ * @die_tag: tag that DIE had when the offset was saved
+ * @from_alt: whether the type DIE is in the dwz alt file
+ * @die_mem: where to store the resulting DIE
+ *
+ * Resolve @die_off in the file it was recorded as belonging to: the
+ * offset is only meaningful there, and there is deliberately no
+ * fallback, as resolving an alt file offset in the main file parses
+ * whatever is at it.  @die_tag is a sanity check.
+ */
+Dwarf_Die *die_get_type_die(Dwarf *dbg, u64 die_off, int die_tag, bool from_alt,
+			    Dwarf_Die *die_mem)
+{
+	Dwarf *target = dbg;
+	Dwarf_Die die;
+
+	if (from_alt) {
+		/*
+		 * No fallback to the main file: resolving an alt file offset in it
+		 * does not fail, it parses whatever is there as a DIE.
+		 */
+		target = dwarf_getalt(dbg);
+		if (target == NULL) {
+			pr_debug("DWARF: no alt (dwz) debug file to resolve the type DIE at offset 0x%lx in\n",
+				 (unsigned long)die_off);
+			return NULL;
+		}
+	}
+
+	if (dwarf_offdie(target, die_off, &die) && dwarf_tag(&die) == die_tag) {
+		*die_mem = die;
+		return die_mem;
+	}
+
+	pr_debug("DWARF: no DIE with tag %d at offset 0x%lx in the %s debug file\n",
+		 die_tag, (unsigned long)die_off, from_alt ? "alt" : "main");
+	return NULL;
+}
+
 /**
  * die_collect_global_vars - Save all global variables
  * @cu_die: a CU DIE
@@ -1807,7 +1864,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
  *
  * Save all global variables in the @cu_die and save them to @var_types.
  * The @var_types is a singly-linked list containing type and location info.
- * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
+ * Actual type can be retrieved using die_get_type_die() with 'die_off',
+ * 'die_tag' and 'from_alt' later.
  *
  * Callers should free @var_types.
  */
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 161f0bf980b6ee6a..299ffddab0358baa 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -152,6 +152,8 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
 struct die_var_type {
 	struct die_var_type *next;
 	u64 die_off;
+	int die_tag;
+	bool from_alt;	/* die_off is relative to the alt (dwz) file */
 	u64 addr;
 	u64 end;        /* end address of location range */
 	int reg;
@@ -183,6 +185,21 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
 /* Save all variables and parameters in this scope */
 void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 
+/*
+ * Get the type DIE saved by die_collect_vars()/die_collect_global_vars().
+ *
+ * Those save the dwarf_dieoffset() of the type DIE, which is relative
+ * to the file it lives in, so @from_alt, recorded when the offset was
+ * saved, says which file to resolve it in; @die_tag is a sanity check.
+ * Resolving an alt file offset in the main file parses whatever is at
+ * it, which is what hung 'perf report -s type'.
+ */
+Dwarf_Die *die_get_type_die(Dwarf *dbg, u64 die_off, int die_tag, bool from_alt,
+			    Dwarf_Die *die_mem);
+
+/* Whether two DIEs live in the same debug file */
+bool die_same_file(Dwarf_Die *die_a, Dwarf_Die *die_b);
+
 /* Save all global variables in this CU */
 void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
 
-- 
2.53.0

