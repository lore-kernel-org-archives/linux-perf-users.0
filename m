Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B412C472
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716747747; cv=none; b=PwaNOEOkFsgnMvAAA2IWOo7HDp+WIH8XEU8rpfDqfgRH61wSxEzmDzDvK4CYNfS9uyVEb8Bpc5ecZfJlrQHZQNmpieDnncy9L6Sz1pOHuzV3mPyuurB0/E/N/GGTMZhvGMCC1kTZFgorZ0KMhrcEbVjrg72EgNhKOBypBhG4EGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716747747; c=relaxed/simple;
	bh=xvPcI6gfFhB1qrDvScfjlNlRUb/SuewMGeLYqNfmCqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERHqgi8dYR59hovjGAa6u7WYcfbnYHRuZu+QfzKMSMI6MKWGiU2jOKbWqi3wnyvkEBdFXa9XVS4zPNMw8pQLNMbxfRq+jwvfkKX9PaLuoFXLc1tJ+1zflu2pBWsFDWPCnbeJTOoQQmWDjJChSYVQxtD8vli1AE+O3VzcJy3xrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiNm0rEU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiNm0rEU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4e2bcc253so2902232276.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716747745; x=1717352545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkztai17OUTDruPYJRakPlD+iWL3WoqixnzK62Tclrw=;
        b=PiNm0rEUeyBvH4LXzjdIrhRG1rkclimlUR7CD3wYQz1TKnnNGBIQtJ8M4ZSElKOHtA
         qZUT+Ev7hgxuwfSrn/lo+m6qseELfcT2Aq/WTBqi36AZYjV7KgPWLCNsoHN4FdrSldaT
         BEvOeOj49MgY9cA4n45XE0003Jo1aqma3lA002UXElDTF6Ao5eBzs03uD6d7/aaNbeRh
         w7y/9jX1RhfGPGFtkxr7DHVFGZ2TawkNrrGKdXDsKwOgCNAa571y/MQYhIy8zGHbcdiz
         tpYLwTjqASmc1prMA3sof690kTz0+jnrk4FRYE6YVGc/bX3b1D4G2mkX9tkEETLXIrAk
         cY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716747745; x=1717352545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkztai17OUTDruPYJRakPlD+iWL3WoqixnzK62Tclrw=;
        b=DOAQc1xajYSR1ckXSJdS0nyvnH/FZWgN6mrYsUxakvj5LhBbSVU5K/66tOUwVeiRYR
         81TY7prNz04/X6ug+wOMig8OZw2g0k/+BKaXbNAPZi17nhRpLPnJVKyDqi8Hc2BtWnBe
         lLixqb4qmo6xaSwa1ruQ0K997aUMadb3dsV1PviFgwBLOm5GZUYNIyiEiZIsVmmvBnf0
         dvjGYnxB0SgFVHm3mEahbZuMSOFn11RHSJkL9vAGek/neFkdN/mUJMmUBjUOY/iETCB6
         ttn8H3T+G2KgaWnu6to1jlUIOf0i3JvkvR9ZVmQUtvssuB5Iv0FAQd8nXDqYA9xn9cl7
         PhUg==
X-Gm-Message-State: AOJu0YwAsuxP5Hwm4klDpc8qKCbQ7q6RY4XQe8Kcxsra6NqGS9J7Kk53
	bqvvKDzVkuSCjbbLVfYMR+jeszIxZvWh6EsYf78wY8VqUfWg+RPOyHh69h4NzSJGKyzjSA+bGA=
	=
X-Google-Smtp-Source: AGHT+IEVs3nJdrnEJtkpiaXiKgg/KgxxsXeqbyxtum2py0Di3sugB8fCJtR9uipW9waD54C/YAsCOC6RPg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:1a92:9649:8b20:5054])
 (user=sesse job=sendgmr) by 2002:a05:6902:f09:b0:dee:80d7:e72d with SMTP id
 3f1490d57ef6-df7721a082bmr514006276.7.1716747745018; Sun, 26 May 2024
 11:22:25 -0700 (PDT)
