Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584E3F4856
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288558; cv=none; b=FST9T1pBxWzHMfUhkEEUbkb9iaNu0sWphx/bCmXlDme5P1zePb/exqqFrJAT8Zjp8veMPcGjyovTnYCMa0L1AS1IbjXDiMSgcuZ0l6ZVyUyWCJtzEohw3whaS2eRAu7nmr3uh46MMLtq9WjB0rDqA40YyufWz3NuJfhhWDJVkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288558; c=relaxed/simple;
	bh=D/tw0w8eAa3nSDuVMYf/sW/Q8H627uckPE9TlM6qwqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Px8aJpbxqWri0J/H46bgBWe1j3ekeVH/WOPY7/SdsGVTB0/zEZKnkmazdaOIqLxp2LDpNlIBNdcilTifHGN5m9c+3kUotqRqo9eJPRFXHkjJ7JT43GfpUMuYSSAEY+g10zMVmZ6Fd/vAa5TPX3MrEanBO8Mxv89l+3xsMImzoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=If27CtRH; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="If27CtRH"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f0e5e36912so3803456d6.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1787288555; x=1787893355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OzB1aNn1o04f40kFNNF+EY0tTOWmlsfUCuB6g5UoRcM=;
        b=If27CtRHZF8OX3cWBs/mmaNyu7MaFc6NlQf1Edgt/pwXj72K0WPbRd/FoZq3ekfa4r
         YpFcfs2Jkq1vJcTdbJB44dLZP+mipGqT6yC9mM+SNwERZbjuOs6lTXlAvNaHr7vs8r77
         qE4kidgKNkfUrtVoQz3Ho4zTScUOds/Kw0h8ktdjOYcQ6OaXxQae86oLza9NeC2+UUGg
         yksNXOmV69znZsWukkt4XmD6wpGn9h5/QPJuzwrAieg3mdKt29ok/0JhUBL+IwCGmPHT
         ZwnS5mlTpuYd4ZRCDqOwwvWKary/bf2mpow73mijhh2AC7MB8GncIGS6nQ4MojBQ59ct
         3LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288555; x=1787893355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OzB1aNn1o04f40kFNNF+EY0tTOWmlsfUCuB6g5UoRcM=;
        b=ADjilZ5aDaWTRzH9Cp/6MVvqNnzlmpBrYsJzynUfvh11puQDBE3WJB2z25G+KGCp5v
         ULkTA4J8NjByvUeATX4qNOH64oXYBfr9BhN5a7ZhVyCnm9kyD+I8Rotyy79MUJfgpzMy
         5Xlsi/FSVMyVu5j90FHXMVQpXv6diMSY7zdNMkG692T9CW5wsu5chXYRO56lVvxgv78A
         MhXtRW0OBoV0y5EtIcQnBUUAswz1JgV/+i7mYLw2pwhYQ3Q/FvsEI9GLvHJC6oHSBFiv
         /RNemg38mVntnkT1otGvbrhsK/5LnYscjU9y5YtSXAMWhET+YRVtOqONcVG/3mPZXUKF
         C9sA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2Apr+AHMEOkBcV5TpzkHy2mpnJGqvgot3dm6maGR2zNGgMkB0rDpTif8zHqsRxmfmrMT74wlVrH38QvPDRwuI@vger.kernel.org
X-Gm-Message-State: AFuF++k39qA5KItJbhgnqaG4hcRoZJcDmyDn1ZmlE5u8HNe8lRxgnbIb
	5K/7PiOx3En2SFxHHCj+m0nOyDlZvdZXcweKs5efjR5BXSUy04+uoS4TcBSgjmpfhg==
X-Gm-Gg: AR+sD11Gb9vhDdrCZS8G1T5pTzwoOLe/JdoD65vOTPpsNcD+6AN4tGcYtugCU6ttbkD
	Aincxd7hUeQ5roOOdGN6xvMZf3ggK4FL5ycT+ryFoUe4F/7oBGOgInS2qtdD1aNpdT23clCL4cu
	WrXTK349cXiutV51vStThgaDfiKbyZIzkJA8xU4v0mavZa3io28URLq/+ypiiIFdGDMwkF7Zg50
	Uk6nV9WqVyP7M117wxO3oSX8Ww0jtlUK/UQ6kaWl3nT6nCZWAr+DbEaTYNX+OysT6Afs9WgLMZf
	Ft/IY4BzaVUK8ShxjH7qusCa1QjEperO0b08NSzDhCDr8kwDNvTlTSs/c7S2UfL16dCQkNQNP/j
	qXLerjtwkjlgcbs7t1Lq8Uvr1rI6PsQrgjMfhMf/LVtvNGo2Sn1mGSsTJtVQx6XvcVRISrV+swb
	W+MY5ouD9bALaL28VjWRJsuL74AfW0Safet3dk5b8Ul1ZW0CyxxrM6yKnZdRSLqCAKGxCxvvwz5
	BFH6W4V4clFwknj4ejr
