Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241FF12AAF8
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716747745; cv=none; b=A9P12H/wVgQfRJMOVcFJXa+tFaWralvVC7r3yyHFXUZphhE02cqkLMMafvZKJPeE25c3D1NQVmUUtX2EwTRQQmbozrerkpjRZXvUeNJwU5FYprpd/HAUIqFbTFkcQtngV7HfOW3RA355raNLvy4i1QHdSE+FjQllRzumrxp+YIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716747745; c=relaxed/simple;
	bh=GpcChZfMpfvtzKftRFDjvbq03JF8yxLIasM86Vlx8i8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJNfks14pv1UfR8CDpN2VK1+Rpkp9ngsdA3DNmmq6HVDfm9AvfjfLLvTiJ0ZZroqEqJXCs671rPN6eBoj3nj32/5NeI2t1L9Fi1J3gVzWxjgazNjb4SL5MEqgwn3ybTCvWDbszGSypjhWaMj/IHUQyBsrA6Bc940elItfQIurRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VU8qoLRk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VU8qoLRk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e9a500faso31328707b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716747742; x=1717352542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgUV7H3zVKc5i2iiaZwEYA1PB5WyP/jjC3KCwzffqKc=;
        b=VU8qoLRkSSOO1cEdY5zXdQq7P7cNurnzJVW9CPoln6GzebobwH4UF0qTIiL4m8kkxQ
         1mJkhlX0/x7+WNG7jUlJOUHIoBXFyppN2YQejRGve6d2xlDUZQHpWBbMq9fN8cVYb0Uj
         7AgWYEDfoeAQkTLwJjKdaQhdL5RrKWAAOp92PSaKEnXNNlbtlxTK9VMVXtOA7W22ZFb+
         7yipccIrBhN15AYw8GOkYGpRmR7fvA/Q2doAMs085z2j212tZpVPXaBoguxg2/7I+pIf
         B3s5HTkaISQUF1gTEXCVO4wB98Pc/giOl5Sblr4MV/GXt0aCecX59k0W7KzHWWAsyr9b
         11pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716747742; x=1717352542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgUV7H3zVKc5i2iiaZwEYA1PB5WyP/jjC3KCwzffqKc=;
        b=BSHz5s9WqCLV4ddey2CGWmsQeCWt8M8g+9SIZSOrO91XekjPO7jVoLhYz892njI/qS
         ZMU0fGPdVzObuDd8Fri1DvMK5zLy4UW3qQHqg+UtSMNmol0a7IG43rQqhgBszPJtMBgQ
         jEb9VQSdDGGvIQ3fy08wjugOQnxDzujFwcaYV0bjUkab1NbKccF+FA2CjUdjMXdxLoIS
         81pnrQidGf+HRS9TKODGKtood3rYguGmPYzCJXkt1mRToN5agO2cYdLYUi76E5XRIRZ2
         Vzc005yaH3ClCNH8HprtKxjFyNJch+BYlLUYrg/mNpLDL5HBM6m473IwlIGxqjbDIMxB
         9tfg==
X-Gm-Message-State: AOJu0YxiZcWtdWTjSiygDn4T9K2ZobIQD0RtUCFaWcRqgvEz10k2er3S
	ixi2PnRte4NxYpYThzo2ClxZInk1Mgrsy8Ou5XGu8MgY7OzC63SLKF/X+qD6ftzamPZiVkL7uw=
	=
X-Google-Smtp-Source: AGHT+IGpk4yOUevSDXOa0NBjZh4lXXeRoQwwGoYeYVvd61gQ58KDoq0nXX6cYYKynkO1cewiL3lHGpE/dg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:1a92:9649:8b20:5054])
 (user=sesse job=sendgmr) by 2002:a05:6902:2b8d:b0:df4:a2a1:4653 with SMTP id
 3f1490d57ef6-df7722165c7mr561899276.9.1716747742185; Sun, 26 May 2024
 11:22:22 -0700 (PDT)
Date: Sun, 26 May 2024 20:22:11 +0200
In-Reply-To: <20240526182212.544525-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240526182212.544525-3-sesse@google.com>
Subject: [PATCH v7 3/4] perf annotate: LLVM-based disassembler
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"

Support using LLVM as a disassembler method, allowing helperless
annotation in non-distro builds. (It is also much faster than
using libbfd or bfd objdump on binaries with a lot of debug
information.)

This is nearly identical to the output of llvm-objdump; there are
some very rare whitespace differences, some minor changes to demangling
(since we use perf's regular demangling and not LLVM's own) and
the occasional case where llvm-objdump makes a different choice
when multiple symbols share the same address. It should work across
all of LLVM's supported architectures, although I've only tested 64-bit
x86, and finding the right triple from perf's idea of machine
architecture can sometimes be a bit tricky. Ideally, we should have
some way of finding the triplet just from the file itself.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
---
 tools/perf/util/disasm.c           | 195 +++++++++++++++++++++++++++++
 tools/perf/util/llvm-c-helpers.cpp |  62 +++++++++
 tools/perf/util/llvm-c-helpers.h   |  11 ++
 3 files changed, 268 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index c0dbb955e61a..ee7c2365d066 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -43,6 +43,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