Date: Sun, 26 May 2024 20:22:12 +0200
In-Reply-To: <20240526182212.544525-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240526182212.544525-4-sesse@google.com>
Subject: [PATCH v7 4/4] perf report: LLVM-based symbol listing
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"

Similar to the previous LLVM patches, this allows symbol enumeration
using LLVM instead of libbfd or libelf. This allows distro builds to
reliably enumerate symbols in e.g. PE binaries as profiled with WINE.

A lot of the logic for e.g. length detection has been carried over
from the libbfd code.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
---
 tools/perf/util/llvm-c-helpers.cpp | 124 +++++++++++++++++++++++++++++
 tools/perf/util/llvm-c-helpers.h   |  49 ++++++++++++
 tools/perf/util/symbol.c           |  54 ++++++++++++-
 tools/perf/util/symbol.h           |   3 +
 4 files changed, 228 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 4070e2d5682f..87caf98cc8f6 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -9,6 +9,7 @@
 #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
 #include <llvm/DebugInfo/Symbolize/Symbolize.h>
 #include <llvm/Support/TargetSelect.h>
+#include <llvm/Object/Binary.h>
 #pragma GCC diagnostic pop
 
 #include <stdio.h>
@@ -17,6 +18,8 @@
 extern "C" {
 #include <linux/zalloc.h>
 }
+#include <vector>
+#include <algorithm>
 #include "symbol_conf.h"
 #include "llvm-c-helpers.h"
 
@@ -24,6 +27,7 @@ extern "C"
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
 using namespace llvm;
