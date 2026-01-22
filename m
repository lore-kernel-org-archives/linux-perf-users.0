Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028A36B078
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100890; cv=none; b=O3IurnopI75V9Kja7WO2fkvRopuxpmoCu3Dcwfr0yx0JyhthFY/S/h4b+T+ESgTeUqwxIzCa3zoSMQz9j4TH3fJ2CnoLg3N3wQIpXv5eBQAyORm3WIKoIHV75be/Dza5AVcWW2Lq/iKAbneh9pkWDYycdnbPxCnMahbWGIDlhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100890; c=relaxed/simple;
	bh=KR5+2EshErmuRybWcBELHd/O8khmGf6P5Bg86ngz38E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CnwUEkTACTJVYEKU3PrYdl1jw9yma+GYGu5trlv3eQVtMFLGTLNTSgdz8UBLTbRBYtTG+IAUD48pICriAjbgvC6jQtHvdk00+d2ixLUuVvhCfrBWTujxuul+0X+iaSAsEjz7R2q/lXgGrYlbmeAQIVkle/MzZzDG9IxUN2sUvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLLLvjm2; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLLLvjm2"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso2215489eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100866; x=1769705666; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJvCENf9OUao4NjSk9nvAVIfxbnn+tkq0I5XRhSJkfA=;
        b=vLLLvjm2OTcAI8h0rOuRT1Dk7RwqfSamkn1ITs0RE6z8oyaeGNbdME4rI5a/KhTYlI
         /ZKkfQZUZA7fYz0a2JUdDrxSKuabpKH31nOuOIsvcTFpEDb2ANUNWieatwgHrSNzpIJb
         0zTcMF2Rgm8KY3EIEmCH0VjTiZu7odMHvQ4bb2WeCCUFWx7MN39J5/o3TFQeng1Qbx0c
         9kSBoWQxetCOHq5DaORjay2tTw91r6lQNLtNl/tRMW6eUhTwMSXSrdUCqjM/7ZmxP1YS
         sDc0K8CE8K6aeAtW3FrD6nfd6kO8izLFwf/oXfceN9PDI+m6LNTwF9drVjW4I5+zmIDm
         By2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100866; x=1769705666;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJvCENf9OUao4NjSk9nvAVIfxbnn+tkq0I5XRhSJkfA=;
        b=CPFDsBDQh25i3jsZuZqHezRxb8+bXz/SdQbzwzoC0YidDJWQMcpDb24Xwv7bSfc4Hp
         o8AAvIHh8v/RFthNi/dYN1TtwfBWG2BCIPvMjLVNBMeku31a7FKdV4mlMvogCzPq2bKv
         pibIGZ+bhjOSTbDbx/T6KQfbT6LqI98275YvyacNn6VEEGLsLm993QlXT15KRlHdwKcV
         nEU3bUPhYfmr6urY54j91Qo1qMO4CTYQ92hoKAYHTVevbnuFdNMbn1jkSPml0Cu40M6v
         MN97Lcti5jIE+Nxq/+/nWGa/7RTzzWQIY0BjwwrT9u8FQivJFKWoPrgkNAcxIRmaEtuN
         fNuA==
X-Forwarded-Encrypted: i=1; AJvYcCUwEMltxWci33M5SisEnKFlDHogbj2IqUnOHPIYo41i/96hT0ObuMnxyqilaTQkxysGlAtk7uRN0aIdHQwpcesc@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjVtfe9JeYwa4uPvepcqVzgI6rkFQLRz0X4ttcrfY4UzIXJYO
	VcxN820Gb632FNQ2Fyq/rrPtQYM3r9asCvkGovfn1/PE+8eR3cB0D/DzADEZu78NF0uYMByDPC/
	s2+Zin/AJyw==
