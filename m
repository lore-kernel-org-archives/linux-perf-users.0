Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F993FD120
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078971; cv=none; b=kt/GFyeHzGjJZOCZQ5FCcKIMn0RwjUzCisDPcu9XaiHbSpRtEHCUR/8qEfsqYKEg+pTB70bkjmlzwE+34ljHh+beluqj1TY4eJAfkrQO3XN05X6ber4zL7OH3dZI2pVfUP+pbFaVHqbClBOa0ugx6xTjzPmHXvBj82h/FdDSTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078971; c=relaxed/simple;
	bh=q6LE+ixU1zVz16lgmY2eKxe6TkipgC5NpO0sfrkT0Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR4wImc42XZx42hluH5YQNcvETqfo2Sevp6AYHGnKTf60drDc6M6KoP70JBRrgvjRE03uzLJ/PVEf1jTjyoG7rq7iSQKjx5T16CaCsJo2+K5zOBSCDzEpZiccX0VTzHH/qpFKFOklWt+PPQD1x5b9NLq6noYtnk/RsO2rh/qWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=cBzKWTyS; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="cBzKWTyS"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so10238308d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078964; x=1773683764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXlD/hErpPiic9ODLls/lxSmno+4Yc8/kOa6LrdepnM=;
        b=cBzKWTySOn8qXWCA4XoDCCaM89ZzObrOqD9Fc2Svj6oxV35rMxDbg5PREo9gKAjeGB
         zSrRaQ0+R4KLgzjOeBafv+5dj4rUkgD/DVk+WS8hp6ZgVGsrRUbKacrdPjnF6LXMi4FV
         Sjh0HiOamRjgqZixyIkC9Wl/iPVRo63+9cGRzi0b9uF3/aZGW5tB3HEWziI84xLj3ibS
         3DFzN06IQ/pPzyOPH+P/6TC27syAn6HUzYM94G798r5BF0Pw6s2WEGkEMBoRm8I0lTvs
         0vKWCitfZhzO9/bhcbe+91Y0ZpoOuCn8D+NJlclP9G+B8Fb3zIwtNZ5YXGM0/+uZ4TUK
         hVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078964; x=1773683764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXlD/hErpPiic9ODLls/lxSmno+4Yc8/kOa6LrdepnM=;
        b=Vqm8vdWOZGITVl4RlQNKk7J3sAhZNNRpsgaSKSwqH3p1EZntFoSea9oRiJgE0QKCWS
         Fx8czjHBktLaSijUXMX4hDaUSHbk9dAZ3/ImZqrB7cwazo4TG59700YGASbe4BJ0KL7s
         KBX3mYOYKHRk/+YHEaC5F5c2UjpQARcL2HdTLUHNwNGRCthXzliGStJXXIYNp2lfnoZ3
         NsSB6SOW+wGMOmaes/I6KLoRJsijkdEZa2Qi+QWS74vGVEbGa+2cKB/PjVEuvUHl4MGa
         H32hbLsnTGl+FEYNETPthz7tNg2Sc/Xlk2mEa42L2XXtY73rTaoA6Hn83WNc2oxfNKbA
         Mvmw==
X-Forwarded-Encrypted: i=1; AJvYcCU/sEV2/OiWfGUNsXsOs8FTlkZbe22GH+e/xG/6cXsPJgrdWjHsQywORnMjwbHs/9y1yw2G21epGUpISCnZn4RS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5mt2Qb3HTjFErG2BPuk6W0DDM2fMNtio0s/RNmfEy3UnMn6e
	9JGzIA7y9i029RupLRIsPnAHbzNR1GG74Am0m8TcwpkDSfayH9ysi1mFTEfQlRRDiw==
X-Gm-Gg: ATEYQzzw86v9bpVTKJGWAESpnDi5AZFgnuIvpKxJpwLs7dSUYYYVsNnbwoNceEHykgV
	//cfKneGWnecdMBEXR9IcWv/Rt0tsVaAj9nVFVG1cS4sIWhhrKFb1qJQg7lq0yX0Nftma0D0mo3
	r9XENqqfLaFFkkxjP5qSwDQ1O1HlCAGJH1nTlcdeekhfj6RGiChNFoBOr7xHHcqNc5t5a31Ysf2
	CwfBDSvEJcCr1/h+9BP/d5B3MKIGBjx/E718NCq9ltaEaIzJcKZh4by1WzhqM6FFw65LdqluX3q
	qpHhbmafxAlRE4l96SLq1W87bfPUcXuDh6gYNIhjImPd4j5Mn/O6pgva2hUIqi4vpaGC/weXNb5
	kBqWLR7XMKD6Iiw2C+Tsw6aza70wvsg0uJFfr9ENxExrEN7R68zmSRE4ot9QNGTGqFZr1yQlBrz
	VTW48uw70b+x03Q3Z36rcea2rqGUJFKBBlKh2TwepZwRvhCj3+FJjztoks
