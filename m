Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8623290C9
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231031; cv=none; b=u0AtnS3solSbchAWz7ci3aXkv4a3hw7q8YfK9nV3CVsESrcbC/lpItG0gK3HsgBHSPWP/bbMeUtNGqefBJxj4qFgPIKoPAwCjQj3tj1yWzQjiilq9/F/u2j2BSFPYMGdXNeZIVY03kf2tvXxzw0Fd+adBiRCzkvoA2+hMTXeKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231031; c=relaxed/simple;
	bh=sjgTEEqa3dNngedBPzz6yodJsbopCr5WmJorYKNVngY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOCa/eIO4unwKyAKraR5zzPz/58Wg7NTLdxX4MAvbMIv++HWy4mtXP4OiDkRlF/7c1PaEz9ozHzwdXAZf5cKIYZmK38Rh1nyxPVX+RY/351mb3Q/4QF9l/V32eCbWKvjlpI3kcpJYfa/yqzAMS/vo7IyIFf63ShNDqAXhr1gTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=fFiWM0Fy; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="fFiWM0Fy"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309a20a55bso21623151cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Oct 2026 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1791231028; x=1791835828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gTC+ObY8Gna8uWXuZKB0+MEzZaUe655gOZK/ZwiSb8=;
        b=fFiWM0Fyu3vhtLmtGB35XSBv3mkVDPSJC66b72GGCeksQfucjwgsuwo+R9G+ydKrP5
         lYi4j7OQ53CsEdXdaTgaEAczbR3hQWuRkvZ1h1dlMv3d/aFEjbtGZfCh+9PV66M/PJ2n
         lCw6fZ9/QVPZRj9bUoL1knEfk/iK1s7kioPH/6SBtLvzhzltfS2+Eallg0IA3wGB7mIx
         wz4NTF9OvzdnVAxqSYc9lyNcWdcHax9+yCJSYYzphAOO3f1UqfjMk/2PoKUdUcQ5vV1R
         VQ8zGGeK3SHQEdlD/AJCK+VfBO9iZn9jmWDI9qY2rPVid0wkAxat44fCVsl+sPjyW2Di
         N+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231028; x=1791835828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gTC+ObY8Gna8uWXuZKB0+MEzZaUe655gOZK/ZwiSb8=;
        b=P2WheZeOSH8ORMYKArN6Jc/8k9zON/Wh7qd2nZH8xA7Lr4pkP61WaC51uFXCSJ476K
         hI1BftTprej+etfh9vwBYHmnYyemBAQcGXv7iN4nUqMdf6LQoTZ38PGTcCPJr0JLDzpK
         ERaH33AGyPjNpkYvPo80ZoLjrW+Pr96Mpf+oO1fEHZFKdkBd7xsnxuLoNSb+TeLbh5qr
         QPd1XsTWAlYGT/UVxYqkJ6IS9whACwD4zOALGh8C+Rfwwb5qpbPl3003SeeyBzSP5Bsv
         YaEUsVNF3QAKKlUrkV6dxkDY89xpnaAPL6gdvdlnMGqFEpCsTQqeFyrUWFosDUONINUr
         0XmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQrLFadqNmJ3c8/Ienyektuv9lQgnBsK/XY8jB4qzZ77c8yHElas0k1nB6giSouhMrwO+jMy8TWdINgWHJVCJe@vger.kernel.org
X-Gm-Message-State: AFuF++mnXtm3vZDCJ0QppevmRh8toYTCrri6kdG8qqM0KwbyR5S5lQGl
	m6wmMsGyT53x3ypKog5Q5V5q4BBDKv+Xna1AU55kWGLFerhg8+kShyf2ZUPYkc58ew==
