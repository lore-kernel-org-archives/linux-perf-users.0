Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E03FFAA2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078965; cv=none; b=Zrz9ytXHnZNgYBx/hWOme77nlSYXyIb67eMhc8GPDdmfy6jBlZ5OZyqedPmpD1LkeRsAAt83/CwS0zn7pkfAMFMHHZc5TiwMiFaF8T7XZPS+BQZfL/soXJyxUt29XVWmVow6GDhCGiAE3iSLMlIT44ZpKWItK2ybh7UhMvKBOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078965; c=relaxed/simple;
	bh=mEoohDgaVS6P4BoQIj2tJG8GaDTdacWN+mjE91dMGAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krDibc9uT18un305HBez8ObtWNCTx6IuqoPN7BmPv9Bx7gCnr7IGivZqiOnuPQlYE/vB3OOnaqKaTjNKrrQwWSSZ+qvw1p4khVoh80suRCEjKbe+An0L1XYSBupH3HqP0H4EmjTZOqdOxo+G+FgenJX6qq5MHHNAKj55xZGP8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=DNxzys8U; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="DNxzys8U"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64c31ca77b4so11783976d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078960; x=1773683760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q99YxW+Ht7TLrQtAPlxKv3AciWXzKlQ9lzRm/MiGx5k=;
        b=DNxzys8U3W38G8tv5EJaWkItOdpuE/pOQt+ZRkEh4+5S7Bpx8dYj6E4xf9K0Ums6Ve
         Y8RwcfBlui0eXROqF4v7MdhBubZsYl6XmJP1jv4s45EC+COQzZa0z/J27mL5diQhweRr
         tOuVCTtxbtRnvUE1yuopI/LUxU4IfVDLl2XI9sJXn4s6QHfQFbZ6KQIdK3W421+rfKBa
         OEJikBwliT5JlsMjFm5E6IrI8593X71ZL/4vAOno98z31dXSr3er8iO3g2nOmd1cKHcN
         Ekw9tYVmGi0WL2D99iAmDVUXGiViYDm8iEYDJJK4GxXjFavvJRohfNMG2Uj35fiFaRN1
         yxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078960; x=1773683760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q99YxW+Ht7TLrQtAPlxKv3AciWXzKlQ9lzRm/MiGx5k=;
        b=ZA5y00kKSPlydYcisDFKuUkIsS2imUn9b8RpwV8ChLTDyjAyaKQY2HzzE7eqC1K2b7
         VAk92Od4Ghoagm98g77MbhrESFeuLgwgoOaFLJCN8LY/VFAoWKK9+5i+issuJNv4mZ55
         lQovoALE2N0wR1EeN3g4hb2diPLpR/f9Sp85nHB1vUO2JmkRPkafyeyAHcwh/uG+0EzE
         gjx1gY9Gn2aW2QQVy4KZul1POwW0aC1l+lilT0Dc6pYt95lMPWxwBNlYtz1dPni4sAPc
         MZFTBmKobz7/omKZdd+cG6f+QFCbYA/0KClswYQTGrGqE/HpkiJoPOnsOC59NM/j9lvi
         zE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0m4ji2oImIUhEpez3ArO1fkHnZZqTpxhP3cVPWTpRUtIRX6aO3J3mMg/d9ylJx5kZhWnc6L8STtwlQ0o66NmC@vger.kernel.org
X-Gm-Message-State: AOJu0YyErOL8yGmyCCPdCjnQ2OxTaYWduVCQhCLGQ0WGOr5lVBdkmi9m
	hFbVQS+OicYPCepyFR/ZRQJjPOlKlpeA98+55g+foDwXz9zSYT3OIUU3eawglrg0/g==
X-Gm-Gg: ATEYQzxXKAUcwNLeT7zJT8wcmHyWg6OFHFo59LkzGYf6wbCZMhizyRIUG7Mk7Hy3UpU
	Hm/LOqOuo8EuH/J6p/V/e+Qf8utfdW1HncxO1L4UBk6M+TRJCIF6a6XcaaK7fc4hqArLnoU/u4e
	MtxOtlbPFbPI+oEaad07uCL2mEu8O9+6NM1qfQp6yOqG3tDwoCVFEgAdNlBtYdSO+9cecNi61rq
	aHosm7ukaeSnfh8g2qQkVvuqgKXnNCyyVHH5e7ic8B/5bM7ZjZJ0O0qWPLPRbbCGdyKlBtV/+oB
	jC747OeOc/ccgZz4JqB8Sk5Xknsgq0LlNInryzxKlgcesB4IMoRexu9m+gdxRYBXxMKspQLJq3m
	mPoavxKHm5Xkx3pNWNmmLFLByoGRdkWp+d08Klwl1esz8D2uPrlaPpnSnRVBG5vhGwtmThKB9C2
	4zp48afQUVyn5Bwn3+k5mSCu/PeK+k6aPoCtK+F8LdD4WmHrwYYAOF6ELC
