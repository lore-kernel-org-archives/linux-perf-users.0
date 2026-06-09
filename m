Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5A3C2BAF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982307; cv=none; b=TbX+wvoX3WVdxXQBAvSfrAGqzD/iF4Z6XAkNUvxwQFpXfY3YlolXeYcIlC2GZIOW8qg0ihFs3xP8iyZRxlgpCs2F6GHcJpexqKr3f0pyGlrv/PcFRXAnx2wIITptDH3B5Tzq+r8gq2NZa+Mqef20xG30sZC9zK35k5xIfXb91Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982307; c=relaxed/simple;
	bh=Q0isCVdlrVSfn3ljYs2T5HWsmfKkYkB5twiZuhYIfe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lKKfQQ1CmX82ljjw3LRMndosfKJUX5aADKpoYmRRH2ga4ybkuglpGVYTaiSURqFS4rlhMyHtPoi2z8IXdI/sOx3cprnK3R/7RQh+qXl9k4EpjZ00ro9hUUsBLvSAhKZw7d5UpL/mxek2+ecOb01r7GCcBRsWOV7kWwlrF2Wr2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdaLn6R0; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdaLn6R0"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074797dfa9so7232341eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982302; x=1781587102; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZ4TyZaXuZ0GggIs0Vx+7Lb3JeADxJTrWnxZqesc/i8=;
        b=GdaLn6R0nSfh6mK/+K2U2BD8cjWLXlAfyyq3DVc8X/V3JuK9i3SJ9Q5Bnj/Jpxi/aI
         GbC4NHGu5D2ovSecH6mPii5uwaqhEA7sOibSLwkMeBBMtljwu2hbFUm4Se1W7dZ6qTpV
         ptOHZOrqBkhY5BklJp9Nb1jQ2sgZh1ok78nQOcDCwuqQIEBI3mUpG99EUPqQHXCsvsyt
         ppuv3sBEBvgPUwvaHUfvVEEnuo5HrABcY0Uzk/0HCxUxk/ui/okS995zpAPIteiPo92Z
         yyVNm8MJq/tfbhm0s9JrU8rFyo760bXzLgXRGqMrnykWPbSRvgDMwUFjA+i8qeh54OMS
         gcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982302; x=1781587102;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ4TyZaXuZ0GggIs0Vx+7Lb3JeADxJTrWnxZqesc/i8=;
        b=N7L4Qyg/pUwHy4c0E4TBlAOLMu9F7AogHl69BAUquEG+ylnDW/qwJnLvw9CXAWLJLJ
         L88zG7LkDK23UvgXr2XtINYAEwXADdjg5LjK6nSgsjwS+Eu21CpKN44IN+z77dUAI+ge
         EZrSVpni8Jw4r82jNH+2/tAy1rQgdTOBWZJnEFvgSpnsoKvTFPJn+6Sia+txZtBhzky4
         QDl5GzBJxKqmVTDjE1Cyldl55gSKmiO9flPNgdU4wx+m6tLGGlio3Mqxmqhah+QnCrlz
         ABLJv8bREW8uiTWGwsQnrD/U+Dx7kKV7RvB20HV4nczPAXBueamEaU+Mrd/QwP2uzefs
         79SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fVPt47hHClUQUF0iu4F3Ut96FDNC7ULrBVrMsgikk60KqZ7ICra8adjx9XkfJ7+Vx8YRJ2wJSQoyBtn+Pelle@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqnh6pfmxbTLHzZu6tMWcAJ+Ftlzw9lJ+plyRsyexqWKhoUOHE
	VqjnuJvB+/rm+U4oKYxkF0RAyC1sVztnoEuWeJPrmnPfkaCB9QxgRxcGFoeV2dbbwUvx6mzycO5
	GYd8BVKiqOg==
X-Received: from dlbdz8.prod.google.com ([2002:a05:7022:ec8:b0:137:f4b6:b399])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4306:10b0:138:12fa:3794
 with SMTP id a92af1059eb24-13812fa38e8mr4342620c88.26.1780982301610; Mon, 08
 Jun 2026 22:18:21 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:58 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-7-irogers@google.com>
Subject: [PATCH v1 6/7] perf annotate: Support BPF JIT disassembly via genelf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For in-memory BPF DSOs (DSO_BINARY_TYPE__BPF_PROG_INFO), write the
JITted instruction buffer to a temporary ELF file on disk using the
existing genelf framework (jit_write_elf). Reroute disassembly to
this temporary ELF file, allowing objdump and libasm to disassemble it
natively. Clean up the temporary file afterward.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 107 ++++++++++++++++++++++++++++++++++++---
 tools/perf/util/disasm.h |   1 +
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 42af3603fdff..8c78ef765787 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -23,6 +23,9 @@
 #include "debug.h"
 #include "disasm.h"
 #include "libasm.h"
+#ifdef HAVE_LIBELF_SUPPORT
+#include "genelf.h"
+#endif
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "env.h"
@@ -1420,7 +1423,7 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO && !args->is_temp_elf)
 		return symbol__disassemble_bpf_libbfd(sym, args);
 
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
@@ -1540,6 +1543,41 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	return err;
 }
 