+using namespace llvm::object;
 using llvm::symbolize::LLVMSymbolizer;
 
 /*
@@ -194,3 +198,123 @@ char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr)
 		dso, res_or_err->Name.c_str(),
 		addr, res_or_err->Start);
 }
+
+int llvm_load_symbols(const char *debugfile, struct llvm_symbol_list *symbols)
+{
+	/* NOTE: This nominally does an mmap, despite the scary name. */
+	ErrorOr<std::unique_ptr<MemoryBuffer>> mem_buf_or_err =
+		MemoryBuffer::getFile(debugfile);
+	if (mem_buf_or_err.getError())
+		return -1;
+
+	Expected<std::unique_ptr<Binary>> binary_or_err(
+		createBinary(mem_buf_or_err.get()->getMemBufferRef(), nullptr));
+	if (!binary_or_err)
+		return -1;
+
+	/* Find the .text section. */
+	SectionRef text_section;
+	uint64_t text_filepos, image_base;
+	for (SectionRef section :
+	     cast<ObjectFile>(*binary_or_err.get()).sections()) {
+		Expected<StringRef> name = section.getName();
+		if (name && *name == ".text") {
+			text_section = section;
+
+			/*
+			 * If we don't find an image base below, we infer the
+			 * image base * from the address and file offset of the
+			 * .text section.
+			 */
+			text_filepos = reinterpret_cast<const char *>(
+				text_section.getContents()->bytes_begin()) -
+				mem_buf_or_err.get()->getBufferStart();
+			image_base = text_section.getAddress() - text_filepos;
+			break;
+		}
+	}
+	if (text_section == SectionRef())
+		/* No .text section, so no symbols (but also not a failure). */
+		return 0;
+
+	/*
+	 * See if we can find an explicit image base pseudosymbol. If so, get
+	 * the image base directly from it, then infer the file position of
+	 * .text from that (i.e., the opposite inference of the fallback above).
+	 */
+	for (SymbolRef symbol :
+	     cast<ObjectFile>(*binary_or_err.get()).symbols())
+		if (symbol.getName() &&
+		    symbol.getAddress() &&
+		    (*symbol.getName() == "__ImageBase" ||
+		     *symbol.getName() == "__image_base__")) {
+			image_base = *symbol.getAddress();
+			if (image_base < 0x100000000ULL)
+				/*
+				 * PE symbols can only have 4 bytes, so use
+				 * .text high bits (if any).
+				 */
+				image_base |= text_section.getAddress() &
+					~0xFFFFFFFFULL;
+			text_filepos = text_section.getAddress() - image_base;
+			break;
+		}
+
+	symbols->image_base = image_base;
+	symbols->text_end = text_filepos + text_section.getSize();
+
+	/* Collect all valid symbols. */
+	std::vector<SymbolRef> all_symbols;
+	for (SymbolRef symbol :
+	     cast<ObjectFile>(*binary_or_err.get()).symbols())
+		if (symbol.getName() && symbol.getFlags() &&
+		    symbol.getAddress() && symbol.getSection())
+			all_symbols.push_back(symbol);
+	symbols->num_symbols = all_symbols.size();
+	symbols->symbols = (struct llvm_symbol *)calloc(
+		all_symbols.size(), sizeof(struct llvm_symbol));
+	if (symbols->symbols == nullptr)
+		return -1;
+
+	/*
+	 * Symbols don't normally come with lengths, so we'll infer them
+	 * from what comes after the symbol address-wise. There is some
+	 * extra logic around zero-length symbols and deduplication,
+	 * which the caller will do for us (it's shared with other backends).
+	 */
+	std::sort(all_symbols.begin(), all_symbols.end(),
+		  [](const SymbolRef &a, const SymbolRef &b) {
+			  if (*a.getAddress() != *b.getAddress())
+				  return *a.getAddress() < *b.getAddress();
+			  return *a.getName() < *b.getName();
+		  });
+	for (size_t i = 0; i < all_symbols.size(); ++i) {
+		const SymbolRef &sym = all_symbols[i];
+		llvm_symbol &out_sym = symbols->symbols[i];
+		out_sym.start = *sym.getAddress() - image_base;
+		out_sym.name = (char *)calloc(1, sym.getName()->size() + 1);
+		if (out_sym.name == nullptr) {
+			for (size_t i = 0; i < all_symbols.size(); ++i) {
+				zfree(&symbols->symbols[i].name);
+			}
+			zfree(&symbols->symbols);
+			return -1;
+		}
+		memcpy(out_sym.name, sym.getName()->bytes_begin(),
+		       sym.getName()->size());
+		out_sym.global = *sym.getFlags() & SymbolRef::SF_Global;
+		out_sym.weak = *sym.getFlags() & SymbolRef::SF_Weak;
+
+		SectionRef section = **sym.getSection();
+		uint64_t next_addr;
+		if (i + 1 < all_symbols.size() &&
+		    section == **all_symbols[i + 1].getSection())
+			next_addr = *all_symbols[i + 1].getAddress();
+		else
+			next_addr = section.getAddress() + section.getSize();
+
+		out_sym.len = next_addr - *sym.getAddress();
+	}
+
+	return 1;
+}
diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
index d2b99637a28a..1abbc9ef3dab 100644
--- a/tools/perf/util/llvm-c-helpers.h
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/compiler.h>
+#include <stddef.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -53,6 +54,54 @@ int llvm_addr2line(const char* dso_name,
 char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr);
 char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr);
 
