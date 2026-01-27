Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E02C0F63
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479599; cv=none; b=uQKEsNYQBtjXlYkDAJgOht3q6yUx3PQ/AEKYbRQCDv/YDmXq7vKN+z0DBpDGQrbV02nI6O1qSExDWJrZt3g9O93W56t8zDnGEWQNNcFswwyVzMKT6/91yd0hfQjVRXQWjX9V0RNuMjytLnr3F/dKW6rAdKT7/XmxZY+t3gt4TR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479599; c=relaxed/simple;
	bh=hTTFx/rRjNVyMVuqEiUDG7gMwiCxWrQQwtW4VOPytac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aw/MetW+dqs3OHbS9VA2Tnn3NW7Z1pWagWo3+D7Dbvwb9YW1XO+9xsDaAhlnYiKt+JCT0+cscFnhsNSMwHPwn3anJWrdwF7qtDMucDYtnpK9IMmVFgtODs91ASF+kMWwX6sKM3cBY+W1DxQBgrw05rvspumBDQxm5WK6UE0tTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=Y2EQ2nda; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="Y2EQ2nda"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6495d592c45so3796032d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479596; x=1770084396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwwPqivI3qVoDOEZBqAjVAkFtZNukybQuCk65HTVtrU=;
        b=Y2EQ2nda6Wfqv34SMAEGxFa3cRYQM2i+LvTcD4G9mf0sbb1VmUDaXMWoKhHLvpf/1K
         DbVuig0HEiA/v0JuvBjNchQn0KtPSUrSaiQ124428MKs+fzoQGNCRL7JYQyZogrpbFCd
         z14M/JALqx5An+m++quF7va4lZzAdJv7fbEH2mtMCyHSyUSCBv1VTO1ZalhpU+AGQ1SR
         qDrvwSyWn0gzdfGSgbS5qhgPrxx6rbqSLhVmJeHbxKev8R/Dzjlznb3js2ur2d4Px5Ay
         zwQJihoDu8LTgzaWbCt69yQL5x9Cthv57aCg5UIIfedQPyHPrJxE0TbIgyuF4xS7gs85
         WeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479596; x=1770084396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwwPqivI3qVoDOEZBqAjVAkFtZNukybQuCk65HTVtrU=;
        b=vzATIaZXOY2uRlAa8eyYy7lmacODQ4MySQTmMyFrdpkLynzAMktfweCJ89VR7hpHxw
         7AGOfIprbfhni489TBoV99uJcbx86BVKxG4EeEqeHVSZrAnHav7Phvf1MK4m+ZIfcdfZ
         0GSjRpInOM0TeLurqvblVhibXKrRlxFX8vPUqofj3Ec2DJl534DqIIVCZfhZ8EdCQ0Uy
         JMxD1Nf25VKYQ96gNiifWhsaV0SlZPz+XI6WDeBeQxIWG2uxhB/SeJNBupEnI+/T47d9
         pddMY0S/pHy8RoqX9FcNsDFmUrGhAwPLr2ro3ifushPYMHStK2PaQ5lRw+T1FbElgFAw
         mR9A==
X-Forwarded-Encrypted: i=1; AJvYcCVo44AFmGJZAFD/uC+ZgodsWUt+nMcB8/X8DRbzIm3iNVa1LtAea+Go5hBzq4uEvmcWRcDTSNzP8FWgwiT0FDwa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrlwb1Q31rsl7zFqig3+QMD5HRicK6OgrkPL3TiPS9XXUxD+sR
	McR77SkO0i+buetQudHdLPAK/cLzP+GYh1G/TiuE1glJ/fJ3IKUlpLUEnf3MfBNG9w==
X-Gm-Gg: AZuq6aIXzqZvpZDHW5eZsGI9DTtZR0ZDCQQ6o5rOg3mAUbQlvDWlswPH1BgjTJZ1aIc
	5PdEM1BKuezl2AQOH8ODGYE+v5ditPDdFjowi3ggNSkBPBV5QyOuoRb8dFmvJLJ26jF/IQ5i/Zg
	WLv1TYm+65KoIuLME4AcMuZtkHUstqh+3R8G/MfOjjOoggHtrJlbdHe87Sc7ut5061Cm71TwCEr
	g8EJqlR4uEHFbN+0UlMQMLdC/lESJvCw6EbQluDBxuXLNx+idtxoaOLdjKublJikGgqor4B4Xtx
	kD4dSadAvXWawSA4GntBzAtt6tAuRweLCbOo9bdN2Cn6ypJG5hO68GMx4efginp04N75R1nklFn
	9seZTe98nGYy5KDI2tZfOmnpfGRinukbuoQUXtH5CEi21KxhHxJIzUlbYR/OTkPLQ85feWGEnHS
	b7wPFil7pKAA==
X-Received: by 2002:a05:690e:169e:b0:642:84a:7ba4 with SMTP id 956f58d0204a3-64970d1e483mr4137331d50.85.1769479595915;
        Mon, 26 Jan 2026 18:06:35 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:35 -0800 (PST)
From: Zecheng Li <zli94@ncsu.edu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	xliuprof@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/11] perf dwarf-aux: Add die_get_pointer_type to get pointer types
Date: Mon, 26 Jan 2026 21:04:55 -0500
Message-ID: <20260127020617.2804780-3-zli94@ncsu.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127020617.2804780-1-zli94@ncsu.edu>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a variable type is wrapped in typedef/qualifiers, callers may need
to first resolve it to the underlying DW_TAG_pointer_type or
DW_TAG_array_type. A simple tag check is not enough and directly calling
__die_get_real_type() can stop at the pointer type (e.g. typedef ->
pointer) instead of the pointee type.

