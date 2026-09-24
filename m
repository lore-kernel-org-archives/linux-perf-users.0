Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66543DEAC;
	Thu, 24 Sep 2026 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285312; cv=none; b=asGjUXBMB1TIw8uzvBX/T2thaR4K3TTH6QgAqCI6FQb4zYfh2U5iR2Uc9jsB9aSNjvFPdBCI4XfWE9+1Z0JiocrLr/n7zo+g0esZZ5gqe9nauAgyZh8gFT15dT2G8qYcBIKL8Dus9ejK2BMFoWz3jTSuNbjcur1uJadPdp7aDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285312; c=relaxed/simple;
	bh=+2eJD629q1ARCdDWrqn+5/1zUYg/1c0PszkBmOjScFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuFq6aU6But2ibG2tsqDSdpvu8LKlg0XpgoKyTpcEDx/l1O/+HNzlVfPtPOMIE4iYcSlyyy/QNFFfCC/xmNvg9HPuftMIqaFZog4cLyMm6II3OAOf6x4l7k3bXp/auMZho8a9/Kkv9M9iW3qGwqExWyhs1JH92NT0rXCLTK7PtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKKV2PnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKKV2PnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45361F00893;
	Thu, 24 Sep 2026 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285306;
	bh=53rhS/RoSwM54PPbARszq9J4rk8Cbol7osj2y9wayrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKKV2PnQWX7Sd6O6fIBjTDiFfw9SWZZtmQV19WlNgkO6cgjRkjiP5clsx2zY2sslY
	 dZB2aWMs8KamDxugyAiMVhi/xCieNSHI3DYfgTdD469irZZWBHYRyY/A9NzVDKWcmq
	 F6PMkNV9Qfqb+oZktmVYtZ4yZLyuSuFZiunzgS0hwtbr8O0Ri7+8zGrZVpz73LXof+
	 BXyqUr6EhG18g33ka9RnlFq98hWrIRptlg/9VQ6mqZx5KfteSe+bkXCg+RDmFrnabq
	 Lz/LRcTEqXr/e0rgskebDnMTJnVrXoS5xtpC4Y/9iVqN5xBY0I4Fb/6gDuGE9IVGoh
	 meky9l4Euk+4Q==
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
Subject: [PATCH v4 3/6] perf annotate-data: Resolve type DIEs in the debug file they came from
Date: Thu, 24 Sep 2026 23:28:06 +0200
Message-ID: <20260924212809.1733663-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924212809.1733663-1-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

'perf report -s type' hangs burning CPU on the dwz compressed debug
info of libz.so.1 (zlib-ng): die_collect_vars() saves the
dwarf_dieoffset() of the type DIE, which is relative to the file it
lives in - the dwz alt file for the types shared by more than one CU -
and update_var_state() resolves that offset in the main debug file,
parsing whatever is at it, here a typedef whose DW_AT_type refers to
itself.

Record whether the type DIE came from the alt file and resolve the
offset with die_get_type_die() in that file, with no fallback.

Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info")
Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global variable types")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-data.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e9b58a3d587be45b..bc9698abc6a9e055 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -739,6 +739,8 @@ struct global_var_entry {
 	u64 start;
 	u64 end;
 	u64 die_offset;
+	int die_tag;
+	bool from_alt;	/* die_offset is relative to the alt (dwz) file */
 };
 
 static int global_var_cmp(const void *_key, const struct rb_node *node)
@@ -776,7 +778,7 @@ static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64
 }
 
 static bool global_var__add(struct data_loc_info *dloc, u64 addr,
-			    const char *name, Dwarf_Die *type_die)
+			    const char *name, Dwarf_Die *type_die, bool from_alt)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	struct global_var_entry *gvar;
@@ -798,6 +800,8 @@ static bool global_var__add(struct data_loc_info *dloc, u64 addr,
 	gvar->start = addr;
 	gvar->end = addr + size;
 	gvar->die_offset = dwarf_dieoffset(type_die);
+	gvar->die_tag = dwarf_tag(type_die);
+	gvar->from_alt = from_alt;
 
 	rb_add(&gvar->node, dso__global_vars(dso), global_var_less);
 	return true;
@@ -872,12 +876,14 @@ static void global_var__collect(struct data_loc_info *dloc)
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
@@ -902,7 +908,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 	gvar = global_var__find(dloc, var_addr);
 	if (gvar) {
-		if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_die))
+		if (!die_get_type_die(dloc->di->dbg, gvar->die_offset,
+				      gvar->die_tag, gvar->from_alt, type_die))
 			return false;
 
 		*var_offset = var_addr - gvar->start;
@@ -932,7 +939,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 ok:
 	/* The address should point to the start of the variable */
-	global_var__add(dloc, var_addr - *var_offset, var_name, type_die);
+	global_var__add(dloc, var_addr - *var_offset, var_name, type_die,
+			!die_same_file(cu_die, type_die));
 	return true;
 }
 
@@ -987,7 +995,8 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
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

