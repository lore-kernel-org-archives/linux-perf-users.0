Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F84623;
	Wed,  3 Jul 2024 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969400; cv=none; b=g1Rsh/lQzh9jcD08Jqc6Ii5nBmdTBV/rs8T3t86+PUDnOikUx0Db2UrQieOEbTcRbX+Cl3cNwLnBTZMoDz4H3BUDPh747WkqWzoKxtqQhVLP3vmxA7GbTiRXFaC640npzEQGSweZL5ku1tyUiDKCr+rd0hjnt4s5o45LeqTawBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969400; c=relaxed/simple;
	bh=VrytQJefr28zuK01ISNsWk203kx+kMBg8J/mggBTr1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgbhI3i1D7wQgfWX/LTiOnWTLYg11+4Z2rGTTHDDvyIm5WvuqJ4UQhNqKJfQWTVzpco38162sOPyWezvEkKQi9RB8dKYrmnip0evR62P8SLFh7bpWaw2UvLtVOu6FDIFLaadwtQvBQojFLqlfkRBAm/X9Ybmg99EVx7UVwhFb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn3VnPOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn3VnPOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E0AC116B1;
	Wed,  3 Jul 2024 01:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719969399;
	bh=VrytQJefr28zuK01ISNsWk203kx+kMBg8J/mggBTr1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn3VnPOayuHrmtmYtEGI3fvK8Q3cFjOKO+XMpMT03VgUescBXqbbd7GDWxodAi4y/
	 nCkhNXVgvDRXUdcct9TF6OEuc+9TsHvSLjKOU6SeQB8Dps/57w8CQx9A7dR8e5te/v
	 PY26RykXWhyWZ+sVvYQ5ypt1UPoIdi8hjXkk9ZOrZlF248dBuJTNMuZAtsXNbskWsJ
	 9nSD+q5X8SfHVFtpYrjplf3kRqOrrlGXauwZeGXCdSAIbAeXLKoiaEWQ2dCACOfGoa
	 7hB5+wxhO34mmu5qsGe+0XTKhFDaBbLoVGkgIAeETeQ38kC1bnR/W1p7o50uH4Ju+U
	 9wav6g1gKFYLw==
Date: Tue, 2 Jul 2024 18:16:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V5 04/17] tools/perf: Add disasm_line__parse to parse raw
 instruction for powerpc
Message-ID: <ZoSmdSlEmZwyuq_b@google.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
 <20240701043430.66666-5-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701043430.66666-5-atrajeev@linux.vnet.ibm.com>

