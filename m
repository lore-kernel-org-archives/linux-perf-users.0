Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8F2D4816
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479606; cv=none; b=bhzZDsgsJO8lt3FAP3wiVVhBIJeg2Zz+JBmH84Wv64MwwCplsLfqmKiRJ1g3v7lW1qqZFEXvJ8PsMIKrX4ETwy3z/kqdVAMoP0x/3M9XPSETSySYK8ZzHxKQZ5DABtbvoC7rmP4HsTGrlwTg1hDMC+pmcWt+KVPCO5yb0fRxJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479606; c=relaxed/simple;
	bh=2GxPZYiJF6xLsgvMaP8XuY6n8Hllxdzw/fL0QUM7ek8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcAR5Q4J/7+/yTuoQ4OZQrqdUeZJB6IneUrN9UBSPHjkkTAdHg183fw5vmp7qtYxk6hSh2S+i9mhKeXigYsO80/p2wfl77gUXNzMs3EcUOeBHOId5pU9SuQor/eUaX3rou/xb8a88WZ1lMXD3Oa5EYyG+Z1wTLsZXJN3KysEbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=U8Ymw189; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="U8Ymw189"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6493937c208so4714362d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479602; x=1770084402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f1gY9r/WleTG9LFphI7gM4RwbmM6PYZcL6EvuwpZSY=;
        b=U8Ymw189dnZSLuThnvPPhA4l0sfY9TlhX/ICd1AdOzAgGm+iMrSQ7IhK4HFd99Vxek
         V4g0Q8Uy+2maZAUDGUtscvROOMUNzCpgvpPfhd01jRdqjZ/4hqE6P05Dvdo1G0I5ZkB2
         8/V729NVo579w5r0Qr8XzWEaBZsBm1VJZ7bDuspc3I52sJC0R0olr7AthFGcVejXP41E
         Ijj62aV1+Z5AyBVu0AXpIFBn06bVORges8yAB8njHccocs0p3/5eTA829mrBG4hqxhfe
         VBX1xDnZzoh/V+cs1tNWeARbf5kNXDBItH5LSYMJpfYA84sBP/cUjO9wZOuTAemFtDrP
         Mv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479602; x=1770084402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0f1gY9r/WleTG9LFphI7gM4RwbmM6PYZcL6EvuwpZSY=;
        b=fNTQs7Hpxj7yG+q9uKcaWBSdo5mOZrzcX5QyCeFKpGNppdU/GgRMF6nJgU3ZKOBzxs
         VPCZ0PfFCwT0Ri7zF9cRYi3vK+neNvBsh53xgHxRtq9IlzduiCD1TXzU8tBSLnShIDHU
         w74mJa3rvc8c/Iw21Fdvismz/eflGYKtLODHYmXSirytkajrYKPJUEqlVpKQsmp/BhjN
         1WbIxw3STS0ajc/+wrcI8BV4Oi9Vkt68Rw5v9gEcYl3NlV4+5u6y1kUe3O+ofeOtKUqn
         SLPnvSBb7HpmFTjvFxXX/mRJatiC1niRuQKgPcrlKelq8CsJ0EdTb18zHxb2Lbz47eQK
         tepA==
X-Forwarded-Encrypted: i=1; AJvYcCXSCRFblobc8xYRKBgPZFsrTSIMqHU89UgFzwHqD9MdZQNmBI/lCcjkTW5Yp9PJXGn/plMkfSuJVVxxf2xsP9nR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxze1xnO3SIRuv2gmJ1t6GxierUl1FSya+GRQY3VMI9YtwE3hNY
	HCp2UzewQwEGXywLmuMr8SC3Edu4KJuwH+rfqAAv1EuPWacMJoZAJzZJFYA6mvY/DQ==
X-Gm-Gg: AZuq6aJTt/kx2OBbc7DAtwSmQKk8pQu3XyoVzDD4S8i524cdT49CQVzfz1b4CzY1Siw
	/p5USCb5iBFxAwZuxdr9R6Jv/Fd5ZQHCQgYyZ9kXG56byx9ffuuuNbsVEyfWLqB1Mf96ySwxlap
	5mjU58oX5XgEwqHR5JX1LeVG6GX9TTeiJJB8JBpbIgE5odY7R6RU3OoLm9kduUEha6w7a77SZuS
	ftTCwTi8PgPvabDMrEXS4MFiHex0XAvanDuUWNAMlWvUee4CYqhwnJj8Br4S4D+dyZtIoClaJ1z
	agKbH7bKSDzu2O8hzY1q0dpCxsiVdcMlOtYfg6xdASMjcICop1cwKsB9hbMMB9BqRq5pTF0cYG0
	Z7X+bRk1oDb7jj78qkFw9uQeJSfmBx71al5j1QeyXkxcaYntwuZBS8xPu/S8RgssCXjwFNsZ5WK
	TzxdAIdqBd0w==