X-Gm-Gg: AYBFou119Nw1n3MTy42JJnfULl2p/M1dDRK1hr5RzZgLttu3DRH+CQXsEYYTiCBOlXr
	qc090PHiXZXmGrY1/ssMGgKvbqnvIfi0CniBv4+3y24V4o7NB+60/5V0rsodKYfOAbLgl6cknen
	eKf9cXwHsPF3Ggor/C5FJkIwraZ3iYEI0AhLlIg1n0LgcjlLbEQuduL/GAqkjjaS+u4rTL2Ykkc
	3wYaJptO/vMaPs7aaL0SbQouweFDUUkdICyvVrNJxX7T89suNtbAW38jXW1fTt9Hr0SyaA5dYjd
	Gv9jyfyxvGD/DtYUAJ75oiMjfD3KxEgmmQUPLVCtYLVFewPi+7JJNy5x4UrAQzBX8EmULukRFrc
	NM7JyI38G80km/lO6aP1Rv8ab1XyRLnPwrCkM2cz3bHm+ahRMdKAH+i5IioEoBnPug835iwKBn0
	Wr1ROuD6KYCWN7B035avgDgrIbwuGQ/hcW7FeLV+Xw1yRxml1N2X4PzK4VomWmnAP53T/8GAqhz
	eQVBK4M5SNH1TCfWgry1EBiBLCMTA9XULP42jaEx6oUUXiHXnoTrN/0DCt0YutwDZA=
X-Received: by 2002:a05:622a:64d:b0:535:11e7:fdb3 with SMTP id d75a77b69052e-53511e80d1bmr156071961cf.34.1791231027301;
        Mon, 05 Oct 2026 13:10:27 -0700 (PDT)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a9c92csm106693991cf.11.2026.10.05.13.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:10:26 -0700 (PDT)
From: Yanbo Zhao <yzhao62@ncsu.edu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanbo Zhao <yzhao62@ncsu.edu>
Subject: [PATCH v3 1/3] perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
Date: Mon,  5 Oct 2026 16:10:08 -0400
Message-ID: <20261005201010.36493-2-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005201010.36493-1-yzhao62@ncsu.edu>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the die_is_compound_type() helper which checks for
DW_TAG_structure_type, DW_TAG_union_type, and DW_TAG_class_type, and
convert the existing open-coded struct/union tag checks to use it:
- die_get_member_type() in dwarf-aux.c.
- is_compound_type() and set_stack_state() in annotate-data.c.

The switch in __add_member_cb() also handles unions and the nesting
limit, so DW_TAG_class_type is just added there as another case.

Also accept DW_TAG_inheritance in the member lookup callbacks
(__die_find_member_offset_cb() and __add_member_cb()) so that member
lookup by offset descends into C++ base class subobjects.

In DWARF, a base class subobject is described by a DW_TAG_inheritance
child of the derived class DIE.  It sits next to the DW_TAG_member
children and carries the same DW_AT_type and DW_AT_data_member_location
attributes, so it can be treated like an unnamed member whose type is
the base class.  Members inherited from the base are not repeated in
the derived class DIE; they can only be reached through the
DW_TAG_inheritance entry.

For example, with the following classes (GCC 15, -O2 -g):

  struct Base  { long a; virtual long get(long x); };
  struct Other { long c; virtual long hi(); };
  struct Multi : Base, Other { long d; ... };

the DWARF looks like this (subprogram DIEs omitted):

  <1><2f>: Abbrev Number: 15 (DW_TAG_structure_type)
     <30>   DW_AT_name        : Multi
     <34>   DW_AT_byte_size   : 40
  <2><3e>: Abbrev Number: 20 (DW_TAG_inheritance)
     <3f>   DW_AT_type        : <0x10b>
     <43>   DW_AT_data_member_location: 0
  <2><44>: Abbrev Number: 20 (DW_TAG_inheritance)
     <45>   DW_AT_type        : <0x1d0>
     <49>   DW_AT_data_member_location: 16
  <2><99>: Abbrev Number: 16 (DW_TAG_member)
     <9a>   DW_AT_name        : d
     <a1>   DW_AT_data_member_location: 32
  ...
  <1><10b>: Abbrev Number: 15 (DW_TAG_structure_type)
     <10c>   DW_AT_name        : Base
     <110>   DW_AT_byte_size   : 16
  <2><14d>: Abbrev Number: 25 (DW_TAG_member)
     <14e>   DW_AT_name        : _vptr.Base
     <156>   DW_AT_data_member_location: 0
  <2><156>: Abbrev Number: 16 (DW_TAG_member)
     <157>   DW_AT_name        : a
     <15e>   DW_AT_data_member_location: 8
  ...
  <1><1d0>: Abbrev Number: 15 (DW_TAG_structure_type)
     <1d1>   DW_AT_name        : Other
     <1d5>   DW_AT_byte_size   : 16
  <2><245>: Abbrev Number: 25 (DW_TAG_member)
     <246>   DW_AT_name        : _vptr.Other
     <24e>   DW_AT_data_member_location: 0
  <2><24e>: Abbrev Number: 16 (DW_TAG_member)
     <24f>   DW_AT_name        : c
     <256>   DW_AT_data_member_location: 8

