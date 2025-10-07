Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBF2E7BA3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855130; cv=none; b=eYMnZbBueqOmDFX4UbVRe+bhTiLXV7BfiW9INKuXjCuH9sEj4QfInEyVxLKvYAjGqQERRiwSDzIt5K1WegfvG19gZHLK6eJO6s6Uk3+XljGUkMKC/jH2m+rpPYlyHvzRKjQ9xE+k2HxGfHKZvOsRewC8sSRAojqz3krSlaYwGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855130; c=relaxed/simple;
	bh=aEAtMjVjgulTf0TDqlU6QiBFacJWqCSnPGZkk3a6iVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=l7SgVnu3sMcAWF3Tkn8iMLSPFLtC8xWaEgpLQ721fBtOZ1rBfRMJhfYnhfhDv2OgXkA5QNg0TtBLHeLIQS8X8aI++tBE1xSHBYdRNzrVaflMUyUZlu2pvdp4MDviQdh1VhiJHj2UPaN1jAZXw/KWc3+DZK78M/DyRy5kxefCTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/wMRuA9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/wMRuA9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-74a11dbcfa9so59833297b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759855127; x=1760459927; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+k0ZT6dX6FpTW7iWOOUOC483WZu4iMuIQMOn3S3WjJM=;
        b=e/wMRuA9zdqTGDaklPl3S8jW0d77ekKFqzyarZpWDGl4euk0/zk4SPp2Cj4oztrdtC
         r3C6Bg2kIy98Wx5Dn1D1qtzSWfGAzM8jpPwSiFXcq3kj78KcPeMY4H9VBxACuiUlmAtP
         NYorqdNzWRdUGAGTUyByq9rvuGKwBdMi2TldLQdat/efzpMmWtgWXn+5tfQNnVz/RtLx
         4Tvp01WEM+5SoV7R2q9+TmpBAWfIo9rIpnQDsuKxmbew5W1H9GI9gzxDqidQrui7VOY3
         jY7ow2gh19ZGnZCSAAIYtx+SiuYQ3emVi2RCdj3fUKWVcHMEvuiBAhFf+oyBsCkCjGzp
         jhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855127; x=1760459927;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k0ZT6dX6FpTW7iWOOUOC483WZu4iMuIQMOn3S3WjJM=;
        b=IY9OEbb6VEA1lKLhAYAmZ8VVZqWIaG3D37ksZOPLj0x4scvvC69LRbsKYdsEYp+tc7
         DOKXq7a1DstRru5oUouiR+Zo45I2wLiyQ8BZymy5mRj0K4W/1MvFQjj5a6Z4idv85qyd
         MGLmJytMOavOfg0FDkXJdqzQNCq9YCRpKxQtJZ0J1lgciWFyyWffFNetkx9gZFgMDJ/j
         Tuhnj8+csSej+yVg4eZG4qgwlboghklH73k4s9XI/roOXBxEtgBXO9NPTQjCjrj1PDwO
         UQbRe+rs4PLwZD1TFjXUN3zzdKcdMcTjLY5XHAM4sLsmxGF9Saf6Q0szve23FpAQd1rv
         yu7w==
X-Forwarded-Encrypted: i=1; AJvYcCVrK5yu5fq4d8xIRD6tLCQL3PVDHJTqYaL0kjT52vuaqUm6rzt9I9mfyFej2412DboAPMw0WnRGYrnVqD1ISfGy@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbCtTmsAeBmgOb/U/nal7TRmUaS6soq9ZAqpr4YNESSm6gx2o
	NUwxfn2Ps4xWu4GOxhTCtyMFdrQ0WHkCq94bNy/p1Ol8Mjb8JyJjejJviqFdo6FWd/aCwlnfGcA
	rwBnMFx1P7w==
X-Google-Smtp-Source: AGHT+IEhdluirlq0+m/wfeNJEa/Eu7w1+WVIlRbdzTGeOfsckZ/M5CIjnQuLVqdhuiq47CkmS2ugk/WgcoTL
X-Received: from ywbhk4.prod.google.com ([2002:a05:690c:61c4:b0:780:d53c:ae35])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:a0a5:20b0:752:3309:bb6
 with SMTP id 00721157ae682-780e14053bbmr4046637b3.8.1759855127220; Tue, 07
 Oct 2025 09:38:47 -0700 (PDT)
Date: Tue,  7 Oct 2025 09:38:33 -0700
In-Reply-To: <20251007163835.3152881-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007163835.3152881-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007163835.3152881-2-irogers@google.com>
Subject: [PATCH v8 1/3] perf capstone: Support for dlopen-ing libcapstone.so
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
support dlopen-ing libcapstone.so and then calling the necessary
functions by looking them up using dlsym. Reverse engineer the types
in the API using pahole, adding only what's used in the perf code or
necessary for the sake of struct size and alignment.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 285 ++++++++++++++++++++++++++++++++-----
 1 file changed, 248 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index be5fd44b1f9d..88e270237443 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -11,20 +11,250 @@
 #include "print_insn.h"
 #include "symbol.h"
 #include "thread.h"
