Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721462;
	b=vyXXwZHRBLdD/9Oa5my/MTMIziV4CBirWtt46o1fPuy1l4TQgZnLmSO5efOx+641KJ7h
	 GsNOHpjmgQDmLaRL64vmHU0mmeCuo5VbQHRjTf/SBQVtGKm9wjHjSOJ8BLxd4/WbLsVVG
	 XReGV+HoTRJ3KiDLNri4EQDA3ID2EKv/F+FyuvTyyHJWuJnhwJ5OAzEbGQaypCKTtZxDc
	 p+XDyz2SGzOX7OGN5QtFfVfk6uXIBzfGGTdXKds62itcNnBOXv7elTAMqBS6KmehhQ3Qe
	 9LRT2IY7erbmd05+jQBOsdKeSlmvH3LGZgbeEPWczKgeSxTbruUdFYdC5Hofc6em1ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BH3r5p3dkFUSM4CjnTP+PtK3GedpKcBSkt3Memes7rg=;
	b=D1xbyjAYcbKJHS/ictvCCNxDYA+2n9S5QsE+jA/+sFwfeIO67U+6P7WZBlmtP3NpMsf6
	 7Ec9zTVNfbwPSTNremnB05xyuHmnrZwSsIP1vHPkC/22Mu7mIW0T0Ty5QrnlUbz6W+9oT
	 DcUUbzrFWs+a9hsRJNO8V5mJcgl7ZRVZNgEVzzSVluhF6pgUZN7iM5DEHALBaCPFtHsxG
	 /0ssU1JLpT2nE3vFftBkx2mdb+5NxttHThXzBn5MtAX1Z/S0yETrk+llruSs9TwinKW/b
	 hwHF0FpkqdoR+u2w7TtUdRdVv2W2jBMoubfQS5dysFGL5llJhgHS8rQNQL1L+8M1Tcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ncsu.edu;
	spf=pass smtp.mailfrom=ncsu.edu;
	dkim=pass header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=fqWnr9sL;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AD60A2638
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 15:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906AD60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=fqWnr9sL
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93cb9e9405fso225464285a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1793721460; x=1794326260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BH3r5p3dkFUSM4CjnTP+PtK3GedpKcBSkt3Memes7rg=;
        b=fqWnr9sLvLKCNwXQxULueqtAQhF0csCZCwvjtYwxiGq+JdAV9KggQ7sUTZ1mdCrzHZ
         V41fZo1WWxFgLtupyYhTL+jZ9ti0ki9KZ4OSA3oiV7RLICtCFze02SuSv+nA7j43Lgtx
         efGGZKPB/92rJiW9WSkm5YjDkWJRILGZb5Dqch3YsmYaJD37LRqwjO5UBZYzfCYPuKA2
         TtbAHns/w75DfvNbesJQBHXojWTGt745/pkS+s5MhFZRxZ4Ki3FfKKn/LQnzF2Fu9QHT
         iTdhKA3XsEUrsrx+KfaIjOIyWqrsndvMMBdtKpZUR22AbHMJxzwIaDKftoUORCIo3HbR
         NGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721460; x=1794326260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BH3r5p3dkFUSM4CjnTP+PtK3GedpKcBSkt3Memes7rg=;
        b=1jRPBibC1dctyVv2Ru4SwhrXnXbsuJ1lz0jpBZNMH2yn4ptOwfwHCgyxBnLgctVlKk
         ZLUUxfDJCmUTqFhjrq3VT+32b6coY9CMnludYZug0GPp3J/3H27n6K3/FNdDRz6BBz/Y
         PMrmjV6Pn8MJ8Fysb/cXdw9+zRDrKiWldDc2K4pSikwy7XalUuYZnb07g7o0qGbCy3yA
         B1ooEibFBe0eQ4rLJeMs1DwjlpMYE9M8R+KdhoR9dj2KmxJJLCEe5fIkfoGUUTqHHof/
         W0ySClooLWduXubycA7GAs3qTfi98RhSh7TnHFAxpeQ4anYKS+H0IJrHCSzwioIxXdjX
         wRkg==