+static char *expand_tabs(char *line, char **storage, size_t *storage_len);
 
 static __attribute__((constructor)) void symbol__init_regexpr(void)
 {
@@ -1378,7 +1379,9 @@ static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
 
 	return 0;
 }
+#endif
 
+#if defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -1442,7 +1445,9 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
 	free(buf);
 	return NULL;
 }
+#endif
 
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
@@ -1606,6 +1611,191 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 }
 #endif
 
+#ifdef HAVE_LIBLLVM_SUPPORT
+#include <llvm-c/Disassembler.h>
+#include <llvm-c/Target.h>
+#include "util/llvm-c-helpers.h"
+
+struct symbol_lookup_storage {
+	u64 branch_addr;
+	u64 pcrel_load_addr;
+};
+
+/*
+ * Whenever LLVM wants to resolve an address into a symbol, it calls this
+ * callback. We don't ever actually _return_ anything (in particular, because
+ * it puts quotation marks around what we return), but we use this as a hint
+ * that there is a branch or PC-relative address in the expression that we
+ * should add some textual annotation for after the instruction. The caller
+ * will use this information to add the actual annotation.
+ */
+static const char *
+symbol_lookup_callback(void *disinfo, uint64_t value,
+		       uint64_t *ref_type,
+		       uint64_t address __maybe_unused,
+		       const char **ref __maybe_unused)
+{
+	struct symbol_lookup_storage *storage =
+		(struct symbol_lookup_storage *)disinfo;
+	if (*ref_type == LLVMDisassembler_ReferenceType_In_Branch)
+		storage->branch_addr = value;
+	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
+		storage->pcrel_load_addr = value;
+	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
+	return NULL;
+}
+
+static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
+				    struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	u64 start = map__rip_2objdump(map, sym->start);
+	u8 *buf;
+	u64 len;
+	u64 pc;
+	bool is_64bit;
+	char triplet[64];
+	char disasm_buf[2048];
+	size_t disasm_len;
+	struct disasm_line *dl;
+	LLVMDisasmContextRef disasm = NULL;
+	struct symbol_lookup_storage storage;
+	char *line_storage = NULL;
+	size_t line_storage_len = 0;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	LLVMInitializeAllTargetInfos();
+	LLVMInitializeAllTargetMCs();
+	LLVMInitializeAllDisassemblers();
+
+	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	if (buf == NULL)
+		return -1;
+
+	if (arch__is(args->arch, "x86")) {
+		if (is_64bit)
+			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
+		else
+			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
+	} else {
+		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
+			  args->arch->name);
+	}
+
+	disasm = LLVMCreateDisasm(
+		triplet, &storage, 0, NULL, symbol_lookup_callback);
+	if (disasm == NULL)
+		goto err;
+
+	if (args->options->disassembler_style &&
+	    !strcmp(args->options->disassembler_style, "intel"))
+		LLVMSetDisasmOptions(
+			disasm, LLVMDisassembler_Option_AsmPrinterVariant);
+
+	/*
+	 * This needs to be set after AsmPrinterVariant, due to a bug in LLVM;
+	 * setting AsmPrinterVariant makes a new instruction printer, making it
+	 * forget about the PrintImmHex flag (which is applied before if both
+	 * are given to the same call).
+	 */
+	LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex);
+
+	/* add the function address and name */
+	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
+		  start, sym->name);
+
+	args->offset = -1;
+	args->line = disasm_buf;
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	args->ms.sym = sym;
+
+	dl = disasm_line__new(args);
+	if (dl == NULL)
+		goto err;
+
+	annotation_line__add(&dl->al, &notes->src->source);
+
+	pc = start;
+	for (u64 offset = 0; offset < len; ) {
+		unsigned int ins_len;
+
+		storage.branch_addr = 0;
+		storage.pcrel_load_addr = 0;
+
+		ins_len = LLVMDisasmInstruction(
+			disasm, buf + offset, len - offset, pc,
+			disasm_buf, sizeof(disasm_buf));
+		if (ins_len == 0)
+			goto err;
+		disasm_len = strlen(disasm_buf);
+
+		if (storage.branch_addr != 0) {
+			char *name = llvm_name_for_code(
+				dso, filename, storage.branch_addr);
+			if (name != NULL) {
+				disasm_len += scnprintf(
+					disasm_buf + disasm_len,
+					sizeof(disasm_buf) - disasm_len,
+					" <%s>", name);
+				free(name);
+			}
+		}
+		if (storage.pcrel_load_addr != 0) {
+			char *name = llvm_name_for_data(
+				dso, filename, storage.pcrel_load_addr);
+			disasm_len += scnprintf(disasm_buf + disasm_len,
+						sizeof(disasm_buf) - disasm_len,
+						"  # %#"PRIx64,
+						storage.pcrel_load_addr);
+			if (name) {
+				disasm_len += scnprintf(
+					disasm_buf + disasm_len,
+					sizeof(disasm_buf) - disasm_len,
+					" <%s>", name);
+				free(name);
+			}
+		}
+
+		args->offset = offset;
+		args->line = expand_tabs(
+			disasm_buf, &line_storage, &line_storage_len);
+		args->line_nr = 0;
+		args->fileloc = NULL;
+		args->ms.sym = sym;
+
+		llvm_addr2line(filename, pc, &args->fileloc,
+			       (unsigned int *)&args->line_nr, false, NULL);
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		free(args->fileloc);
+		pc += ins_len;
+		offset += ins_len;
+	}
+
+	LLVMDisasmDispose(disasm);
+	free(buf);
+	free(line_storage);
+	return 0;
+
+err:
+	LLVMDisasmDispose(disasm);
+	free(buf);
+	free(line_storage);
+	return -1;
+}
+#endif
+
+
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
@@ -1730,6 +1920,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		strcpy(symfs_filename, tmp);
 	}
 