+#ifdef HAVE_LIBELF_SUPPORT
+static int symbol__create_bpf_temp_elf(const char *filename, struct symbol *sym,
+				       struct annotate_args *args,
+				       char *tmp_elf, size_t tmp_elf_sz)
+{
+	struct map *map = args->ms->map;
+	struct dso *dso = map__dso(map);
+	u8 *code_buf = NULL;
+	const u8 *buf;
+	u64 buf_len;
+	bool is_64bit;
+	int tmp_fd;
+	int err = -1;
+
+	buf = dso__read_symbol(dso, filename, map, sym, &code_buf, &buf_len, &is_64bit);
+	if (!buf)
+		return -1;
+
+	snprintf(tmp_elf, tmp_elf_sz, "/tmp/perf-bpf-XXXXXX");
+	tmp_fd = mkstemp(tmp_elf);
+	if (tmp_fd >= 0) {
+		if (jit_write_elf(tmp_fd, map__rip_2objdump(map, sym->start),
+				  sym->name, buf, buf_len,
+				  NULL, 0, NULL, 0, 0) == 0) {
+			err = 0;
+		}
+		close(tmp_fd);
+		if (err)
+			unlink(tmp_elf);
+	}
+	free(code_buf);
+	return err;
+}
+#endif
+
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *options = args->options;
@@ -1549,8 +1587,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	bool delete_extract = false;
 	struct kcore_extract kce;
 	bool decomp = false;
-	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
+	int err;
 
+	args->is_temp_elf = false;
+
+	err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 	if (err)
 		return err;
 
@@ -1605,7 +1646,25 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	/* FIXME: LLVM and CAPSTONE should support source code */
 	if (options->annotate_src && !options->hide_src_code) {
-		err = symbol__disassemble_objdump(symfs_filename, sym, args);
+		const char *disasm_filename = symfs_filename;
+		bool is_temp = false;
+		char tmp_elf[PATH_MAX];
+
+#ifdef HAVE_LIBELF_SUPPORT
+		if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+			if (symbol__create_bpf_temp_elf(symfs_filename, sym, args,
+							tmp_elf, sizeof(tmp_elf)) == 0) {
+				disasm_filename = tmp_elf;
+				is_temp = true;
+				args->is_temp_elf = true;
+			}
+		}
+#endif
+		err = symbol__disassemble_objdump(disasm_filename, sym, args);
+		if (is_temp) {
+			unlink(tmp_elf);
+			args->is_temp_elf = false;
+		}
 		if (err == 0)
 			goto out_remove_tmp;
 	}
@@ -1613,29 +1672,63 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = -1;
 	for (u8 i = 0; i < ARRAY_SIZE(options->disassemblers) && err != 0; i++) {
 		enum perf_disassembler dis = options->disassemblers[i];
+		const char *disasm_filename = symfs_filename;
+		bool is_temp = false;
+		char tmp_elf[PATH_MAX];
+
+		switch (dis) {
+		case PERF_DISASM_LIBASM:
+		case PERF_DISASM_OBJDUMP:
+#ifdef HAVE_LIBELF_SUPPORT
+			if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+				if (symbol__create_bpf_temp_elf(symfs_filename, sym, args,
+								tmp_elf, sizeof(tmp_elf)) == 0) {
+					disasm_filename = tmp_elf;
+					is_temp = true;
+					args->is_temp_elf = true;
+				}
+			}
+#endif
+			break;
+		case PERF_DISASM_LLVM:
+		case PERF_DISASM_CAPSTONE:
+		case PERF_DISASM_UNKNOWN:
+		default:
+			break;
+		}
 
 		switch (dis) {
 		case PERF_DISASM_LLVM:
 			args->options->disassembler_used = PERF_DISASM_LLVM;
-			err = symbol__disassemble_llvm(symfs_filename, sym, args);
+			err = symbol__disassemble_llvm(disasm_filename, sym, args);
 			break;
 		case PERF_DISASM_CAPSTONE:
 			args->options->disassembler_used = PERF_DISASM_CAPSTONE;
-			err = symbol__disassemble_capstone(symfs_filename, sym, args);
+			err = symbol__disassemble_capstone(disasm_filename, sym, args);
 			break;
 		case PERF_DISASM_LIBASM:
 			args->options->disassembler_used = PERF_DISASM_LIBASM;
-			err = symbol__disassemble_libasm(symfs_filename, sym, args);
+			err = symbol__disassemble_libasm(disasm_filename, sym, args);
 			break;
 		case PERF_DISASM_OBJDUMP:
 			args->options->disassembler_used = PERF_DISASM_OBJDUMP;
-			err = symbol__disassemble_objdump(symfs_filename, sym, args);
+			err = symbol__disassemble_objdump(disasm_filename, sym, args);
 			break;
 		case PERF_DISASM_UNKNOWN: /* End of disassemblers. */
 		default:
 			args->options->disassembler_used = PERF_DISASM_UNKNOWN;
+			if (is_temp) {
+				unlink(tmp_elf);
+				args->is_temp_elf = false;
+			}
 			goto out_remove_tmp;
 		}
+
+		if (is_temp) {
+			unlink(tmp_elf);
+			args->is_temp_elf = false;
+		}
+
 		if (err == 0)
 			pr_debug("Disassembled with %s\n", perf_disassembler__strs[dis]);
 	}
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 25756e3f47e4..32a5b3f5d1c6 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -106,6 +106,7 @@ struct annotate_args {
 	char			  *line;
 	int			  line_nr;
 	char			  *fileloc;
+	bool			  is_temp_elf;
 };
 
 const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
-- 
2.54.0.1064.gd145956f57-goog

