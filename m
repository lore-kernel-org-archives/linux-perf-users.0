Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8237C6D5
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Jun 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360941; cv=none; b=QiAJaPZsypk78rdK2ZjeVzzOKLv/vmZKEDCC6FxleAhX/ejOMukM71hpMsZ+cMxAnMJWY/wk/C3V9ZeNgoVEyNspmzZo4u/RT54bDdtoEXUqto0I5MiMJDoY6ihVXjTyKJfAt56dJ1HFN1XarVifhA3wwwZsirFAzS2VEzrO7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360941; c=relaxed/simple;
	bh=nwiXh1kVMr1X74jPIV1B2PLO4mexVfukoir15XiKi8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=reNrSdk2llJ5ACbVjfjo6Gk+Ad7xIC1V5FaJBmaqkVZvW2EpY5JyAWvIy541WrTlztUBn4T8G0KTL/Q8h3ishqBwdqRjcBefpGdRfipEEoFTQ1rpwsnNUjoyafs1oDeRVPozE+ExG10tfdc/UaRFALViEscY7eu6RCmLCCYXxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwCuU9l/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwCuU9l/"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa77d54cd2so3916261276.3
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Jun 2024 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360939; x=1717965739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvE27fZgMle3SbyuEBFL7kUJMzHMZ5tJiocuJ6FMpfw=;
        b=HwCuU9l/QJ4NRUY5PiJHiXpC70kJybS5rhYeB2uJyIgtp56wuqml37Vk4ZIyRhBXE/
         7clUCls3KUB5OWLHOLrFbrgH9HcaVhEtRXMf+dhwcVk41bpk1zdjEZ73REIg8mMmbANT
         T1M/tQCax6O8lLjB2hdToplk9zOf23b8gbw9Mp+RQk3SAFydCC7aZpiSyaSxYFh8HeaD
         yYOM/k3LtmkPSUpfZ3/jwNz10ek3qfOCNMinFy5zlvvTyezFdKGCROtcx4NIZw2oLAqd
         QFIv2DemTNRGvQWAiLIB4kdCus3vcBLSd7A8qkZHt/2OpGsYA2Eibbd+ecuoF2eRzun8
         9F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360939; x=1717965739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvE27fZgMle3SbyuEBFL7kUJMzHMZ5tJiocuJ6FMpfw=;
        b=dw2/nQOYEtUuG/tV48ad1L7dQS32Nzk6HyjZ2h3+fjeaiFTegZqlsu5Nz+Mq8PR7Ho
         AcUbEDPrqdGQtvT5pJthJ2j7gmq4GCYgziAJl5JQF9Kw31fbdxzcntHT4cr9/UpSq0+V
         I6lTaAvczNRozSkgMEbVk0a8NLjdkd13tAD0axYXnA6rd7V8ZW/XFrMOG/5oab4zZKIJ
         WIs7CUzmVP33jUvgsGryrYybaglSQ+y30tb5awj1kN55DAvK7h9j/U+d753B5/vv1PbH
         Dby/6fEEfgQXlsc2tQnUnSwfmhPqpDncDdAyJyHDOzs/IbrKNUHFqb6/9Jipok/5VC1O
         EvvA==
X-Gm-Message-State: AOJu0YzYzpQKgXNVEEme8/N0/U1hs+oUa0mAbHwn7p57Jq+x2GcblAaa
	oFBi8xmABnEyuGw3w/aPPBM8D7JKoSehkFlmTm6Fw/mdtzPjRjPM2O4P7YoRKIF3HEvgE+h2iQ=
	=
X-Google-Smtp-Source: AGHT+IFfXtNdeFnunW+CX1eDr9cn54M2yEucpQxHcglhyCznAKsv0qbLZi3quNJBUnPHLmessPTOuq77AA==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
 (user=sesse job=sendgmr) by 2002:a05:6902:1542:b0:dd9:2a64:e98a with SMTP id
 3f1490d57ef6-dfa73d8d92emr566773276.9.1717360938797; Sun, 02 Jun 2024
 13:42:18 -0700 (PDT)
Date: Sun,  2 Jun 2024 22:42:08 +0200
In-Reply-To: <20240602204208.735793-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240602204208.735793-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240602204208.735793-3-sesse@google.com>
Subject: [PATCH v8 3/3] perf annotate: LLVM-based disassembler
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
 tools/perf/util/disasm.c           | 193 +++++++++++++++++++++++++++++
 tools/perf/util/llvm-c-helpers.cpp |  62 +++++++++
 tools/perf/util/llvm-c-helpers.h   |  11 ++
 3 files changed, 266 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index c0dbb955e61a..4946e9ccf93b 100644
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
@@ -1606,6 +1611,189 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
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
+	struct symbol_lookup_storage *storage = disinfo;
+
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
+	int ret = -1;
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
+	disasm = LLVMCreateDisasm(triplet, &storage, 0, NULL,
+				  symbol_lookup_callback);
+	if (disasm == NULL)
+		goto err;
+
+	if (args->options->disassembler_style &&
+	    !strcmp(args->options->disassembler_style, "intel"))
+		LLVMSetDisasmOptions(disasm,
+				     LLVMDisassembler_Option_AsmPrinterVariant);
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
+		ins_len = LLVMDisasmInstruction(disasm, buf + offset,
+						len - offset, pc,
+						disasm_buf, sizeof(disasm_buf));
+		if (ins_len == 0)
+			goto err;
+		disasm_len = strlen(disasm_buf);
+
+		if (storage.branch_addr != 0) {
+			char *name = llvm_name_for_code(dso, filename,
+							storage.branch_addr);
+			if (name != NULL) {
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) -
+								disasm_len,
+							" <%s>", name);
+				free(name);
+			}
+		}
+		if (storage.pcrel_load_addr != 0) {
+			char *name = llvm_name_for_data(dso, filename,
+							storage.pcrel_load_addr);
+			disasm_len += scnprintf(disasm_buf + disasm_len,
+						sizeof(disasm_buf) - disasm_len,
+						"  # %#"PRIx64,
+						storage.pcrel_load_addr);
+			if (name) {
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) -
+							disasm_len,
+							" <%s>", name);
+				free(name);
+			}
+		}
+
+		args->offset = offset;
+		args->line = expand_tabs(disasm_buf, &line_storage,
+					 &line_storage_len);
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
+	ret = 0;
+
+err:
+	LLVMDisasmDispose(disasm);
+	free(buf);
+	free(line_storage);
+	return ret;
+}
+#endif
+
+
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
@@ -1730,6 +1918,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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