X-Received: from dycna11.prod.google.com ([2002:a05:7300:ea8b:b0:2b0:5418:353f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3005:b0:2b7:13f5:43ac
 with SMTP id 5a478bee46e88-2b713f54696mr3598450eec.15.1769100865487; Thu, 22
 Jan 2026 08:54:25 -0800 (PST)
Date: Thu, 22 Jan 2026 08:54:01 -0800
In-Reply-To: <20260122165407.561888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122165407.561888-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165407.561888-7-irogers@google.com>
Subject: [PATCH v2 06/12] perf disasm: Constify use of struct ins
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The struct ins holds variables that are read but not written, except
during some initialization. Change most uses to be for a "const struct
ins *" version to capture this immutability. So the x86__instructions
can be const pre-sort it and make the sorted variable true.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/annotate/instructions.c |  2 +-
 tools/perf/arch/x86/annotate/instructions.c   | 26 +++++++++++----
 tools/perf/util/disasm.c                      | 32 ++++++++++---------
 tools/perf/util/disasm.h                      |  4 +--
 4 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 363af2f55122..44db33854dba 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -60,7 +60,7 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
 	return -1;
 }
 
-static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
+static int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
 			  struct ins_operands *ops, int max_ins_name);
 
 static const struct ins_ops arm64_mov_ops = {
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 24b388bacdae..ffca3029388b 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -7,7 +7,7 @@
  * So this table should not have entries with the suffix unless it's
  * a complete different instruction than ones without the suffix.
  */
-static struct ins x86__instructions[] = {
+static const struct ins x86__instructions[] = {
 	{ .name = "adc",	.ops = &mov_ops,  },
 	{ .name = "add",	.ops = &mov_ops,  },
 	{ .name = "addsd",	.ops = &mov_ops,  },
@@ -19,9 +19,9 @@ static struct ins x86__instructions[] = {
 	{ .name = "btr",	.ops = &mov_ops,  },
 	{ .name = "bts",	.ops = &mov_ops,  },
 	{ .name = "call",	.ops = &call_ops, },
+	{ .name = "cmovae",	.ops = &mov_ops,  },
 	{ .name = "cmovbe",	.ops = &mov_ops,  },
 	{ .name = "cmove",	.ops = &mov_ops,  },
-	{ .name = "cmovae",	.ops = &mov_ops,  },
 	{ .name = "cmp",	.ops = &mov_ops,  },
 	{ .name = "cmpxch",	.ops = &mov_ops,  },
 	{ .name = "cmpxchg",	.ops = &mov_ops,  },
@@ -73,23 +73,23 @@ static struct ins x86__instructions[] = {
 	{ .name = "movaps",	.ops = &mov_ops,  },
 	{ .name = "movdqa",	.ops = &mov_ops,  },
 	{ .name = "movdqu",	.ops = &mov_ops,  },
+	{ .name = "movsb",	.ops = &mov_ops,  },
 	{ .name = "movsd",	.ops = &mov_ops,  },
+	{ .name = "movsl",	.ops = &mov_ops,  },
 	{ .name = "movss",	.ops = &mov_ops,  },
-	{ .name = "movsb",	.ops = &mov_ops,  },
 	{ .name = "movsw",	.ops = &mov_ops,  },
-	{ .name = "movsl",	.ops = &mov_ops,  },
 	{ .name = "movupd",	.ops = &mov_ops,  },
 	{ .name = "movups",	.ops = &mov_ops,  },
 	{ .name = "movzb",	.ops = &mov_ops,  },
-	{ .name = "movzw",	.ops = &mov_ops,  },
 	{ .name = "movzl",	.ops = &mov_ops,  },
+	{ .name = "movzw",	.ops = &mov_ops,  },
 	{ .name = "mulsd",	.ops = &mov_ops,  },
 	{ .name = "mulss",	.ops = &mov_ops,  },
 	{ .name = "nop",	.ops = &nop_ops,  },
 	{ .name = "or",		.ops = &mov_ops,  },
 	{ .name = "orps",	.ops = &mov_ops,  },
-	{ .name = "pand",	.ops = &mov_ops,  },
 	{ .name = "paddq",	.ops = &mov_ops,  },
+	{ .name = "pand",	.ops = &mov_ops,  },
 	{ .name = "pcmpeqb",	.ops = &mov_ops,  },
 	{ .name = "por",	.ops = &mov_ops,  },
 	{ .name = "rcl",	.ops = &mov_ops,  },
@@ -202,6 +202,20 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 		if (x86__cpuid_parse(arch, cpuid))
 			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
 	}
+
+#ifndef NDEBUG
+	{
+		static bool sorted_check;
+
+		if (!sorted_check) {
+			for (size_t i = 0; i < arch->nr_instructions - 1; i++) {
+				assert(strcmp(arch->instructions[i].name,
+					      arch->instructions[i + 1].name) <= 0);
+			}
+			sorted_check = true;
+		}
+	}
+#endif
 	arch->e_machine = EM_X86_64;
 	arch->e_flags = 0;
 	arch->initialized = true;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 9bc9b1de98db..2793697ce75c 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -43,9 +43,9 @@ static const struct ins_ops ret_ops;
 static const struct ins_ops load_store_ops;
 static const struct ins_ops arithmetic_ops;
 
-static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
+static int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
-static int call__scnprintf(struct ins *ins, char *bf, size_t size,
+static int call__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
 
 static void ins__sort(struct arch *arch);
@@ -66,7 +66,8 @@ static int arch__grow_instructions(struct arch *arch)
 		goto grow_from_non_allocated_table;
 
 	new_nr_allocated = arch->nr_instructions_allocated + 128;
-	new_instructions = realloc(arch->instructions, new_nr_allocated * sizeof(struct ins));
+	new_instructions = realloc((void *)arch->instructions,
+				   new_nr_allocated * sizeof(struct ins));
 	if (new_instructions == NULL)
 		return -1;
 
@@ -93,7 +94,7 @@ static int arch__associate_ins_ops(struct arch *arch, const char *name, const st
 	    arch__grow_instructions(arch))
 		return -1;
 
-	ins = &arch->instructions[arch->nr_instructions];
+	ins = (struct ins *)&arch->instructions[arch->nr_instructions];
 	ins->name = strdup(name);
 	if (!ins->name)
 		return -1;
@@ -146,6 +147,7 @@ static struct arch architectures[] = {
 		.init = x86__annotate_init,
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
+		.sorted_instructions = true,
 		.insn_suffix = "bwlq",
 		.objdump =  {
 			.comment_char = '#',
@@ -241,13 +243,13 @@ static void ins_ops__delete(struct ins_operands *ops)
 	zfree(&ops->target.name);
 }
 
-static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
+static int ins__raw_scnprintf(const struct ins *ins, char *bf, size_t size,
 			      struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+static int ins__scnprintf(const struct ins *ins, char *bf, size_t size,
 			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
@@ -319,7 +321,7 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 	goto find_target;
 }
 
-static int call__scnprintf(struct ins *ins, char *bf, size_t size,
+static int call__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name)
 {
 	if (ops->target.sym)
@@ -446,7 +448,7 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	return 0;
 }
 
-static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
+static int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name)
 {
 	const char *c;
@@ -551,7 +553,7 @@ static int lock__parse(const struct arch *arch, struct ins_operands *ops, struct
 	return 0;
 }
 
-static int lock__scnprintf(struct ins *ins, char *bf, size_t size,
+static int lock__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name)
 {
 	int printed;
@@ -680,7 +682,7 @@ static int mov__parse(const struct arch *arch, struct ins_operands *ops,
 	return -1;
 }
 
-static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
+static int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
@@ -699,7 +701,7 @@ static const struct ins_ops mov_ops = {
 #define	ADD_ZERO_EXT_XO_FORM	202
 #define	SUB_ZERO_EXT_XO_FORM	200
 
-static int arithmetic__scnprintf(struct ins *ins, char *bf, size_t size,
+static int arithmetic__scnprintf(const struct ins *ins, char *bf, size_t size,
 		struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
@@ -743,7 +745,7 @@ static const struct ins_ops arithmetic_ops = {
 	.scnprintf = arithmetic__scnprintf,
 };
 
-static int load_store__scnprintf(struct ins *ins, char *bf, size_t size,
+static int load_store__scnprintf(const struct ins *ins, char *bf, size_t size,
 		struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
@@ -806,7 +808,7 @@ static int dec__parse(const struct arch *arch __maybe_unused, struct ins_operand
 	return 0;
 }
 
-static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
+static int dec__scnprintf(const struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
@@ -818,7 +820,7 @@ static const struct ins_ops dec_ops = {
 	.scnprintf = dec__scnprintf,
 };
 
-static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
+static int nop__scnprintf(const struct ins *ins __maybe_unused, char *bf, size_t size,
 			  struct ins_operands *ops __maybe_unused, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s", max_ins_name, "nop");
@@ -866,7 +868,7 @@ static void ins__sort(struct arch *arch)
 {
 	const int nmemb = arch->nr_instructions;
 
-	qsort(arch->instructions, nmemb, sizeof(struct ins), ins__cmp);
+	qsort((void *)arch->instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
 static const struct ins_ops *__ins__find(const struct arch *arch, const char *name,
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index dc5233f2a773..4f5c9a985786 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -19,7 +19,7 @@ struct disasm_line;
 
 struct arch {
 	const char	*name;
-	struct ins	*instructions;
+	const struct ins	*instructions;
 	size_t		nr_instructions;
 	size_t		nr_instructions_allocated;
 	const struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
@@ -91,7 +91,7 @@ struct ins_ops {
 	void (*free)(struct ins_operands *ops);
 	int (*parse)(const struct arch *arch, struct ins_operands *ops, struct map_symbol *ms,
 			struct disasm_line *dl);
-	int (*scnprintf)(struct ins *ins, char *bf, size_t size,
+	int (*scnprintf)(const struct ins *ins, char *bf, size_t size,
 			 struct ins_operands *ops, int max_ins_name);
 };
 
-- 
2.52.0.457.g6b5491de43-goog

