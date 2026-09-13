Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC8384CDF;
	Sun, 13 Sep 2026 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270037; cv=none; b=cL3f8U3KbffUz33uGUmmo2Bxz9ZThABZF2LLgN8gaGwJ0REb+hVgLr3oy2NlFKSE3hSS6Y6NWMTeAYqCrLeMvoRFsH7iLHjcw9NOGxfPJ0HYSosHZdD+qOlVboxbNWRgFz4VXGhwtJNR9HR4mq2NM4fOE7QvlpRrNhGsLBfL+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270037; c=relaxed/simple;
	bh=F4i1E530PiQ9BZhPss37RHpJT9G2nBbzhfx2pgnpkIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z38/HyMFdexV2fZilPnTaC3Z51/6k27W2SUbWj4LE60MYCt+Otpe2dxC0B4Y9bFhm8TNaVUcAnr9ahpA1pwooxUk2fe1jPZBN7zGJF4Em0sv9X3mKVbQJSk9RS/NM/z1dvpaDxBp2dOJ8kXBK9RnGlkDesD5feXli7ILW6PRWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flvv1iRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flvv1iRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614021F00893;
	Sun, 13 Sep 2026 03:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270034;
	bh=Zs+HEUmNnElS+rChiLca94YJcxPzka/SnqzS4rf+0jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Flvv1iRQkHVXLp5fVaamxblzuuZv0LGJKdo7Qpg77abJeP5INQPgL8IR1poJSgmzZ
	 x2hWo00L/7bxTBrCFn4NDTQDIvj3BK9j1nAKYVczJlGLj9glwcwzBHXtcOf+kbdRe+
	 HOHn3BcCPV9xnNULDFaFcw7jSEZgdo2zlw3b8eyhmzkctLpyqkMsUDv5BLr2tUH5yD
	 +xGYTKXy7IOkhyVQ7LpB0kQdZOwSaMp8M3n620SkKovRYq3cqtd8HCQtwOOLLomt6o
	 X4ttNYGVTHN73A4gMqBTETNZ1fhNwwIeft2GXb91SUy8Ay2ws56uVd6/UAnJ2r8mUa
	 YuxRD6ZvjxcIA==
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
Subject: [PATCH v2 7/8] perf annotate-data: Resolve type DIEs in the debug file they came from
Date: Sun, 13 Sep 2026 00:26:27 -0300
Message-ID: <20260913032632.116277-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913032632.116277-1-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A 'perf report -s type' on a 783 MB AMD IBS data type profiling session
hangs, burning all of a CPU and producing no output:

  ⬢ [acme@toolbx perf-tools-next]$ perf report --progress -s type -i perf.data.ibs > /dev/null
  Processing events... [100.0%] 746M / 746M
  Merging related events... [ 58.0%] 293828 / 506686
  Merging related events... [ 59.0%] 298894 / 506686
  Merging related events... [ 60.0%] 303960 / 506686
  Merging related events... [ 61.0%] 309026 / 506686
  [ ... nothing else, ever ... ]

It is a spin and not a slow path: with perf-stuck the CPU time used
grows by a whole interval on every sample, while the [stack] mapping,
which would be moving down if this was recursion, stays put:

  ⬢ [acme@toolbx perf-tools-next]$ tools/perf/scripts/perf-stuck.sh -i 15 -n 4 -l ibs.log $(pgrep -x perf)
  watching 2297313 (perf report --progress -s type -i perf.data.ibs) every 15s
  09:39:34 state=R cpu=+0 (0.00s) rss=664295kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB  Merging related events... [ 39.0%] 197574 / 506686
  09:39:49 state=R cpu=+1496 (14.96s) rss=665383kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB stuck=1 Merging related events... [ 39.0%] 197574 / 506686
  09:40:04 state=R cpu=+1497 (14.97s) rss=665383kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB stuck=2 Merging related events... [ 39.0%] 197574 / 506686
  09:40:19 state=R cpu=+1497 (14.97s) rss=502250kB stack=7ffc3ae31000-7ffc3ae52000 size=132kB stuck=0 Merging related events... [ 61.0%] 309026 / 506686

