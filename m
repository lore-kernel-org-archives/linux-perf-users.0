Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B714149E17;
	Wed, 22 Jan 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584829; cv=none; b=ASYmHPHRZg0APp9cpDqF1Y86o2hhz1rCtzIWydAKYatqjWh8RhJaigrrFXF3o568iZ/KzPksxQNTWIsj9HdNol3x1q0i/0p3FauC8e+8neyow7Jpt0FJZO38C5nm17A1HGCRHSLyPwpW8bgXwefANHlI2ZttcqwjnCtMgnLDdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584829; c=relaxed/simple;
	bh=2k99FF1+RWmFmT/wgOa1NAB6nj+9Ej4vB1cnO9KTBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlWDElzSMhEiOBMd/h9nYOUmvsY4ydhhi0kIdKQoqMOrHV3uKc5trA8BtzpJjcZtlSBvsrr0kqeVSQJddQEdr5L/tSb4supwZ4S0oC9ionaTkCtJsdXxuObqnIpB+MhqRawfKyMAj9epIaZQHDM9pP+w1TIN+HGqpJ8qN7W5Vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU5GTtlN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU5GTtlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550D3C4CED2;
	Wed, 22 Jan 2025 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737584829;
	bh=2k99FF1+RWmFmT/wgOa1NAB6nj+9Ej4vB1cnO9KTBCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uU5GTtlN3mYM6SzpS2MNgDjm4jvAITMgyOSI14BAhd9MMy/Vz61vm6FmziCF6WXnC
	 KkgwcMvZtjSY13cNookkx7hC2XcIyPWZ7scgntCpa+sdSKHS/u4AoGYXVWORtvHs5Z
	 vjT4Qqflkv2RZrV058GI0XQ+eKr1NfvOc81KBfu6jqRq2u5+P09gnkW7KzgTmOxo8a
	 iSTYTZN1bTV/z+Sq7lRQUIDHebY0+r7BnUJ2zeSM/gurrAAyRSxbL2QJ865jRhWh95
	 +j9iW3N9FI5mfAa1zobAKc1p/4yUE3MafhPisj5LB4FOVsJD9YUPvQYeEsPDRlDw/N
	 /MJ+IpncaDC7A==
Date: Wed, 22 Jan 2025 14:27:06 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 4/5] perf capstone: Support for dlopen-ing
 libcapstone.so
Message-ID: <Z5FwusFZ_bYlu6aK@google.com>
References: <20250120173208.344231-1-irogers@google.com>
 <20250120173208.344231-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120173208.344231-5-irogers@google.com>

Hi Ian,

On Mon, Jan 20, 2025 at 09:32:07AM -0800, Ian Rogers wrote:
> If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> support dlopen-ing libcapstone.so and then calling the necessary
> functions by looking them up using dlsym. Reverse engineer the types
> in the API using pahole, adding only what's used in the perf code or
> necessary for the sake of struct size and alignment.