X-Received: by 2002:a05:690e:1486:b0:644:7398:6682 with SMTP id 956f58d0204a3-6498fbf8fecmr9024d50.30.1769479602346;
        Mon, 26 Jan 2026 18:06:42 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:41 -0800 (PST)
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
Subject: [PATCH v1 08/11] perf annotate-data: Add invalidate_reg_state() helper for x86
Date: Mon, 26 Jan 2026 21:05:01 -0500
Message-ID: <20260127020617.2804780-9-zli94@ncsu.edu>
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

Add a helper function to consistently invalidate register state instead
of field assignments. This ensures kind, ok, and copied_from are all
properly cleared when a register becomes invalid.

The helper sets:
- kind = TSR_KIND_INVALID
- ok = false
- copied_from = -1

Replace all invalidation patterns with calls to this helper. No
functional change and this removes some incorrect annotations that were
caused by incomplete invalidation (e.g. a obsolete copied_from from an
invalidated register).

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/arch/x86/annotate/instructions.c | 29 ++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 803f9351a3fb..e033abb0667b 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -209,6 +209,13 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 }
 
 #ifdef HAVE_LIBDW_SUPPORT
+static void invalidate_reg_state(struct type_state_reg *reg)
+{
+	reg->kind = TSR_KIND_INVALID;
+	reg->ok = false;
+	reg->copied_from = -1;
+}
+
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
@@ -240,7 +247,7 @@ static void update_insn_state_x86(struct type_state *state,
 		/* Otherwise invalidate caller-saved registers after call */
 		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
 			if (state->regs[i].caller_saved)
-				state->regs[i].ok = false;
+				invalidate_reg_state(&state->regs[i]);
 		}
 
 		/* Update register with the return type (if any) */
@@ -369,8 +376,7 @@ static void update_insn_state_x86(struct type_state *state,
 		src_tsr = state->regs[sreg];
 		tsr = &state->regs[dst->reg1];
 
-		tsr->copied_from = -1;
-		tsr->ok = false;
+		invalidate_reg_state(tsr);
 
 		/* Case 1: Based on stack pointer or frame pointer */
 		if (sreg == fbreg || sreg == state->stack_reg) {
@@ -438,8 +444,7 @@ static void update_insn_state_x86(struct type_state *state,
 		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
 			pr_debug_dtp("%s [%x] invalidate reg%d\n",
 						dl->ins.name, insn_offset, dst->reg1);
-			state->regs[dst->reg1].ok = false;
-			state->regs[dst->reg1].copied_from = -1;
+			invalidate_reg_state(&state->regs[dst->reg1]);
 			return;
 		}
 
@@ -501,7 +506,7 @@ static void update_insn_state_x86(struct type_state *state,
 			if (!get_global_var_type(cu_die, dloc, ip, var_addr,
 						 &offset, &type_die) ||
 			    !die_get_member_type(&type_die, offset, &type_die)) {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			}
 
@@ -529,7 +534,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		if (!has_reg_type(state, src->reg1) ||
 		    !state->regs[src->reg1].ok) {
-			tsr->ok = false;
+			invalidate_reg_state(tsr);
 			return;
 		}
 
@@ -565,7 +570,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			stack = find_stack_state(state, offset);
 			if (stack == NULL) {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
@@ -580,7 +585,7 @@ static void update_insn_state_x86(struct type_state *state,
 				tsr->offset = 0;
 				tsr->ok = true;
 			} else {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			}
 
@@ -633,7 +638,7 @@ static void update_insn_state_x86(struct type_state *state,
 			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
 						 &type_die) ||
 			    !die_get_member_type(&type_die, offset, &type_die)) {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			}
 
@@ -684,7 +689,7 @@ static void update_insn_state_x86(struct type_state *state,
 				}
 				pr_debug_type_name(&tsr->type, tsr->kind);
 			} else {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 			}
 		}
 		/* And then dereference the calculated pointer if it has one */
@@ -726,7 +731,7 @@ static void update_insn_state_x86(struct type_state *state,
 				}
 			}
 
-			tsr->ok = false;
+			invalidate_reg_state(tsr);
 		}
 	}
 	/* Case 3. register to memory transfers */
-- 
2.52.0