X-Forwarded-Encrypted: i=1; AKwUvBwtaERaJDcmWwfhka+29XDlJxO3VesqthwtZwczOxtyLOc/ez1G0kXG8/MTdj69Un8kbxVuSviOQPgqBCNTeBnQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9y6rqhfhASXO/A3r3rIhbu6ITuqSX2qVjQU7FIJPhlfSEJhvF0
	3OLERQOeLtEkepN0nqeDTqSnHTlWfbjHZ/b7YwG/bYdsgolcRjPp9epQmDGI2HAAyw==
X-Gm-Gg: AYBFou2F3LxBuNV4xh4obxxmXu/6XbJxuSBZW8/ZukvXvt+QYXUPiCo1qOvtNysLnXi
	S6ZZAn/hHiaLvX1u2jwKExKiVoGyIKSVFd9d7Wn2gTbTL2bfMXq6Gd5dVjwAvvnBfFfxplx7zD3
	GFHj6Jjx1j5vqbteRZ7NqUHqvGthxeuoR23P4Eatle6GfsKoNOabuEoNDqcg/RbJKBkU8OtcKnq
	VxuXmb9g00xa0cyOHcgHYrBpR4d7Mq6wXStvvSGT+NNjf0ijLbzDBcHu3c8PfcSLqCj5Q1wl10u
	vN4oLQellCMciZo/aKe2aH9tJwr4339Y2NcoxgWbsITweR8XO3LEJ2RsjE2Fi3U4z+W9s14gLjo
	Plz4mdDLeol3KkfGFtPR27dosPnzm6Zy2Vdc+1XwCjMAV2kcd0eBFnKVYTaME9DSWMMVe5uPJdQ
	X7FJMJjxitTva0yG9wozqBWc64HzY57BBZ7KbZX60a53ZsA+u+CXswZnoAtcnstKstjYnSFLDmn
	m7qqMv75m7Lrx/YG5TzjSn4xP4OOC5y/8n9RBbGa+p8d6oQF306yhOJpbUhlR1CcuVPh5+StDBR
	KdWgL+MAEa1X30qr8PQucJBuf3RMkOjJmh+D6Gq+Hrq9MC6GeeZgnJ+yHDB0TW9h4XATgiDkyVt
	8feOtEVsnOlaukDwQ7jyVIy+xrOik1uVG4iT8MB3oCME=
X-Received: by 2002:a05:620a:a2c1:10b0:945:c6bd:16be with SMTP id af79cd13be357-945c6bd17b0mr298417885a.10.1793721460174;
        Tue, 03 Nov 2026 07:57:40 -0800 (PST)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425a7195esm1113191985a.27.2026.11.03.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:57:39 -0800 (PST)
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
Subject: [PATCH v4 2/3] perf dwarf-aux: Add C++ vtable helpers
Date: Tue,  3 Nov 2026 10:56:49 -0500
Message-ID: <20261103155650.269973-3-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103155650.269973-1-yzhao62@ncsu.edu>
References: <20261103155650.269973-1-yzhao62@ncsu.edu>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DWARF helper functions needed to resolve C++ virtual function calls
statically in the data type profiling:

- die_get_vtable_index() returns the vtable slot index of a virtual
  function DIE from DW_AT_vtable_elem_location.  DWARF defines the
  attribute as a location description of the slot but GCC and Clang
  both emit the slot index as a single DW_OP_constu, which is also how
  debuggers interpret it.

- die_find_virtual_func() finds the virtual function DIE at a given
  vtable slot index of a class.  The (primary) vtable of a class starts
  with the vtable of its primary base class, i.e. the first non-virtual
  base class at offset 0 which has a vtable, and the slots for virtual
  functions introduced by the class come after that.  So it looks at
  the class first and then follows the primary base class chain.
  Non-primary base classes have their own secondary vtables with a
  different slot numbering, so they are not searched.  Note that an
  empty base class can be placed at offset 0 too (empty base
  optimization) and it comes before the primary base in DWARF if it's
  declared first, like 'struct Derived : Empty, Base'.  So the base
  class needs to be checked if it has the vtable pointer at offset 0.