+#ifdef HAVE_LIBLLVM_SUPPORT
+	err = symbol__disassemble_llvm(symfs_filename, sym, args);
+	if (err == 0)
+		goto out_remove_tmp;
+#endif
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	err = symbol__disassemble_capstone(symfs_filename, sym, args);
 	if (err == 0)
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 3cc967ec6f28..4070e2d5682f 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -8,6 +8,7 @@
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
 #include <llvm/DebugInfo/Symbolize/Symbolize.h>
+#include <llvm/Support/TargetSelect.h>
 #pragma GCC diagnostic pop
 
 #include <stdio.h>
@@ -19,6 +20,9 @@ extern "C" {
 #include "symbol_conf.h"
 #include "llvm-c-helpers.h"
 
+extern "C"
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
+
 using namespace llvm;
 using llvm::symbolize::LLVMSymbolizer;
 
@@ -132,3 +136,61 @@ int llvm_addr2line(const char *dso_name, u64 addr,
 		return extract_file_and_line(*res_or_err, file, line);
 	}
 }
+
+static char *
+make_symbol_relative_string(struct dso *dso, const char *sym_name,
+			    u64 addr, u64 base_addr)
+{
+	if (!strcmp(sym_name, "<invalid>"))
+		return NULL;
+
+	char *demangled = dso__demangle_sym(dso, 0, sym_name);
+	if (base_addr && base_addr != addr) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "%s+0x%lx",
+			 demangled ? demangled : sym_name, addr - base_addr);
+		free(demangled);
+		return strdup(buf);
+	} else {
+		if (demangled)
+			return demangled;
+		else
+			return strdup(sym_name);
+	}
+}
+
+extern "C"
+char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr)
+{
+	LLVMSymbolizer *symbolizer = get_symbolizer();
+	object::SectionedAddress sectioned_addr = {
+		addr,
+		object::SectionedAddress::UndefSection
+	};
+	Expected<DILineInfo> res_or_err =
+		symbolizer->symbolizeCode(dso_name, sectioned_addr);
+	if (!res_or_err) {
+		return NULL;
+	}
+	return make_symbol_relative_string(
+		dso, res_or_err->FunctionName.c_str(),
+		addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
+}
+
+extern "C"
+char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr)
+{
+	LLVMSymbolizer *symbolizer = get_symbolizer();
+	object::SectionedAddress sectioned_addr = {
+		addr,
+		object::SectionedAddress::UndefSection
+	};
+	Expected<DIGlobal> res_or_err =
+		symbolizer->symbolizeData(dso_name, sectioned_addr);
+	if (!res_or_err) {
+		return NULL;
+	}
+	return make_symbol_relative_string(
+		dso, res_or_err->Name.c_str(),
+		addr, res_or_err->Start);
+}
diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
index 19332dd98e14..d2b99637a28a 100644
--- a/tools/perf/util/llvm-c-helpers.h
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+struct dso;
+
 struct llvm_a2l_frame {
   char* filename;
   char* funcname;
@@ -42,6 +44,15 @@ int llvm_addr2line(const char* dso_name,
                    bool unwind_inlines,
                    struct llvm_a2l_frame** inline_frames);
 
+/*
+ * Simple symbolizers for addresses; will convert something like
+ * 0x12345 to "func+0x123". Will return NULL if no symbol was found.
+ *
+ * The returned value must be freed by the caller, with free().
+ */
+char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr);
+char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.45.1

