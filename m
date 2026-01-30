Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2D389DF3
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816087; cv=none; b=qDZs6WpusazXlngvGGaJZOsCD/nOHvklyXxVcb9MFddtjfebVUlIoXgvZYIkN++/ZVyOQqdenBsRscpoYN8juwdKeDlzgKZSAvrlEfkDzN1NR1rmSZBrdj24T7lXrBAwACUyqYogHrvWmL7dAKk26tU1B1xMGnFL6QLqbknhiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816087; c=relaxed/simple;
	bh=eP+yFNqsM0F+bYwBExXX2CJyNNwIZLp4DSCLVeZFhdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRxxExdy4UuQF+WQSPqM+M4QtPinpiWGhdCfJnd2InyfkBzUaG/uAz9SeXOgNx8a7yb75skEeDhQEV9QGpev/ZEUQJbNIq4ToS47kXBvUHXs7O49e4hUN/rzm66+FOu/hmMDViC5E8G6/6d3xbwFT4UVxjaaQkPBict5+F/NiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GROFaqsX; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GROFaqsX"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b795cff830so725526eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769816085; x=1770420885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQj2Z4SylGf/VCJDURPMv3UALI8c3Pg/YVazRrOkdHk=;
        b=GROFaqsXJGZKIP2T9r1LGu6Re4bcsRcJ7RnKhyH3Q36HUCS3NwmM5aPYNZz4FmTCXd
         BsqN1i1jKg1LJOksysINOReRLAKF+u5zhmBEjNJRUOqMvrcf/NKjhgSku/2gaY962lOv
         /7FwnJYG2QmGNPOGUgKNvHbWl/2UoOSXCZe1CepuOxSx7tMyK+vAILb/8jUGK4oinKp2
         ae3IRNm3dFtVwkeSr6bhRiwsCRrdzYMMdPJkD2VrQvVSWugc3GTV9+kuSpMxJvqVUiLL
         3hCTTJflzBmoHfR+RpkKhLFON28P2SRrRiJjPmYHkJ3AZKdfuIzDNdGxKaItZEoSUsZx
         eEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769816085; x=1770420885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQj2Z4SylGf/VCJDURPMv3UALI8c3Pg/YVazRrOkdHk=;
        b=g+7mDk2DazuZzQAyvGuIe3SSy7sPyiDS/x9pqiqzE5u758+yTAKCMEYoH6WjNAzQ/3
         i9am+yJmKj8nKT2OcWwpmwYGI1ibIbqzqiatJ0OsolMTVBJ3cY/E630IG9cWQyjo9f2x
         AM5ILNnK7rc0QkrtaZpLjXB4ga+s6UsfhbAiirYLHJyHNkYL57JCUnlEESjOpHQjEH9j
         qpYE0Bat2MdDTrmgbJCvVYcZRu+Wm/Ma3fSrmurR29KYr0bKBzyEqLPxZqlXllsjkGjP
         aolI1rqvCe52A6HQ5vuIrvlRN6J6A2yDlhzm8t0v/sxbypVT+dIz9YWp8zA6THL6aLl6
         uzGA==
X-Forwarded-Encrypted: i=1; AJvYcCU3VG0FwbuUhii9rXP+5usruzcPqQ0Lk3qV/Y1JVBs2wcfez3ul5BlCjTh/CnU6Rd1Uc0tYEkZGp5sXt00DxC0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaEKh8XP3A0230tT7zDrPSNfookipM3NE2636yz5T5zrSnuxr
	+h4MD6D262FABtHx6Fm+dGRPKaO8xSptHJ/CjZlFCLLQXPePBTgIc5qzOEy1xRtNEe9eEVdS9qj
	dAM8rpZLdEA==
