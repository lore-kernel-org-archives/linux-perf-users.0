Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23C3F485D
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288557; cv=none; b=S6kYzRQViEyQsPkkLHQjJBgffMbJJ2lNeSR9aXgfPjE42D0MVJCy+40nxpS1pCSLhdZeuxaAvYbN23R/3n/HLpPc0DFOHtimBOdyXG/mgTNTk2/H+nEE7X/oIWxnTDE/xg/7xADpc08ZsB09LftZUy8Zt9KP6FjVt+PleHudR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288557; c=relaxed/simple;
	bh=bZbm6XOK98Prr6KSnd5pF4eIfpTE8UabYOUOPHg+Lq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDaPEMqc3xuGbmupiI5OB/f6gbSF2IpNsDylf+JHU8skuaISevybJKWsjipKf2yBevTl2/6vGxoasnQY8d3kY9Hxx+m7p4rUoKO/qTtRgQ31LjlU9ruQFpFzjTJbZA4k4tUmeTSKra94qjRtAJY1NrXqKIKS/OIPqEsWd2Y2dGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=FyvsO/Op; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="FyvsO/Op"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90c776f6c13so6191216d6.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 22:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1787288554; x=1787893354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgYq+HSuWV0wHdSKUb0LnpK8mur76MdWfMhpvbEJMks=;
        b=FyvsO/OpA+CIsh3iVjrOw8boeSCt+/JbFoaqfStxl6pKjelP2mD54rzhWRGCDr8rQF
         490Ecae5a7ZS9Xxy+mFCcoLS7yNKm36qXEtYfLBdi80GTMjhFVsPSCDSs+8OtjpgyS1M
         rNxEg1CgNzqXcgAz48WpPFtjMZmTnSX030yqsVY7/3xfBnh5h/10yvcJCO+UqThqFBkO
         LubgHABHbJqfSyAPJYzYJ83nIavT5LkmEBP1/2NF0Utislaf4Iovu8yD2ueLx7r+ra+k
         wTZBzWD7UWZREA2YO8ki244divT8Rg3P5M8XGbmVpK5tlE0w+Oa7XtWriVdXvz1PvEjN
         vg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288554; x=1787893354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JgYq+HSuWV0wHdSKUb0LnpK8mur76MdWfMhpvbEJMks=;
        b=YH+Dv8OcEJRz/xovuo1qga/jYJ+5dz4RiwKpVkseS5hwSz5zJgaQ8i6ayQlJh1/MNW
         C/p2u6uAVUy7a0U+pxlJvp9ectYS27brMw3JdgzLFIzxbzm+XSTk6g5UYyKUzOgPJC53
         CTRwEPJiFiOSXDKfsREfTIQX5RJHFf7io3rNCEjVr3YVKLAqRV2KMv4P9BVeu7wpUqM0
         ja1TMiXaapmLg4luE76avrMbJY66gOwOAq7VQQKU3G1Dg5YPX0yegyglBen51awMe+Ys
         AbC4AjzYM1EfJMOJQ1KgIxk1Ol/t/WJmJzYpZZvvAt/yCG2+WIpgji1m1PZMWEwaGpx+
         R26A==
X-Forwarded-Encrypted: i=1; AHgh+RoH2lENxSM+nyGKdJLKM2TidP1Jy8XPOAagf6nNBMRWcPm4tOU+DxoobBUz2e65N0isYcIpVf/Fu3E4WCBpdQKH@vger.kernel.org
X-Gm-Message-State: AFuF++kmToq1dW9X/dCThNql5tEurerxc1S2PNmZkvNRIcmJJPuoKpYi
	r3Bpeda8mI/TlcMRNP9n/rGQjHYnkD3meSOZFdQOeHOPgdcJDAYH63zcS1SCFOx7Ww==
X-Gm-Gg: AR+sD13UpQBttLjNNo8/KRsC35dNdF35VT6mX46F/4eKrd8BkNFt10yO7FaZiu0h9Ej
	osIDaB1EyayDFNdF8nFs4XD+45w04ril07URUOLRZKENBYt+MP8LWSJE1qktGtNIBie6eMliu5X
	fDIFaURrzN2Nc6H6sgp4dl2nYizDES35iq0RtlOeMjxek0Ojs7O2XtyooQPMlkExgI2Mo9PnRUv
	C9FPiHv5kVVXHnO2RSyR6QCWJvGQpdIuN230GImDqSAazPaA2qfgZ4WMXdcTEpVVbiPe1mkPKXx
	qxbvyfjUrB6yiBYJRF52Z9WRmF/8TkP/NOxEVKj/GSoUgQEbWHYRxn+adkYmZlGpLJ4tLy8ghqk
	uoSLQzCLOcQWsxAHK9gSPVGaytwiyUM3h23VdCml+YIIn1YZkWnhwghvOIuZ5umC3ditRF3drCT
	ydnUGkw37p5Hmn7CX3Lv4xk381UR+1kdHpcXtigJOR3V3dDDk4A5BwUg4GxphryQWXnyem05kac
	u+P1FAApFNpYs6yXz+a
