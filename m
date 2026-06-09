Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCD4CA271
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029287; cv=none; b=kXXkS2z6dXoPfrWuXGw5haY1qgs1NcBAs8yIlltYc9s8qya66J0TJVCM7NWnE46i2rfDw67NC3p+bao3hYFro6UKN2E8XwTNCLL2xE43hdXAHY0yUKr4uHHHNqD/Vxg2xP9BMvmrQA4GJD5rDB1i+HpxTp5mn6tmLjw5pIeHtp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029287; c=relaxed/simple;
	bh=orYa/EopEB8/3q8PXupahwgg9uNj8+k3sWYBCs7/5eE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lyq/3WfUR7OkqhIl93eAN1NroUh8GZ5FLEngzbUAlkx98yAWNQ3OREq1FxGj8qh2DS/XTe8/J+KFAmQBdGxgZgr7Se9yuydDia+vE6zAZYgGMAqe3B9jhapQeXE+M6fn2Ky5zS3hkkPGpv60fFAD2RiAhX25TsQZluyMIIiFC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cff5ADgD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cff5ADgD"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30761ab3483so15997810eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029285; x=1781634085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1lPccdlXeo/XjksmAjYV516kNKYAAjQtkUSY5yJm8A=;
        b=Cff5ADgDBMO1LG9iqBw25FSCG6c8r7S5rwiUYTElu/NWAGZGMo6qbiNV+JruGeVIpg
         eJRW3rnZQcwhxYXBEHB23GvWZjz2/SrPBdJOP4JKLoqSnfqSw/RRKNNm/3L1QLdXp6fe
         cBNXNIX/Ug7fO6nPPv9OWSqWQEGmlPat5M+HXnBnQNZJd7AsnpQMBexJBOnunA2dbAn0
         bDcDoIjLdEBQiwooyLA+MoQ0vBdx7zQSpSnYE9TIjaClf5WI9P9MTvFZ59h6etyD+Dv5
         j9RutCFkATatQtvykfj2Y/M3gXgHMaFDb9/+Z4Kp/aEJo/nGMKuivQEcOT7sXjB9xPmN
         2stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029285; x=1781634085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1lPccdlXeo/XjksmAjYV516kNKYAAjQtkUSY5yJm8A=;
        b=qxLoJso+9/Rs+EAAMmzDVheu7likqAzMG3Af53nRcLdCJomABO2D7+hofBDQJGdlx7
         adF5CNWyAF7VsS7av61TOMN3EqFhYcd4hHBFboq7IwgddUfVj4FS6icxA1M5RelLX6Sy
         9W3rtyywtOCGDIIK4yuoOCQqVnNPSYFD/HyOx841r7poftewsVQGxV5GDbpd1zanxmQp
         ns8Sd6K7ctj7v30ubFM+UgMz50NXn8BC04xsAG5eXPyju6YyCGxyyKNYV6vp3gt0mO7B
         T1e9Lj8Dh6+hIFY+wgOAnuyuunRg2M/dz2HuGSKSFHAk4ZTL1xvY1xNAoIpKMXLZsIlr
         RSwg==
X-Forwarded-Encrypted: i=1; AFNElJ9e2EduSeobwBFsGpLAGDGcvo0qRUhLLxHk/OfWpq22nJ5Ap0+QIuFJeps4505wt9XRAb0SXJwUjyWPD7MhmO9b@vger.kernel.org
X-Gm-Message-State: AOJu0YxktOC53OxyEucl5ZGfOaRCcwGAIseA5ps7anDyiRDqorATf58k
	g+m0WEBOMjIF2knChz6qmptI2tF3Sf8E2SaZTJPgjPtGcdnQSq2gArZQmzy/psvNsQPvIN8wuK8
	CrboVSTc42g==
