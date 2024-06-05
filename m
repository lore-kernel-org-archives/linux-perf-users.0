Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CB2F2B;
	Wed,  5 Jun 2024 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717549849; cv=none; b=D8HEJrIYJCdehg5wJoqKl9nw1BIj5cYvAACm/M3ohZg3l618Wb66/SZahKfWwxcCuVUuooeBLGGcNk0aq4kjO6m4u6uEKoK6Cv4yU8padSuNO7LAnoum1ea7dPBEsu9vsI4qYZOJxQDiw7CU4nsWxnxYgH3XoxpqrChX9mqtGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717549849; c=relaxed/simple;
	bh=cHc/0ZdmuHo5jRwZHm5Alo/p/rjYM9Aw1Ngf1OY3QAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqldClQ8d9bhr8ayTUF8GSo5HFKWtIoVKt6Ta+m3u8E3vd8S2THV09OCVzoKjBKT9Xgztf10s3zaIwkXlWPGE6DsWxvt/UPVUQ+QkBycNZv7GcbolBzmr419aYwa6l+2SfT6qHZjyfOCYgiDEREHD4SPNIvbmTNNk+le7+ygD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxPmb3aH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxPmb3aH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EACC2BBFC;
	Wed,  5 Jun 2024 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717549848;
	bh=cHc/0ZdmuHo5jRwZHm5Alo/p/rjYM9Aw1Ngf1OY3QAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxPmb3aHfNTlO+izjpeTjqxODioDyba6worXTsVmVPja7m7QDJ7v/vJmwwTqZsDPD
	 uximD3cjydeoB7GwsKIdRn0SaOX/Qmp6f5+PtIBEPsAytaEoseoxirMAOgsHAiftHG
	 YF1a7OvovnsMD4AxvX/UtcYtsZdd62gn+mvjRw1rbYJcd9U83na20x1pDy2NvMdISZ
	 qQY4r4LeBoVJ9Iu9IQaiTH969cD290OZ2NaLzhTCld9WvSKgvUHHsLgVEFsHX2vBcK
	 OXd7deQzXtMpg5IZcwF3nGoSmYbCS63Y0tcVMMAB4BRHFGW2lHKSyrXq8KkUL3k2xY
	 cfE/cp/hJpu9A==
Date: Tue, 4 Jun 2024 18:10:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH v8 3/3] perf annotate: LLVM-based disassembler
Message-ID: <Zl-7F4amEqiTj4mw@google.com>
References: <20240602204208.735793-1-sesse@google.com>
 <20240602204208.735793-3-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240602204208.735793-3-sesse@google.com>

Hello,

On Sun, Jun 02, 2024 at 10:42:08PM +0200, Steinar H. Gunderson wrote:
> Support using LLVM as a disassembler method, allowing helperless
> annotation in non-distro builds. (It is also much faster than
> using libbfd or bfd objdump on binaries with a lot of debug
> information.)
> 
> This is nearly identical to the output of llvm-objdump; there are
> some very rare whitespace differences, some minor changes to demangling
> (since we use perf's regular demangling and not LLVM's own) and
> the occasional case where llvm-objdump makes a different choice
> when multiple symbols share the same address. It should work across
> all of LLVM's supported architectures, although I've only tested 64-bit
> x86, and finding the right triple from perf's idea of machine
> architecture can sometimes be a bit tricky. Ideally, we should have
> some way of finding the triplet just from the file itself.
> 
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>

I got a build error like this:

    CC      util/disasm.o
  util/disasm.c:1615:10: fatal error: llvm-c/Disassembler.h: No such file or directory
   1615 | #include <llvm-c/Disassembler.h>
        |          ^~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

My LLVM version is 16.

  $ llvm-config --version
  16.0.6

Thanks,
Namhyung

