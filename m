Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCF3F105D;
	Wed,  9 Sep 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966097; cv=none; b=LzTfmSGVEjpSBMHYoFT+j4+skt7lZKhXYcVqKZi9a8ydn/0HiV4lxdt036bY2jsIphlOUzzSUoDiA069T1zZsD9AHt83nnIFrd5z1TV422TftQR/h6og4J7FPmfQxm4/JQmmET4FdA2jziedu0gOvOPyqAgCJRSg4gmOcLe/MV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966097; c=relaxed/simple;
	bh=BzoZ634HGOc8Mg7dHqhh1d5cvliBMGjPmOUx6mld/sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/I7FsJppXxjwWJzZM/xC60f1/qJLF18nSkgSbGQ9loaXro6WJC2L/gqzhVcABQsP6cRCRjBWRkvDQtAI+a3+W2z0+Nqjc95v3m7g8xjCTSsdIISb3FHiJZha/Hqq/O1VYcpXyIH6+g34GhlGqzbaRW/BEhAPLz/a/HsMptR+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln7hZnnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln7hZnnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1FA1F00A3A;
	Wed,  9 Sep 2026 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966096;
	bh=Jbiv43kuCfE3AfQ6JAlUY4GrTeO1TozLkhaI4YIBbaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ln7hZnnT2WmHjU5QJPq5pbq8kn2gV5bwDxGohWz77eEwoE86AdqrSGVPqOtH8b8Bp
	 0lY+vcI8FVk9guWc8gK87oo2ZBEjbhvA6NCQ+Uj9sRv9+aRv0N213WmC0sBPxYv6Ui
	 0SJU8UrVilH43OLxy7Hu9BoQjNis64a3k9/FsgA3iUUGQ+zjJPEobYpOh5AevVinpj
	 6tk6/rDZEZGdkZl2X+SRGwGcKMFZo2F4njeecRQZv3tWi/f6Vr0qBh7MnHpJK2BqRK
	 GxiGGT5XeQlMpXxi3MJP6S9kRTMcSyb3sSMePN7xluBJtQ8CyN7PmBpi2jUbluhtE5
	 wuk8tuhlLhnVA==
Date: Wed, 9 Sep 2026 11:01:33 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 06/26] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
Message-ID: <aqF0zceTOQBjRJl1@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a9f1bafb17bc2e2c6152f6e3a0c63b9d72a0e657.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9f1bafb17bc2e2c6152f6e3a0c63b9d72a0e657.1788872630.git.wutengda@huaweicloud.com>