X-Received: from dybtv10.prod.google.com ([2002:a05:7300:f48a:b0:2b7:9b1b:2ed4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7305:b0:2b7:a3a9:9c28
 with SMTP id 5a478bee46e88-2b7c88d8c3bmr2541185eec.20.1769816084925; Fri, 30
 Jan 2026 15:34:44 -0800 (PST)
Date: Fri, 30 Jan 2026 15:34:37 -0800
In-Reply-To: <20260130233439.647447-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130233439.647447-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130233439.647447-2-irogers@google.com>
Subject: [PATCH v10 1/3] perf capstone: Support for dlopen-ing libcapstone.so
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

If perf is built with LIBCAPSTONE_DLOPEN=1, support dlopen-ing
libcapstone.so and then calling the necessary functions by looking
them up using dlsym. The types come from capstone.h which means the
libcapstone feature check needs to pass, and NO_CAPSTONE=1 hasn't been
defined. This will cause the definition of HAVE_LIBCAPSTONE_SUPPORT.

Earlier versions of this code tried to declare the necessary
capstone.h constants and structs, but they weren't stable and caused
breakages across libcapstone releases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |   8 +-
 tools/perf/tests/make      |   2 +
 tools/perf/util/Build      |   2 +-
 tools/perf/util/capstone.c | 176 +++++++++++++++++++++++++++++--------
 tools/perf/util/capstone.h |  33 +++++++
 5 files changed, 179 insertions(+), 42 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 63ca9b2be663..e085d27f698a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1078,8 +1078,12 @@ ifndef NO_CAPSTONE
   $(call feature_check,libcapstone)
   ifeq ($(feature-libcapstone), 1)
     CFLAGS += -DHAVE_LIBCAPSTONE_SUPPORT $(LIBCAPSTONE_CFLAGS)
-    LDFLAGS += $(LICAPSTONE_LDFLAGS)
-    EXTLIBS += -lcapstone
+    ifdef LIBCAPSTONE_DLOPEN
+      CFLAGS += -DLIBCAPSTONE_DLOPEN
+    else
+      LDFLAGS += $(LIBCAPSTONE_LDFLAGS)
+      EXTLIBS += -lcapstone
+    endif
     $(call detected,CONFIG_LIBCAPSTONE)
   else
     msg := $(warning No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel);
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 767ad9e147a8..f15096074d57 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -85,6 +85,7 @@ make_no_libdw       := NO_LIBDW=1
 make_libunwind      := LIBUNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
+make_libcapstone_dlopen := LIBCAPSTONE_DLOPEN=1
 make_no_libnuma     := NO_LIBNUMA=1
 make_no_libbionic   := NO_LIBBIONIC=1
 make_no_libbpf	    := NO_LIBBPF=1
@@ -159,6 +160,7 @@ run += make_libunwind
 run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
 run += make_no_libcapstone
+run += make_libcapstone_dlopen
 run += make_no_libnuma
 run += make_no_libbionic
 run += make_no_libbpf
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b9925c6902ca..c037b1e99d28 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -11,7 +11,7 @@ perf-util-y += block-info.o
 perf-util-y += block-range.o
 perf-util-y += build-id.o
 perf-util-y += cacheline.o
-perf-util-y += capstone.o
+perf-util-$(CONFIG_LIBCAPSTONE) += capstone.o
 perf-util-y += config.o
 perf-util-y += copyfile.o
 perf-util-y += ctype.o
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 9216916f848f..25cf6e15ec27 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -11,20 +11,137 @@
 #include "print_insn.h"
 #include "symbol.h"
 #include "thread.h"
+#include <dlfcn.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <string.h>
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
+
+#ifdef LIBCAPSTONE_DLOPEN
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
+#ifndef LIBCAPSTONE_DLOPEN
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
 #endif
+}
+
+static enum cs_err perf_cs_option(csh handle, enum cs_opt_type type, size_t value)
+{
+#ifndef LIBCAPSTONE_DLOPEN
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
+#ifndef LIBCAPSTONE_DLOPEN
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
+#endif
+}
+
+static void perf_cs_free(struct cs_insn *insn, size_t count)
+{
+#ifndef LIBCAPSTONE_DLOPEN
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
+#ifndef LIBCAPSTONE_DLOPEN
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
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 			 bool disassembler_style)
 {
-	cs_arch arch;
-	cs_mode mode;
+	enum cs_arch arch;
+	enum cs_mode mode;
 
 	if (machine__is(machine, "x86_64") && is64) {
 		arch = CS_ARCH_X86;
@@ -45,7 +162,7 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 		return -1;
 	}
 
-	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
+	if (perf_cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
 		pr_warning_once("cs_open failed\n");
 		return -1;
 	}
@@ -57,27 +174,25 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
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
@@ -95,7 +210,6 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
 	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
 	return printed;
 }
-#endif
 
 
 ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
@@ -106,9 +220,8 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
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
@@ -118,7 +231,7 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 	if (ret < 0)
 		return ret;
 
-	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
+	count = perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
 		if (machine__normalized_is(machine, "x86"))
 			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
@@ -126,20 +239,16 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
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
@@ -154,7 +263,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		return;
 
 	for (i = 0; i < insn->detail->x86.op_count; i++) {
-		cs_x86_op *op = &insn->detail->x86.operands[i];
+		struct cs_x86_op *op = &insn->detail->x86.operands[i];
 		u64 orig_addr;
 
 		if (op->type != X86_OP_MEM)
@@ -195,9 +304,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		break;
 	}
 }
