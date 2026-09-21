Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356A4E01EC;
	Mon, 21 Sep 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009332; cv=none; b=fAMlfR8rNDAFKSeyJzpMT8GE+oAx31vZ1q8e/3HP2TvUkt8PWI+5f1w9fjyQtvHiY0mLBDt98PL5tQVylGidKsLzX8FwChmZGcUYcA2Y3x8XQc2KjQ73Jiucd9kOoSAVjf5ykjnyHHCrYiWlItMfuQuobypwQp+a7ED3b+oi3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009332; c=relaxed/simple;
	bh=jdqlWZ8Uw3eCXfH2zwaSOTBWozGXvQl89lOuEJLWemQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgRgojqDuKsFWqieG88WYmjTOlzpUvI6AtbmsxwxJ1fXEAgq0Caw/rWZgJVqEs4karK90ksWkE3WA8jT+s3+qaaNSd6Q1d8yZqbhW0xUo0FUy3PgVdBpM8fyc1qysQSTvNmyHRV4jbJG9RC9DkODEuLSr79NZVKaZi0OfZL/YvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEgVzHKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEgVzHKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBD21F00893;
	Mon, 21 Sep 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009331;
	bh=RAKzrrpReCOvLem2gwUxjMaJMp10YTpRJYGulbVatRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hEgVzHKeBvEa72484THKMGRLcHZsUlPwLWqOc8qdLOEtd45WV9desXrAjdJY/+7YG
	 HVS5tjjMDQH5K6GHSQUy2yOunv2vsqMmCf49BsT78MTWzMR1DyxkJte7FV33sLvIHM
	 dC0Fm5O1XZXVOwmNEkUOyAFqcrsV7Tiln7V3cqvUgKIv8LmlaWc53L8cbGnUWXS5Z7
	 B4lNW/T7UatEeen1j+q6z3tm+hjZg3IwQAIOJtkLr8vuingodYDgiT3BXeegtPlDe5
	 5fNIiGdoPpPtTepKht8OCB0Xp73emOjNPNlmW7MWq7Vo42b0Q5+EsEohlbuJiY5GLR
	 sU+kUkwrjBGaQ==
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
Subject: [PATCH 3/7] perf annotate-data: Resolve type DIEs in the debug file they came from
Date: Mon, 21 Sep 2026 18:48:09 +0200
Message-ID: <20260921164813.6727-4-acme@kernel.org>
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

'perf report -s type' hangs, burning all of a CPU with no output, when
resolving a hist entry on the dwz compressed debug info of libz.so.1
(zlib-ng): die_collect_vars() saves the dwarf_dieoffset() of the type
DIE, which is relative to the file it lives in - the dwz alt file for
the types shared by more than one CU - and update_var_state() resolves
that offset in the main debug file, where it parses whatever is at that
offset, here a typedef whose DW_AT_type refers to itself, making the
type chase spin forever.

Record whether the type DIE came from the alt file and resolve the
offset with die_get_type_die() in that file, with no fallback:
resolving an alt file offset in the main file is exactly the misparse
above.

Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info")
Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global variable types")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-data.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index aff60a630fd05b01..2ad6d012e069c522 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -645,6 +645,8 @@ struct global_var_entry {
 	u64 start;
 	u64 end;
 	u64 die_offset;
+	int die_tag;
+	bool from_alt;	/* die_offset is relative to the alt (dwz) file */
 };
 
 static int global_var_cmp(const void *_key, const struct rb_node *node)
@@ -682,7 +684,7 @@ static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64
 }
 
 static bool global_var__add(struct data_loc_info *dloc, u64 addr,
-			    const char *name, Dwarf_Die *type_die)
+			    const char *name, Dwarf_Die *type_die, bool from_alt)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	struct global_var_entry *gvar;
@@ -704,6 +706,8 @@ static bool global_var__add(struct data_loc_info *dloc, u64 addr,
 	gvar->start = addr;
 	gvar->end = addr + size;
 	gvar->die_offset = dwarf_dieoffset(type_die);
+	gvar->die_tag = dwarf_tag(type_die);
+	gvar->from_alt = from_alt;
 
 	rb_add(&gvar->node, dso__global_vars(dso), global_var_less);
 	return true;
@@ -778,12 +782,14 @@ static void global_var__collect(struct data_loc_info *dloc)
 			if (pos->reg != -1)
 				continue;
 
-			if (!dwarf_offdie(dwarf, pos->die_off, &type_die))
+			if (!die_get_type_die(dwarf, pos->die_off, pos->die_tag,
+					      pos->from_alt, &type_die))
 				continue;
 
 			get_global_var_info(dloc, pos->addr, &var_name, &var_offset);
 
-			global_var__add(dloc, pos->addr, var_name, &type_die);
+			global_var__add(dloc, pos->addr, var_name, &type_die,
+					pos->from_alt);
 		}
 
 		delete_var_types(var_types);
@@ -808,7 +814,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 	gvar = global_var__find(dloc, var_addr);
 	if (gvar) {
-		if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_die))
+		if (!die_get_type_die(dloc->di->dbg, gvar->die_offset,
+				      gvar->die_tag, gvar->from_alt, type_die))
 			return false;
 
 		*var_offset = var_addr - gvar->start;
@@ -838,7 +845,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 ok:
 	/* The address should point to the start of the variable */
-	global_var__add(dloc, var_addr - *var_offset, var_name, type_die);
+	global_var__add(dloc, var_addr - *var_offset, var_name, type_die,
+			!die_same_file(cu_die, type_die));
 	return true;
 }
 
@@ -893,7 +901,8 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 		}
 		/* Get the type DIE using the offset */
-		if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
+		if (!die_get_type_die(dloc->di->dbg, var->die_off,
+				      var->die_tag, var->from_alt, &mem_die))
 			continue;
 
 		if (var->reg == DWARF_REG_FB || var->reg == fbreg || var->reg == state->stack_reg) {
-- 
2.53.0