Attaching gdb and stepping the loop, printing dwarf_dieoffset() and
dwarf_tag() for the DIE being chased on each trip round it, shows the
chase never moving, on a typedef that refers to itself:

  ⬢ [acme@toolbx perf-tools-next]$ gdb -p $(pgrep -x perf) -batch -x tools/perf/scripts/perf-stuck.gdb -ex 'perf-die-chain die_get_pointer_type type_die 8' -ex perf-dso -ex detach
  stuck in die_get_pointer_type():
  #3  0x0000000000772421 in die_get_pointer_type (type_die=0x7ffc3ae4b710, type_die@entry=0x7ffc3ae4b6f0, die_mem=die_mem@entry=0x7ffc3ae4b710) at util/dwarf-aux.c:327
  327			type_die = die_get_type(type_die, die_mem);
  chain[0] die=0x7ffc3ae4b710 addr=0x7ff6811591ef cu=0x44ef0878 off=0x1f tag=22 name=(null)
  chain[1] die=0x7ffc3ae4b710 addr=0x7ff6811591ef cu=0x44ef0878 off=0x1f tag=22 name=(null)
  [ ... the very same DIE, forever ... ]
  dso=/usr/lib64/libz.so.1.3.1.zlib-ng ip=0xe2e sym=build_tree

The DIE is at offset 0x1f of the debug info of libz.so.1, which is
zlib-ng, and is one of the dwz compressed ones: the type DIEs shared by
more than one CU live in the common file, where 0x1f is a perfectly good
DW_TAG_base_type:

  ⬢ [acme@toolbx perf-tools-next]$ readelf --debug-dump=info /usr/lib/debug/.dwz/zlib-ng-2.3.3-3.fc44.x86_64 | sed -n '/Compilation Unit @ offset 0:/,/Compilation Unit @ offset 0x5f:/p'
    Compilation Unit @ offset 0:
     Length:        0x5b (32-bit)
     Version:       5
     Unit Type:     DW_UT_partial (3)
   <0><c>: Abbrev Number: 1 (DW_TAG_partial_unit)
   [...]
   <1><1f>: Abbrev Number: 62 (DW_TAG_base_type)
      <20>   DW_AT_byte_size   : 4
      <21>   DW_AT_encoding    : 5	(signed)
      <22>   DW_AT_name        : int

while in the main debug file that same offset is not a DIE at all, it is
the start of another unit's header:

  ⬢ [acme@toolbx perf-tools-next]$ readelf --debug-dump=info /usr/lib/debug/usr/lib64/libz.so.1.3.1.zlib-ng-2.3.3-3.fc44.x86_64.debug | grep 'Compilation Unit @' | head -2
    Compilation Unit @ offset 0:
    Compilation Unit @ offset 0x1f:

die_collect_vars() saves the dwarf_dieoffset() of the type DIE, which is
relative to the file that DIE lives in, and update_var_state() then hands
that offset to dwarf_offdie() together with the main debug file, where
dwarf_offdie() parses whatever is there as a DIE, in this case the one
typedef that refers to itself, which is what makes the "follow the
typedefs and qualifiers until a pointer or an array type" loop in
die_get_pointer_type() spin.

So record, next to the offset, whether the type DIE was in the file the
variable DIE came from or in the dwz common one, and resolve the offset
in the file it came from, which is what the new die_get_type_die() does.

Which of the two that is does not have to be guessed from what is at the
offset: dwz encodes the references into its common file as
DW_FORM_GNU_ref_alt, so elfutils resolves them into the alt Dwarf and
the CU of the resulting type DIE belongs to that other file, so
comparing the Dwarf each of the two CUs belongs to, die_same_file(),
settles it exactly, for any number of hops from the variable DIE.

Then bound the chases themselves: no sane chain of typedefs and
qualifiers is 32 DIEs long, no sane nesting for the struct and union
members that __add_member_cb() follows recursively is 8 deep, and the
same recursion bound covers the type names die_get_typename_from_type()
builds by following pointers and arrays, so that a debug info file
broken in some other way makes perf give up on a type, telling about it
with pr_debug, visible with -v, instead of looking like it hung.  The
member nesting bound is reported with pr_debug_dtp (visible with -vvv or
-D type-profile).

Cycles can't occur in member trees from valid DWARF, embedded members
can't be recursive in C, so the nesting bound only ever bites legitimate
depth and the member where the recursion was cut is marked 'truncated',
which the JSON exporter added in a subsequent series reports to its
consumers, so that they can tell a truncated tree from one that really
ends there.

die_get_type_die() then has no fallback to the other file: resolving an
alt file offset in the main file is the misparse above, so it resolves
in the file the offset was recorded as belonging to, and gives up on the
type when the offset does not resolve there.  The tag the type DIE had is
kept as a sanity check, a mismatch means the debug info changed under
perf or is broken in yet another way, and the bounds on the type chasers
remain the backstop: a debug info file broken in some other way still
makes perf give up on a type with a pr_debug instead of hanging.