+#include <dlfcn.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <string.h>
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
+#else
+typedef size_t csh;
+enum cs_arch {
+	CS_ARCH_ARM = 0,
+	CS_ARCH_ARM64 = 1,
+	CS_ARCH_X86 = 3,
+	CS_ARCH_SYSZ = 6,
+};
+enum cs_mode {
+	CS_MODE_ARM = 0,
+	CS_MODE_32 = 1 << 2,
+	CS_MODE_64 = 1 << 3,
+	CS_MODE_V8 = 1 << 6,
+	CS_MODE_BIG_ENDIAN = 1 << 31,
+};
+enum cs_opt_type {
+	CS_OPT_SYNTAX = 1,
+	CS_OPT_DETAIL = 2,
+};
+enum cs_opt_value {
+	CS_OPT_SYNTAX_ATT = 2,
+	CS_OPT_ON = 3,
+};
+enum cs_err {
+	CS_ERR_OK = 0,
+	CS_ERR_HANDLE = 3,
+};
+enum x86_op_type {
+	X86_OP_IMM = 2,
+	X86_OP_MEM = 3,
+};
+enum x86_reg {
+	X86_REG_RIP = 41,
+};
+typedef int32_t x86_avx_bcast;
+struct x86_op_mem {
+	enum x86_reg segment;
+	enum x86_reg base;
+	enum x86_reg index;
+	int scale;
+	int64_t disp;
+};
+
+struct cs_x86_op {
+	enum x86_op_type type;
+	union {
+		enum x86_reg  reg;
+		int64_t imm;
+		struct x86_op_mem mem;
+	};
+	uint8_t size;
+	uint8_t access;
+	x86_avx_bcast avx_bcast;
+	bool avx_zero_opmask;
+};
+struct cs_x86_encoding {
+	uint8_t modrm_offset;
+	uint8_t disp_offset;
+	uint8_t disp_size;
+	uint8_t imm_offset;
+	uint8_t imm_size;
+};
+typedef int32_t  x86_xop_cc;
+typedef int32_t  x86_sse_cc;
+typedef int32_t  x86_avx_cc;
+typedef int32_t  x86_avx_rm;
+struct cs_x86 {
+	uint8_t prefix[4];
+	uint8_t opcode[4];
+	uint8_t rex;
+	uint8_t addr_size;
+	uint8_t modrm;
+	uint8_t sib;
+	int64_t disp;
+	enum x86_reg sib_index;
+	int8_t sib_scale;
+	enum x86_reg sib_base;
+	x86_xop_cc xop_cc;
+	x86_sse_cc sse_cc;
+	x86_avx_cc avx_cc;
+	bool avx_sae;
+	x86_avx_rm avx_rm;
+	union {
+		uint64_t eflags;
+		uint64_t fpu_flags;
+	};
+	uint8_t op_count;
+	struct cs_x86_op operands[8];
+	struct cs_x86_encoding encoding;
+};
+struct cs_detail {
+	uint16_t regs_read[12];
+	uint8_t regs_read_count;
+	uint16_t regs_write[20];
+	uint8_t regs_write_count;
+	uint8_t groups[8];
+	uint8_t groups_count;
+
+	union {
+		struct cs_x86 x86;
+	};
+};
+struct cs_insn {
+	unsigned int id;
+	uint64_t address;
+	uint16_t size;
+	uint8_t bytes[16];
+	char mnemonic[32];
+	char op_str[160];
+	struct cs_detail *detail;
+};
+#endif
+
+#ifndef HAVE_LIBCAPSTONE_SUPPORT
+static void *perf_cs_dll_handle(void)
+{
+	static bool dll_handle_init;
+	static void *dll_handle;
+
+	if (!dll_handle_init) {
+		dll_handle_init = true;
+		dll_handle = dlopen("libcapstone.so", RTLD_LAZY);
+		if (!dll_handle)
+			pr_debug("dlopen failed for libcapstone.so\n");
+	}
+	return dll_handle;
+}
+#endif
+
+static enum cs_err perf_cs_open(enum cs_arch arch, enum cs_mode mode, csh *handle)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_open(arch, mode, handle);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(enum cs_arch arch, enum cs_mode mode, csh *handle);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_open");
+		if (!fn)
+			pr_debug("dlsym failed for cs_open\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(arch, mode, handle);
+#endif
+}
+
+static enum cs_err perf_cs_option(csh handle, enum cs_opt_type type, size_t value)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_option(handle, type, value);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(csh handle, enum cs_opt_type type, size_t value);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_option");
+		if (!fn)
+			pr_debug("dlsym failed for cs_option\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(handle, type, value);
+#endif
+}
+
+static size_t perf_cs_disasm(csh handle, const uint8_t *code, size_t code_size,
+			uint64_t address, size_t count, struct cs_insn **insn)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_disasm(handle, code, code_size, address, count, insn);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(csh handle, const uint8_t *code, size_t code_size,
+				 uint64_t address, size_t count, struct cs_insn **insn);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_disasm");
+		if (!fn)
+			pr_debug("dlsym failed for cs_disasm\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(handle, code, code_size, address, count, insn);
 #endif
+}
 
