Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27232032B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 May 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193863; cv=none; b=jrfBqg+3/9EupYxYht6GylYh6ILyy15/mn/ztpPM4xi7DV8FAm5Tr+pUAis60bPTaYLvDPkPBEJ62//dLZiA9R4iZhFIAqFQ41U2TOMBPdjNIQGzynZwBee7j13EQYMWOet6kWK5P+wUM2aIvfOGSWemdd4ARVO+PaRjEjesqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193863; c=relaxed/simple;
	bh=6XxkJRyAXUFzmp/1AU4YIOWkTmCFlWfzgHj2xRErRmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U5lDI669kKqy3dpUGOW+skzV9M8gbS0JMg3RPEYWocgwABM8wrUozbmiiBsYva1PdHVojDzR40xgjvF5fHMg6S2bbxd69e/qoJtEvTyJkK9/PrsphqjStm1d3KsBatNM/wbKuUaJM9Qvjz13QdCYEUEPah4UDuHZA+j9TXEIqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbAFI4n7; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbAFI4n7"
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52389b09bb6so5002386e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 May 2024 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716193860; x=1716798660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ye5dRMb6UlKqDx47Lo1ZI0oUFANIm1Rov6hDvAkwJw=;
        b=nbAFI4n7JKwpXRs0wu/4SbiTP3yy7VedsVw65WUFg8ighbADoY6Vw/VyALvpi0cdLI
         uKunJTMYOvJvI3YrbkxG7DyVQew136JRDy8ZMtVDVHdbxn/yudDzFDqYzhEdHJ9TOgh7
         tDK8Wj2q+6dnBpr/t5Dg6tRfr1e2Qpca270WAw1c8oj8Dk/3DB6jA3k9KAlOr7bScMk6
         aJOPQ1JEJ7DZ2bLAlA0/MWBBiL4usCbtdGHQp8QvAt7Tb8DnyDt0Jw7X7KRlaAxB473P
         r7z4Y9hqph7zupk8fo5F56YntcYN/1bED9DROK95rWqSWeW0oUDkKgPq4EEaArzuS9ba
         GUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193860; x=1716798660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ye5dRMb6UlKqDx47Lo1ZI0oUFANIm1Rov6hDvAkwJw=;
        b=tJfPaX5K29yXeGBaKFNudu7sc2g67HEt0aAd8UCva4FJya5XzUiGxJCYWxRaKHceVZ
         NxAd4w146cjP9i5/Jl4jtMa2CWhIHymUnte0XE+fXP/yo2TqwtaW+/BhqzXfoyU4bMHL
         fyIa5ZGBIpLPHjXGB8y2l0iDy11fxXHDue44FKqzvcBY04hNmWv1+3C3yFi0Mfc0PUzL
         7YrxPeniJN6uMp7LJk8xpNvOJltWcZRHzGUPOLPX/Fr3qEPu2vegUQY7wCIoLE9hTt0n
         zBL1ADkb9y/QXLUYLNkVwgB1hlrEeMnvWrAvD3NkqyXk+xJpDgx+UyqP34bvIsrv4HLN
         3LGA==
X-Gm-Message-State: AOJu0YzVEsmfd5DjiLP+TvQPDrdA59FFQZ162yZYumnsZr8gWd5YpTzn
	/7u1gLzWIjtoJTEg4+ASm51e4yslGKjcttlqEZw2XZAqNxUzAId5c9s8oxMW7bhUVUeTtqPfHQ=
	=
X-Google-Smtp-Source: AGHT+IGAy3oSTQnIu98XK81X7SnjyClBrm0/6TNGsTjOI2f/r/KTc98P8APBcWSkGVKoG1qQLridaBEnaw==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:d897:cddc:22b9:d054])
 (user=sesse job=sendgmr) by 2002:a05:6512:2813:b0:51d:5d23:3ea8 with SMTP id
 2adb3069b0e04-5221006c47cmr29602e87.6.1716193859803; Mon, 20 May 2024
 01:30:59 -0700 (PDT)
Date: Mon, 20 May 2024 10:30:48 +0200
In-Reply-To: <20240520083048.322863-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520083048.322863-1-sesse@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240520083048.322863-3-sesse@google.com>
Subject: [PATCH v4 3/3] perf annotate: LLVM-based disassembler
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
index c0dbb955e61a..9c07d2a8c8a8 100644
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
 
+#if defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LLVM_SUPPORT)
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
 
+#ifdef HAVE_LLVM_SUPPORT
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
 
+#ifdef HAVE_LLVM_SUPPORT
+	err = symbol__disassemble_llvm(symfs_filename, sym, args);
+	if (err == 0)
+		goto out_remove_tmp;
+#endif
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	err = symbol__disassemble_capstone(symfs_filename, sym, args);
 	if (err == 0)
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index cde3f1f03af0..4a34de7551f8 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -8,6 +8,7 @@
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
 #include <llvm/DebugInfo/Symbolize/Symbolize.h>
+#include <llvm/Support/TargetSelect.h>
 #pragma GCC diagnostic pop
 
 #include <stdio.h>
@@ -16,6 +17,9 @@
 #include "symbol_conf.h"
 #include "llvm-c-helpers.h"
 
+extern "C"
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
+
 using namespace llvm;
 using llvm::symbolize::LLVMSymbolizer;
 
@@ -128,3 +132,61 @@ int llvm_addr2line(const char *dso_name, u64 addr,
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
+		addr, res_or_err->StartAddress.value_or(0));
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
index 1b28cdc9f9b7..e00e3f73a906 100644
--- a/tools/perf/util/llvm-c-helpers.h
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -11,6 +11,8 @@
 extern "C" {
 #endif
 
+struct dso;
+
 struct llvm_a2l_frame {
 	char *filename;
 	char *funcname;
@@ -40,6 +42,15 @@ int llvm_addr2line(const char *dso_name,
 		   bool unwind_inlines,
 		   struct llvm_a2l_frame **inline_frames);
 
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
2.43.0