X-Received: by 2002:a05:6214:124d:b0:8ee:5e59:7b04 with SMTP id 6a1803df08f44-90c80e00b57mr32278996d6.18.1787288555148;
        Thu, 20 Aug 2026 22:02:35 -0700 (PDT)
Received: from home.localdomain ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec1e7fsm54368116d6.12.2026.08.20.22.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:02:34 -0700 (PDT)
From: Yanbo Zhao <yzhao62@ncsu.edu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanbo Zhao <yzhao62@ncsu.edu>
Subject: [PATCH 2/3] perf dwarf-aux: Add C++ class, inheritance and vtable helpers
Date: Fri, 21 Aug 2026 01:02:06 -0400
Message-Id: <20260821050207.4517-3-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821050207.4517-1-yzhao62@ncsu.edu>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DWARF helper functions for C++ virtual function support:
- cu_get_language() and cu_is_cplusplus() to detect source language.
- die_get_base_class() and die_get_vtable_index() for virtual table
  inspection.
- die_get_parent() to retrieve enclosing scopes.
- die_find_member_by_offset() and die_find_virtual_func() to locate
  class members and virtual function DIEs.
- die_is_vptr_member() to check if a member is a virtual table pointer.
- Define DW_AT_vtable_elem_index and DW_LANG_C_plus_plus_17/20
  fallbacks for older elfutils that lack these DWARF 5 constants.

Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
---
 tools/perf/util/dwarf-aux.c | 192 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  24 +++++
 2 files changed, 216 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 88ba0ec23a68..e991eed963a8 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -12,6 +12,19 @@
 #include "dwarf-regs.h"
 #include "strbuf.h"
 #include "string2.h"
