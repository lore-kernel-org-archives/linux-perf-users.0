Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80148155352;
	Wed,  7 Aug 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069915; cv=none; b=iFFOC/OvTXN9eMmzW2mdqIm91Q+yPhauPl96pgAoKuVTYsSDMWxHuRiAdlqzLiB5hQR6M1QIYVfLgoVW3uqtEoU/jMFH6f9ODkJYUNcfcS6eHn14qIHemRE4U8MvNcfiG3VKrHGW7p1w7e42UNpHcDK+1AdfrvXpLFjjH99Gwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069915; c=relaxed/simple;
	bh=xxDFnP+QPMwGRiH/cGQuQ2IEzs+X53WX5tDES7h35go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr+ftYsn9+pVZWy3+CkHan8HoEqgEffujoREp+cizsXoXTHhnXG9RHLg4tDgsegbyamSgwgebKE9hwD9ayDz3VEjSB3fW1R8hO4Hb86+hcqC51GmSowsK/y8y5u3cY41fOzJ7ideUmgbwHA7MXDvWsiQeodb7RstdOMHrF/1XS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X11GTqE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X11GTqE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9FAC32781;
	Wed,  7 Aug 2024 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723069915;
	bh=xxDFnP+QPMwGRiH/cGQuQ2IEzs+X53WX5tDES7h35go=;
	h=From:To:Cc:Subject:Date:From;
	b=X11GTqE2/O6cne3Wve24FQ3ndaLxvagxyIMmo91QYQPJs/jTG3JEXEGfUVhOVwv5o
	 wz5Vbj7UfP72NYiqtsPYwck1TGxsQargJtnKGpRvZ9dhZ14zuWLLq1y/Zv98pbFNYK
	 EgFU4UyYEoTjdUdyTKbeISwhdhUO5mGCGlhOZiU+SRG940FclE6gOfO2OC+NLEJbLP
	 CKjrV2WhaiuDeR8kJQvjWw6jamqiDdmIE4Z+91PgKjy8E3JnVlsl6+bEQKWCrewZr2
	 mNoThl86R6bzsSoWCR/h6hykjnsQSgHglBn0wFYe0MctvsXU3N609DN6yxlTSqF5py
	 pYun9hIsmBVkw==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] perf annotate-data: Show typedef names properly
Date: Wed,  7 Aug 2024 15:31:29 -0700
Message-ID: <20240807223129.1738004-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The die_get_typename() would resolve typedef and get to the original
type.  But sometimes the original type is a struct without name and it
makes the output confusing and hard to read.

This is a diff of perf report -s type before and after the change.
New types such as atomic{,64}_t and sigset_t appeared and the portion
of unnamed struct was reduced.  Also u32, u64 and size_t were splitted
from the base types.

  --- b   2024-08-01 17:02:34.307809952 -0700
  +++ a   2024-08-07 14:17:05.245853999 -0700
  -     2.40%  long unsigned int
  +     2.26%  long unsigned int
  -     1.56%  unsigned int
  +     1.27%  unsigned int
  -     0.98%  struct
  -     0.79%  long long unsigned int
  +     0.58%  long long unsigned int
  +     0.36%  struct
  +     0.27%  atomic64_t
  +     0.22%  u32
  +     0.21%  u64
  +     0.19%  atomic_t
  +     0.13%  size_t
  -     0.08%  struct seqcount_spinlock
  +     0.08%  seqcount_spinlock_t
  +     0.08%  sigset_t
  +     0.08%  __poll_t

Let's use the typedef name directly and the resolved to get the size of
the type.

Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 39 +++++++++++++++++++++++++--------
 tools/perf/util/dwarf-aux.c     |  2 +-
 tools/perf/util/dwarf-aux.h     |  2 ++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 734acdd8c4b7..092809bb92f5 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -217,8 +217,13 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	strbuf_init(&sb, 32);
 	die_get_typename(die, &sb);
 
