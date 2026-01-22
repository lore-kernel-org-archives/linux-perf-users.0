Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC35481A80
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067111; cv=none; b=NVini94f70j5xaIRAvZmnvgscUCiaWBWMfkwSlrUjdqbs/l2qsWeHGqSTuHDjc0jqHul6beWe2gyRX/ew8RGaSEw5VaQkja/LUr4/YhHPe8+pGO1PCQC8fCYmhRGhkxbiOI66zDDK0dIC/AKxd/uWBAlFtzefX+xupANv6nv/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067111; c=relaxed/simple;
	bh=sGYJ80zb+odIeZsPqSh9Z6jfiKodLGQ+R7PjMI4z2k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Oz0Dggn1jk1t1SRmneWooL3EbR9hzfL/X/w6vdYL+pRJp4J8vHkrqQim6LgN57RLFvvsSKdzm6tRoTz9cawO1gagSg8e8/A3OqMO8YejiQuxYN3OiIV58NNMS1zu/3gUxkK1/zGqShh4sspLERkobgcpB8jDDCZMX5CR1ff2eQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZAggZIi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZAggZIi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b715b26fc3so949464eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067101; x=1769671901; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eELKbKMV3ddq32Z1Vp6GPW9GgpbguHI2Z4sdCa/Txxg=;
        b=QZAggZIiQ30dLfzCf1K80/cu5ZrcTNKPCFvFdH2HthmT1wiIL0Xaz2+u30kBjFdTir
         JX5XVW1WeQD9SsbWrgU/SQW/Pmm0klZW6nNiDNCvzRhGrWlVN63++4ZilBsMwR8V61pU
         ijzP9o9IPsG+VClpWMWGo5HisgO+zoSufZC4dEOJscDo1llgwxGXtoKAeBGzkykf3q3l
         hz0OYcAncXGJCofOUTd/60BDsB2QxDWZA6zGj8UkE8+ADBOIFT/b0NExN2NO8L/YEpSX
         +e+u0ntDj0eyUVueeBLJFbHISIj9SLG4AzfSiZ9nUYM1wYRiNQ5pK311qIxEP25y84M2
         2eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067101; x=1769671901;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eELKbKMV3ddq32Z1Vp6GPW9GgpbguHI2Z4sdCa/Txxg=;
        b=uvrO7VxgYqyIexfiU5cC9Vb3qW8GQnPTOowjkl2KRMrI56NXFmEVtySmBNqgMZ/uCt
         fuCQc5FNVI/Lz/y098P7R1X77AA5nZ4G13BSz3JR/KwJfsyh+I7GnYRpi3SsjSjkcTVU
         Wz+kjS2DUre02CrLruBAL073qEC55n7qIK+NCI4pec2E5mddvWnvyX0N6W6oEDuOVi+q
         +wph6ofAWQsuloww0eWCq0VQwgYVjhrODIBeWeNsERgOYsjRUM6N5XFNbSySmYznOy7k
         VDdYkI/Mxu34oM4ca1K0+N/C09hpTnpZKyl6luJarkm5M7ewZ442KOhuRp6ZF69e4mWi
         mmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVcRGE5/0H09HR9L1Ua7miR+sTaKA8fLH0mm1es6O9JlorRF2PH6cCIf7HgDw0odZh80SX4ceVduTpmzIVqeFB@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpN1LzYQRkL71r4A7chYNS0LmoZ5sf3LJ0CyjqiORl/0jbG0l
	C0FLq4HEqiRTIZvNpw8GVWN/fdS48ta4K3bYQ60XyZyi3F+UxMXvNKhG9x8Hy7b8ANACo/6dChA
	FNdZ+iFCrLw==
X-Received: from dlbcm36.prod.google.com ([2002:a05:7022:68a4:b0:123:2821:f02])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2d94:b0:2b1:7486:3a06
 with SMTP id 5a478bee46e88-2b6fd74750dmr4713049eec.18.1769067101320; Wed, 21
 Jan 2026 23:31:41 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:22 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-7-irogers@google.com>
Subject: [PATCH v1 06/11] perf disasm: Rework the string arch__is to use the
 ELF machine
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