An access to 'struct Multi' at offset 0x8 is Base::a, and one at
offset 0x18 is Other::c.  Neither of them is a DW_TAG_member of Multi.
With DW_TAG_inheritance accepted in __die_find_member_offset_cb(),
die_get_member_type() finds the DW_TAG_inheritance at offset 0 (size
16, covering 0x8), follows its DW_AT_type to Base, and then resolves
'a' at offset 0x8 within Base.  Likewise offset 0x18 goes through the
second DW_TAG_inheritance at 16 and resolves to 'c' at offset 0x8 in
Other.  The same applies to __add_member_cb() which builds the member
tree used to print 'Data Type Offset' names.

Note that this is only about the layout of data members: a base class
subobject is looked up in the same way regardless of how many base
classes the class has.  Resolving virtual function calls through the
vtable of a class with multiple base classes is a separate matter and
is described in the following patches.

Note that GCC emits DW_TAG_structure_type for a C++ 'struct' even when
it has virtual functions, and DW_TAG_class_type for 'class', so both
tags need to be treated as compound types.

A base class subobject differs from a member in three ways that need
care:

1. It can take less space than the size of the base class type.  An
   empty base occupies no bytes (empty base optimization) although the
   DW_AT_byte_size of the base type is 1, and a member of the derived
   class can be placed in the tail padding of the base:

     struct Empty {};
     struct EboD : Empty { long x; };         // Empty at 0, x at 0

     struct B { long a; int b; B(); };        // sizeof(B) == 16
     struct TailD : B { int c; };             // B at 0, c at 12

   The DW_TAG_inheritance comes before the DW_TAG_member in DWARF, so
   an offset-based lookup would match the base first and then fail to
   find the member in it.  To handle this, __die_find_member_offset_cb()
   only matches a DW_TAG_inheritance if the base class actually has a
   member at the offset, and fill_member_name() continues with the next
   sibling when an anonymous child (a base class or an anonymous
   struct/union) has nothing at the offset.

2. A virtual base class has a DW_AT_data_member_location that is a
   location expression evaluated at runtime with the vtable:

     struct V { long v; };
     struct VirtD : virtual V { long d; };

     <2><5d>: Abbrev Number: 13 (DW_TAG_inheritance)
        <5e>   DW_AT_type        : <0x2f>
        <62>   DW_AT_data_member_location: 6 byte block: 12 6 48 1c 6 22
                 (DW_OP_dup; DW_OP_deref; DW_OP_lit24; DW_OP_minus;
                  DW_OP_deref; DW_OP_plus)
        <69>   DW_AT_virtuality  : 1        (virtual)

   Its offset cannot be resolved statically, so such an entry is
   skipped in both __die_find_member_offset_cb() and __add_member_cb()
   instead of falling back to offset 0 which would shadow the vtable
   pointer of the derived class.

3. DW_TAG_inheritance has no DW_AT_name.  It's added to the member
   tree as an anonymous entry with the base class as its type name,
   so 'Data Type Offset' shows the member name without the base class,
   like 'struct Multi +0x8 (a)'.