-	die_get_real_type(die, &member_type);
-	if (dwarf_aggregate_size(&member_type, &size) < 0)
+	__die_get_real_type(die, &member_type);
+	if (dwarf_tag(&member_type) == DW_TAG_typedef)
+		die_get_real_type(&member_type, &die_mem);
+	else
+		die_mem = member_type;
+
+	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
 
 	if (!dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
@@ -235,11 +240,11 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	INIT_LIST_HEAD(&member->children);
 	list_add_tail(&member->node, &parent->children);
 
-	tag = dwarf_tag(&member_type);
+	tag = dwarf_tag(&die_mem);
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
-		die_find_child(&member_type, __add_member_cb, member, &die_mem);
+		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
 		break;
 	default:
 		break;
@@ -281,6 +286,10 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	if (die_get_typename_from_type(type_die, &sb) < 0)
 		strbuf_add(&sb, "(unknown type)", 14);
 	type_name = strbuf_detach(&sb, NULL);
+
+	if (dwarf_tag(type_die) == DW_TAG_typedef)
+		die_get_real_type(type_die, type_die);
+
 	dwarf_aggregate_size(type_die, &size);
 
 	/* Check existing nodes in dso->data_types tree */
@@ -342,6 +351,7 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 {
 	Dwarf_Word size;
 	bool is_pointer = true;
+	Dwarf_Die sized_type;
 
 	if (reg == DWARF_REG_PC)
 		is_pointer = false;
@@ -351,7 +361,7 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 		is_pointer = false;
 
 	/* Get the type of the variable */
-	if (die_get_real_type(var_die, type_die) == NULL) {
+	if (__die_get_real_type(var_die, type_die) == NULL) {
 		pr_debug_dtp("variable has no type\n");
 		ann_data_stat.no_typeinfo++;
 		return -1;
@@ -365,15 +375,20 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 	if (is_pointer) {
 		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
 		     dwarf_tag(type_die) != DW_TAG_array_type) ||
-		    die_get_real_type(type_die, type_die) == NULL) {
+		    __die_get_real_type(type_die, type_die) == NULL) {
 			pr_debug_dtp("no pointer or no type\n");
 			ann_data_stat.no_typeinfo++;
 			return -1;
 		}
 	}
 
+	if (dwarf_tag(type_die) == DW_TAG_typedef)
+		die_get_real_type(type_die, &sized_type);
+	else
+		sized_type = *type_die;
+
 	/* Get the size of the actual type */
-	if (dwarf_aggregate_size(type_die, &size) < 0) {
+	if (dwarf_aggregate_size(&sized_type, &size) < 0) {
 		pr_debug_dtp("type size is unknown\n");
 		ann_data_stat.invalid_size++;
 		return -1;
@@ -846,6 +861,7 @@ static int check_matching_type(struct type_state *state,
 
 	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_TYPE) {
 		int tag = dwarf_tag(&state->regs[reg].type);
+		Dwarf_Die sized_type;
 
 		/*
 		 * Normal registers should hold a pointer (or array) to
@@ -862,13 +878,18 @@ static int check_matching_type(struct type_state *state,
 		pr_debug_dtp("\n");
 
 		/* Remove the pointer and get the target type */
-		if (die_get_real_type(&state->regs[reg].type, type_die) == NULL)
+		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
 			return -1;
 
 		dloc->type_offset = dloc->op->offset;
 
+		if (dwarf_tag(type_die) == DW_TAG_typedef)
+			die_get_real_type(type_die, &sized_type);
+		else
+			sized_type = *type_die;
+
 		/* Get the size of the actual type */
-		if (dwarf_aggregate_size(type_die, &size) < 0 ||
+		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
 		    (unsigned)dloc->type_offset >= size)
 			return -1;
 
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 44ef968a7ad3..5e080d7e22c2 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -267,7 +267,7 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 }
 
 /* Get a type die, but skip qualifiers */
-static Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
+Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 {
 	int tag;
 
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 24446412b869..336a3a183a78 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -56,6 +56,8 @@ const char *die_get_decl_file(Dwarf_Die *dw_die);
 /* Get type die */
 Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
 
+/* Get a type die, but skip qualifiers */
+Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
 /* Get a type die, but skip qualifiers and typedef */
 Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog

