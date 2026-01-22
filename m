Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F33C0894
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117750; cv=none; b=uj7Giwzx+ibRHkgIYNNisK1R8aGJIzgZg4pm4QwX6+6FZTVewu/OxqrMVlCaom9rBaFwYpO5XjAtsAjInHUbn5+EIpwUyTiluPQjxRM5ebZoEoKBxTNdKxlIjUW4Ic04WD8iLJIJsyE5wLf9mtvlXUOg/T+rToKfsXDfjVpsbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117750; c=relaxed/simple;
	bh=rD9vOzeeXzOTCD+l66o8DhGrmT+MJuoo1UTvO0WycIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=g4UUs4+iwGCMRMTENq71mIZul8kHXUWAesJUEhTPYxWE3IJ0QYRwWtbYCdQD/IFqUNvTCCtKXyrThBD3tJTgZUTCkbAtkTsch2Bx/bgfd5AhZ5cqbAz2iDmu2f1M3iOydGwW7IHT5l1eWGzGm4+G160VjSMpybGnkxy57ToYWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvKaPtCK; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvKaPtCK"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b722bc1be1so2289129eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 13:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769117733; x=1769722533; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANZB4nsW0oD2Yy9bdDZ7x29IcTZAs2bHCHMIwFReZjE=;
        b=uvKaPtCKe70K8aIxJisFIw+ipubxOKisFYj9EkcyDWE7JNA9XHQbdS6i4wgDHkULqk
         lYWOdQGjFB3O16ivmNK/Ks/YXepic/t+vszpwOH92wYcaJmQ39urDcacpnhz4Arbvq6A
         NWldgxrpy83/8x7Rygact2OZ7Ui1sKXxZIU3TJeDHjFdxmUH9XVh0OQob/2vSAloZN9k
         skv8IMvS75grES6VtNdR0vc7wUXSnyrG7orn7aFTMsJ3+adPqjk60N8HJ5k97FBdO/T9
         UA3+zdbU4Y+U6ubdKu/v8bPY7paKYc3eafzrE3aBn4/aJYBPnqdYkNwYKl6zszANH0Q0
         HVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117733; x=1769722533;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANZB4nsW0oD2Yy9bdDZ7x29IcTZAs2bHCHMIwFReZjE=;
        b=dwQJ/874vpzcrb6Bnm6Z2AFfct1KWGakaXpuaLZRvcol+MmIYfqLPZPynWOUg+z72g
         XI+LdOcrm5GNZIbUxm4egDCccfw1AvaH1y3dcuU0bp2fewErPB4dLb44yz7Y62S+opp7
         hYpvy2tUT5SSr6LaWxcaJPMyy1gmLYXd/ASJoKw4ern+ak0eC46LCwmsD4zzvW2m0RAy
         TXmoKTsa253G34Toeku1QXbD98J63zz6LGClIi3VGnfjAY+8lMUFdNl+Y168g+v3GYbr
         fhtpPxmB0R2O9K6rQIYK1DF1uuew09fvT0XF9qoVLWtdCRl+BmfHmyA0KxMVyGK6Ncxt
         /XRw==
X-Forwarded-Encrypted: i=1; AJvYcCVW1D0eEmXQ+/Itdt8+gCQ2S2Mk2IH9KeH3kQaNowunTwl1X4OjAFRwWSKnAIoJCwIXqVt5/6RVXSECCUTgdtTD@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNuhdAqNXLCbR5k265SyadNTYS3knMbNn+eOc/h49PVO4ZzW1
	KnfafPCWLcdJUUMmdGMwBtjZt8BEUJZHn9kcqIRUW2S0MSzWGVyMGpFW3PuHJ7/cs70ZEWprrfD
	4LhVyAymnEA==