Add die_get_pointer_type() helper that follows typedef/qualifier chains
and returns the underlying pointer DIE. Use it in annotate-data.c so
pointer checks and dereference work correctly for typedef'd pointers.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 39 +++++++++++++++++++--------------
 tools/perf/util/dwarf-aux.c     | 27 +++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h     |  2 ++
 3 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 99ffc6d70565..8ff1972981b7 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -455,13 +455,6 @@ static const char *match_result_str(enum type_match_result tmr)
 	}
 }
 
-static bool is_pointer_type(Dwarf_Die *type_die)
-{
-	int tag = dwarf_tag(type_die);
-
-	return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
-}
-
 static bool is_compound_type(Dwarf_Die *type_die)
 {
 	int tag = dwarf_tag(type_die);
@@ -474,19 +467,24 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
 {
 	Dwarf_Word size_a, size_b;
 	Dwarf_Die die_a, die_b;
+	Dwarf_Die ptr_a, ptr_b;
+	Dwarf_Die *ptr_type_a, *ptr_type_b;
+
+	ptr_type_a = die_get_pointer_type(type_a, &ptr_a);
+	ptr_type_b = die_get_pointer_type(type_b, &ptr_b);
 
 	/* pointer type is preferred */
-	if (is_pointer_type(type_a) != is_pointer_type(type_b))
-		return is_pointer_type(type_b);
+	if ((ptr_type_a != NULL) != (ptr_type_b != NULL))
+		return ptr_type_b != NULL;
 
-	if (is_pointer_type(type_b)) {
+	if (ptr_type_b) {
 		/*
 		 * We want to compare the target type, but 'void *' can fail to
 		 * get the target type.
 		 */
-		if (die_get_real_type(type_a, &die_a) == NULL)
+		if (die_get_real_type(ptr_type_a, &die_a) == NULL)
 			return true;
-		if (die_get_real_type(type_b, &die_b) == NULL)
+		if (die_get_real_type(ptr_type_b, &die_b) == NULL)
 			return false;
 
 		type_a = &die_a;
@@ -539,7 +537,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 	 * and local variables are accessed directly without a pointer.
 	 */
 	if (needs_pointer) {
-		if (!is_pointer_type(type_die) ||
+		if (die_get_pointer_type(type_die, type_die) == NULL ||
 		    __die_get_real_type(type_die, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 	}
@@ -880,12 +878,16 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			continue;
 
 		if (var->reg == DWARF_REG_FB || var->reg == fbreg || var->reg == state->stack_reg) {
+			Dwarf_Die ptr_die;
+			Dwarf_Die *ptr_type;
 			int offset = var->offset;
 			struct type_state_stack *stack;
 
+			ptr_type = die_get_pointer_type(&mem_die, &ptr_die);
+
 			/* If the reg location holds the pointer value, dereference the type */
-			if (!var->is_reg_var_addr && is_pointer_type(&mem_die) &&
-				__die_get_real_type(&mem_die, &mem_die) == NULL)
+			if (!var->is_reg_var_addr && ptr_type &&
+			    __die_get_real_type(ptr_type, &mem_die) == NULL)
 				continue;
 
 			if (var->reg != DWARF_REG_FB)
@@ -1110,7 +1112,9 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		goto check_non_register;
 
 	if (state->regs[reg].kind == TSR_KIND_TYPE) {
+		Dwarf_Die ptr_die;
 		Dwarf_Die sized_type;
+		Dwarf_Die *ptr_type;
 		struct strbuf sb;
 
 		strbuf_init(&sb, 32);
@@ -1122,7 +1126,8 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 * Normal registers should hold a pointer (or array) to
 		 * dereference a memory location.
 		 */
-		if (!is_pointer_type(&state->regs[reg].type)) {
+		ptr_type = die_get_pointer_type(&state->regs[reg].type, &ptr_die);
+		if (!ptr_type) {
 			if (dloc->op->offset < 0 && reg != state->stack_reg)
 				goto check_kernel;
 
@@ -1130,7 +1135,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		}
 
 		/* Remove the pointer and get the target type */
-		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
+		if (__die_get_real_type(ptr_type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
 		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b57cdc8860f0..96cfcbd40c45 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -303,6 +303,33 @@ Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 	return vr_die;
 }
 
+/**
+ * die_get_pointer_type - Get a pointer/array type die
+ * @type_die: a DIE of a type
+ * @die_mem: where to store a type DIE
+ *
+ * Get a pointer/array type DIE from @type_die. If the type is a typedef or
+ * qualifier (const, volatile, etc.), follow the chain to find the underlying
+ * pointer type.
+ */
+Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
+{
+	int tag;
+
+	do {
+		tag = dwarf_tag(type_die);
+		if (tag == DW_TAG_pointer_type || tag == DW_TAG_array_type)
+			return type_die;
+		if (tag != DW_TAG_typedef && tag != DW_TAG_const_type &&
+		    tag != DW_TAG_restrict_type && tag != DW_TAG_volatile_type &&
+		    tag != DW_TAG_shared_type)
+			return NULL;
+		type_die = die_get_type(type_die, die_mem);
+	} while (type_die);
+
+	return NULL;
+}
+
 /* Get attribute and translate it as a udata */
 static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
 			      Dwarf_Word *result)
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index b3ee5df0b6be..8045281f219c 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -60,6 +60,8 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
 Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
 /* Get a type die, but skip qualifiers and typedef */
 Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
+/* Get a pointer/array type, following typedefs/qualifiers */
+Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem);
 
 /* Check whether the DIE is signed or not */
 bool die_is_signed_type(Dwarf_Die *tp_die);
-- 
2.52.0

