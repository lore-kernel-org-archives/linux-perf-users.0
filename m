Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B02EBB9E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479608; cv=none; b=LyTAl+g+yVshZ/RJMWqUJFT88Et/nKiXentxKQfH277CmZa+XdMK96nRsLb/C5iR4c3/LlwgQ+284FInDTnv7tSZCh14R+aL0K28isiH1mGWjvPafglUsg6oyeS11/eqvnbNLveNLEyAjxdR6mfPbGcx7QeOoA3nhE89BwYxi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479608; c=relaxed/simple;
	bh=Z0zNtvAEypLxwpX5+4CHJT8c6wRy00jo1ldE57np0Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOKSTZ0N0c7QpsTnEjP132fGNGLbesRtCN+YCgWBZeAS/EVmwGEiB51m13hWer8et8W25I9qti1oBwfJq7jSoiXe4rh8fCcS9blAC8nhzWj58Dua6Nl5h6wLmUtQW3Aj23W/zabJlKjo5/ZRk5egDSv8vnULT6tvG0xPfz9mU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=KN/JHe2a; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="KN/JHe2a"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6493937c342so5068238d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479604; x=1770084404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq6WdE0WbGucsm8HDxS+kNLEuZlM6IbJ6kGho6LsktQ=;
        b=KN/JHe2aJKBXSK9V/bx2MwIH5RrCU0wONdKzkCRxgbA6PjwbE1u+Vr2+wIpridr45H
         YTvid7zOWqmzzU8PwU/L+YQUsdGjhTFI1CZsmipFbOglucOp9iXt/ygR//u0QlP/wbRy
         BIFElF03bR3iLpmMm0xGuoeB/LaSg18pdr6H/+3Carm0f57vIBP77CRZszFFQ0khJuWK
         onZrsWaC6omnOjqYsxFWizhpGpU0gK58nQ4PatLUOFW7JLtEZycw5oRis/2FL36rJHrV
         ZUnB1yL8ddnIbEJYLf1BFOgQjwTAc2DUZxkKrIjcZflaMbJA1QHNe3RKL/M9BIZEEgHv
         Hu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479604; x=1770084404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dq6WdE0WbGucsm8HDxS+kNLEuZlM6IbJ6kGho6LsktQ=;
        b=YoIGKC4oT7zhfEXkRdw1v382xBw4Nx4AucuhDFPNwcDuPhQV0vgRynC61LnzAVI8Nh
         huSoU/HY8R4hZjhHrqrNeULZKzhDPYllLI7Erhp2GWnF0T1nddv5pkId/iLho+372lYa
         oSCNvmia0LWp1LIZCmMrijeY421WNZNwWnzgP6guw4366UvE+NpCf+7HSmwd9/SEhNGr
         /K4LP4AtZytKw8BCdXnGRpkhjnOwmRA3CYMxzvFO/WDxMBoKt+JNI04YRv4TlJaJGLO3
         WuJ7rnI/Y2HEyceUsPEVnRARYsJ3jiP8vBJhJNGJIh7XzTW02xPZFsU7HNfy4WCaRf6N
         q05Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU1HNNL6JG5ra4qsh/g3U4LY8WLjGGJwebY18BQahJZ50HMcJ/iFCZbIREXcli8vvbk/5DQfImICmlWA0wB3ZV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdrtASYGozLs1BXDm93/2iH2YvxZpYZLzxPyddSjRFmzIikbE
	/1BWIhin9CeFkEChBiBBuGQQQXQC/MWXQvGfkMHhSNDNVZ3mPKgrwZ8Nc8n2fTg/Ng==
X-Gm-Gg: AZuq6aK9rGCLqA8N6BEKar47JX3tLxIDV4My+sCkbRAg/FX8l5bb1ubriBEgvbJL6FD
	0DuoFC4uuXceRU6ygLNAX0y7TBPmsDTiXquR7f5wTffzCMx59y18qwHkmZ8AyR9NAqtw2ICbDn2
	/NeUSoBS1PvYJTpbOXYQRJ0NpuVN9NJ4mQev8yVYwvRWfIXSIbW0pve4EhQz80yU0X7PVllEJIl
	cd5AFvAnAe2xex1HlIQJTh3j5APc6DdVIOl0XPMvyV1DtX+0F4yBbBz7O+FlVgj3ZHi/WAGwKIj
	f5UrZnPlVrKI0UvLSNrpE05QnUdivHeoCZQkvI+E1WEuCX9sas/GO1pUDAkR0izTiLnFRlBft72
	LOBHkWGRSuvasHCrS6VSC2fz8chhkHpLlzouMGNPTmtFAE6PC93Lvt3xSJvQS6rIyJPwqVEj7cB
	GLbTB0J1XAzg==