X-Received: from dlb34.prod.google.com ([2002:a05:7022:622:b0:123:35cc:b60f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ec15:b0:2b7:3281:6c33
 with SMTP id 5a478bee46e88-2b739997aafmr446745eec.12.1769117733358; Thu, 22
 Jan 2026 13:35:33 -0800 (PST)
Date: Thu, 22 Jan 2026 13:35:09 -0800
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122213516.671089-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122213516.671089-6-irogers@google.com>
Subject: [PATCH v3 05/12] perf disasm: Constify use of struct ins_op
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

The struct ins_op holds variables to function pointers that are read
but not written. Change uses to be for a "const struct ins_op *"
version to capture this immutability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/annotate/instructions.c   |  4 +-
 tools/perf/arch/arm64/annotate/instructions.c |  6 +--
 tools/perf/arch/csky/annotate/instructions.c  |  6 +--
 .../arch/loongarch/annotate/instructions.c    |  8 ++--
 tools/perf/arch/mips/annotate/instructions.c  |  4 +-
 .../perf/arch/powerpc/annotate/instructions.c |  6 +--
 .../perf/arch/riscv64/annotate/instructions.c |  4 +-
 tools/perf/arch/s390/annotate/instructions.c  |  8 ++--
 tools/perf/arch/sparc/annotate/instructions.c |  4 +-
 tools/perf/util/disasm.c                      | 46 +++++++++----------
 tools/perf/util/disasm.h                      |  6 +--
 11 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index 5e667b0f5512..b997d127fedd 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -11,10 +11,10 @@ struct arm_annotate {
 		jump_insn;
 };
 
-static struct ins_ops *arm__associate_instruction_ops(struct arch *arch, const char *name)
+static const struct ins_ops *arm__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arm_annotate *arm = arch->priv;
-	struct ins_ops *ops;
+	const struct ins_ops *ops;
 	regmatch_t match[2];
 
 	if (!regexec(&arm->call_insn, name, 2, match, 0))
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 5099fa36180d..363af2f55122 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -63,15 +63,15 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
 			  struct ins_operands *ops, int max_ins_name);
 
-static struct ins_ops arm64_mov_ops = {
+static const struct ins_ops arm64_mov_ops = {
 	.parse	   = arm64_mov__parse,
 	.scnprintf = mov__scnprintf,
 };
 
-static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
+static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arm64_annotate *arm = arch->priv;
-	struct ins_ops *ops;
+	const struct ins_ops *ops;
 	regmatch_t match[2];
 
 	if (!regexec(&arm->jump_insn, name, 2, match, 0))
diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
index 14270311d215..4a55c84a320a 100644
--- a/tools/perf/arch/csky/annotate/instructions.c
+++ b/tools/perf/arch/csky/annotate/instructions.c
@@ -3,10 +3,10 @@
 
 #include <linux/compiler.h>
 
-static struct ins_ops *csky__associate_ins_ops(struct arch *arch,
-					       const char *name)
+static const struct ins_ops *csky__associate_ins_ops(struct arch *arch,
+						     const char *name)
 {
-	struct ins_ops *ops = NULL;
+	const struct ins_ops *ops = NULL;
 
 	/* catch all kind of jumps */
 	if (!strcmp(name, "bt") ||
diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
index 5ebfe629ea68..5010d5d58375 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -51,7 +51,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	return 0;
 }
 
-static struct ins_ops loongarch_call_ops = {
+static const struct ins_ops loongarch_call_ops = {
 	.parse	   = loongarch_call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -100,15 +100,15 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 	return 0;
 }
 
-static struct ins_ops loongarch_jump_ops = {
+static const struct ins_ops loongarch_jump_ops = {
 	.parse	   = loongarch_jump__parse,
 	.scnprintf = jump__scnprintf,
 };
 
 static
-struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char *name)
+const struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char *name)
 {
-	struct ins_ops *ops = NULL;
+	const struct ins_ops *ops = NULL;
 
 	if (!strcmp(name, "bl"))
 		ops = &loongarch_call_ops;
diff --git a/tools/perf/arch/mips/annotate/instructions.c b/tools/perf/arch/mips/annotate/instructions.c
index b50b46c613d6..0fbe0a7df95a 100644
--- a/tools/perf/arch/mips/annotate/instructions.c
+++ b/tools/perf/arch/mips/annotate/instructions.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 static
-struct ins_ops *mips__associate_ins_ops(struct arch *arch, const char *name)
+const struct ins_ops *mips__associate_ins_ops(struct arch *arch, const char *name)
 {
-	struct ins_ops *ops = NULL;
+	const struct ins_ops *ops = NULL;
 
 	if (!strncmp(name, "bal", 3) ||
 	    !strncmp(name, "bgezal", 6) ||
diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index ca567cfdcbdb..d1be55425e35 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 
-static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, const char *name)
+static const struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	int i;
-	struct ins_ops *ops;
+	const struct ins_ops *ops;
 
 	/*
 	 * - Interested only if instruction starts with 'b'.
@@ -189,7 +189,7 @@ static int cmp_offset(const void *a, const void *b)
 	return (val1->value - val2->value);
 }
 
-static struct ins_ops *check_ppc_insn(struct disasm_line *dl)
+static const struct ins_ops *check_ppc_insn(struct disasm_line *dl)
 {
 	int raw_insn = dl->raw.raw_insn;
 	int opcode = PPC_OP(raw_insn);
diff --git a/tools/perf/arch/riscv64/annotate/instructions.c b/tools/perf/arch/riscv64/annotate/instructions.c
index 55cf911633f8..a34798864fab 100644
--- a/tools/perf/arch/riscv64/annotate/instructions.c
+++ b/tools/perf/arch/riscv64/annotate/instructions.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 static
-struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *name)
+const struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *name)
 {
-	struct ins_ops *ops = NULL;
+	const struct ins_ops *ops = NULL;
 
 	if (!strncmp(name, "jal", 3) ||
 	    !strncmp(name, "jr", 2) ||
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 37c1b62641d8..1b22e6276e7d 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -49,7 +49,7 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 	return 0;
 }
 
-static struct ins_ops s390_call_ops = {
+static const struct ins_ops s390_call_ops = {
 	.parse	   = s390_call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -103,14 +103,14 @@ static int s390_mov__parse(const struct arch *arch __maybe_unused,
 }
 
 
-static struct ins_ops s390_mov_ops = {
+static const struct ins_ops s390_mov_ops = {
 	.parse	   = s390_mov__parse,
 	.scnprintf = mov__scnprintf,
 };
 
-static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
+static const struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
 {
-	struct ins_ops *ops = NULL;
+	const struct ins_ops *ops = NULL;
 
 	/* catch all kind of jumps */
 	if (strchr(name, 'j') ||
diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/arch/sparc/annotate/instructions.c
index 68c31580ccfc..a08d8734c883 100644
--- a/tools/perf/arch/sparc/annotate/instructions.c
+++ b/tools/perf/arch/sparc/annotate/instructions.c
@@ -117,9 +117,9 @@ static int is_branch_float_cond(const char *cond)
 	return 0;
 }
 
-static struct ins_ops *sparc__associate_instruction_ops(struct arch *arch, const char *name)
+static const struct ins_ops *sparc__associate_instruction_ops(struct arch *arch, const char *name)
 {
-	struct ins_ops *ops = NULL;
+	const struct ins_ops *ops = NULL;
 
 	if (!strcmp(name, "call") ||
 	    !strcmp(name, "jmp") ||
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index d92c0424e8fc..9bc9b1de98db 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -33,15 +33,15 @@
 static regex_t	 file_lineno;
 
 /* These can be referred from the arch-dependent code */
-static struct ins_ops call_ops;
-static struct ins_ops dec_ops;
-static struct ins_ops jump_ops;
-static struct ins_ops mov_ops;
-static struct ins_ops nop_ops;
-static struct ins_ops lock_ops;
-static struct ins_ops ret_ops;
-static struct ins_ops load_store_ops;
-static struct ins_ops arithmetic_ops;
+static const struct ins_ops call_ops;
+static const struct ins_ops dec_ops;
+static const struct ins_ops jump_ops;
+static const struct ins_ops mov_ops;
+static const struct ins_ops nop_ops;
+static const struct ins_ops lock_ops;
+static const struct ins_ops ret_ops;
+static const struct ins_ops load_store_ops;
+static const struct ins_ops arithmetic_ops;
 
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
@@ -85,7 +85,7 @@ static int arch__grow_instructions(struct arch *arch)
 	goto out_update_instructions;
 }
 
-static int arch__associate_ins_ops(struct arch* arch, const char *name, struct ins_ops *ops)
+static int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops)
 {
 	struct ins *ins;
 
@@ -334,7 +334,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s *%" PRIx64, max_ins_name, ins->name, ops->target.addr);
 }
 
-static struct ins_ops call_ops = {
+static const struct ins_ops call_ops = {
 	.parse	   = call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -487,7 +487,7 @@ static void jump__delete(struct ins_operands *ops __maybe_unused)
 	 */
 }
 
-static struct ins_ops jump_ops = {
+static const struct ins_ops jump_ops = {
 	.free	   = jump__delete,
 	.parse	   = jump__parse,
 	.scnprintf = jump__scnprintf,
@@ -579,7 +579,7 @@ static void lock__delete(struct ins_operands *ops)
 	zfree(&ops->target.name);
 }
 
-static struct ins_ops lock_ops = {
+static const struct ins_ops lock_ops = {
 	.free	   = lock__delete,
 	.parse	   = lock__parse,
 	.scnprintf = lock__scnprintf,
@@ -688,7 +688,7 @@ static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static struct ins_ops mov_ops = {
+static const struct ins_ops mov_ops = {
 	.parse	   = mov__parse,
 	.scnprintf = mov__scnprintf,
 };
@@ -738,7 +738,7 @@ static int arithmetic__parse(const struct arch *arch __maybe_unused, struct ins_
 	return 0;
 }
 
-static struct ins_ops arithmetic_ops = {
+static const struct ins_ops arithmetic_ops = {
 	.parse     = arithmetic__parse,
 	.scnprintf = arithmetic__scnprintf,
 };
@@ -772,7 +772,7 @@ static int load_store__parse(const struct arch *arch __maybe_unused, struct ins_
 	return 0;
 }
 
-static struct ins_ops load_store_ops = {
+static const struct ins_ops load_store_ops = {
 	.parse     = load_store__parse,
 	.scnprintf = load_store__scnprintf,
 };
@@ -813,7 +813,7 @@ static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static struct ins_ops dec_ops = {
+static const struct ins_ops dec_ops = {
 	.parse	   = dec__parse,
 	.scnprintf = dec__scnprintf,
 };
@@ -824,11 +824,11 @@ static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s", max_ins_name, "nop");
 }
 
-static struct ins_ops nop_ops = {
+static const struct ins_ops nop_ops = {
 	.scnprintf = nop__scnprintf,
 };
 
-static struct ins_ops ret_ops = {
+static const struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
@@ -869,7 +869,7 @@ static void ins__sort(struct arch *arch)
 	qsort(arch->instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
-static struct ins_ops *__ins__find(const struct arch *arch, const char *name,
+static const struct ins_ops *__ins__find(const struct arch *arch, const char *name,
 				     struct disasm_line *dl)
 {
 	struct ins *ins;
@@ -880,7 +880,7 @@ static struct ins_ops *__ins__find(const struct arch *arch, const char *name,
 		 * For powerpc, identify the instruction ops
 		 * from the opcode using raw_insn.
 		 */
-		struct ins_ops *ops;
+		const struct ins_ops *ops;
 
 		ops = check_ppc_insn(dl);
 		if (ops)
@@ -916,9 +916,9 @@ static struct ins_ops *__ins__find(const struct arch *arch, const char *name,
 	return ins ? ins->ops : NULL;
 }
 
-struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl)
+const struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl)
 {
-	struct ins_ops *ops = __ins__find(arch, name, dl);
+	const struct ins_ops *ops = __ins__find(arch, name, dl);
 
 	if (!ops && arch->associate_instruction_ops)
 		ops = arch->associate_instruction_ops((struct arch *)arch, name);
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 273a9c906514..dc5233f2a773 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -22,7 +22,7 @@ struct arch {
 	struct ins	*instructions;
 	size_t		nr_instructions;
 	size_t		nr_instructions_allocated;
-	struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
+	const struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
 	bool		sorted_instructions;
 	bool		initialized;
 	const char	*insn_suffix;
@@ -52,7 +52,7 @@ struct arch {
 
 struct ins {
 	const char     *name;
-	struct ins_ops *ops;
+	const struct ins_ops *ops;
 };
 
 struct ins_operands {
@@ -108,7 +108,7 @@ struct annotate_args {
 const struct arch *arch__find(const char *name);
 bool arch__is(const struct arch *arch, const char *name);
 
-struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl);
+const struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl);
 
 bool ins__is_call(const struct ins *ins);
 bool ins__is_jump(const struct ins *ins);
-- 
2.52.0.457.g6b5491de43-goog