> ---
>  tools/perf/util/disasm.c           | 193 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.cpp |  62 +++++++++
>  tools/perf/util/llvm-c-helpers.h   |  11 ++
>  3 files changed, 266 insertions(+)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index c0dbb955e61a..4946e9ccf93b 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -43,6 +43,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
>  
>  static void ins__sort(struct arch *arch);
>  static int disasm_line__parse(char *line, const char **namep, char **rawp);
> +static char *expand_tabs(char *line, char **storage, size_t *storage_len);
>  
>  static __attribute__((constructor)) void symbol__init_regexpr(void)
>  {
> @@ -1378,7 +1379,9 @@ static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
>  
>  	return 0;
>  }
> +#endif
>  
> +#if defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
>  struct find_file_offset_data {
>  	u64 ip;
>  	u64 offset;
> @@ -1442,7 +1445,9 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
>  	free(buf);
>  	return NULL;
>  }
> +#endif
>  
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
>  				  struct annotate_args *args, u64 addr)
>  {
> @@ -1606,6 +1611,189 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  }
>  #endif
>  
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +#include <llvm-c/Disassembler.h>
> +#include <llvm-c/Target.h>
> +#include "util/llvm-c-helpers.h"
> +
> +struct symbol_lookup_storage {
> +	u64 branch_addr;
> +	u64 pcrel_load_addr;
> +};
> +
> +/*
> + * Whenever LLVM wants to resolve an address into a symbol, it calls this
> + * callback. We don't ever actually _return_ anything (in particular, because
> + * it puts quotation marks around what we return), but we use this as a hint
> + * that there is a branch or PC-relative address in the expression that we
> + * should add some textual annotation for after the instruction. The caller
> + * will use this information to add the actual annotation.
> + */
> +static const char *
> +symbol_lookup_callback(void *disinfo, uint64_t value,
> +		       uint64_t *ref_type,
> +		       uint64_t address __maybe_unused,
> +		       const char **ref __maybe_unused)
> +{
> +	struct symbol_lookup_storage *storage = disinfo;
> +
> +	if (*ref_type == LLVMDisassembler_ReferenceType_In_Branch)
> +		storage->branch_addr = value;
> +	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
> +		storage->pcrel_load_addr = value;
> +	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
> +	return NULL;
> +}
> +
> +static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> +				    struct annotate_args *args)
> +{
> +	struct annotation *notes = symbol__annotation(sym);
> +	struct map *map = args->ms.map;
> +	struct dso *dso = map__dso(map);
> +	u64 start = map__rip_2objdump(map, sym->start);
> +	u8 *buf;
> +	u64 len;
> +	u64 pc;
> +	bool is_64bit;
> +	char triplet[64];
> +	char disasm_buf[2048];
> +	size_t disasm_len;
> +	struct disasm_line *dl;
> +	LLVMDisasmContextRef disasm = NULL;
> +	struct symbol_lookup_storage storage;
> +	char *line_storage = NULL;
> +	size_t line_storage_len = 0;
> +	int ret = -1;
> +
> +	if (args->options->objdump_path)
> +		return -1;
> +
> +	LLVMInitializeAllTargetInfos();
> +	LLVMInitializeAllTargetMCs();
> +	LLVMInitializeAllDisassemblers();
> +
> +	buf = read_symbol(filename, map, sym, &len, &is_64bit);
> +	if (buf == NULL)
> +		return -1;
> +
> +	if (arch__is(args->arch, "x86")) {
> +		if (is_64bit)
> +			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
> +		else
> +			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
> +	} else {
> +		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
> +			  args->arch->name);
> +	}
> +
> +	disasm = LLVMCreateDisasm(triplet, &storage, 0, NULL,
> +				  symbol_lookup_callback);
> +	if (disasm == NULL)
> +		goto err;
> +
> +	if (args->options->disassembler_style &&
> +	    !strcmp(args->options->disassembler_style, "intel"))
> +		LLVMSetDisasmOptions(disasm,
> +				     LLVMDisassembler_Option_AsmPrinterVariant);
> +
> +	/*
> +	 * This needs to be set after AsmPrinterVariant, due to a bug in LLVM;
> +	 * setting AsmPrinterVariant makes a new instruction printer, making it
> +	 * forget about the PrintImmHex flag (which is applied before if both
> +	 * are given to the same call).
> +	 */
> +	LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex);
> +
> +	/* add the function address and name */
> +	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
> +		  start, sym->name);
> +
> +	args->offset = -1;
> +	args->line = disasm_buf;
> +	args->line_nr = 0;
> +	args->fileloc = NULL;
> +	args->ms.sym = sym;
> +
> +	dl = disasm_line__new(args);
> +	if (dl == NULL)
> +		goto err;
> +
> +	annotation_line__add(&dl->al, &notes->src->source);
> +
> +	pc = start;
> +	for (u64 offset = 0; offset < len; ) {
> +		unsigned int ins_len;
> +
> +		storage.branch_addr = 0;
> +		storage.pcrel_load_addr = 0;
> +
> +		ins_len = LLVMDisasmInstruction(disasm, buf + offset,
> +						len - offset, pc,
> +						disasm_buf, sizeof(disasm_buf));
> +		if (ins_len == 0)
> +			goto err;
> +		disasm_len = strlen(disasm_buf);
> +
> +		if (storage.branch_addr != 0) {
> +			char *name = llvm_name_for_code(dso, filename,
> +							storage.branch_addr);
> +			if (name != NULL) {
> +				disasm_len += scnprintf(disasm_buf + disasm_len,
> +							sizeof(disasm_buf) -
> +								disasm_len,
> +							" <%s>", name);
> +				free(name);
> +			}
> +		}
> +		if (storage.pcrel_load_addr != 0) {
> +			char *name = llvm_name_for_data(dso, filename,
> +							storage.pcrel_load_addr);
> +			disasm_len += scnprintf(disasm_buf + disasm_len,
> +						sizeof(disasm_buf) - disasm_len,
> +						"  # %#"PRIx64,
> +						storage.pcrel_load_addr);
> +			if (name) {
> +				disasm_len += scnprintf(disasm_buf + disasm_len,
> +							sizeof(disasm_buf) -
> +							disasm_len,
> +							" <%s>", name);
> +				free(name);
> +			}
> +		}
> +
> +		args->offset = offset;
> +		args->line = expand_tabs(disasm_buf, &line_storage,
> +					 &line_storage_len);
> +		args->line_nr = 0;
> +		args->fileloc = NULL;
> +		args->ms.sym = sym;
> +
> +		llvm_addr2line(filename, pc, &args->fileloc,
> +			       (unsigned int *)&args->line_nr, false, NULL);
> +
> +		dl = disasm_line__new(args);
> +		if (dl == NULL)
> +			goto err;
> +
> +		annotation_line__add(&dl->al, &notes->src->source);
> +
> +		free(args->fileloc);
> +		pc += ins_len;
> +		offset += ins_len;
> +	}
> +
> +	ret = 0;
> +
> +err:
> +	LLVMDisasmDispose(disasm);
> +	free(buf);
> +	free(line_storage);
> +	return ret;
> +}
> +#endif
> +
> +
>  /*
>   * Possibly create a new version of line with tabs expanded. Returns the
>   * existing or new line, storage is updated if a new line is allocated. If
> @@ -1730,6 +1918,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		strcpy(symfs_filename, tmp);
>  	}
>  
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +	err = symbol__disassemble_llvm(symfs_filename, sym, args);
> +	if (err == 0)
> +		goto out_remove_tmp;
> +#endif
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	err = symbol__disassemble_capstone(symfs_filename, sym, args);
>  	if (err == 0)
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
> index 3cc967ec6f28..4070e2d5682f 100644
> --- a/tools/perf/util/llvm-c-helpers.cpp
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -8,6 +8,7 @@
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
>  #include <llvm/DebugInfo/Symbolize/Symbolize.h>
> +#include <llvm/Support/TargetSelect.h>
>  #pragma GCC diagnostic pop
>  
>  #include <stdio.h>
> @@ -19,6 +20,9 @@ extern "C" {
>  #include "symbol_conf.h"
>  #include "llvm-c-helpers.h"
>  
> +extern "C"
> +char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
> +
>  using namespace llvm;
>  using llvm::symbolize::LLVMSymbolizer;
>  
> @@ -132,3 +136,61 @@ int llvm_addr2line(const char *dso_name, u64 addr,
>  		return extract_file_and_line(*res_or_err, file, line);
>  	}
>  }
> +
> +static char *
> +make_symbol_relative_string(struct dso *dso, const char *sym_name,
> +			    u64 addr, u64 base_addr)
> +{
> +	if (!strcmp(sym_name, "<invalid>"))
> +		return NULL;
> +
> +	char *demangled = dso__demangle_sym(dso, 0, sym_name);
> +	if (base_addr && base_addr != addr) {
> +		char buf[256];
> +		snprintf(buf, sizeof(buf), "%s+0x%lx",
> +			 demangled ? demangled : sym_name, addr - base_addr);
> +		free(demangled);
> +		return strdup(buf);
> +	} else {
> +		if (demangled)
> +			return demangled;
> +		else
> +			return strdup(sym_name);
> +	}
> +}
> +
> +extern "C"
> +char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr)
> +{
> +	LLVMSymbolizer *symbolizer = get_symbolizer();
> +	object::SectionedAddress sectioned_addr = {
> +		addr,
> +		object::SectionedAddress::UndefSection
> +	};
> +	Expected<DILineInfo> res_or_err =
> +		symbolizer->symbolizeCode(dso_name, sectioned_addr);
> +	if (!res_or_err) {
> +		return NULL;
> +	}
> +	return make_symbol_relative_string(
> +		dso, res_or_err->FunctionName.c_str(),
> +		addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
> +}
> +
> +extern "C"
> +char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr)
> +{
> +	LLVMSymbolizer *symbolizer = get_symbolizer();
> +	object::SectionedAddress sectioned_addr = {
> +		addr,
> +		object::SectionedAddress::UndefSection
> +	};
> +	Expected<DIGlobal> res_or_err =
> +		symbolizer->symbolizeData(dso_name, sectioned_addr);
> +	if (!res_or_err) {
> +		return NULL;
> +	}
> +	return make_symbol_relative_string(
> +		dso, res_or_err->Name.c_str(),
> +		addr, res_or_err->Start);
> +}
> diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
> index 19332dd98e14..d2b99637a28a 100644
> --- a/tools/perf/util/llvm-c-helpers.h
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -13,6 +13,8 @@
>  extern "C" {
>  #endif
>  
> +struct dso;
> +
>  struct llvm_a2l_frame {
>    char* filename;
>    char* funcname;
> @@ -42,6 +44,15 @@ int llvm_addr2line(const char* dso_name,
>                     bool unwind_inlines,
>                     struct llvm_a2l_frame** inline_frames);
>  
> +/*
> + * Simple symbolizers for addresses; will convert something like
> + * 0x12345 to "func+0x123". Will return NULL if no symbol was found.
> + *
> + * The returned value must be freed by the caller, with free().
> + */
> +char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr);
> +char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> -- 
> 2.45.1
> 