X-Received: by 2002:ad4:5749:0:b0:90c:4e70:e5e0 with SMTP id 6a1803df08f44-90c80943eebmr34589566d6.6.1787288554166;
        Thu, 20 Aug 2026 22:02:34 -0700 (PDT)
Received: from home.localdomain ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec1e7fsm54368116d6.12.2026.08.20.22.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:02:33 -0700 (PDT)
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
Subject: [PATCH 1/3] perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
Date: Fri, 21 Aug 2026 01:02:05 -0400
Message-Id: <20260821050207.4517-2-yzhao62@ncsu.edu>
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

Introduce the die_is_compound_type() helper which checks for
DW_TAG_structure_type, DW_TAG_union_type, and DW_TAG_class_type, and
convert all the existing open-coded struct/union tag checks to use it:
- die_get_member_type() in dwarf-aux.c.
- __add_member_cb(), is_compound_type(), and set_stack_state() in
  annotate-data.c.

Also accept DW_TAG_inheritance in the member lookup callbacks
(__die_find_member_offset_cb() and __add_member_cb()) so that member
lookup by offset descends into C++ base class subobjects.

This extends the existing member type resolution and data type
profiling state handling to C++ classes with inheritance without
changing behavior for C struct/union types.

Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 29 ++++++-----------------------
 tools/perf/util/dwarf-aux.c     | 17 ++++++++++++-----
 tools/perf/util/dwarf-aux.h     |  3 +++
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4e4c58764082..ee6bd2d0012d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -230,9 +230,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	Dwarf_Word size, loc, bit_size = 0;
 	Dwarf_Attribute attr;
 	struct strbuf sb;
-	int tag;
+	int tag = dwarf_tag(die);
 
-	if (dwarf_tag(die) != DW_TAG_member)
+	if (tag != DW_TAG_member && tag != DW_TAG_inheritance)
 		return DIE_FIND_CB_SIBLING;
 
 	member = zalloc(sizeof(*member));
@@ -292,15 +292,8 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	INIT_LIST_HEAD(&member->children);
 	list_add_tail(&member->node, &parent->children);
 
-	tag = dwarf_tag(&die_mem);
-	switch (tag) {
-	case DW_TAG_structure_type:
-	case DW_TAG_union_type:
+	if (die_is_compound_type(&die_mem))
 		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
-		break;
-	default:
-		break;
-	}
 	return DIE_FIND_CB_SIBLING;
 }
 
@@ -464,9 +457,7 @@ static const char *match_result_str(enum type_match_result tmr)
 
 static bool is_compound_type(Dwarf_Die *type_die)
 {
-	int tag = dwarf_tag(type_die);
-
-	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type;
+	return die_is_compound_type(type_die);
 }
 
 /* returns if Type B has better information than Type A */
@@ -584,7 +575,6 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 			    Dwarf_Die *type_die, int ptr_offset)
 {
-	int tag;
 	Dwarf_Word size;
 
 	if (kind == TSR_KIND_POINTER) {
@@ -605,17 +595,10 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
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
index d7160f87ac7d..88ba0ec23a68 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -60,6 +60,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
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
@@ -2053,7 +2061,7 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Word offset = (long)arg;
 	int tag = dwarf_tag(die_mem);
 
-	if (tag != DW_TAG_member)
+	if (tag != DW_TAG_member && tag != DW_TAG_inheritance)
 		return DIE_FIND_CB_SIBLING;
 
 	/* Unions might not have location */
@@ -2104,7 +2112,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 	tag = dwarf_tag(type_die);
 	/* If it's not a compound type, return the type directly */
-	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+	if (!die_is_compound_type(type_die)) {
 		Dwarf_Word size;
 
 		if (dwarf_aggregate_size(type_die, &size) < 0)
@@ -2119,7 +2127,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 	mb_type = *type_die;
 	/* TODO: Handle union types better? */
-	while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+	while (die_is_compound_type(&mb_type)) {
 		member = die_find_child(&mb_type, __die_find_member_offset_cb,
 					(void *)(long)offset, die_mem);
 		if (member == NULL)
@@ -2130,8 +2138,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 		tag = dwarf_tag(&mb_type);
 
-		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
-		    tag == DW_TAG_array_type) {
+		if (die_is_compound_type(&mb_type) || tag == DW_TAG_array_type) {
 			Dwarf_Word loc;
 
 			/* Update offset for the start of the member struct */
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 161f0bf980b6..855c45fec5bb 100644
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
2.25.1