On Mon, Jul 01, 2024 at 10:04:17AM +0530, Athira Rajeev wrote:
> Currently, the perf tool infrastructure disasm_line__parse function to
> parse disassembled line.
> 
> Example snippet from objdump:
> objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>
> 
> c0000000010224b4:	lwz     r10,0(r9)
> 
> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> registers names and offset. In powerpc, the approach for data type
> profiling uses raw instruction instead of result from objdump to identify
> the instruction category and extract the source/target registers.
> 
> Example: 38 01 81 e8     ld      r4,312(r1)
> 
> Here "38 01 81 e8" is the raw instruction representation. Add function
> "disasm_line__parse_powerpc" to handle parsing of raw instruction.
> Also update "struct disasm_line" to save the binary code/
> With the change, function captures:
> 
> line -> "38 01 81 e8     ld      r4,312(r1)"
> raw instruction "38 01 81 e8"
> 
> Raw instruction is used later to extract the reg/offset fields. Macros
> are added to extract opcode and register fields. "struct disasm_line"
> is updated to carry union of "bytes" and "raw_insn" of 32 bit to carry raw
> code (raw). Function "disasm_line__parse_powerpc fills the raw
> instruction hex value and can use macros to get opcode. There is no
> changes in existing code paths, which parses the disassembled code.
> The size of raw instruction depends on architecture. In case of powerpc,
> the parsing the disasm line needs to handle cases for reading binary code
> directly from DSO as well as parsing the objdump result. Hence adding
> the logic into separate function instead of updating "disasm_line__parse".
> The architecture using the instruction name and present approach is
> not altered. Since this approach targets powerpc, the macro
> implementation is added for powerpc as of now.
> 
> Since the disasm_line__parse is used in other cases (perf annotate) and
> not only data tye profiling, the powerpc callback includes changes to
> work with binary code as well as mneumonic representation. Also in case
> if the DSO read fails and libcapstone is not supported, the approach
> fallback to use objdump as option. Hence as option, patch has changes to
> ensure objdump option also works well.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/include/linux/string.h                  |  2 +
>  tools/lib/string.c                            | 13 ++++
>  .../perf/arch/powerpc/annotate/instructions.c |  1 +
>  tools/perf/arch/powerpc/util/dwarf-regs.c     |  9 +++
>  tools/perf/util/annotate.h                    |  5 +-
>  tools/perf/util/disasm.c                      | 59 ++++++++++++++++++-
>  6 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> index db5c99318c79..0acb1fc14e19 100644
> --- a/tools/include/linux/string.h
> +++ b/tools/include/linux/string.h
> @@ -46,5 +46,7 @@ extern char * __must_check skip_spaces(const char *);
>  
>  extern char *strim(char *);
>  
> +extern void remove_spaces(char *s);
> +
>  extern void *memchr_inv(const void *start, int c, size_t bytes);
>  #endif /* _TOOLS_LINUX_STRING_H_ */
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index 8b6892f959ab..3126d2cff716 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -153,6 +153,19 @@ char *strim(char *s)
>  	return skip_spaces(s);
>  }
>  
> +/*
> + * remove_spaces - Removes whitespaces from @s
> + */
> +void remove_spaces(char *s)
> +{
> +	char *d = s;
> +
> +	do {
> +		while (*d == ' ')
> +			++d;
> +	} while ((*s++ = *d++));
> +}
> +
>  /**
>   * strreplace - Replace all occurrences of character in string.
>   * @s: The string to operate on.
> diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
> index a3f423c27cae..d57fd023ef9c 100644
> --- a/tools/perf/arch/powerpc/annotate/instructions.c
> +++ b/tools/perf/arch/powerpc/annotate/instructions.c
> @@ -55,6 +55,7 @@ static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		arch->initialized = true;
>  		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
>  		arch->objdump.comment_char      = '#';
> +		annotate_opts.show_asm_raw = true;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
> index 0c4f4caf53ac..430623ca5612 100644
> --- a/tools/perf/arch/powerpc/util/dwarf-regs.c
> +++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
> @@ -98,3 +98,12 @@ int regs_query_register_offset(const char *name)
>  			return roff->ptregs_offset;
>  	return -EINVAL;
>  }
> +
> +#define PPC_OP(op)	(((op) >> 26) & 0x3F)
> +#define PPC_RA(a)	(((a) >> 16) & 0x1f)
> +#define PPC_RT(t)	(((t) >> 21) & 0x1f)
> +#define PPC_RB(b)	(((b) >> 11) & 0x1f)
> +#define PPC_D(D)	((D) & 0xfffe)
> +#define PPC_DS(DS)	((DS) & 0xfffc)
> +#define OP_LD	58
> +#define OP_STD	62
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index d5c821c22f79..9ba772f46270 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -113,7 +113,10 @@ struct annotation_line {
>  struct disasm_line {
>  	struct ins		 ins;
>  	struct ins_operands	 ops;
> -
> +	union {
> +		u8 bytes[4];
> +		u32 raw_insn;
> +	} raw;
>  	/* This needs to be at the end. */
>  	struct annotation_line	 al;
>  };
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index d2723ba024bf..ddb861a0b043 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -44,6 +44,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
>  
>  static void ins__sort(struct arch *arch);
>  static int disasm_line__parse(char *line, const char **namep, char **rawp);
> +static int disasm_line__parse_powerpc(struct disasm_line *dl);
>  
>  static __attribute__((constructor)) void symbol__init_regexpr(void)
>  {
> @@ -845,6 +846,59 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
>  	return -1;
>  }
>  
> +/*
> + * Parses the result captured from symbol__disassemble_*
> + * Example, line read from DSO file in powerpc:
> + * line:    38 01 81 e8
> + * opcode: fetched from arch specific get_opcode_insn
> + * rawp_insn: e8810138
> + *
> + * rawp_insn is used later to extract the reg/offset fields
> + */
> +#define	PPC_OP(op)	(((op) >> 26) & 0x3F)
> +
> +static int disasm_line__parse_powerpc(struct disasm_line *dl)
> +{
> +	char *line = dl->al.line;
> +	const char **namep = &dl->ins.name;
> +	char **rawp = &dl->ops.raw;
> +	char tmp, *tmp_raw_insn, *name_raw_insn = skip_spaces(line);
> +	char *name = skip_spaces(name_raw_insn + 11);

What does 11 mean?  Can you add a macro for it instead?
I guess it's the width of the raw codes and spaces.


> +	int objdump = 0;
> +
> +	if (strlen(line) > 11)
> +		objdump = 1;
> +
> +	if (name_raw_insn[0] == '\0')
> +		return -1;
> +
> +	if (objdump) {
> +		*rawp = name + 1;
> +		while ((*rawp)[0] != '\0' && !isspace((*rawp)[0]))
> +			++*rawp;
> +		tmp = (*rawp)[0];
> +		(*rawp)[0] = '\0';
> +
> +		*namep = strdup(name);
> +		if (*namep == NULL)
> +			return -1;
> +
> +		(*rawp)[0] = tmp;
> +		*rawp = strim(*rawp);

Can we just call disasm_line__parse()?


> +	} else
> +		*namep = "";
> +
> +	tmp_raw_insn = strdup(name_raw_insn);
> +	tmp_raw_insn[11] = '\0';

You can use strndup().

Thanks,
Namhyung


> +	remove_spaces(tmp_raw_insn);
> +
> +	sscanf(tmp_raw_insn, "%x", &dl->raw.raw_insn);
> +	if (objdump)
> +		dl->raw.raw_insn = be32_to_cpu(dl->raw.raw_insn);
> +
> +	return 0;
> +}
> +
>  static void annotation_line__init(struct annotation_line *al,
>  				  struct annotate_args *args,
>  				  int nr)
> @@ -898,7 +952,10 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
>  		goto out_delete;
>  
>  	if (args->offset != -1) {
> -		if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
> +		if (arch__is(args->arch, "powerpc")) {
> +			if (disasm_line__parse_powerpc(dl) < 0)
> +				goto out_free_line;
> +		} else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
>  			goto out_free_line;
>  
>  		disasm_line__init_ins(dl, args->arch, &args->ms);
> -- 
> 2.43.0
> 