- die_is_vtbl_ptr_type() checks if a type is the vtable pointer.
  Compilers add the vtable pointer as an artificial member named
  '_vptr.<class>' (GCC) or '_vptr$<class>' (Clang) to the class that
  first introduces virtual functions, and both give it a type of
  pointer to a pointer type named '__vtbl_ptr_type'.  Checking the
  type is cheap once a member type is resolved, so the instruction
  tracking can use it on every pointer access without an extra DWARF
  lookup.

- die_get_vptr_class() checks if the member at an offset of a class is
  the vtable pointer, following DW_TAG_inheritance into base class
  subobjects like die_get_member_type(), and returns the class whose
  vtable it points to.  Since
  the primary vtable of a derived class extends the one of its base,
  the vtable pointer at offset 0 is returned as the vtable of the
  (derived) class itself, and only when a non-primary base subobject at
  a non-zero offset is entered it's the vtable of that base class.
  die_deref_vptr_class() is a variant for an access through a pointer
  to the class like die_deref_ptr_type().

The walks over the base classes in die_find_virtual_func() and
die_get_vptr_class() are bounded by MAX_TYPE_CHASE like the other type
chases, in case of broken debug info with cyclic inheritance.

For example, with the following classes (GCC 15, -O2 -g):

  struct Base {
      long a;
      virtual long get(long x);
      virtual void set(long v);
  };
  struct Other {
      long c;
      virtual long hi();
  };
  struct Multi : Base, Other {
      long d;
      long get(long x) override;
      long hi() override;
  };

the vtable pointers and slot indexes are described like below:

  <1><10b>: Abbrev Number: 15 (DW_TAG_structure_type)
     <10c>   DW_AT_name        : Base
  <2><14d>: Abbrev Number: 25 (DW_TAG_member)
     <14e>   DW_AT_name        : _vptr.Base
     <152>   DW_AT_type        : <0x2bf>
     <156>   DW_AT_data_member_location: 0
  <2><15f>: Abbrev Number: 17 (DW_TAG_subprogram)
     <160>   DW_AT_name        : get
     <16e>   DW_AT_virtuality  : 1        (virtual)
     <16e>  DW_AT_vtable_elem_location: (DW_OP_constu: 0)
  <2><188>: Abbrev Number: 38 (DW_TAG_subprogram)
     <189>   DW_AT_name        : set
     <194>   DW_AT_virtuality  : 1        (virtual)
     <195>  DW_AT_vtable_elem_location: (DW_OP_constu: 1)
  ...
  <1><2f>: Abbrev Number: 15 (DW_TAG_structure_type)
     <30>   DW_AT_name        : Multi
  <2><3e>: Abbrev Number: 20 (DW_TAG_inheritance)
     <3f>   DW_AT_type        : <0x10b>                        # Base
     <43>   DW_AT_data_member_location: 0
  <2><44>: Abbrev Number: 20 (DW_TAG_inheritance)
     <45>   DW_AT_type        : <0x1d0>                        # Other
     <49>   DW_AT_data_member_location: 16
  <2><a2>: Abbrev Number: 17 (DW_TAG_subprogram)
     <a3>   DW_AT_name        : get
     <b1>   DW_AT_vtable_elem_location: (DW_OP_constu: 0)
  <2><cb>: Abbrev Number: 17 (DW_TAG_subprogram)
     <cc>   DW_AT_name        : hi
     <d9>   DW_AT_vtable_elem_location: (DW_OP_constu: 4)