Testing:

Before, on the 783 MB AMD IBS session, killed after some 8 minutes stuck
at 61%:

  ⬢ [acme@toolbx perf-tools-next]$ perf report --progress -s type -i perf.data.ibs > /dev/null
  Processing events... [100.0%] 746M / 746M
  Merging related events... [ 61.0%] 309026 / 506686
  ⬢ [acme@toolbx perf-tools-next]$

After, the whole session is processed, and the zlib-ng types, from the
build_tree() hist entry that used to hang it, show up:

  ⬢ [acme@toolbx perf-tools-next]$ perf report --progress -s type -i perf.data.ibs > ibs.out
  Processing events... [100.0%] 746M / 746M
  Merging related events... [100.0%] 506686 / 506686
  Sorting events for output... [100.0%] 1428 / 1428
  ⬢ [acme@toolbx perf-tools-next]$ grep -E "deflate_state|inflate_state|internal_state" ibs.out
      0.00%  deflate_state
      0.00%  deflate_state*
      0.00%  struct inflate_state
      0.00%  struct inflate_state*
      0.00%  struct internal_state
  ⬢ [acme@toolbx perf-tools-next]$ perf test 17 27 30 31 85 88
  17: Match and link multiple hists                              : Ok
  27: Filter hist entries                                        : Ok
  30: Sort output of hist entries                                : Ok
  31: Cumulate child hist entries                                : Ok
  85: Test that perf report includes file offsets and event type names in diagnostic messages. : Ok
  88: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Skip
  ⬢ [acme@toolbx perf-tools-next]$

Requiring elfutils 0.160 for this: dwarf_cu_getdwarf(), the function
that tells which Dwarf a CU belongs to, first appeared in 0.160 ("libdw:
New functions dwarf_cu_getdwarf, dwarf_cu_die", elfutils NEWS), so the
libdw feature test now probes for it, in tools/build/feature/test-libdw.c,
and Makefile.config says 0.160 where it said 0.157.  The probe takes the
address instead of calling it, as that is all that is needed to make a
0.157-0.159 elfutils, from 2014 and without the symbol, disable dwarf
support with the existing message rather than fail to link dwarf-aux.c.

Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info")
Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global variable types")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-libdw.c |  15 ++-
 tools/perf/Makefile.config       |   2 +-
 tools/perf/util/annotate-data.c  |  55 ++++++++---
 tools/perf/util/annotate-data.h  |   3 +
 tools/perf/util/dwarf-aux.c      | 161 +++++++++++++++++++++++++++----
 tools/perf/util/dwarf-aux.h      |  33 +++++++
 6 files changed, 235 insertions(+), 34 deletions(-)

diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index aabd63ca76b4d7e6..23e1ba6ff3466b9f 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -49,8 +49,21 @@ int test_elfutils(void)
 	return 0;
 }
 
+/*
+ * elfutils 0.160 and later: used to tell which debug file a DIE lives in,
+ * the dwz alt file or the main one, see die_same_file() in
+ * tools/perf/util/dwarf-aux.c.  Only the symbol is needed, so take its
+ * address instead of calling it.
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
index 4d5993da9f94579f..fa78f50db60179f3 100644
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
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4e4c587640823c81..2f552286c91c3d2c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -221,6 +221,15 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
 	return strcmp(a->self.type_name, b->self.type_name) < 0;
 }
 
+/*
+ * Members of struct/union members are added recursively, and the same DIE
+ * that is not what it looks like, the one that makes the type chasers in
+ * util/dwarf-aux.c spin, can make a member's type point back at one of its
+ * own ancestors, recursing until the stack is gone.  Nothing usable comes
+ * out of nesting members this deep anyway.
+ */
+#define MAX_MEMBER_DEPTH 8
+
 /* Recursively add new members for struct/union */
 static int __add_member_cb(Dwarf_Die *die, void *arg)
 {
@@ -235,6 +244,16 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_tag(die) != DW_TAG_member)
 		return DIE_FIND_CB_SIBLING;
 
+	if (__die_get_real_type(die, &member_type) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_tag(&member_type) == DW_TAG_typedef) {
+		if (die_get_real_type(&member_type, &die_mem) == NULL)
+			return DIE_FIND_CB_SIBLING;
+	} else {
+		die_mem = member_type;
+	}
+
 	member = zalloc(sizeof(*member));
 	if (member == NULL)
 		return DIE_FIND_CB_END;