X-Received: by 2002:a05:690e:12ce:b0:649:393c:86cc with SMTP id 956f58d0204a3-6498fbd5cd6mr16816d50.4.1769479604511;
        Mon, 26 Jan 2026 18:06:44 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:43 -0800 (PST)
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
Subject: [PATCH v1 10/11] perf annotate-data: Use DWARF location ranges to preserve reg state
Date: Mon, 26 Jan 2026 21:05:03 -0500
Message-ID: <20260127020617.2804780-11-zli94@ncsu.edu>
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

When a function call occurs, caller-saved registers are typically
invalidated since the callee may clobber them. However, DWARF debug
info provides location ranges that indicate exactly where a variable
is valid in a register.

Track the DWARF location range end address in type_state_reg and use
it to determine if a caller-saved register should be preserved across
a call. If the current call address is within the DWARF-specified
lifetime of the variable, keep the register state valid instead of
invalidating it.

This improves type annotation for code where the compiler knows a
register value survives across calls (e.g., when the callee is known not
to clobber certain registers or when the value is reloaded after the
call at the same logical location).

Changes:
- Add `end` and `has_range` fields to die_var_type to capture DWARF
  location range information
- Add `lifetime_active` and `lifetime_end` fields to type_state_reg
- Check location lifetime before invalidating caller-saved registers

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/arch/x86/annotate/instructions.c | 25 ++++++++++++++++++---
 tools/perf/util/annotate-data.c             | 24 ++++++++++++++++++--
 tools/perf/util/annotate-data.h             |  3 +++
 tools/perf/util/dwarf-aux.c                 |  6 ++++-
 tools/perf/util/dwarf-aux.h                 |  2 ++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index aba356754520..e45041855e17 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -213,6 +213,8 @@ static void invalidate_reg_state(struct type_state_reg *reg)
 {
 	reg->kind = TSR_KIND_INVALID;
 	reg->ok = false;
+	reg->lifetime_active = false;
+	reg->lifetime_end = 0;
 	reg->copied_from = -1;
 }
 