X-Received: by 2002:a53:b442:0:b0:64c:97ae:2e71 with SMTP id 956f58d0204a3-64d14280e4fmr9557058d50.47.1773078960139;
        Mon, 09 Mar 2026 10:56:00 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:59 -0700 (PDT)
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
Subject: [PATCH v2 08/11] perf annotate-data: Add invalidate_reg_state() helper for x86
Date: Mon,  9 Mar 2026 13:55:21 -0400
Message-ID: <20260309175546.916039-9-zli94@ncsu.edu>
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
 tools/perf/util/annotate-arch/annotate-x86.c | 29 ++++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index eb9a649ca656..eb390a253d71 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -204,6 +204,13 @@ static int x86__cpuid_parse(struct arch *arch, const char *cpuid)
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
@@ -235,7 +242,7 @@ static void update_insn_state_x86(struct type_state *state,
 		/* Otherwise invalidate caller-saved registers after call */
 		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
 			if (state->regs[i].caller_saved)
-				state->regs[i].ok = false;
+				invalidate_reg_state(&state->regs[i]);
 		}
 
 		/* Update register with the return type (if any) */
@@ -364,8 +371,7 @@ static void update_insn_state_x86(struct type_state *state,
 		src_tsr = state->regs[sreg];
 		tsr = &state->regs[dst->reg1];
 
-		tsr->copied_from = -1;
-		tsr->ok = false;
+		invalidate_reg_state(tsr);
 
 		/* Case 1: Based on stack pointer or frame pointer */
 		if (sreg == fbreg || sreg == state->stack_reg) {
@@ -433,8 +439,7 @@ static void update_insn_state_x86(struct type_state *state,
 		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
 			pr_debug_dtp("%s [%x] invalidate reg%d\n",
 						dl->ins.name, insn_offset, dst->reg1);
-			state->regs[dst->reg1].ok = false;
-			state->regs[dst->reg1].copied_from = -1;
+			invalidate_reg_state(&state->regs[dst->reg1]);
 			return;
 		}
 
@@ -496,7 +501,7 @@ static void update_insn_state_x86(struct type_state *state,
 			if (!get_global_var_type(cu_die, dloc, ip, var_addr,
 						 &offset, &type_die) ||
 			    !die_get_member_type(&type_die, offset, &type_die)) {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			}
 
@@ -524,7 +529,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		if (!has_reg_type(state, src->reg1) ||
 		    !state->regs[src->reg1].ok) {
-			tsr->ok = false;
+			invalidate_reg_state(tsr);
 			return;
 		}
 
@@ -560,7 +565,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			stack = find_stack_state(state, offset);
 			if (stack == NULL) {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
@@ -575,7 +580,7 @@ static void update_insn_state_x86(struct type_state *state,
 				tsr->offset = 0;
 				tsr->ok = true;
 			} else {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			}
 
@@ -628,7 +633,7 @@ static void update_insn_state_x86(struct type_state *state,
 			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
 						 &type_die) ||
 			    !die_get_member_type(&type_die, offset, &type_die)) {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 				return;
 			}
 
@@ -679,7 +684,7 @@ static void update_insn_state_x86(struct type_state *state,
 				}
 				pr_debug_type_name(&tsr->type, tsr->kind);
 			} else {
-				tsr->ok = false;
+				invalidate_reg_state(tsr);
 			}
 		}
 		/* And then dereference the calculated pointer if it has one */
@@ -721,7 +726,7 @@ static void update_insn_state_x86(struct type_state *state,
 				}
 			}
 
-			tsr->ok = false;
+			invalidate_reg_state(tsr);
 		}
 	}
 	/* Case 3. register to memory transfers */
-- 
2.53.0

