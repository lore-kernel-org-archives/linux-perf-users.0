Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690563D813C
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988874; cv=none; b=vGixMfymPMi6dgoEnidIi4TOLQIj/qb+g224iC7g0nlaKfq9gLUccSvZ/xuH6PuK3szABWPX9ouBvWtkkGLAe7mLSwMAaMkIfKgC8VJScMrXzx9i2Wo2hbU5bUtMMnNgOfAgT3YZfDbog9EwuIomP+upNpBQLE17QR0lVRF12fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988874; c=relaxed/simple;
	bh=eEAqOVQ7jgkMsFR7m4Al77yMjHhfHCBYejmIVbB+oIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tXfIVZqlUaQB0sgwj2OPoBFisWYVECekDEQXtRGLJYEjsDO9dLu8gnDaC4va6K74AWoyxfEJAiu6XpV+j5849ZDMlZ459H1lOVnMzFX96zWj2GnhMSpiY1HnDtnXpmNHA3bTzpZLSzVWZYn+wjUGKhcTySAhB8SlncbZQe4ozUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NlPPdy+n; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlPPdy+n"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f23c55b2so5204287eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988872; x=1781593672; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RT9vbijmuSRhN5e951EY2ubCmPvlLiTiWxtk659Fbr4=;
        b=NlPPdy+nC1tCMyeofNcZvtKjeruMHD77CJN8bTcOU7btj9LAT0RzHVWymZyN8jI5dD
         +ZtWb5H9T9K7MLNNr6PU61IZEuHC2b14i5vJrd+NE9dWFlhKMIx5Wq2K5xqyoCnvxwOf
         aQQyuSWILq/uBzAYWDjsCdL9icdOE+FW4SUsbU9qoxixthEy15jw3qFkZbaOGYTcvyJz
         fRQs0Tx/wqNtHK3x5ArA6YD8mJP43VXDTb3fFvD0CKF8cwMvPjtf/sFQrMRCLOh4baUV
         Vd7wxUIzzzvdcW/sAL2xgyUitJvyhOIsGbDDNRd3U9sifG0dKoROdhOJfHZcQvnmBwIw
         5w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988872; x=1781593672;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RT9vbijmuSRhN5e951EY2ubCmPvlLiTiWxtk659Fbr4=;
        b=G87wP/tSHgi9KPWosFUYbRa5Z5uLcQlqsqm/+K/K9O1PC2tIiwzp2DqfH7byaPlxsa
         IZksiwTKkB6yX1XzoUH+ARSXBv4IixzSDsLDA1U33DbXVGRACGnHvSgy+w3VpdUcyjxy
         wJWP11gihyhebAEtf4ILZuPlJnch9XwdPNGzIffGrcLSmW74qGqNj+layDeITAOcIcVk
         vISA434JryFbiIk4HCSuge0Hn+iJ+Yzr8K0NcI9aUvqfwLMua8l9cKbCfl9dh2GrXga/
         X8fZV3Wfip0WzQithFLj42EA+dF/AgRP8GCDxVYP/92gHxRp/xAuM9wQYdbCEpb859mh
         MM0w==
X-Forwarded-Encrypted: i=1; AFNElJ9API38P+ikkR8wf/5HUX2DNFqxGIJJ5DcxXLBUcExqTomVUIhuLBF11qtJCLF6YK6jULdVMDVSbIPhXI30oKvw@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyxYUUP5zD1bZPYZNUbFgwErHrXBBP1wfPaBX3zKi97ohq5Be
	B1XpDCidEKwl1/1Xpy19hniG/gbF0uN8jE7Lgxl0Quiec0sZpKD5S61OUpGAmFuXMqwoadRsFM4
	E4CARv77bmA==
X-Received: from dybtt1.prod.google.com ([2002:a05:7300:f401:b0:304:ec70:1029])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd14:b0:304:8870:2ac5
 with SMTP id 5a478bee46e88-3077b328526mr10773330eec.6.1780988871384; Tue, 09
 Jun 2026 00:07:51 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:31 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-7-irogers@google.com>
Subject: [PATCH v2 6/7] perf annotate: Support BPF JIT disassembly via genelf
From: Ian Rogers <irogers@google.com>
To: Serhei Makarov <serhei@serhei.io>, mark@klomp.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
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
 tools/perf/tests/genelf.c |   2 +-
 tools/perf/util/disasm.c  | 111 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/disasm.h  |   1 +
 tools/perf/util/genelf.c  |   4 +-
 tools/perf/util/genelf.h  |   2 +-
 tools/perf/util/jitdump.c |   2 +-
 6 files changed, 110 insertions(+), 12 deletions(-)

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
index 14882def9704..42731b6de797 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -179,7 +179,7 @@ static void blake2s_update_tagged(struct blake2s_ctx *ctx, int tag,
  * csize: the code size in bytes
  */
 int
-jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
+jit_write_elf(int fd, uint16_t e_machine, uint64_t load_addr __maybe_unused, const char *sym,
 	      const void *code, int csize,
 	      void *debug __maybe_unused, int nr_debug_entries __maybe_unused,
 	      void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size)
@@ -218,7 +218,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 
 	ehdr->e_ident[EI_DATA] = GEN_ELF_ENDIAN;
 	ehdr->e_ident[EI_CLASS] = GEN_ELF_CLASS;
-	ehdr->e_machine = GEN_ELF_ARCH;
+	ehdr->e_machine = e_machine;
 	ehdr->e_type = ET_DYN;
 	ehdr->e_entry = GEN_ELF_TEXT_OFFSET;
 	ehdr->e_version = EV_CURRENT;
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
index 18fd84a82153..febf3e5a7851 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -95,7 +95,7 @@ jit_emit_elf(struct jit_buf_desc *jd,
 		return -1;
 	}
 
-	ret = jit_write_elf(fd, code_addr, sym, (const void *)code, csize, debug, nr_debug_entries,
+	ret = jit_write_elf(fd, GEN_ELF_ARCH, code_addr, sym, (const void *)code, csize, debug, nr_debug_entries,
 			    unwinding, unwinding_header_size, unwinding_size);
 
         close(fd);
-- 
2.54.0.1064.gd145956f57-goog