X-Received: by 2002:a05:690e:b88:b0:64d:29a4:c933 with SMTP id 956f58d0204a3-64d29a4cc49mr5162990d50.56.1773078963881;
        Mon, 09 Mar 2026 10:56:03 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:56:01 -0700 (PDT)
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
Subject: [PATCH v2 10/11] perf annotate-data: Use DWARF location ranges to preserve reg state
Date: Mon,  9 Mar 2026 13:55:23 -0400
Message-ID: <20260309175546.916039-11-zli94@ncsu.edu>
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

When a function call occurs, caller-saved registers are typically
invalidated since the callee may clobber them. However, DWARF debug info
provides location ranges that indicate exactly where a variable is valid
in a register.

Track the DWARF location range end address in type_state_reg and use it
to determine if a caller-saved register should be preserved across a
call. If the current call address is within the DWARF-specified lifetime
of the variable, keep the register state valid instead of invalidating
it.

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
 tools/perf/util/annotate-arch/annotate-x86.c | 25 +++++++++++++++++---
 tools/perf/util/annotate-data.c              | 24 +++++++++++++++++--
 tools/perf/util/annotate-data.h              |  3 +++
 tools/perf/util/dwarf-aux.c                  |  6 ++++-
 tools/perf/util/dwarf-aux.h                  |  2 ++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index df9fc0a51b39..c77aabd48eba 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -208,6 +208,8 @@ static void invalidate_reg_state(struct type_state_reg *reg)
 {
 	reg->kind = TSR_KIND_INVALID;
 	reg->ok = false;
+	reg->lifetime_active = false;
+	reg->lifetime_end = 0;
 	reg->copied_from = -1;
 }
 
@@ -230,6 +232,7 @@ static void update_insn_state_x86(struct type_state *state,
 	if (ins__is_call(&dl->ins)) {
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
+		u64 call_addr;
 
 		/* Try to resolve the call target name */
 		if (func)
@@ -246,10 +249,18 @@ static void update_insn_state_x86(struct type_state *state,
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
@@ -279,6 +290,8 @@ static void update_insn_state_x86(struct type_state *state,
 
 		tsr = &state->regs[dst->reg1];
 		tsr->copied_from = -1;
+		tsr->lifetime_active = false;
+		tsr->lifetime_end = 0;
 
 		if (src->imm)
 			imm_value = src->offset;
@@ -344,6 +357,8 @@ static void update_insn_state_x86(struct type_state *state,
 
 		tsr = &state->regs[dst->reg1];
 		tsr->copied_from = -1;
+		tsr->lifetime_active = false;
+		tsr->lifetime_end = 0;
 
 		if (src->imm)
 			imm_value = src->offset;
@@ -458,6 +473,8 @@ static void update_insn_state_x86(struct type_state *state,
 			state->regs[dst->reg1].kind = TSR_KIND_CONST;
 			state->regs[dst->reg1].imm_value = 0;
 			state->regs[dst->reg1].ok = true;
+			state->regs[dst->reg1].lifetime_active = false;
+			state->regs[dst->reg1].lifetime_end = 0;
 			state->regs[dst->reg1].copied_from = -1;
 			return;
 		}
@@ -544,6 +561,8 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->kind = state->regs[src->reg1].kind;
 		tsr->imm_value = state->regs[src->reg1].imm_value;
 		tsr->offset = state->regs[src->reg1].offset;
+		tsr->lifetime_active = state->regs[src->reg1].lifetime_active;
+		tsr->lifetime_end = state->regs[src->reg1].lifetime_end;
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 50c82c91f828..1eff0a27237d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -840,6 +840,18 @@ static bool die_is_same(Dwarf_Die *die_a, Dwarf_Die *die_b)
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
@@ -865,8 +877,14 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
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
@@ -923,6 +941,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				reg->type = mem_die;
 				reg->kind = TSR_KIND_POINTER;
 				reg->ok = true;
+				tsr_set_lifetime(reg, var);
 
 				pr_debug_dtp("var [%"PRIx64"] reg%d addr offset %x",
 					     insn_offset, var->reg, var->offset);
@@ -939,6 +958,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			reg->type = mem_die;
 			reg->kind = TSR_KIND_TYPE;
 			reg->ok = true;
+			tsr_set_lifetime(reg, var);
 
 			pr_debug_dtp("var [%"PRIx64"] reg%d offset %x",
 				     insn_offset, var->reg, var->offset);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 9b222869e42d..c26130744260 100644
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
index 1feefc329154..0710c875416f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1641,7 +1641,7 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Die type_die;
 	int tag = dwarf_tag(die_mem);
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end = 0;
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
@@ -1681,6 +1681,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->addr = start;
+	vt->end = end;
+	vt->has_range = (end != 0 || start != 0);
 	vt->reg = reg_from_dwarf_op(ops);
 	vt->offset = offset_from_dwarf_op(ops);
 	vt->next = *var_types;
@@ -1743,6 +1745,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->addr = ops->number;
+	vt->end = 0;
+	vt->has_range = false;
 	vt->reg = -1;
 	vt->offset = 0;
 	vt->next = *var_types;
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 939a59c91796..a79968a2e573 100644
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
2.53.0

