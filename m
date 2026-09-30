Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1893E1681
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802058; cv=none; b=CAFTPF2B3DA/6o57q4a5T9rBehIUkqbRAUyJcdxoB2AXDRcVK0MeDEZNe+ao1m3hMsCl4Umy03w5cbhI6DYH5Mt9SzQNeDcW09FqxqkAieyl19OlIZAq6zOAMvuLLQCP87lwod/Vn+VFBQ0AD8iT+7sPAr9LGrhw6+TOt8iwi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802058; c=relaxed/simple;
	bh=gFMg6q1TiNC/5q0bOvHfPBh2rN+HWfW92KVwbVMwGGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv4phCwSaWsNdKoz/0pTf6fbJ3wjspR62Ynhq+244C3VrrAHugKt6/2EbSShJpWO9SJxaiLKJ34FWe6/UmglVhWBTsGEkvZPPxXSbepPk+xwk5IIPVGmLuUeZbdpUNLzefAb1iuYX5t/nPVQdIMBbQgkM+GNUcxiW8HWijsQJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=fDtd2WBo; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="fDtd2WBo"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-670fee39d73so6437382d50.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1790802055; x=1791406855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CmX6ioAYxJPCAPz0/Bhdwb/CbObsNSPjxI3S26V74U=;
        b=fDtd2WBoXqJ/djkErZosWbHRFERb7T+OqAqQ2YBAhAG7i0jqjFUvOUgJ/rBfbIe/7K
         3QKFpan3i7RHSmwLF+N4cxZZWViGqHPXjbwtGzdsgvYwBuU9OzK0w9An62MjD7I4e3Pt
         U+Jd3TH7Xi5Jn3AbFoxGih/IUeFHOpZ+QBboLNvpdzod1hc8sRJYz5qSlwIUdsqvrG4/
         SorNlZ5HIe3sZusZ90x+ZT4QtDfLnRlrM1/ughLPes9o8plV+Odato6gDc3BP/smUL5f
         sMSmfGKmQvXFfE1KUwiK8DcBEUHkRk+V2Fz22bw7MdVZqI09d3etNj0fMprjimaov5Vb
         UIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802055; x=1791406855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CmX6ioAYxJPCAPz0/Bhdwb/CbObsNSPjxI3S26V74U=;
        b=HZj3R5xIGcDb6OAXTsFW5WG1iP6m3HmyUmPzzHmx6qASiLSkNEsrfKBdDP373qs2q/
         fqMSZTzn9loay4dT2ujkdB8Pa34ovG/3BFhPEGuCYj6wbM113wpEGw0c6Du0IkvBCjvX
         EqCC6dwFJ/zqU7WPmJr4F2KA7f2abN80fevSlhLj7qXPpj6iaQUE1V8gcRkm9Atj9WlG
         OkQZb4++wlCoBHJxD/SbHVHeV57IwkPE/jUY5DopB6AIUSOVoCZQrC3p1UGMhNnXucmj
         hzquB1wx0rVsv6whDesFPEUx4mk96xPKMI7a6KFmt5A2KhaC1sujJ2pq7THmPZ7RwgqT
         zefg==
X-Forwarded-Encrypted: i=1; AKwUvByy3GGQqdvjC39uhsf7UTwaW9EtcLgR4+NqBsu43pWVuw3VAXZQEGq701iitw2yoAU6cYJTAcMP2K9c0tpwF0VH@vger.kernel.org
X-Gm-Message-State: AFq9FYJk+epNLB/vu2rPpdsC6jw85Lv/S9w4o7S6SRKuH50D7rPDhQiM
	cuMVhhwDIQQeiJyltrNMSL4JZmtEXoxsFyayDlZJRhb9U5e+NvLl9zUjysZOITbUCQ==
X-Gm-Gg: AYBFou3xLvr4NUb2C8eZKsZwZ/W898GrqKXa4F3qSjIemlEeBswDG/qb80Dt+AFRExZ
	xJuqEpdKm9fuUEVSz3BeL9/zgx3DM+moIo9BWTNJpxhSooOESPRVjKGaCqqMecGjDh1H4AouHCc
	MyYUgW93Uba2XRmaLujoERA4NxSpmzd7DpmgucOkEYnRyu/o6PqUNR1xM7fFJicnO+Je/y5AGPd
	QePUcdWfYNic9zeLw9cnQH10mNhj9VWtDJbyLENfIXgklISjm7yyJtV1uoa2cMrdI3WkJdV/rih
	A+6KBmOxUi7fWeIdZEN29meGfK79Ii7I8b2LyyTjyr4Tac7AFJARyC0JQJNFS40su112JWr30CO
	IG5A+/dbXMxFc6qz6KeURIqNdmKERfiwB2pZWiX8HT27xusHtpyjzceSD+4KG2aUv1PPsgBpfwf
	p/y+MrEgv/ayB0cnEVoHRzeIz32I3232heBTnDM3O8Cet6qz5xKaMr9GZUdS0EeksnCPb1XzwHI
	vLcXU3U+5k9T1EtMmAMvpdjZo8/RZhYJKWxgxw2edH/qLQjpUWvoAg0dSV5m6fTcM4=
X-Received: by 2002:a05:690e:400a:b0:676:85dc:84d1 with SMTP id 956f58d0204a3-67685dc8598mr1439532d50.41.1790802054128;
        Wed, 30 Sep 2026 14:00:54 -0700 (PDT)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a579d8sm8580336d6.38.2026.09.30.14.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:00:53 -0700 (PDT)
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
Subject: [PATCH v2 2/3] perf dwarf-aux: Add C++ vtable helpers
Date: Wed, 30 Sep 2026 17:00:37 -0400
Message-ID: <20260930210038.196928-3-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210038.196928-1-yzhao62@ncsu.edu>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
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
---
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

 tools/perf/util/dwarf-aux.c | 216 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  18 +++
 2 files changed, 234 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index eb4b8f3475df..b1f3dca057ab 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2293,6 +2293,222 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
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
+	Dwarf_Word loc;
+
+	if (dwarf_tag(die_mem) != DW_TAG_inheritance)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr))
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
+
+	while (die_is_compound_type(&cur_die)) {
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
+
+	while (die_is_compound_type(&class_die)) {
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