On Tue, Sep 08, 2026 at 01:05:09PM +0000, Tengda Wu wrote:
> Assembly syntax for operands varies significantly across different
> architectures, which prevents the operand location (op_loc) parsing
> logic in annotate_get_insn_location() from being directly reused.
> 
> To simplify the core logic and improve maintainability, move the
> operand parsing inside the for_each_insn_op_loc loop into arch-specific
> extract_op_location callbacks. This refactoring is intended to be a
> cleanup with no functional changes.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  .../util/annotate-arch/annotate-powerpc.c     |  9 ++
>  tools/perf/util/annotate-arch/annotate-x86.c  | 79 ++++++++++++++++
>  tools/perf/util/annotate.c                    | 94 +------------------
>  tools/perf/util/annotate.h                    |  2 +
>  tools/perf/util/disasm.h                      |  4 +
>  5 files changed, 99 insertions(+), 89 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-powerpc.c b/tools/perf/util/annotate-arch/annotate-powerpc.c
> index 218207b52581..00b93296fc94 100644
> --- a/tools/perf/util/annotate-arch/annotate-powerpc.c
> +++ b/tools/perf/util/annotate-arch/annotate-powerpc.c
> @@ -390,6 +390,14 @@ static void update_insn_state_powerpc(struct type_state *state,
>  }
>  #endif /* HAVE_LIBDW_SUPPORT */
>  
> +static void extract_op_location_powerpc(const struct arch *arch __maybe_unused,
> +					struct disasm_line *dl,
> +					const char *op_str __maybe_unused, int op_idx,
> +					struct annotated_op_loc *op_loc)
> +{
> +	get_powerpc_regs(dl->raw.raw_insn, !op_idx, op_loc);
> +}
> +
>  const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
>  				     const char *cpuid __maybe_unused)
>  {
> @@ -406,5 +414,6 @@ const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
>  #ifdef HAVE_LIBDW_SUPPORT
>  	arch->update_insn_state = update_insn_state_powerpc;
>  #endif
> +	arch->extract_op_location = extract_op_location_powerpc;
>  	return arch;
>  }
> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> index 7e6136536393..1acf31a2c759 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
> +#include <stdlib.h>
>  #include <linux/compiler.h>
> +#include <linux/ctype.h>
>  #include <linux/zalloc.h>
>  #include <assert.h>
>  #include <inttypes.h>
> @@ -809,6 +811,82 @@ static void update_insn_state_x86(struct type_state *state,
>  }
>  #endif
>  
> +/*
> + * Get register number and access offset from the given instruction.
> + * It assumes AT&T x86 asm format like OFFSET(REG).
> + * Fills @reg and @offset when return 0.
> + */
> +static int extract_reg_offset(const struct arch *arch, const char *str,
> +			      struct annotated_op_loc *op_loc)
> +{
> +	char *p;
> +
> +	if (arch->objdump.register_char == 0)
> +		return -1;
> +
> +	/*
> +	 * It should start from offset, but it's possible to skip 0
> +	 * in the asm.  So 0(%rax) should be same as (%rax).
> +	 *
> +	 * However, it also start with a segment select register like
> +	 * %gs:0x18(%rbx).  In that case it should skip the part.
> +	 */
> +	if (*str == arch->objdump.register_char) {
> +		/* FIXME: Handle other segment registers */
> +		if (!strncmp(str, "%gs:", 4))
> +			op_loc->segment = INSN_SEG_X86_GS;
> +
> +		while (*str && !isdigit(*str) &&
> +		       *str != arch->objdump.memory_ref_char)
> +			str++;
> +	}
> +
> +	op_loc->offset = strtol(str, &p, 0);
> +	op_loc->reg1 = arch__dwarf_regnum(arch, p);
> +	if (op_loc->reg1 == -1)
> +		return -1;
> +
> +	/* Get the second register */
> +	if (op_loc->multi_regs)
> +		op_loc->reg2 = arch__dwarf_regnum(arch, p + 1);
> +
> +	return 0;
> +}
> +
> +static void extract_op_location_x86(const struct arch *arch,
> +				    struct disasm_line *dl __maybe_unused,
> +				    const char *op_str, int op_idx __maybe_unused,
> +				    struct annotated_op_loc *op_loc)
> +{
> +	if (op_str == NULL)
> +		return;
> +
> +	if (strchr(op_str, arch->objdump.memory_ref_char)) {
> +		op_loc->mem_ref = true;
> +		extract_reg_offset(arch, op_str, op_loc);
> +	} else {
> +		const char *s = op_str;
> +		char *p = NULL;
> +
> +		/* FIXME: Handle other segment registers */
> +		if (!strncmp(op_str, "%gs:", 4)) {
> +			op_loc->segment = INSN_SEG_X86_GS;
> +			op_loc->offset = strtol(op_str + 4, &p, 0);
> +			if (p && p != op_str + 4)
> +				op_loc->imm = true;
> +			return;
> +		}
> +
> +		if (*s == arch->objdump.register_char) {
> +			op_loc->reg1 = arch__dwarf_regnum(arch, s);
> +		} else if (*s == arch->objdump.imm_char) {
> +			op_loc->offset = strtol(s + 1, &p, 0);
> +			if (p && p != s + 1)
> +				op_loc->imm = true;
> +		}
> +	}
> +}
> +
>  const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const char *cpuid)
>  {
>  	struct arch *arch = zalloc(sizeof(*arch));
> @@ -848,5 +926,6 @@ const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const c
>  #ifdef HAVE_LIBDW_SUPPORT
>  	arch->update_insn_state = update_insn_state_x86;
>  #endif
> +	arch->extract_op_location = extract_op_location_x86;
>  	return arch;
>  }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index f3d17d153b67..a3d48cf88dad 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2472,7 +2472,7 @@ int annotate_check_args(void)
>  	return 0;
>  }
>  
> -static int arch__dwarf_regnum(const struct arch *arch, const char *str)
> +int arch__dwarf_regnum(const struct arch *arch, const char *str)
>  {
>  	const char *p;
>  	char *regname, *q;
> @@ -2495,51 +2495,6 @@ static int arch__dwarf_regnum(const struct arch *arch, const char *str)
>  	return reg < 0 ? -1 : reg;
>  }
>  
> -/*
> - * Get register number and access offset from the given instruction.
> - * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
> - * to revisit the format when it handles different architecture.
> - * Fills @reg and @offset when return 0.
> - */
> -static int extract_reg_offset(const struct arch *arch, const char *str,
> -			      struct annotated_op_loc *op_loc)
> -{
> -	char *p;
> -
> -	if (arch->objdump.register_char == 0)
> -		return -1;
> -
> -	/*
> -	 * It should start from offset, but it's possible to skip 0
> -	 * in the asm.  So 0(%rax) should be same as (%rax).
> -	 *
> -	 * However, it also start with a segment select register like
> -	 * %gs:0x18(%rbx).  In that case it should skip the part.
> -	 */
> -	if (*str == arch->objdump.register_char) {
> -		if (arch__is_x86(arch)) {
> -			/* FIXME: Handle other segment registers */
> -			if (!strncmp(str, "%gs:", 4))
> -				op_loc->segment = INSN_SEG_X86_GS;
> -		}
> -
> -		while (*str && !isdigit(*str) &&
> -		       *str != arch->objdump.memory_ref_char)
> -			str++;
> -	}
> -
> -	op_loc->offset = strtol(str, &p, 0);
> -	op_loc->reg1 = arch__dwarf_regnum(arch, p);
> -	if (op_loc->reg1 == -1)
> -		return -1;
> -
> -	/* Get the second register */
> -	if (op_loc->multi_regs)
> -		op_loc->reg2 = arch__dwarf_regnum(arch, p + 1);
> -
> -	return 0;
> -}
> -
>  /**
>   * annotate_get_insn_location - Get location of instruction
>   * @arch: the architecture info
> @@ -2595,50 +2550,11 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
>  		/* Invalidate the register by default */
>  		op_loc->reg1 = -1;
>  		op_loc->reg2 = -1;
> +		op_loc->mem_ref = mem_ref;
> +		op_loc->multi_regs = multi_regs;
>  
> -		if (insn_str == NULL) {
> -			if (!arch__is_powerpc(arch))
> -				continue;
> -		}
> -
> -		/*
> -		 * For powerpc, call get_powerpc_regs function which extracts the
> -		 * required fields for op_loc, ie reg1, reg2, offset from the
> -		 * raw instruction.
> -		 */
> -		if (arch__is_powerpc(arch)) {
> -			op_loc->mem_ref = mem_ref;
> -			op_loc->multi_regs = multi_regs;
> -			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
> -		} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
> -			op_loc->mem_ref = true;
> -			op_loc->multi_regs = multi_regs;
> -			extract_reg_offset(arch, insn_str, op_loc);
> -		} else {
> -			const char *s = insn_str;
> -			char *p = NULL;
> -
> -			if (arch__is_x86(arch)) {
> -				/* FIXME: Handle other segment registers */
> -				if (!strncmp(insn_str, "%gs:", 4)) {
> -					op_loc->segment = INSN_SEG_X86_GS;
> -					op_loc->offset = strtol(insn_str + 4,
> -								&p, 0);
> -					if (p && p != insn_str + 4)
> -						op_loc->imm = true;
> -					continue;
> -				}
> -			}
> -
> -			if (*s == arch->objdump.register_char) {
> -				op_loc->reg1 = arch__dwarf_regnum(arch, s);
> -			}
> -			else if (*s == arch->objdump.imm_char) {
> -				op_loc->offset = strtol(s + 1, &p, 0);
> -				if (p && p != s + 1)
> -					op_loc->imm = true;
> -			}
> -		}
> +		if (arch->extract_op_location)
> +			arch->extract_op_location(arch, dl, insn_str, i, op_loc);
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index fa08d09b80f7..11b6e4780c02 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -492,6 +492,8 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
>  
>  int annotate_check_args(void);
>  
> +int arch__dwarf_regnum(const struct arch *arch, const char *str);
> +
>  /**
>   * struct annotated_op_loc - Location info of instruction operand
>   * @reg1: First register in the operand
> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> index 06c664fd4fc2..62c2949c4c30 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -16,6 +16,7 @@ struct symbol;
>  struct data_loc_info;
>  struct type_state;
>  struct disasm_line;
> +struct annotated_op_loc;
>  
>  struct e_machine_and_e_flags {
>  	uint32_t e_flags;
> @@ -49,6 +50,9 @@ struct arch {
>  				struct data_loc_info *dloc, Dwarf_Die *cu_die,
>  				struct disasm_line *dl);
>  #endif
> +	void		(*extract_op_location)(const struct arch *arch, struct disasm_line *dl,
> +					       const char *op_str, int op_idx,
> +					       struct annotated_op_loc *op_loc);
>  };
>  
>  struct ins {
> -- 
> 2.34.1
> 