+struct llvm_symbol {
+	u64 start, len;
+	bool weak, global;
+
+	/* Must be freed by the caller. */
+	char *name;
+};
+
+struct llvm_symbol_list {
+	/*
+	 * The address this dso is loaded at in memory; adding this to
+	 * the file position of any symbol will give the address that
+	 * symbol is loaded at.
+	 */
+	u64 image_base;
+
+	/*
+	 * The byte offset of the end of the .text segment (one-past-the-end)
+	 * in the file.
+	 */
+	u64 text_end;
+
+	/*
+	 * The actual symbols. Must be freed by the caller, with free().
+	 * The string inside each llvm_symbol must also be freed.
+	 */
+	size_t num_symbols;
+	struct llvm_symbol *symbols;
+};
+
+/*
+ * Get a list of all symbols in the given file using LLVM. Similarly to
+ * addr2line(), we need to implement this using a helper structure;
+ * LLVM actually has a C API for this, but we can't use it (it doesn't
+ * have an equivalent of getFlags()). So we do the meat of the LLVM-facing
+ * logic here and let the caller make perf symbols out of it.
+ *
+ * Possible return values and their meaning:
+ *
+ * -1: An error occurred.
+ *  0: The file loaded fine, but there were no .text section.
+ *  1: The file loaded successfully.
+ *
+ * For -1 and 0, "symbols" does not contain any meaningful information,
+ * and nothing needs to be freed.
+ */
+int llvm_load_symbols(const char *debugfile, struct llvm_symbol_list *symbols);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9e5940b5bc59..69b8c0a280c7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -22,6 +22,7 @@
 #include "util.h" // lsdir()
 #include "debug.h"
 #include "event.h"
+#include "llvm-c-helpers.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
@@ -1566,6 +1567,50 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 	return -1;
 }
 
+#ifdef HAVE_LIBLLVM_SUPPORT
+int dso__load_llvm_symbols(struct dso *dso, const char *debugfile)
+{
+	struct llvm_symbol_list symbols;
+	struct symbol *symbol;
+	int err = llvm_load_symbols(debugfile, &symbols);
+	int ret = -1;
+
+	if (err == -1)
+		return -1;
+	else if (err == 0)
+		return 0;
+
+	for (size_t i = 0; i < symbols.num_symbols; ++i) {
+		const struct llvm_symbol *sym = &symbols.symbols[i];
+		int elf_binding;
+
+		if (sym->weak)
+			elf_binding = STB_WEAK;
+		else if (sym->global)
+			elf_binding = STB_GLOBAL;
+		else
+			elf_binding = STB_LOCAL;
+		symbol = symbol__new(sym->start, sym->len, elf_binding, STT_FUNC,
+				     sym->name);
+		if (!symbol)
+			goto out_free;
+
+		symbols__insert(dso__symbols(dso), symbol);
+	}
+
+	symbols__fixup_end(dso__symbols(dso), false);
+	symbols__fixup_duplicate(dso__symbols(dso));
+	dso__set_adjust_symbols(dso, true);
+	ret = 0;
+
+out_free:
+	for (size_t i = 0; i < symbols.num_symbols; ++i)
+		zfree(&symbols.symbols[i].name);
+	zfree(&symbols.symbols);
+	return ret;
+}
+#endif
+
 #ifdef HAVE_LIBBFD_SUPPORT
 #define PACKAGE 'perf'
 #include <bfd.h>
@@ -1871,6 +1916,7 @@ int dso__load(struct dso *dso, struct map *map)
 		bool next_slot = false;
 		bool is_reg;
 		bool nsexit;
+		int llvmrc = -1;
 		int bfdrc = -1;
 		int sirc = -1;
 
@@ -1899,11 +1945,15 @@ int dso__load(struct dso *dso, struct map *map)
 			}
 		}
 
-#ifdef HAVE_LIBBFD_SUPPORT
+#ifdef HAVE_LIBLLVM_SUPPORT
 		if (is_reg)
+			llvmrc = dso__load_llvm_symbols(dso, name);
+#endif
+#ifdef HAVE_LIBBFD_SUPPORT
+		if (is_reg && llvmrc < 0)
 			bfdrc = dso__load_bfd_symbols(dso, name);
 #endif
-		if (is_reg && bfdrc < 0)
+		if (is_reg && llvmrc < 0 && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
 		if (nsexit)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..01256c41467a 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -174,6 +174,9 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 
 struct symsrc;
 
+#ifdef HAVE_LIBLLVM_SUPPORT
+int dso__load_llvm_symbols(struct dso *dso, const char *debugfile);
+#endif
 #ifdef HAVE_LIBBFD_SUPPORT
 int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
 #endif
-- 
2.45.1