@@ -242,12 +261,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	strbuf_init(&sb, 32);
 	die_get_typename(die, &sb);
 
-	__die_get_real_type(die, &member_type);
-	if (dwarf_tag(&member_type) == DW_TAG_typedef)
-		die_get_real_type(&member_type, &die_mem);
-	else
-		die_mem = member_type;
-
 	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
 
@@ -289,10 +302,19 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	}
 	member->size = size;
 	member->offset = loc + parent->offset;
+	member->depth = parent->depth + 1;
 	INIT_LIST_HEAD(&member->children);
 	list_add_tail(&member->node, &parent->children);
 
 	tag = dwarf_tag(&die_mem);
+	if (member->depth >= MAX_MEMBER_DEPTH) {
+		/* Tell the browser and JSON consumers this isn't all */
+		member->truncated = true;
+		pr_debug_dtp("member nesting limit reached at %s\n",
+			     member->type_name ?: "(unknown type)");
+		return DIE_FIND_CB_SIBLING;
+	}
+
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
@@ -645,6 +667,8 @@ struct global_var_entry {
 	u64 start;
 	u64 end;
 	u64 die_offset;
+	int die_tag;
+	bool from_alt;	/* die_offset is relative to the alt (dwz) file */
 };
 
 static int global_var_cmp(const void *_key, const struct rb_node *node)
@@ -682,7 +706,7 @@ static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64
 }
 
 static bool global_var__add(struct data_loc_info *dloc, u64 addr,
-			    const char *name, Dwarf_Die *type_die)
+			    const char *name, Dwarf_Die *type_die, bool from_alt)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	struct global_var_entry *gvar;
@@ -704,6 +728,8 @@ static bool global_var__add(struct data_loc_info *dloc, u64 addr,
 	gvar->start = addr;
 	gvar->end = addr + size;
 	gvar->die_offset = dwarf_dieoffset(type_die);
+	gvar->die_tag = dwarf_tag(type_die);
+	gvar->from_alt = from_alt;
 
 	rb_add(&gvar->node, dso__global_vars(dso), global_var_less);
 	return true;
@@ -778,12 +804,14 @@ static void global_var__collect(struct data_loc_info *dloc)
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
@@ -808,7 +836,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 	gvar = global_var__find(dloc, var_addr);
 	if (gvar) {
-		if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_die))
+		if (!die_get_type_die(dloc->di->dbg, gvar->die_offset,
+				      gvar->die_tag, gvar->from_alt, type_die))
 			return false;
 
 		*var_offset = var_addr - gvar->start;
@@ -838,7 +867,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 ok:
 	/* The address should point to the start of the variable */
-	global_var__add(dloc, var_addr - *var_offset, var_name, type_die);
+	global_var__add(dloc, var_addr - *var_offset, var_name, type_die,
+			!die_same_file(cu_die, type_die));
 	return true;
 }
 
@@ -893,7 +923,8 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 		}
 		/* Get the type DIE using the offset */
-		if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
+		if (!die_get_type_die(dloc->di->dbg, var->die_off,
+				      var->die_tag, var->from_alt, &mem_die))
 			continue;
 
 		if (var->reg == DWARF_REG_FB || var->reg == fbreg || var->reg == state->stack_reg) {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index c26130744260955f..d85866e83fbda69a 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -57,6 +57,9 @@ struct annotated_member {
 	char *var_name;
 	int offset;
 	int size;
+	unsigned int depth;
+	/* Children not expanded because the nesting limit was reached */
+	bool truncated;
 };
 
 /**
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index d7160f87ac7d7ab3..e35f724ea6835a8c 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -266,16 +266,35 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 		return NULL;
 }
 
+/*
+ * The chases below cross typedefs and qualifiers to get to the type that
+ * is actually meant, and a DIE that is not what it looks like, e.g. one
+ * parsed at an offset that is not the start of a DIE in the file it was
+ * resolved in, can have a DW_AT_type that refers back to itself, which
+ * makes them spin forever: 'perf report -s type' did exactly that on the
+ * dwz compressed debug info of zlib-ng (libz.so.1), burning all of a CPU
+ * with no output while resolving a hist entry in build_tree().
+ *
+ * No sane chain is this long, so give up instead of hanging, telling about
+ * it so that the broken debug info can be looked at.
+ */
+#define MAX_TYPE_CHASE 32
+
 /* Get a type die, but skip qualifiers */
 Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 {
-	int tag;
+	int tag, chase = 0;
 
 	do {
 		vr_die = die_get_type(vr_die, die_mem);
 		if (!vr_die)
-			break;
+			return NULL;
 		tag = dwarf_tag(vr_die);
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: qualifier chase limit reached at DIE 0x%lx\n",
+				 (unsigned long)dwarf_dieoffset(vr_die));
+			return NULL;
+		}
 	} while (tag == DW_TAG_const_type ||
 		 tag == DW_TAG_restrict_type ||
 		 tag == DW_TAG_volatile_type ||
@@ -296,8 +315,15 @@ Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
  */
 Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 {
+	int chase = 0;
+
 	do {
 		vr_die = __die_get_real_type(vr_die, die_mem);
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: typedef chase limit reached at DIE 0x%lx\n",
+				 vr_die ? (unsigned long)dwarf_dieoffset(vr_die) : 0);
+			return NULL;
+		}
 	} while (vr_die && dwarf_tag(vr_die) == DW_TAG_typedef);
 
 	return vr_die;