+#include "symbol.h"
+
+#ifndef DW_AT_vtable_elem_index
+#define DW_AT_vtable_elem_index 0x8c
+#endif
+
+/* Added in DWARF 5, may be missing in older elfutils */
+#ifndef DW_LANG_C_plus_plus_17
+#define DW_LANG_C_plus_plus_17 0x2a
+#endif
+#ifndef DW_LANG_C_plus_plus_20
+#define DW_LANG_C_plus_plus_20 0x2b
+#endif
 
 /**
  * cu_find_realpath - Find the realpath of the target file
@@ -60,6 +73,37 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
 	return dwarf_formstring(&attr);
 }
 
+Dwarf_Word cu_get_language(Dwarf_Die *cu_die)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Word lang;
+
+	if (dwarf_attr(cu_die, DW_AT_language, &attr) == NULL)
+		return 0;
+
+	if (dwarf_formudata(&attr, &lang) != 0)
+		return 0;
+
+	return lang;
+}
+
+bool cu_is_cplusplus(Dwarf_Die *cu_die)
+{
+	Dwarf_Word lang = cu_get_language(cu_die);
+
+	switch (lang) {
+	case DW_LANG_C_plus_plus:
+	case DW_LANG_C_plus_plus_03:
+	case DW_LANG_C_plus_plus_11:
+	case DW_LANG_C_plus_plus_14:
+	case DW_LANG_C_plus_plus_17:
+	case DW_LANG_C_plus_plus_20:
+		return true;
+	default:
+		return false;
+	}
+}
+
 bool die_is_compound_type(Dwarf_Die *type_die)
 {
 	int tag = dwarf_tag(type_die);
@@ -68,6 +112,90 @@ bool die_is_compound_type(Dwarf_Die *type_die)
 	       tag == DW_TAG_class_type;
 }
 
+static int __die_find_inheritance_cb(Dwarf_Die *die_mem, void *arg)
+{
+	int tag = dwarf_tag(die_mem);
+
+	if (tag == DW_TAG_inheritance) {
+		*(Dwarf_Die *)arg = *die_mem;
+		return DIE_FIND_CB_END;
+	}
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+Dwarf_Die *die_get_base_class(Dwarf_Die *class_die, Dwarf_Die *base_die, int *offset)
+{
+	Dwarf_Die inherit_die;
+	Dwarf_Attribute attr;
+	Dwarf_Word loc;
+
+	if (die_find_child(class_die, __die_find_inheritance_cb,
+			   &inherit_die, &inherit_die) == NULL)
+		return NULL;
+
+	if (__die_get_real_type(&inherit_die, base_die) == NULL)
+		return NULL;
+
+	if (dwarf_attr_integrate(&inherit_die, DW_AT_data_member_location, &attr) &&
+	    dwarf_formudata(&attr, &loc) == 0) {
+		*offset = loc;
+	} else {
+		*offset = 0;
+	}
+
+	return base_die;
+}
+
+int die_get_vtable_index(Dwarf_Die *func_die, int *index)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Word idx;
+
+	/* Try DW_AT_vtable_elem_index first (DWARF 5+) */
+	if (dwarf_attr(func_die, DW_AT_vtable_elem_index, &attr) &&
+	    dwarf_formudata(&attr, &idx) == 0) {
+		*index = idx;
+		return 0;
+	}
+
+	/* Fallback to DW_AT_vtable_elem_location (older DWARF) */
+	if (dwarf_attr(func_die, DW_AT_vtable_elem_location, &attr)) {
+		Dwarf_Op *expr;
+		size_t expr_len;
+
+		/* Compile often emits it as a simple constant expression or block */
+		if (dwarf_getlocation(&attr, &expr, &expr_len) == 0 && expr_len > 0) {
+			if (expr[0].atom == DW_OP_constu) {
+				*index = expr[0].number;
+				return 0;
+			}
+			if (expr[0].atom >= DW_OP_lit0 && expr[0].atom <= DW_OP_lit31) {
+				*index = expr[0].atom - DW_OP_lit0;
+				return 0;
+			}
+		}
+	}
+
+	return -1;
+}
+
+Dwarf_Die *die_get_parent(Dwarf_Die *die, Dwarf_Die *parent_die)
+{
+	Dwarf_Die *scopes = NULL;
+	int n = dwarf_getscopes_die(die, &scopes);
+
+	if (n <= 1) {
+		free(scopes);
+		return NULL;
+	}
+
+	/* scopes[0] is the DIE itself, scopes[1] is the parent */
+	*parent_die = scopes[1];
+	free(scopes);
+	return parent_die;
+}
+
 /* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
 static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
 {
@@ -2164,6 +2292,70 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 	return die_mem;
 }
 
+Dwarf_Die *die_find_member_by_offset(Dwarf_Die *type_die, int offset, Dwarf_Die *member_die)
+{
+	if (!die_is_compound_type(type_die))
+		return NULL;
+
+	return die_find_child(type_die, __die_find_member_offset_cb,
+			      (void *)(long)offset, member_die);
+}
+
+struct find_virtual_func_data {
+	int index;
+	Dwarf_Die func_die;
+	bool found;
+};
+
+static int __die_find_virtual_func_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_virtual_func_data *ad = arg;
+	int tag = dwarf_tag(die_mem);
+
+	if (tag == DW_TAG_subprogram) {
+		int idx;
+
+		if (die_get_vtable_index(die_mem, &idx) == 0 && idx == ad->index) {
+			ad->func_die = *die_mem;
+			ad->found = true;
+			return DIE_FIND_CB_END;
+		}
+	}
+
+	if (tag == DW_TAG_inheritance) {
+		Dwarf_Die base_type;
+
+		if (__die_get_real_type(die_mem, &base_type)) {
+			if (die_find_child(&base_type,
+					   __die_find_virtual_func_cb,
+					   ad, &ad->func_die))
+				return DIE_FIND_CB_END;
+		}
+	}
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index, Dwarf_Die *die_mem)
+{
+	struct find_virtual_func_data ad = {
+		.index = index,
+		.found = false,
+	};
+
+	if (die_find_child(class_die, __die_find_virtual_func_cb, &ad, die_mem))
+		return die_mem;
+
+	return NULL;
+}
+
+bool die_is_vptr_member(Dwarf_Die *die)
+{
+	const char *name = dwarf_diename(die);
+
+	return name && strstarts(name, "_vptr");
+}
+
 /**
  * die_deref_ptr_type - Return type info for pointer access
  * @ptr_die: a pointer type DIE
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 855c45fec5bb..0f30f44ad863 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -23,9 +23,33 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 /* Get DW_AT_comp_dir (should be NULL with older gcc) */
 const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 
+/* Get source language of CU */
+Dwarf_Word cu_get_language(Dwarf_Die *cu_die);
+
+/* Check if CU is C++ */
+bool cu_is_cplusplus(Dwarf_Die *cu_die);
+
 /* Check if DIE is a compound type (structure, union, or class) */
 bool die_is_compound_type(Dwarf_Die *type_die);
 
+/* Get base class of a class DIE */
+Dwarf_Die *die_get_base_class(Dwarf_Die *class_die, Dwarf_Die *base_die, int *offset);
+
+/* Get vtable index of a virtual function */
+int die_get_vtable_index(Dwarf_Die *func_die, int *index);
+
+/* Get parent DIE */
+Dwarf_Die *die_get_parent(Dwarf_Die *die, Dwarf_Die *parent_die);
+
+/* Find member DIE by offset */
+Dwarf_Die *die_find_member_by_offset(Dwarf_Die *type_die, int offset, Dwarf_Die *member_die);
+
+/* Find virtual function by vtable index */
+Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index, Dwarf_Die *die_mem);
+
+/* Check if member DIE is a vtable pointer (_vptr) */
+bool die_is_vptr_member(Dwarf_Die *die);
+
 /* Get a line number and file name for given address */
 int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
 		     const char **fname, int *lineno);
-- 
2.25.1