Add new arch__is_x86 and arch__is_powerpc functions that avoid string
comparisons and use the ELF machine. Remove arch__is that is no longer
used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-data.c | 10 +++++-----
 tools/perf/util/annotate.c      | 16 ++++++++--------
 tools/perf/util/capstone.c      |  2 +-
 tools/perf/util/disasm.c        | 15 ++++++++++-----
 tools/perf/util/disasm.h        |  3 ++-
 tools/perf/util/llvm.c          |  2 +-
 6 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index edfcd6e9df9c..44fbd41e3845 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -165,7 +165,7 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
 	memset(state, 0, sizeof(*state));
 	INIT_LIST_HEAD(&state->stack_vars);
 
-	if (arch__is(arch, "x86")) {
+	if (arch__is_x86(arch)) {
 		state->regs[0].caller_saved = true;
 		state->regs[1].caller_saved = true;
 		state->regs[2].caller_saved = true;
@@ -526,7 +526,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 		needs_pointer = false;
 	else if (reg == dloc->fbreg || is_fbreg)
 		needs_pointer = false;
-	else if (arch__is(dloc->arch, "x86") && reg == X86_REG_SP)
+	else if (arch__is_x86(dloc->arch) && reg == X86_REG_SP)
 		needs_pointer = false;
 
 	/* Get the type of the variable */
@@ -1071,7 +1071,7 @@ static void delete_var_types(struct die_var_type *var_types)
 /* should match to is_stack_canary() in util/annotate.c */
 static void setup_stack_canary(struct data_loc_info *dloc)
 {
-	if (arch__is(dloc->arch, "x86")) {
+	if (arch__is_x86(dloc->arch)) {
 		dloc->op->segment = INSN_SEG_X86_GS;
 		dloc->op->imm = true;
 		dloc->op->offset = 40;
@@ -1311,7 +1311,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		/* Direct this-cpu access like "%gs:0x34740" */
 		if (dloc->op->segment == INSN_SEG_X86_GS && dloc->op->imm &&
-		    arch__is(dloc->arch, "x86")) {
+		    arch__is_x86(dloc->arch)) {
 			pr_debug_dtp("this-cpu var");
 
 			addr = dloc->op->offset;
@@ -1397,7 +1397,7 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 
 static int arch_supports_insn_tracking(struct data_loc_info *dloc)
 {
-	if ((arch__is(dloc->arch, "x86")) || (arch__is(dloc->arch, "powerpc")))
+	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)))
 		return 1;
 	return 0;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 132af2556aec..79702072568b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2474,7 +2474,7 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 	 * %gs:0x18(%rbx).  In that case it should skip the part.
 	 */
 	if (*str == arch->objdump.register_char) {
-		if (arch__is(arch, "x86")) {
+		if (arch__is_x86(arch)) {
 			/* FIXME: Handle other segment registers */
 			if (!strncmp(str, "%gs:", 4))
 				op_loc->segment = INSN_SEG_X86_GS;
@@ -2571,7 +2571,7 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 		op_loc->reg2 = -1;
 
 		if (insn_str == NULL) {
-			if (!arch__is(arch, "powerpc"))
+			if (!arch__is_powerpc(arch))
 				continue;
 		}
 
@@ -2580,7 +2580,7 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 		 * required fields for op_loc, ie reg1, reg2, offset from the
 		 * raw instruction.
 		 */
-		if (arch__is(arch, "powerpc")) {
+		if (arch__is_powerpc(arch)) {
 			op_loc->mem_ref = mem_ref;
 			op_loc->multi_regs = multi_regs;
 			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
@@ -2591,7 +2591,7 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 		} else {
 			char *s, *p = NULL;
 
-			if (arch__is(arch, "x86")) {
+			if (arch__is_x86(arch)) {
 				/* FIXME: Handle other segment registers */
 				if (!strncmp(insn_str, "%gs:", 4)) {
 					op_loc->segment = INSN_SEG_X86_GS;
@@ -2675,7 +2675,7 @@ static struct annotated_item_stat *annotate_data_stat(struct list_head *head,
 
 static bool is_stack_operation(const struct arch *arch, struct disasm_line *dl)
 {
-	if (arch__is(arch, "x86")) {
+	if (arch__is_x86(arch)) {
 		if (!strncmp(dl->ins.name, "push", 4) ||
 		    !strncmp(dl->ins.name, "pop", 3) ||
 		    !strncmp(dl->ins.name, "call", 4) ||
@@ -2689,7 +2689,7 @@ static bool is_stack_operation(const struct arch *arch, struct disasm_line *dl)
 static bool is_stack_canary(const struct arch *arch, struct annotated_op_loc *loc)
 {
 	/* On x86_64, %gs:40 is used for stack canary */
-	if (arch__is(arch, "x86")) {
+	if (arch__is_x86(arch)) {
 		if (loc->segment == INSN_SEG_X86_GS && loc->imm &&
 		    loc->offset == 40)
 			return true;
@@ -2704,7 +2704,7 @@ static bool is_stack_canary(const struct arch *arch, struct annotated_op_loc *lo
  */
 static bool is_address_gen_insn(const struct arch *arch, struct disasm_line *dl)
 {
-	if (arch__is(arch, "x86")) {
+	if (arch__is_x86(arch)) {
 		if (!strncmp(dl->ins.name, "lea", 3))
 			return true;
 	}
@@ -2847,7 +2847,7 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 		}
 
 		/* This CPU access in kernel - pretend PC-relative addressing */
-		if (dso__kernel(map__dso(ms->map)) && arch__is(arch, "x86") &&
+		if (dso__kernel(map__dso(ms->map)) && arch__is_x86(arch) &&
 		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
 			dloc.var_addr = op_loc->offset;
 			op_loc->reg1 = DWARF_REG_PC;
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 2c7feab61b7b..ce06cfd253ef 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -147,7 +147,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 	struct symbol *sym;
 
 	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
+	if (!arch__is_x86(args->arch))
 		return;
 
 	if (insn->detail == NULL)
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 7cfea3419041..bc6cc7a60e3c 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -228,9 +228,14 @@ const struct arch *arch__find(const char *name)
 	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
 }
 
-bool arch__is(const struct arch *arch, const char *name)
+bool arch__is_x86(const struct arch *arch)
 {
-	return !strcmp(arch->name, name);
+	return arch->e_machine == EM_386 || arch->e_machine == EM_X86_64;
+}
+
+bool arch__is_powerpc(const struct arch *arch)
+{
+	return arch->e_machine == EM_PPC || arch->e_machine == EM_PPC64;
 }
 
 static void ins_ops__delete(struct ins_operands *ops)
@@ -877,7 +882,7 @@ static const struct ins_ops *__ins__find(const struct arch *arch, const char *na
 	struct ins *ins;
 	const int nmemb = arch->nr_instructions;
 
-	if (arch__is(arch, "powerpc")) {
+	if (arch__is_powerpc(arch)) {
 		/*
 		 * For powerpc, identify the instruction ops
 		 * from the opcode using raw_insn.
@@ -1066,7 +1071,7 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 		goto out_delete;
 
 	if (args->offset != -1) {
-		if (arch__is(args->arch, "powerpc")) {
+		if (arch__is_powerpc(args->arch)) {
 			if (disasm_line__parse_powerpc(dl, args) < 0)
 				goto out_free_line;
 		} else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
@@ -1698,7 +1703,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	 * and typeoff, disassemble to mnemonic notation is not required in
 	 * case of powerpc.
 	 */
-	if (arch__is(args->arch, "powerpc")) {
+	if (arch__is_powerpc(args->arch)) {
 		extern const char *sort_order;
 
 		if (sort_order && !strstr(sort_order, "sym")) {
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 4f5c9a985786..db7f1ee3d8e7 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -106,7 +106,8 @@ struct annotate_args {
 };
 
 const struct arch *arch__find(const char *name);
-bool arch__is(const struct arch *arch, const char *name);
+bool arch__is_x86(const struct arch *arch);
+bool arch__is_powerpc(const struct arch *arch);
 
 const struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl);
 
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 4ada9a10bd93..0d126d233c01 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -146,7 +146,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 		return errno;
 
 	init_llvm();
-	if (arch__is(args->arch, "x86")) {
+	if (arch__is_x86(args->arch)) {
 		const char *triplet = is_64bit ? "x86_64-pc-linux" : "i686-pc-linux";
 
 		disasm = LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
-- 
2.52.0.457.g6b5491de43-goog