Multi::hi() is at slot 4 of the primary vtable of Multi (after get,
set and the two destructor entries), while Other::hi() is at slot 0
of the vtable of Other.  Thus for a 'Multi *' the vtable pointer at
offset 0 is looked up with Multi: slot 4 finds Multi::hi() and slot 1
finds Base::set() through the primary base.  The vtable pointer at
offset 16 belongs to the Other subobject, so it's looked up with Other
where slot 0 finds Other::hi().

Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---
Changes in v4:
- No change (rebased).  Add Reviewed-by from Namhyung.

Changes in v3:
- Check the value of DW_AT_virtuality instead of its presence, as it
  can be DW_VIRTUALITY_none (Sashiko, Namhyung).
- Bound the base class walks in die_find_virtual_func() and
  die_get_vptr_class() with MAX_TYPE_CHASE and bail out, in case of
  broken debug info with cyclic inheritance (Sashiko, Namhyung).

Changes in v2:
- Drop the DW_AT_vtable_elem_index fallback which does not exist in
  DWARF (0x8c is DW_AT_loclists_base) (Namhyung).
- Drop the DW_LANG_C_plus_plus_* fallback macros; they are enum
  constants and the language check is not needed anymore (Namhyung).
- Drop cu_get_language(), cu_is_cplusplus(), die_get_base_class(),
  die_get_parent() and die_find_member_by_offset() which are unused
  or duplicate die_get_member_type() (Namhyung, Sashiko).
- Document that die_get_vtable_index() returns the vtable slot index
  of the function.  GCC and Clang both emit DW_AT_vtable_elem_location
  as a single DW_OP_constu with the slot index, not a byte offset
  (Namhyung, Sashiko).
- Fix die_find_virtual_func() to return the DW_TAG_subprogram DIE
  instead of the DW_TAG_inheritance DIE when the function is found in
  a base class (Sashiko).
- Follow only the primary base class chain in die_find_virtual_func()
  since non-primary base classes have their own secondary vtables with
  a different slot numbering, and skip an empty base class at offset 0
  which comes before the primary base in DWARF.
- Add die_is_vtbl_ptr_type() to identify the vtable pointer by its
  type ('__vtbl_ptr_type') and die_get_vptr_class() /
  die_deref_vptr_class() to get the class of the vtable pointer
  through base class subobjects, replacing die_find_member_by_offset()
  and die_is_vptr_member().
 tools/perf/util/dwarf-aux.c | 233 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  18 +++
 2 files changed, 251 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index eb4b8f3475df..10079f47a6c3 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2293,6 +2293,239 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 	return die_mem;
 }
 