-#endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -214,13 +321,11 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
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
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
@@ -235,7 +340,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	const u8 *buf;
 	u64 buf_len;
 	csh handle;
-	cs_insn *insn = NULL;
+	struct cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
@@ -274,7 +379,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	needs_cs_close = true;
 
-	free_count = count = cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
+	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -313,9 +418,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
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
@@ -335,16 +440,12 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
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
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
@@ -458,7 +559,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 
 out:
 	if (needs_cs_close)
-		cs_close(&handle);
+		perf_cs_close(&handle);
 	free(buf);
 	return count < 0 ? count : 0;
 
@@ -467,7 +568,4 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 		close(fd);
 	count = -1;
 	goto out;
-#else
-	return -1;
-#endif
 }
diff --git a/tools/perf/util/capstone.h b/tools/perf/util/capstone.h
index 0f030ea034b6..7c0baaa01a73 100644
--- a/tools/perf/util/capstone.h
+++ b/tools/perf/util/capstone.h
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <linux/compiler.h>
 #include <linux/types.h>
 
 struct annotate_args;
@@ -13,6 +14,7 @@ struct machine;
 struct symbol;
 struct thread;
 
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
 ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
 				   bool is64bit, const uint8_t *code, size_t code_size,
 				   uint64_t ip, int *lenp, int print_opts, FILE *fp);
@@ -21,4 +23,35 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 int symbol__disassemble_capstone_powerpc(const char *filename, struct symbol *sym,
 					 struct annotate_args *args);
 
+#else /* !HAVE_LIBCAPSTONE_SUPPORT */
+static inline ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
+						 struct thread *thread __maybe_unused,
+						 u8 cpumode __maybe_unused,
+						 bool is64bit __maybe_unused,
+						 const uint8_t *code __maybe_unused,
+						 size_t code_size __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 int *lenp __maybe_unused,
+						 int print_opts __maybe_unused,
+						 FILE *fp __maybe_unused)
+{
+	return -1;
+}
+
+static inline int symbol__disassemble_capstone(const char *filename __maybe_unused,
+					       struct symbol *sym __maybe_unused,
+					       struct annotate_args *args __maybe_unused)
+{
+	return -1;
+}
+
+static inline int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
+						       struct symbol *sym __maybe_unused,
+						       struct annotate_args *args __maybe_unused)
+{
+	return -1;
+}
+
+#endif /* HAVE_LIBCAPSTONE_SUPPORT */
+
 #endif /* __PERF_CAPSTONE_H */
-- 
2.53.0.rc1.225.gd81095ad13-goog