With this, accesses through pointers to the types above are resolved
as below, where the first two were reported as '(no field)' before:

  struct EboD  +0    (x)
  struct TailD +0xc  (c)
  struct VirtD +0x8  (d)

This extends the existing member type resolution and data type
profiling state handling to C++ classes with inheritance without
changing behavior for C struct/union types.

Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
---
Changes in v3:
- No change.

Changes in v2:
- Add an example DWARF of a class with base classes to the commit
  message and explain why DW_TAG_inheritance is handled like
  DW_TAG_member (Namhyung).
- Skip virtual base classes whose DW_AT_data_member_location is a
  runtime expression instead of falling back to offset 0, in both
  __die_find_member_offset_cb() and __add_member_cb() (Sashiko).
- Match a DW_TAG_inheritance in the offset lookup only if the base
  class actually has a member at the offset, so that a member of the
  derived class placed at the same offset as an empty base (EBO) or in
  the tail padding of the base is found (Sashiko).
- Continue with the next sibling in fill_member_name() when an
  anonymous child (base class) has nothing at the offset, so the member
  name is shown instead of '(no field)' in the cases above.

 tools/perf/util/annotate-data.c | 46 +++++++++++++++++++------------
 tools/perf/util/dwarf-aux.c     | 49 +++++++++++++++++++++++++++++----
 tools/perf/util/dwarf-aux.h     |  3 ++
 3 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 19a6ecd67f28..8a9d3f2eec4d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -237,9 +237,17 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	Dwarf_Word size, loc, bit_size = 0;
 	Dwarf_Attribute attr;
 	struct strbuf sb;
-	int tag;
+	int tag = dwarf_tag(die);
+
+	if (tag != DW_TAG_member && tag != DW_TAG_inheritance)
+		return DIE_FIND_CB_SIBLING;
 
-	if (dwarf_tag(die) != DW_TAG_member)
+	/*
+	 * A virtual base class (C++) has a location expression evaluated
+	 * using the vtable at runtime, so its offset is not known here.
+	 */
+	if (tag == DW_TAG_inheritance &&
+	    die_get_data_member_location(die, &loc) < 0)
 		return DIE_FIND_CB_SIBLING;
 
 	if (die_get_real_type(die, &die_mem) == NULL)
@@ -321,6 +329,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 		member->is_union = true;
 		/* fall through */
 	case DW_TAG_structure_type:
+	case DW_TAG_class_type:
 		/* Only aggregates have children to expand, so only they get truncated. */
 		if (member->depth >= MAX_MEMBER_DEPTH) {
 			/* Consumed by the JSON exporter added in a later series. */
@@ -405,8 +414,21 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
 		if (offset < child->offset || offset >= child->offset + child->size)
 			continue;
 
-		found = true;
-		break;
+		if (child->var_name) {
+			found = true;
+			break;
+		}
+
+		/*
+		 * An anonymous child is a C++ base class or an anonymous
+		 * struct/union.  A base class subobject can share the offset
+		 * with a member of the derived class (empty base or tail
+		 * padding reuse), so keep looking if nothing is found in it.
+		 */
+		len = fill_member_name(buf, sz, child, offset, first,
+				       has_flex_array);
+		if (len)
+			return len;
 	}
 
 	if (!found && has_flex_array) {
@@ -565,9 +587,7 @@ static const char *match_result_str(enum type_match_result tmr)
 
 static bool is_compound_type(Dwarf_Die *type_die)
 {
-	int tag = dwarf_tag(type_die);
-
-	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type;
+	return die_is_compound_type(type_die);
 }
 
 /* returns if Type B has better information than Type A */
@@ -694,7 +714,6 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 			    Dwarf_Die *type_die, int ptr_offset)
 {
-	int tag;
 	Dwarf_Word size;
 
 	if (kind == TSR_KIND_POINTER) {
@@ -715,17 +734,10 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 		return;
 	}
 
-	tag = dwarf_tag(type_die);
-
-	switch (tag) {
-	case DW_TAG_structure_type:
-	case DW_TAG_union_type:
+	if (die_is_compound_type(type_die))
 		stack->compound = (kind != TSR_KIND_PERCPU_POINTER);
-		break;
-	default:
+	else
 		stack->compound = false;
-		break;
-	}
 }
 
 struct type_state_stack *findnew_stack_state(struct type_state *state,
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 54f8b5ec74a2..eb4b8f3475df 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -61,6 +61,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
 	return dwarf_formstring(&attr);
 }
 