@@ -235,6 +237,7 @@ static void update_insn_state_x86(struct type_state *state,
 	if (ins__is_call(&dl->ins)) {
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
+		u64 call_addr;
 
 		/* Try to resolve the call target name */
 		if (func)
@@ -251,10 +254,18 @@ static void update_insn_state_x86(struct type_state *state,
 		else
 			pr_debug_dtp("call [%x] <unknown>\n", insn_offset);
 
-		/* Invalidate caller-saved registers after call (ABI requirement) */
+		/* Invalidate caller-saved registers after call */
+		call_addr = map__rip_2objdump(dloc->ms->map,
+					      dloc->ms->sym->start + dl->al.offset);
 		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
-			if (state->regs[i].caller_saved)
-				invalidate_reg_state(&state->regs[i]);
+			struct type_state_reg *reg = &state->regs[i];
+
+			if (!reg->caller_saved)
+				continue;
+			/* Keep register valid within DWARF location lifetime */
+			if (reg->lifetime_active && call_addr < reg->lifetime_end)
+				continue;
+			invalidate_reg_state(reg);
 		}
 
 		/* Update register with the return type (if any) */
@@ -284,6 +295,8 @@ static void update_insn_state_x86(struct type_state *state,
 
 		tsr = &state->regs[dst->reg1];
 		tsr->copied_from = -1;
+		tsr->lifetime_active = false;
+		tsr->lifetime_end = 0;
 
 		if (src->imm)
 			imm_value = src->offset;
@@ -349,6 +362,8 @@ static void update_insn_state_x86(struct type_state *state,
 
 		tsr = &state->regs[dst->reg1];
 		tsr->copied_from = -1;
+		tsr->lifetime_active = false;
+		tsr->lifetime_end = 0;
 
 		if (src->imm)
 			imm_value = src->offset;
@@ -463,6 +478,8 @@ static void update_insn_state_x86(struct type_state *state,
 			state->regs[dst->reg1].kind = TSR_KIND_CONST;
 			state->regs[dst->reg1].imm_value = 0;
 			state->regs[dst->reg1].ok = true;
+			state->regs[dst->reg1].lifetime_active = false;
+			state->regs[dst->reg1].lifetime_end = 0;
 			state->regs[dst->reg1].copied_from = -1;
 			return;
 		}
@@ -549,6 +566,8 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->kind = state->regs[src->reg1].kind;
 		tsr->imm_value = state->regs[src->reg1].imm_value;
 		tsr->offset = state->regs[src->reg1].offset;
+		tsr->lifetime_active = state->regs[src->reg1].lifetime_active;
+		tsr->lifetime_end = state->regs[src->reg1].lifetime_end;
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 177aa6634504..b42b17ba0d10 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -841,6 +841,18 @@ static bool die_is_same(Dwarf_Die *die_a, Dwarf_Die *die_b)
 	return (die_a->cu == die_b->cu) && (die_a->addr == die_b->addr);
 }
 
+static void tsr_set_lifetime(struct type_state_reg *tsr,
+			     const struct die_var_type *var)
+{
+	if (var && var->has_range && var->end > var->addr) {
+		tsr->lifetime_active = true;
+		tsr->lifetime_end = var->end;
+	} else {
+		tsr->lifetime_active = false;
+		tsr->lifetime_end = 0;
+	}
+}
+
 /**
  * update_var_state - Update type state using given variables
  * @state: type state table
@@ -866,8 +878,14 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 	}
 
 	for (var = var_types; var != NULL; var = var->next) {
-		if (var->addr != addr)
-			continue;
+		/* Check if addr falls within the variable's valid range */
+		if (var->has_range) {
+			if (addr < var->addr || (var->end && addr >= var->end))
+				continue;
+		} else {
+			if (addr != var->addr)
+				continue;
+		}
 		/* Get the type DIE using the offset */
 		if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
 			continue;
@@ -924,6 +942,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				reg->type = mem_die;
 				reg->kind = TSR_KIND_POINTER;
 				reg->ok = true;
+				tsr_set_lifetime(reg, var);
 
 				pr_debug_dtp("var [%"PRIx64"] reg%d addr offset %x",
 					     insn_offset, var->reg, var->offset);
@@ -940,6 +959,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			reg->type = mem_die;
 			reg->kind = TSR_KIND_TYPE;
 			reg->ok = true;
+			tsr_set_lifetime(reg, var);
 
 			pr_debug_dtp("var [%"PRIx64"] reg%d offset %x",
 				     insn_offset, var->reg, var->offset);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 869307c7f130..46bc770e150e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -182,6 +182,9 @@ struct type_state_reg {
 	s32 offset;
 	bool ok;
 	bool caller_saved;
+	/* DWARF location range tracking for register lifetime */
+	bool lifetime_active;
+	u64 lifetime_end;
 	u8 kind;
 	u8 copied_from;
 };
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index ee72b7a4a65d..a05d73d6e9e7 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1639,7 +1639,7 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Die type_die;
 	int tag = dwarf_tag(die_mem);
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end = 0;
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
@@ -1679,6 +1679,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->addr = start;
+	vt->end = end;
+	vt->has_range = (end != 0 || start != 0);
 	vt->reg = reg_from_dwarf_op(ops);
 	vt->offset = offset_from_dwarf_op(ops);
 	vt->next = *var_types;
@@ -1741,6 +1743,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->addr = ops->number;
+	vt->end = 0;
+	vt->has_range = false;
 	vt->reg = -1;
 	vt->offset = 0;
 	vt->next = *var_types;
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 8045281f219c..6d418acfff14 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -148,10 +148,12 @@ struct die_var_type {
 	struct die_var_type *next;
 	u64 die_off;
 	u64 addr;
+	u64 end;        /* end address of location range */
 	int reg;
 	int offset;
 	/* Whether the register holds a address to the type */
 	bool is_reg_var_addr;
+	bool has_range; /* whether end is valid */
 };
 
 /* Return type info of a member at offset */
-- 
2.52.0

