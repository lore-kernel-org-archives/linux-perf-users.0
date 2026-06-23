Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEA2BE05A;
	Tue, 23 Jun 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219767; cv=none; b=KUq4m9R8Mb4/t5g06mtDJdu0Dk173P0x18sxaSqQuFkuHicilgzWtlXwp+9ydIZxHY+ouw5z8qrGxwC2c14HVqKhHFsSpRDgCNFE6hHCxRuSlSMbdg5jIohvgDS/Ywxh9B4NpxJ1GjLxXU9guboI0edQTeJjXtbDVTLX+BpZ7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219767; c=relaxed/simple;
	bh=uqhoioUKJmm5ByIRFMn7RRM3RgTEGlrLJTWIE8DnSU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUz/ZVL/N7IAMSLHuCKoqKqZRXqSNpFqSF7UFcm76UdAFlAPXw2i4pah9brt9PqD4rfDuiOEbHHcszdNw78W7lKlEanckV7i71z6oAvQqPVn5omp9kqKbFHOU8Lot1yimm022MVOgL90DpmjgLUomNwXGZXY9NDCTYrbBbRx7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oBId7k6Q; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oBId7k6Q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782219761; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zIHwQ42aJHxpbTfGhKZHK2ouoH4tx53i5ocbBCdN6CE=;
	b=oBId7k6QUZYP4t9AqF/e9aqqi/+YCOWX5Pfr89m94aE9X7zX2rFZ6Bob5/dAFl0xaGO6zt8SaYMksAKgEP5aV/JzrTcWTdehr1BGTziQsZ9nchz9bF7RHdyy/v4yCtXUv2Y3gYEJ0Tm8kNPSgdb9YmSpsmstdsj5dSXUY4ZTypg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5UKIlu_1782219759;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5UKIlu_1782219759 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 21:02:39 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/5] perf disasm: Add ARM64 architecture detection and raw instruction parsing
Date: Tue, 23 Jun 2026 21:02:31 +0800
Message-Id: <20260623130234.8709-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arch__is_arm64() helper to identify ARM64 binaries by ELF machine
type, following the existing arch__is_x86() and arch__is_powerpc()
pattern.

Add disasm_line__parse_arm64() to extract raw 32-bit instruction words
from ARM64 objdump output. Unlike PowerPC which needs be32_to_cpu()
byte-swapping, ARM64 instructions are always little-endian and can be
used directly. The parser finds the hex word boundary dynamically
instead of using a hardcoded width, and validates the sscanf result.

Set annotate_opts.show_asm_raw in arch__new_arm64() so that objdump
includes raw instruction bytes, which the parser requires.

Wire up the ARM64 parsing path in disasm_line__new() alongside the
existing PowerPC path.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  |  1 +
 tools/perf/util/disasm.c                      | 64 +++++++++++++++++++
 tools/perf/util/disasm.h                      |  2 +
 3 files changed, 67 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 33080fdca125..b98aaf9a8a7b 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -104,6 +104,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	annotate_opts.show_asm_raw = true;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 59ba88e1f744..83fad4f01442 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -52,6 +52,7 @@ const struct ins_ops arithmetic_ops;
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
 static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_args *args);
+static int disasm_line__parse_arm64(struct disasm_line *dl, struct annotate_args *args);
 
 static __attribute__((constructor)) void symbol__init_regexpr(void)
 {
@@ -203,6 +204,11 @@ bool arch__is_powerpc(const struct arch *arch)
 	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
 }
 
+bool arch__is_arm64(const struct arch *arch)
+{
+	return arch->id.e_machine == EM_AARCH64;
+}
+
 static void ins_ops__delete(struct ins_operands *ops)
 {
 	if (ops == NULL)
@@ -777,6 +783,14 @@ static const struct ins_ops *__ins__find(const struct arch *arch, const char *na
 			return ops;
 	}
 
+	if (arch__is_arm64(arch)) {
+		const struct ins_ops *ops;
+
+		ops = check_arm64_insn(dl);
+		if (ops)
+			return ops;
+	}
+
 	if (!arch->sorted_instructions) {
 		ins__sort((struct arch *)arch);
 		((struct arch *)arch)->sorted_instructions = true;
@@ -902,6 +916,53 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
 	return ret;
 }
 
+/*
+ * Parses ARM64 disassembly output which includes raw instruction bytes.
+ * ARM64 objdump format:
+ *   a9bf7bfd 	stp	x29, x30, [sp, #-16]!
+ *
+ * The raw instruction is a hex word (typically 8 chars) followed by whitespace.
+ */
+static int disasm_line__parse_arm64(struct disasm_line *dl, struct annotate_args *args)
+{
+	char *line = dl->al.line;
+	const char **namep = &dl->ins.name;
+	char **rawp = &dl->ops.raw;
+	char *name_raw_insn = skip_spaces(line);
+	char *end_raw, *name, *tmp_raw_insn;
+	int ret = 0;
+
+	if (name_raw_insn[0] == '\0')
+		return -1;
+
+	/* Find end of raw instruction hex by looking for whitespace */
+	end_raw = name_raw_insn;
+	while (*end_raw && !isspace(*end_raw))
+		end_raw++;
+
+	name = skip_spaces(end_raw);
+
+	if (args->options->disassembler_used)
+		ret = disasm_line__parse(name, namep, rawp);
+	else
+		*namep = "";
+
+	tmp_raw_insn = strndup(name_raw_insn, end_raw - name_raw_insn);
+	if (tmp_raw_insn == NULL) {
+		if (args->options->disassembler_used)
+			zfree(namep);
+		return -1;
+	}
+
+	remove_spaces(tmp_raw_insn);
+
+	if (sscanf(tmp_raw_insn, "%x", &dl->raw.raw_insn) != 1)
+		dl->raw.raw_insn = 0;
+	free(tmp_raw_insn);
+
+	return ret;
+}
+
 static void annotation_line__init(struct annotation_line *al,
 				  struct annotate_args *args,
 				  int nr)
@@ -958,6 +1019,9 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 		if (arch__is_powerpc(args->arch)) {
 			if (disasm_line__parse_powerpc(dl, args) < 0)
 				goto out_free_line;
+		} else if (arch__is_arm64(args->arch)) {
+			if (disasm_line__parse_arm64(dl, args) < 0)
+				goto out_free_line;
 		} else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 			goto out_free_line;
 
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 25756e3f47e4..dfce128a3188 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -111,6 +111,7 @@ struct annotate_args {
 const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
 bool arch__is_x86(const struct arch *arch);
 bool arch__is_powerpc(const struct arch *arch);
+bool arch__is_arm64(const struct arch *arch);
 
 extern const struct ins_ops call_ops;
 extern const struct ins_ops dec_ops;
@@ -143,6 +144,7 @@ bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
 const struct ins_ops *check_ppc_insn(struct disasm_line *dl);
+const struct ins_ops *check_arm64_insn(struct disasm_line *dl);
 
 struct disasm_line *disasm_line__new(struct annotate_args *args);
 void disasm_line__free(struct disasm_line *dl);
-- 
2.51.2.612.gdc70283dfc

