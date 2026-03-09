Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AE3F23BB
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078958; cv=none; b=CwO3U3W5JwSBl2zfcYQeXxVfoYbJC/7P7zVN5oj88FuWqSWi71CqHpuCRb103zIT8yacUm8H/cudgqoHHtJotYtWbr/mDe4a5iSxe68Vs+YkEcYf4UjztRbgcj+JYDMDWxtASN6lf3+wBz3g0i/VLOrrZQuJTTAqQgrQIrjaTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078958; c=relaxed/simple;
	bh=jZkqxNuYYxB3LoWNGONWU5a5o1Wwng84PdjBv7LMNv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STl7KTzfPRHT8psq6sdqHbCnLebC3SSgHsCyQdiePctvHPyAZ155c/tRIUlnkZ7ukXzrIl7HDdgIGqq2syacDqIToHZzCfbMwkedVdbsq0/zAvyIJyHkJZnLISb0GTtm0ALGE8ko8kP5Jhw8ldwV+HKiuWid4abNu1NSpKst4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=ergh+Jii; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="ergh+Jii"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ca1ba0089so10956734d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078953; x=1773683753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lPHrHUbCvA0nk/Bz11ONoeBHbNhRdJurUU0iBLUrTc=;
        b=ergh+Jiic6FQECc2jF+2eW05PYdBCdK+cgrAA9w4tT9m7FV1W4chf45Ru33SHsnAWr
         kYQ/2Qp2W72M1qeH+M9g917lXoDR1jN2grQNq28cu+o+kO6aKi/ZdQ/o1DUc0tTWo9hk
         O5q1uGzRSWPOM0bo451hOBB0MhWwmcmmKip507vy+2K2BbSdv+vEe7luHceU5ZMZ2q5T
         fH1dkj+vOog8BMVR3h5TXLvE8JCyTY84V1gi9fL6aGY3PeGdHREfn6Cl7vDQZyYN0RVx
         gmQGQwoR9PfDiPmUf0eO/69xUvjmw4AXEXgw9nFJUmgcM6rI9OFT88E43xB06jNH2fcn
         7ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078953; x=1773683753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4lPHrHUbCvA0nk/Bz11ONoeBHbNhRdJurUU0iBLUrTc=;
        b=WZdP6uuL1kKKnCW4VCwB/iAzPFYBLWQcEHoXrxz6FZC0lUIf4OupjBwS0NmRoRZAQS
         yZVgPbV50h1DNcb9CRaZqT94JTeG9GEiVkRuJdKFb+Zws1GTxxKvEcxgSo/rk/CkCLBT
         FSuPZhs7VDqpnRb/+Yms+ECj2wAXc+FQUbMJzHWpcgEQHW56jQARAydEwpV4VoRzXIAR
         GBwO+BNizd848ifRhb0YIb6PaZMK270vczfeOdfatJA0d9lIRyIs4DQ7EOAr3c1A4zmj
         LtRlC2Q8RUuNI3AHAlZ0Kag8xD4hXk4gvB1a3NFAJ01AeQZmrdi2jqdEbPndKXYjy8cv
         Dgyw==
X-Forwarded-Encrypted: i=1; AJvYcCWbIlUsq0RKgX8VguiAowmoxdEqPKLDX0r25Kt4cOvkbSLXdkW1maT/nhDanhAGiso+8K97vkIYuaVuRQc+M1ij@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0qclh9HrSoOUuIUshcNsQdjbcsgOvqi8Z012Ki25e/HM4OCF
	V6EhSg4vsaq6ELUMH6fKn8m9hRXaLm9bi4IOWaZ/pJ0KT4qgOFadqQ710p3Di6BXVQ==
X-Gm-Gg: ATEYQzwjRDLqciGbbaRLyg1h8BuAn4HTpaEFUQBjjCrwEQUHro7Z/IIM8mh2dszxzr1
	9cT7wKwxnrlcj9zhske7iC4LRiYAHb8uYJs2j2sQ5XWbyefNCOOqwTd5s3bw8zHfTJHLz5eVkeb
	DjcXL41lvaY7YlqAtRBqNsqeRDeu8P67L4eltJAdTEQ4tKeiMU2xZj1i1Noga6UjRApkyTjHpGX
	hiB/V0/eO2qFpYdlxvpzeet/qMl+L20idE8OCuJDU04gdD98dh+DQLJiOj7tPAbAkPf2ydspHlY
	6rIjcb/RCxi3DCSigyPGKBypqpbEVt5pZlcxin1MzB4vlMxJSumjMW3rPMQvEqc1hzoBqqGC5GH
	kOE860RzACbDovOUOfl2N4ICF5LefjWGCaSbX4T463RTH6q5SHTquYW0DiNdADqAvxereLU06cR
	AX+1Zbo8ctLDNjO9mYhhX/Ku4VQZecA+tB6T0GTrA2linkTNjK6zw3YRdG
X-Received: by 2002:a05:690e:6c3:b0:64c:9b19:9238 with SMTP id 956f58d0204a3-64d142034c7mr8345441d50.40.1773078952719;
        Mon, 09 Mar 2026 10:55:52 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:52 -0700 (PDT)
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
Subject: [PATCH v2 01/11] perf dwarf-aux: Add die_get_pointer_type to get pointer types
Date: Mon,  9 Mar 2026 13:55:14 -0400
Message-ID: <20260309175546.916039-2-zli94@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>
References: <20260309175546.916039-1-zli94@ncsu.edu>
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
index 44fbd41e3845..cda020ea18d5 100644
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
index 9267af204c7d..38142062d6e5 100644
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
index cd481ec9c5a1..99d2735122d5 100644
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
2.53.0