I think reverse engineering the types is fragile.  Can we simply change
to dlopen if libcapstone is available?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/capstone.c | 287 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 248 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index c9845e4d8781..8d65c7a55a8b 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -11,19 +11,249 @@
>  #include "print_insn.h"
>  #include "symbol.h"
>  #include "thread.h"
> +#include <dlfcn.h>
>  #include <fcntl.h>
> +#include <inttypes.h>
>  #include <string.h>
>  
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  #include <capstone/capstone.h>
> +#else
> +typedef size_t csh;
> +enum cs_arch {
> +	CS_ARCH_ARM = 0,
> +	CS_ARCH_ARM64 = 1,
> +	CS_ARCH_X86 = 3,
> +	CS_ARCH_SYSZ = 6,
> +};
> +enum cs_mode {
> +	CS_MODE_ARM = 0,
> +	CS_MODE_32 = 1 << 2,
> +	CS_MODE_64 = 1 << 3,
> +	CS_MODE_V8 = 1 << 6,
> +	CS_MODE_BIG_ENDIAN = 1 << 31,
> +};
> +enum cs_opt_type {
> +	CS_OPT_SYNTAX = 1,
> +	CS_OPT_DETAIL = 2,
> +};
> +enum cs_opt_value {
> +	CS_OPT_SYNTAX_ATT = 2,
> +	CS_OPT_ON = 3,
> +};
> +enum cs_err {
> +	CS_ERR_OK = 0,
> +	CS_ERR_HANDLE = 3,
> +};
> +enum x86_op_type {
> +	X86_OP_IMM = 2,
> +	X86_OP_MEM = 3,
> +};
> +enum x86_reg {
> +	X86_REG_RIP = 41,
> +};
> +typedef int32_t x86_avx_bcast;
> +struct x86_op_mem {
> +	enum x86_reg segment;
> +	enum x86_reg base;
> +	enum x86_reg index;
> +	int scale;
> +	int64_t disp;
> +};
> +
> +struct cs_x86_op {
> +	enum x86_op_type type;
> +	union {
> +		enum x86_reg  reg;
> +		int64_t imm;
> +		struct x86_op_mem mem;
> +	};
> +	uint8_t size;
> +	uint8_t access;
> +	x86_avx_bcast avx_bcast;
> +	bool avx_zero_opmask;
> +};
> +struct cs_x86_encoding {
> +	uint8_t modrm_offset;
> +	uint8_t disp_offset;
> +	uint8_t disp_size;
> +	uint8_t imm_offset;
> +	uint8_t imm_size;
> +};
> +typedef int32_t  x86_xop_cc;
> +typedef int32_t  x86_sse_cc;
> +typedef int32_t  x86_avx_cc;
> +typedef int32_t  x86_avx_rm;
> +struct cs_x86 {
> +	uint8_t prefix[4];
> +	uint8_t opcode[4];
> +	uint8_t rex;
> +	uint8_t addr_size;
> +	uint8_t modrm;
> +	uint8_t sib;
> +	int64_t disp;
> +	enum x86_reg sib_index;
> +	int8_t sib_scale;
> +	enum x86_reg sib_base;
> +	x86_xop_cc xop_cc;
> +	x86_sse_cc sse_cc;
> +	x86_avx_cc avx_cc;
> +	bool avx_sae;
> +	x86_avx_rm avx_rm;
> +	union {
> +		uint64_t eflags;
> +		uint64_t fpu_flags;
> +	};
> +	uint8_t op_count;
> +	struct cs_x86_op operands[8];
> +	struct cs_x86_encoding encoding;
> +};
> +struct cs_detail {
> +	uint16_t regs_read[12];
> +	uint8_t regs_read_count;
> +	uint16_t regs_write[20];
> +	uint8_t regs_write_count;
> +	uint8_t groups[8];
> +	uint8_t groups_count;
> +
> +	union {
> +		struct cs_x86 x86;
> +	};
> +};
> +struct cs_insn {
> +	unsigned int id;
> +	uint64_t address;
> +	uint16_t size;
> +	uint8_t bytes[16];
> +	char mnemonic[32];
> +	char op_str[160];
> +	struct cs_detail *detail;
> +};
> +#endif
> +
> +#ifndef HAVE_LIBCAPSTONE_SUPPORT
> +static void *perf_cs_dll_handle(void)
> +{
> +	static bool dll_handle_init;
> +	static void *dll_handle;
> +
> +	if (!dll_handle_init) {
> +		dll_handle_init = true;
> +		dll_handle = dlopen("libcapstone.so", RTLD_LAZY);
> +		if (!dll_handle)
> +			pr_debug("dlopen failed for libcapstone.so\n");
> +	}
> +	return dll_handle;
> +}
> +#endif
> +
> +static enum cs_err perf_cs_open(enum cs_arch arch, enum cs_mode mode, csh *handle)
> +{
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	return cs_open(arch, mode, handle);
> +#else
> +	static bool fn_init;
> +	static enum cs_err (*fn)(enum cs_arch arch, enum cs_mode mode, csh *handle);
> +
> +	if (!fn_init) {
> +		fn = dlsym(perf_cs_dll_handle(), "cs_open");
> +		if (!fn)
> +			pr_debug("dlsym failed for cs_open\n");
> +		fn_init = true;
> +	}
> +	if (!fn)
> +		return CS_ERR_HANDLE;
> +	return fn(arch, mode, handle);
> +#endif
> +}
> +
> +static enum cs_err perf_cs_option(csh handle, enum cs_opt_type type, size_t value)
> +{
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	return cs_option(handle, type, value);
> +#else
> +	static bool fn_init;
> +	static enum cs_err (*fn)(csh handle, enum cs_opt_type type, size_t value);
> +
> +	if (!fn_init) {
> +		fn = dlsym(perf_cs_dll_handle(), "cs_option");
> +		if (!fn)
> +			pr_debug("dlsym failed for cs_option\n");
> +		fn_init = true;
> +	}
> +	if (!fn)
> +		return CS_ERR_HANDLE;
> +	return fn(handle, type, value);
> +#endif
> +}
> +
> +static size_t perf_cs_disasm(csh handle, const uint8_t *code, size_t code_size,
> +			uint64_t address, size_t count, struct cs_insn **insn)
> +{
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	return cs_disasm(handle, code, code_size, address, count, insn);
> +#else
> +	static bool fn_init;
> +	static enum cs_err (*fn)(csh handle, const uint8_t *code, size_t code_size,
> +				 uint64_t address, size_t count, struct cs_insn **insn);
> +
> +	if (!fn_init) {
> +		fn = dlsym(perf_cs_dll_handle(), "cs_disasm");
> +		if (!fn)
> +			pr_debug("dlsym failed for cs_disasm\n");
> +		fn_init = true;
> +	}
> +	if (!fn)
> +		return CS_ERR_HANDLE;
> +	return fn(handle, code, code_size, address, count, insn);
>  #endif
> +}
>  
> +static void perf_cs_free(struct cs_insn *insn, size_t count)
> +{
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	cs_free(insn, count);
> +#else
> +	static bool fn_init;
> +	static void (*fn)(struct cs_insn *insn, size_t count);
> +
> +	if (!fn_init) {
> +		fn = dlsym(perf_cs_dll_handle(), "cs_free");
> +		if (!fn)
> +			pr_debug("dlsym failed for cs_free\n");
> +		fn_init = true;
> +	}
> +	if (!fn)
> +		return;
> +	fn(insn, count);
> +#endif
> +}
> +
> +static enum cs_err perf_cs_close(csh *handle)
> +{
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	return cs_close(handle);
> +#else
> +	static bool fn_init;
> +	static enum cs_err (*fn)(csh *handle);
> +
> +	if (!fn_init) {
> +		fn = dlsym(perf_cs_dll_handle(), "cs_close");
> +		if (!fn)
> +			pr_debug("dlsym failed for cs_close\n");
> +		fn_init = true;
> +	}
> +	if (!fn)
> +		return CS_ERR_HANDLE;
> +	return fn(handle);
> +#endif
> +}
> +
>  static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
>  			 bool disassembler_style)
>  {
> -	cs_arch arch;
> -	cs_mode mode;
> +	enum cs_arch arch;
> +	enum cs_mode mode;
>  
>  	if (machine__is(machine, "x86_64") && is64) {
>  		arch = CS_ARCH_X86;
> @@ -44,7 +274,7 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
>  		return -1;
>  	}
>  
> -	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
> +	if (perf_cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
>  		pr_warning_once("cs_open failed\n");
>  		return -1;
>  	}
> @@ -56,27 +286,25 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
>  		 * is set via annotation args
>  		 */
>  		if (disassembler_style)
> -			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> +			perf_cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
>  		/*
>  		 * Resolving address operands to symbols is implemented
>  		 * on x86 by investigating instruction details.
>  		 */
> -		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> +		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>  	}
>  
>  	return 0;
>  }
> -#endif
>  
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> -static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
> +static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *insn,
>  			     int print_opts, FILE *fp)
>  {
>  	struct addr_location al;
>  	size_t printed = 0;
>  
>  	if (insn->detail && insn->detail->x86.op_count == 1) {
> -		cs_x86_op *op = &insn->detail->x86.operands[0];
> +		struct cs_x86_op *op = &insn->detail->x86.operands[0];
>  
>  		addr_location__init(&al);
>  		if (op->type == X86_OP_IMM &&
> @@ -94,7 +322,6 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
>  	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
>  	return printed;
>  }
> -#endif
>  
>  
>  ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
> @@ -105,9 +332,8 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
>  				   uint64_t ip __maybe_unused, int *lenp __maybe_unused,
>  				   int print_opts __maybe_unused, FILE *fp __maybe_unused)
>  {
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	size_t printed;
> -	cs_insn *insn;
> +	struct cs_insn *insn;
>  	csh cs_handle;
>  	size_t count;
>  	int ret;
> @@ -117,7 +343,7 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
>  	if (ret < 0)
>  		return ret;
>  
> -	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
> +	count = perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
>  	if (count > 0) {
>  		if (machine__normalized_is(machine, "x86"))
>  			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
> @@ -125,20 +351,16 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
>  			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
>  		if (lenp)
>  			*lenp = insn->size;
> -		cs_free(insn, count);
> +		perf_cs_free(insn, count);
>  	} else {
>  		printed = -1;
>  	}
>  
> -	cs_close(&cs_handle);
> +	perf_cs_close(&cs_handle);
>  	return printed;
> -#else
> -	return -1;
> -#endif
>  }
>  
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> -static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
> +static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  				  struct annotate_args *args, u64 addr)
>  {
>  	int i;
> @@ -153,7 +375,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
>  		return;
>  
>  	for (i = 0; i < insn->detail->x86.op_count; i++) {
> -		cs_x86_op *op = &insn->detail->x86.operands[i];
> +		struct cs_x86_op *op = &insn->detail->x86.operands[i];
>  		u64 orig_addr;
>  
>  		if (op->type != X86_OP_MEM)
> @@ -194,9 +416,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
>  		break;
>  	}
>  }
> -#endif
>  
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  struct find_file_offset_data {
>  	u64 ip;
>  	u64 offset;
> @@ -213,9 +433,7 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
>  	}
>  	return 0;
>  }
> -#endif
>  
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  static u8 *
>  read_symbol(const char *filename, struct map *map, struct symbol *sym,
>  	    u64 *len, bool *is_64bit)
> @@ -262,13 +480,11 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
>  	free(buf);
>  	return NULL;
>  }
> -#endif
>  
>  int symbol__disassemble_capstone(const char *filename __maybe_unused,
>  				 struct symbol *sym __maybe_unused,
>  				 struct annotate_args *args __maybe_unused)
>  {
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	struct annotation *notes = symbol__annotation(sym);
>  	struct map *map = args->ms.map;
>  	u64 start = map__rip_2objdump(map, sym->start);
> @@ -279,7 +495,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>  	bool needs_cs_close = false;
>  	u8 *buf = NULL;
>  	csh handle;
> -	cs_insn *insn = NULL;
> +	struct cs_insn *insn = NULL;
>  	char disasm_buf[512];
>  	struct disasm_line *dl;
>  	bool disassembler_style = false;
> @@ -316,7 +532,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>  
>  	needs_cs_close = true;
>  
> -	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
> +	free_count = count = perf_cs_disasm(handle, buf, len, start, len, &insn);
>  	for (i = 0, offset = 0; i < count; i++) {
>  		int printed;
>  
> @@ -355,9 +571,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>  
>  out:
>  	if (needs_cs_close) {
> -		cs_close(&handle);
> +		perf_cs_close(&handle);
>  		if (free_count > 0)
> -			cs_free(insn, free_count);
> +			perf_cs_free(insn, free_count);
>  	}
>  	free(buf);
>  	return count < 0 ? count : 0;
> @@ -377,16 +593,12 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>  	}
>  	count = -1;
>  	goto out;
> -#else
> -	return -1;
> -#endif
>  }
>  
>  int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
>  					 struct symbol *sym __maybe_unused,
>  					 struct annotate_args *args __maybe_unused)
>  {
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	struct annotation *notes = symbol__annotation(sym);
>  	struct map *map = args->ms.map;
>  	struct dso *dso = map__dso(map);
> @@ -499,7 +711,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
>  
>  out:
>  	if (needs_cs_close)
> -		cs_close(&handle);
> +		perf_cs_close(&handle);
>  	free(buf);
>  	return count < 0 ? count : 0;
>  
> @@ -508,7 +720,4 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
>  		close(fd);
>  	count = -1;
>  	goto out;
> -#else
> -	return -1;
> -#endif
>  }
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 