@@ -314,7 +340,7 @@ Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
  */
 Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
 {
-	int tag;
+	int tag, chase = 0;
 
 	do {
 		tag = dwarf_tag(type_die);
@@ -324,6 +350,11 @@ Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
 		    tag != DW_TAG_restrict_type && tag != DW_TAG_volatile_type &&
 		    tag != DW_TAG_shared_type)
 			return NULL;
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: pointer type chase limit reached at DIE 0x%lx\n",
+				 (unsigned long)dwarf_dieoffset(type_die));
+			return NULL;
+		}
 		type_die = die_get_type(type_die, die_mem);
 	} while (type_die);
 
@@ -1118,17 +1149,27 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 			      die_mem);
 }
 
-/**
- * die_get_typename_from_type - Get the name of given type DIE
- * @type_die: a type DIE
- * @buf: a strbuf for result type name
- *
- * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
- * and Return -ENOENT if failed to find type name.
- * Note that the result will stores typedef name if possible, and stores
- * "*(function_type)" if the type is a function pointer.
+/*
+ * The name of a pointer or array type is built from the name of the type
+ * it points to or holds, so the recursion below follows DW_AT_type; a
+ * garbage DIE whose DW_AT_type refers back to itself makes it recurse
+ * forever, just like the chases above, so it gets the same bound.
  */