+/**
+ * die_get_vtable_index - Get the vtable slot index of a virtual function
+ * @func_die: a DW_TAG_subprogram DIE
+ *
+ * Returns the index of the slot of @func_die in the vtable of its class or
+ * -1 if it's not a virtual function.  DWARF defines the
+ * DW_AT_vtable_elem_location as a location description of the slot, but
+ * both GCC and Clang emit the slot index as a single DW_OP_constu (or
+ * DW_OP_litN) and it's what debuggers expect too.
+ */
+int die_get_vtable_index(Dwarf_Die *func_die)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Op *expr;
+	size_t nexpr;
+
+	if (dwarf_attr_integrate(func_die, DW_AT_vtable_elem_location, &attr) == NULL)
+		return -1;
+
+	if (dwarf_getlocation(&attr, &expr, &nexpr) < 0 || nexpr != 1)
+		return -1;
+
+	if (expr[0].atom == DW_OP_constu)
+		return expr[0].number;
+
+	if (expr[0].atom >= DW_OP_lit0 && expr[0].atom <= DW_OP_lit31)
+		return expr[0].atom - DW_OP_lit0;
+
+	pr_debug("Unexpected vtable_elem_location OP %x\n", expr[0].atom);
+	return -1;
+}
+
+static int __die_find_virtual_func_cb(Dwarf_Die *die_mem, void *arg)
+{
+	int index = (long)arg;
+
+	if (dwarf_tag(die_mem) != DW_TAG_subprogram)
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_vtable_index(die_mem) == index)
+		return DIE_FIND_CB_END;
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/*
+ * Find the primary base class: the first non-virtual base class at offset 0
+ * which has a vtable.  Note that an empty base class can also be placed at
+ * offset 0 (empty base optimization) before the primary base.
+ */
+static int __die_find_primary_base_cb(Dwarf_Die *die_mem, void *arg __maybe_unused)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Die base_die, vptr_die;
+	Dwarf_Word loc, virtuality;
+
+	if (dwarf_tag(die_mem) != DW_TAG_inheritance)
+		return DIE_FIND_CB_SIBLING;
+
+	/* The attribute can be present with DW_VIRTUALITY_none */
+	if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr) &&
+	    dwarf_formudata(&attr, &virtuality) == 0 &&
+	    virtuality != DW_VIRTUALITY_none)
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_data_member_location(die_mem, &loc) < 0 || loc != 0)
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_real_type(die_mem, &base_die) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	/* It should have the vtable pointer at offset 0 */
+	if (die_get_vptr_class(&base_die, 0, &vptr_die) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	return DIE_FIND_CB_END;
+}
+
+/**
+ * die_find_virtual_func - Find a virtual function by its vtable slot index
+ * @class_die: a class type DIE
+ * @index: index of the slot in the vtable of @class_die
+ * @die_mem: a buffer for result DIE
+ *
+ * Search a DW_TAG_subprogram DIE at the slot @index of the vtable of
+ * @class_die and store the DIE to @die_mem and returns it if found.  The
+ * (primary) vtable of a class starts with the vtable of its primary base
+ * class, that is the first non-virtual base class at offset 0 which has a
+ * vtable, and virtual functions introduced by the class come after that.
+ * So if @class_die doesn't have a virtual function with the @index, it
+ * continues to the primary base.  Other (non-primary) base classes have
+ * their own secondary vtables where the index is different, so they are
+ * not searched.
+ *
+ * Returns NULL if not found.
+ */
+Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index,
+				 Dwarf_Die *die_mem)
+{
+	Dwarf_Die cur_die = *class_die;
+	Dwarf_Die base_die;
+	int chase = 0;
+
+	while (die_is_compound_type(&cur_die)) {
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: base class chase limit reached at DIE 0x%lx\n",
+				 (unsigned long)dwarf_dieoffset(class_die));
+			return NULL;
+		}
+
+		if (die_find_child(&cur_die, __die_find_virtual_func_cb,
+				   (void *)(long)index, die_mem))
+			return die_mem;
+
+		if (die_find_child(&cur_die, __die_find_primary_base_cb,
+				   NULL, &base_die) == NULL)
+			break;
+
+		if (die_get_real_type(&base_die, &cur_die) == NULL)
+			break;
+	}
+	return NULL;
+}
+
+/**
+ * die_is_vtbl_ptr_type - Check if the type is a C++ vtable pointer
+ * @type_die: a type DIE
+ *
+ * Compilers add the vtable pointer as an artificial member to the class
+ * that introduces virtual functions first.  Both GCC and Clang give it a
+ * type of pointer to a pointer type named "__vtbl_ptr_type", so it can
+ * be identified by the type without looking at the member name.
+ */
+bool die_is_vtbl_ptr_type(Dwarf_Die *type_die)
+{
+	Dwarf_Die ptr_die;
+	const char *name;
+
+	if (dwarf_tag(type_die) != DW_TAG_pointer_type)
+		return false;
+
+	if (die_get_real_type(type_die, &ptr_die) == NULL)
+		return false;
+
+	name = dwarf_diename(&ptr_die);
+	return name != NULL && !strcmp(name, "__vtbl_ptr_type");
+}
+
+/**
+ * die_get_vptr_class - Get the class of the vtable pointer at the offset
+ * @type_die: a class type DIE
+ * @offset: offset of the accessed member in @type_die
+ * @die_mem: a buffer for result DIE
+ *
+ * Check if the member at @offset in @type_die is a vtable pointer and
+ * return the class DIE whose vtable it points to.  The vtable pointer is
+ * a member of the class that introduces virtual functions first, so it
+ * follows DW_TAG_inheritance to look into the base class subobjects like
+ * die_get_member_type().
+ *
+ * Note that the vtable pointer at offset 0 belongs to the (primary) vtable
+ * of @type_die itself as it extends the one of the primary base class.
+ * Only when a non-primary base class subobject (at non-zero offset) is
+ * entered, it points to a separate vtable of the base class.
+ *
+ * Returns NULL if the member at @offset is not a vtable pointer.
+ */
+Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
+			      Dwarf_Die *die_mem)
+{
+	Dwarf_Die class_die = *type_die;
+	Dwarf_Die vptr_class = *type_die;
+	Dwarf_Die member_die, mb_type;
+	Dwarf_Word loc;
+	int chase = 0;
+
+	while (die_is_compound_type(&class_die)) {
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: base class chase limit reached at DIE 0x%lx\n",
+				 (unsigned long)dwarf_dieoffset(type_die));
+			return NULL;
+		}
+
+		if (die_find_child(&class_die, __die_find_member_offset_cb,
+				   (void *)(long)offset, &member_die) == NULL)
+			return NULL;
+
+		if (dwarf_tag(&member_die) == DW_TAG_member) {
+			if (die_get_real_type(&member_die, &mb_type) == NULL ||
+			    !die_is_vtbl_ptr_type(&mb_type))
+				return NULL;
+
+			*die_mem = vptr_class;
+			return die_mem;
+		}
+
+		/* DW_TAG_inheritance: go into the base class subobject */
+		if (die_get_data_member_location(&member_die, &loc) < 0)
+			return NULL;
+
+		if (die_get_real_type(&member_die, &class_die) == NULL)
+			return NULL;
+
+		offset -= loc;
+		if (loc != 0)
+			vptr_class = class_die;
+	}
+	return NULL;
+}
+
+/**
+ * die_deref_vptr_class - Get the class of the vtable pointer via pointer access
+ * @ptr_die: a pointer type DIE
+ * @offset: offset of the accessed member from the pointer
+ * @die_mem: a buffer for result DIE
+ *
+ * Same as die_get_vptr_class() but for an access through a pointer to the
+ * class, like die_deref_ptr_type().
+ */
+Dwarf_Die *die_deref_vptr_class(Dwarf_Die *ptr_die, int offset,
+				Dwarf_Die *die_mem)
+{
+	Dwarf_Die type_die;
+
+	if (dwarf_tag(ptr_die) != DW_TAG_pointer_type)
+		return NULL;
+
+	if (die_get_real_type(ptr_die, &type_die) == NULL)
+		return NULL;
+
+	return die_get_vptr_class(&type_die, offset, die_mem);
+}
+
 /**
  * die_deref_ptr_type - Return type info for pointer access
  * @ptr_die: a pointer type DIE
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 7c893e385824..803182cdff8a 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -26,6 +26,24 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 /* Check if DIE is a compound type (structure, union, or class) */
 bool die_is_compound_type(Dwarf_Die *type_die);
 
+/* Get the vtable slot index of a virtual function (-1 if not virtual) */
+int die_get_vtable_index(Dwarf_Die *func_die);
+
+/* Find the virtual function at the vtable slot index of a class */
+Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index,
+				 Dwarf_Die *die_mem);
+
+/* Check if the type is a C++ vtable pointer (pointer to __vtbl_ptr_type) */
+bool die_is_vtbl_ptr_type(Dwarf_Die *type_die);
+
+/* Get the class of the vtable pointer at the offset of a type (or NULL) */
+Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
+			      Dwarf_Die *die_mem);
+
+/* Get the class of the vtable pointer at the offset from a pointer (or NULL) */
+Dwarf_Die *die_deref_vptr_class(Dwarf_Die *ptr_die, int offset,
+				Dwarf_Die *die_mem);
+
 /* Get a line number and file name for given address */
 int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
 		     const char **fname, int *lineno);
-- 
2.53.0