+bool die_is_compound_type(Dwarf_Die *type_die)
+{
+	int tag = dwarf_tag(type_die);
+
+	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
+	       tag == DW_TAG_class_type;
+}
+
 /* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
 static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
 {
@@ -2150,13 +2158,21 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Word offset = (long)arg;
 	int tag = dwarf_tag(die_mem);
 
-	if (tag != DW_TAG_member)
+	if (tag != DW_TAG_member && tag != DW_TAG_inheritance)
 		return DIE_FIND_CB_SIBLING;
 
 	/* Unions might not have location */
 	if (die_get_data_member_location(die_mem, &loc) < 0) {
 		Dwarf_Attribute attr;
 
+		/*
+		 * A virtual base class (C++) has a location expression that
+		 * needs the vtable at runtime.  Skip it as it cannot be
+		 * resolved statically.
+		 */
+		if (tag == DW_TAG_inheritance)
+			return DIE_FIND_CB_SIBLING;
+
 		if (dwarf_attr_integrate(die_mem, DW_AT_data_bit_offset, &attr) &&
 		    dwarf_formudata(&attr, &loc) == 0)
 			loc /= 8;
@@ -2164,6 +2180,30 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
 			loc = 0;
 	}
 
+	if (tag == DW_TAG_inheritance) {
+		Dwarf_Die base_die, member_die;
+
+		/*
+		 * A base class subobject can be smaller than the size of the
+		 * class type: an empty base takes no space (EBO) and a member
+		 * of the derived class can be placed in the tail padding of
+		 * the base.  In both cases a member of the derived class is
+		 * at the same offset as the base, so only match the base if
+		 * it actually has a member at the offset.
+		 */
+		if (offset < loc)
+			return DIE_FIND_CB_SIBLING;
+
+		if (die_get_real_type(die_mem, &base_die) == NULL)
+			return DIE_FIND_CB_SIBLING;
+
+		if (die_find_child(&base_die, __die_find_member_offset_cb,
+				   (void *)(long)(offset - loc), &member_die))
+			return DIE_FIND_CB_END;
+
+		return DIE_FIND_CB_SIBLING;
+	}
+
 	if (offset == loc)
 		return DIE_FIND_CB_END;
 
@@ -2201,7 +2241,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 	tag = dwarf_tag(type_die);
 	/* If it's not a compound type, return the type directly */
-	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+	if (!die_is_compound_type(type_die)) {
 		Dwarf_Word size;
 
 		if (dwarf_aggregate_size(type_die, &size) < 0)
@@ -2216,7 +2256,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 	mb_type = *type_die;
 	/* TODO: Handle union types better? */
-	while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+	while (die_is_compound_type(&mb_type)) {
 		member = die_find_child(&mb_type, __die_find_member_offset_cb,
 					(void *)(long)offset, die_mem);
 		if (member == NULL)
@@ -2227,8 +2267,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 		tag = dwarf_tag(&mb_type);
 
-		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
-		    tag == DW_TAG_array_type) {
+		if (die_is_compound_type(&mb_type) || tag == DW_TAG_array_type) {
 			Dwarf_Word loc;
 
 			/* Update offset for the start of the member struct */
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 6f9145510adc..7c893e385824 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -23,6 +23,9 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 /* Get DW_AT_comp_dir (should be NULL with older gcc) */
 const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 
+/* Check if DIE is a compound type (structure, union, or class) */
+bool die_is_compound_type(Dwarf_Die *type_die);
+
 /* Get a line number and file name for given address */
 int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
 		     const char **fname, int *lineno);
-- 
2.53.0