+static void perf_cs_free(struct cs_insn *insn, size_t count)
+{
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
+	cs_free(insn, count);
+#else
+	static bool fn_init;
+	static void (*fn)(struct cs_insn *insn, size_t count);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_free");
+		if (!fn)
+			pr_debug("dlsym failed for cs_free\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return;
+	fn(insn, count);
+#endif
+}
+
+static enum cs_err perf_cs_close(csh *handle)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_close(handle);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(csh *handle);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_close");
+		if (!fn)
+			pr_debug("dlsym failed for cs_close\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(handle);
+#endif
+}
+
 static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 			 bool disassembler_style)
 {
-	cs_arch arch;
-	cs_mode mode;
+	enum cs_arch arch;
+	enum cs_mode mode;
 
 	if (machine__is(machine, "x86_64") && is64) {
 		arch = CS_ARCH_X86;
@@ -45,7 +275,7 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 		return -1;
 	}
 
-	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
+	if (perf_cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
 		pr_warning_once("cs_open failed\n");
 		return -1;
 	}
@@ -57,27 +287,25 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 		 * is set via annotation args
 		 */
 		if (disassembler_style)
-			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+			perf_cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
 		/*
 		 * Resolving address operands to symbols is implemented
 		 * on x86 by investigating instruction details.
 		 */
-		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
+		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
 	}
 
 	return 0;
 }
-#endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
+static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *insn,
 			     int print_opts, FILE *fp)
 {
 	struct addr_location al;
 	size_t printed = 0;
 
 	if (insn->detail && insn->detail->x86.op_count == 1) {
-		cs_x86_op *op = &insn->detail->x86.operands[0];
+		struct cs_x86_op *op = &insn->detail->x86.operands[0];
 
 		addr_location__init(&al);
 		if (op->type == X86_OP_IMM &&
@@ -95,7 +323,6 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
 	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
 	return printed;
 }
-#endif
 
 
 ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
@@ -106,9 +333,8 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 				   uint64_t ip __maybe_unused, int *lenp __maybe_unused,
 				   int print_opts __maybe_unused, FILE *fp __maybe_unused)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	size_t printed;
-	cs_insn *insn;
+	struct cs_insn *insn;
 	csh cs_handle;
 	size_t count;
 	int ret;
@@ -118,7 +344,7 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 	if (ret < 0)
 		return ret;
 
-	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
+	count = perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
 		if (machine__normalized_is(machine, "x86"))
 			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
@@ -126,20 +352,16 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
 		if (lenp)
 			*lenp = insn->size;
-		cs_free(insn, count);
+		perf_cs_free(insn, count);
 	} else {
 		printed = -1;
 	}
 
-	cs_close(&cs_handle);
+	perf_cs_close(&cs_handle);
 	return printed;
-#else
-	return -1;
-#endif
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
+static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
 	int i;
@@ -154,7 +376,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		return;
 
 	for (i = 0; i < insn->detail->x86.op_count; i++) {
-		cs_x86_op *op = &insn->detail->x86.operands[i];
+		struct cs_x86_op *op = &insn->detail->x86.operands[i];
 		u64 orig_addr;
 
 		if (op->type != X86_OP_MEM)
@@ -195,9 +417,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		break;
 	}
 }
-#endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -214,13 +434,11 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	}
 	return 0;
 }
-#endif
 
 int symbol__disassemble_capstone(const char *filename __maybe_unused,
 				 struct symbol *sym __maybe_unused,
 				 struct annotate_args *args __maybe_unused)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
@@ -235,7 +453,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	const u8 *buf;
 	u64 buf_len;
 	csh handle;
-	cs_insn *insn = NULL;
+	struct cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
@@ -273,7 +491,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	needs_cs_close = true;
 
-	free_count = count = cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
+	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -312,9 +530,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 out:
 	if (needs_cs_close) {
-		cs_close(&handle);
+		perf_cs_close(&handle);
 		if (free_count > 0)
-			cs_free(insn, free_count);
+			perf_cs_free(insn, free_count);
 	}
 	free(code_buf);
 	return count < 0 ? count : 0;
@@ -334,16 +552,12 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	}
 	count = -1;
 	goto out;
-#else
-	return -1;
-#endif
 }
 
 int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 					 struct symbol *sym __maybe_unused,
 					 struct annotate_args *args __maybe_unused)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
@@ -456,7 +670,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 
 out:
 	if (needs_cs_close)
-		cs_close(&handle);
+		perf_cs_close(&handle);
 	free(buf);
 	return count < 0 ? count : 0;
 
@@ -465,7 +679,4 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 		close(fd);
 	count = -1;
 	goto out;
-#else
-	return -1;
-#endif
 }
-- 
2.51.0.618.g983fd99d29-goog