X-Received: from dyba16.prod.google.com ([2002:a05:693c:63d0:b0:304:cde4:bdc3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6917:b0:2c1:6676:5ebd
 with SMTP id 5a478bee46e88-307d5fed672mr3397977eec.10.1781029284650; Tue, 09
 Jun 2026 11:21:24 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:07 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-7-irogers@google.com>
Subject: [PATCH v3 6/7] perf annotate: Support BPF JIT disassembly via genelf
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

For in-memory BPF DSOs (DSO_BINARY_TYPE__BPF_PROG_INFO), write the
JITted instruction buffer to a temporary ELF file on disk using the
existing genelf framework (jit_write_elf). Reroute disassembly to
this temporary ELF file, allowing objdump and libasm to disassemble it
natively. Clean up the temporary file afterward.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/genelf.c |   2 +-
 tools/perf/util/disasm.c  | 111 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/disasm.h  |   1 +
 tools/perf/util/genelf.c  |  16 +++---
 tools/perf/util/genelf.h  |   2 +-
 tools/perf/util/jitdump.c |   3 +-
 6 files changed, 117 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
index 95f3be1b683a..1723370db32e 100644
--- a/tools/perf/tests/genelf.c
+++ b/tools/perf/tests/genelf.c
@@ -38,7 +38,7 @@ static int test__jit_write_elf(struct test_suite *test __maybe_unused,
 
 	pr_info("Writing jit code to: %s\n", path);
 
-	ret = jit_write_elf(fd, 0, "main", x86_code, sizeof(x86_code),
+	ret = jit_write_elf(fd, GEN_ELF_ARCH, 0, "main", x86_code, sizeof(x86_code),
 			NULL, 0, NULL, 0, 0);
 	close(fd);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 42af3603fdff..0648afd1b5f3 100644
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
@@ -1540,6 +1543,45 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	return err;
 }
 
+#ifdef HAVE_LIBELF_SUPPORT
+#include <unistd.h>
+#include "dwarf-regs.h"
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
+		uint16_t e_machine = args->arch ? args->arch->id.e_machine : EM_HOST;
+
+		if (jit_write_elf(tmp_fd, e_machine, map__rip_2objdump(map, sym->start),
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
@@ -1549,8 +1591,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	bool delete_extract = false;
 	struct kcore_extract kce;
 	bool decomp = false;
-	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
+	int err;
+
+	args->is_temp_elf = false;
 
+	err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 	if (err)
 		return err;
 
@@ -1605,7 +1650,25 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
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
@@ -1613,29 +1676,63 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 14882def9704..c3af040121ee 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -179,7 +179,7 @@ static void blake2s_update_tagged(struct blake2s_ctx *ctx, int tag,
  * csize: the code size in bytes
  */
 int
-jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
+jit_write_elf(int fd, uint16_t e_machine, uint64_t load_addr, const char *sym,
 	      const void *code, int csize,
 	      void *debug __maybe_unused, int nr_debug_entries __maybe_unused,
 	      void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size)
@@ -218,9 +218,9 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 
 	ehdr->e_ident[EI_DATA] = GEN_ELF_ENDIAN;
 	ehdr->e_ident[EI_CLASS] = GEN_ELF_CLASS;
-	ehdr->e_machine = GEN_ELF_ARCH;
+	ehdr->e_machine = e_machine;
 	ehdr->e_type = ET_DYN;
-	ehdr->e_entry = GEN_ELF_TEXT_OFFSET;
+	ehdr->e_entry = load_addr;
 	ehdr->e_version = EV_CURRENT;
 	ehdr->e_shstrndx= unwinding ? 4 : 2; /* shdr index for section name */
 
@@ -230,8 +230,8 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	phdr = elf_newphdr(e, 1);
 	phdr[0].p_type = PT_LOAD;
 	phdr[0].p_offset = GEN_ELF_TEXT_OFFSET;
-	phdr[0].p_vaddr = GEN_ELF_TEXT_OFFSET;
-	phdr[0].p_paddr = GEN_ELF_TEXT_OFFSET;
+	phdr[0].p_vaddr = load_addr;
+	phdr[0].p_paddr = load_addr;
 	phdr[0].p_filesz = csize;
 	phdr[0].p_memsz = csize;
 	phdr[0].p_flags = PF_X | PF_R;
@@ -267,7 +267,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 
 	shdr->sh_name = 1;
 	shdr->sh_type = SHT_PROGBITS;
-	shdr->sh_addr = GEN_ELF_TEXT_OFFSET;
+	shdr->sh_addr = load_addr;
 	shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
 	shdr->sh_entsize = 0;
 
@@ -278,7 +278,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	 * Setup .eh_frame_hdr and .eh_frame
 	 */
 	if (unwinding) {
-		eh_frame_base_offset = ALIGN_8(GEN_ELF_TEXT_OFFSET + csize);
+		eh_frame_base_offset = ALIGN_8(load_addr + csize);
 		retval = jit_add_eh_frame_info(e, unwinding,
 					       unwinding_header_size, unwinding_size,
 					       eh_frame_base_offset);
@@ -324,7 +324,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	 * setup symtab section
 	 */
 	symtab[1].st_size  = csize;
-	symtab[1].st_value = GEN_ELF_TEXT_OFFSET;
+	symtab[1].st_value = load_addr;
 
 	scn = elf_newscn(e);
 	if (!scn) {
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 9f0b875d6548..992ca1eb2734 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -5,7 +5,7 @@
 #include <linux/math.h>
 
 /* genelf.c */
-int jit_write_elf(int fd, uint64_t code_addr, const char *sym,
+int jit_write_elf(int fd, uint16_t e_machine, uint64_t code_addr, const char *sym,
 		  const void *code, int csize, void *debug, int nr_debug_entries,
 		  void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size);
 #ifdef HAVE_LIBDW_SUPPORT
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 18fd84a82153..ddf69032b01c 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -95,7 +95,8 @@ jit_emit_elf(struct jit_buf_desc *jd,
 		return -1;
 	}
 
-	ret = jit_write_elf(fd, code_addr, sym, (const void *)code, csize, debug, nr_debug_entries,
+	ret = jit_write_elf(fd, GEN_ELF_ARCH, code_addr, sym,
+			    (const void *)code, csize, debug, nr_debug_entries,
 			    unwinding, unwinding_header_size, unwinding_size);
 
         close(fd);
-- 
2.54.0.1099.g489fc7bff1-goog