-int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
+static int __die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf,
+					int depth);
+
+static int __die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf, int depth)
+{
+	Dwarf_Die type;
+
+	if (__die_get_real_type(vr_die, &type) == NULL)
+		return -ENOENT;
+
+	return __die_get_typename_from_type(&type, buf, depth);
+}
+
+static int __die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf,
+					int depth)
 {
 	int tag, ret;
 	const char *tmp = "";
@@ -1155,7 +1196,12 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 		/* Write a base name */
 		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
-	ret = die_get_typename(type_die, buf);
+	if (depth >= MAX_TYPE_CHASE) {
+		pr_debug("DWARF: type name recursion limit reached at DIE 0x%lx\n",
+			 (unsigned long)dwarf_dieoffset(type_die));
+		return -ENOENT;
+	}
+	ret = __die_get_typename(type_die, buf, depth + 1);
 	if (ret < 0) {
 		/* void pointer has no type attribute */
 		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
@@ -1166,6 +1212,21 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 	return strbuf_addstr(buf, tmp);
 }
 
+/**
+ * die_get_typename_from_type - Get the name of given type DIE
+ * @type_die: a type DIE
+ * @buf: a strbuf for result type name
+ *
+ * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
+ * and Return -ENOENT if failed to find type name.
+ * Note that the result will stores typedef name if possible, and stores
+ * "*(function_type)" if the type is a function pointer.
+ */
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
+{
+	return __die_get_typename_from_type(type_die, buf, 0);
+}
+
 /**
  * die_get_typename - Get the name of given variable DIE
  * @vr_die: a variable DIE
@@ -1178,12 +1239,7 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
  */
 int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 {
-	Dwarf_Die type;
-
-	if (__die_get_real_type(vr_die, &type) == NULL)
-		return -ENOENT;
-
-	return die_get_typename_from_type(&type, buf);
+	return __die_get_typename(vr_die, buf, 0);
 }
 
 /**
@@ -1632,6 +1688,22 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
 	return result;
 }
 
+/*
+ * Whether two DIEs live in the same debug file.
+ *
+ * dwarf_dieoffset() is relative to the file the DIE is in, so this is what
+ * tells an offset that has to be resolved in the dwz alt file, where dwz
+ * moved the type, from one that belongs to the main file: dwz encodes the
+ * references into its common file as DW_FORM_GNU_ref_alt, elfutils resolves
+ * them into the alt Dwarf and the CU of the resulting DIE belongs to that
+ * other file, so comparing the Dwarf each CU belongs to settles it exactly,
+ * rather than inferring it from what happens to be at the offset.
+ */
+bool die_same_file(Dwarf_Die *die_a, Dwarf_Die *die_b)
+{
+	return dwarf_cu_getdwarf(die_a->cu) == dwarf_cu_getdwarf(die_b->cu);
+}
+
 static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 {
 	struct die_var_type **var_types = arg;
@@ -1676,6 +1748,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 			vt->is_reg_var_addr = true;
 
 		vt->die_off = dwarf_dieoffset(&type_die);
+		vt->die_tag = dwarf_tag(&type_die);
+		vt->from_alt = !die_same_file(die_mem, &type_die);
 		vt->addr = start;
 		vt->end = end;
 		vt->has_range = (end != 0 || start != 0);
@@ -1741,6 +1815,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_END;
 
 	vt->die_off = dwarf_dieoffset(&type_die);
+	vt->die_tag = dwarf_tag(&type_die);
+	vt->from_alt = !die_same_file(die_mem, &type_die);
 	vt->addr = ops->number;
 	vt->end = 0;
 	vt->has_range = false;
@@ -1752,6 +1828,51 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	return DIE_FIND_CB_SIBLING;
 }
 
+/**
+ * die_get_type_die - Get a type DIE saved by die_collect_vars()
+ * @dbg: the main debug info
+ * @die_off: offset of the type DIE, from dwarf_dieoffset()
+ * @die_tag: tag that DIE had when the offset was saved
+ * @die_mem: where to store the resulting DIE
+ *
+ * See the comment in util/dwarf-aux.h: the offset is only meaningful in the
+ * file the DIE was in, which can be the dwz common file, so look at the main
+ * file and then at the alt file, and use the one that has a DIE with the tag
+ * the type had when it was collected.
+ */
+Dwarf_Die *die_get_type_die(Dwarf *dbg, u64 die_off, int die_tag, bool from_alt,
+			    Dwarf_Die *die_mem)
+{
+	Dwarf *target = dbg;
+	Dwarf_Die die;
+
+	if (from_alt) {
+		/*
+		 * Deliberately no fallback to the main file when there is
+		 * no alt file, or when the offset does not resolve in it:
+		 * resolving an alt file offset in the main file does not
+		 * fail, it parses whatever is there as a DIE, and that is
+		 * what hung 'perf report -s type', see the comment in
+		 * util/dwarf-aux.h.
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
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 161f0bf980b6ee6a..149e0cbf63ccc82a 100644
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
@@ -183,6 +185,37 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
 /* Save all variables and parameters in this scope */
 void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 
+/*
+ * Get the type DIE saved by die_collect_vars()/die_collect_global_vars().
+ *
+ * The offsets those save are the dwarf_dieoffset() of the type DIE, which is
+ * relative to the debug file that DIE lives in: the dwz common file, the alt
+ * file in libdw terms, for the types shared by more than one CU, the main
+ * file for the rest.  Resolving an alt file offset in the main file does not
+ * fail: dwarf_offdie() parses whatever is at that offset there, and an offset
+ * that is a CU header in the main file reads back as a typedef whose
+ * DW_AT_type refers to itself, which is what hung 'perf report -s type' on
+ * the dwz compressed debug info of zlib-ng (libz.so.1).
+ *
+ * So @from_alt, recorded when the offset was saved, says which of the two
+ * files to resolve it in.  It is not inferred from the DIE contents: dwz
+ * encodes references into the common file as DW_FORM_GNU_ref_alt, so
+ * elfutils resolves them into the alt Dwarf and the CU of the type DIE then
+ * belongs to that other file, which die_same_file() compares exactly.
+ *
+ * There is deliberately no fallback to the other file when the offset does
+ * not resolve: that fallback is the misparse above.
+ *
+ * @die_tag is then only a sanity check: the offset is of a DIE that had this
+ * tag when it was saved, so a mismatch means the debug info changed under us,
+ * or is broken, and giving up on the type is the right answer.
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
2.55.0

