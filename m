Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A81714AA;
	Tue,  7 Apr 2026 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544206; cv=none; b=URL/cFkSOPfgb1CfVZfiLolXxnai3+Ee7EeZH/5sZ0aCrSMhw7uqt0Q9YxiX3og979STeY6h5nuTZfPfgjRObDHO3sIfDIsNTAp32hv/7VBzObIp0gS6XYHEfB4l4K+YlZ55NYcWxy/fkHBnreu2aX8ZS8z6nWqGH6zlcuQPKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544206; c=relaxed/simple;
	bh=RJY0OI3iws38tWzphXWx5YaOjiybb8QfQfQzYz02fl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCYQVKoPDC/qhpAINhXmY7VTD1zjF8HembfllJwyjsBBbvbNFH20Kbyr3ttaEtDd3DojsDvl+c1o3J3GAb3TiSyRYIvPPXAN8fd29P2jvcbt1bbMcDXxlqhsH6+/Fz6FJQ1nj4k/wWRmfPDIoI8IM4QU49PYMPmI7GoJH9pnCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL7lSwf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL7lSwf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00D4C116C6;
	Tue,  7 Apr 2026 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544206;
	bh=RJY0OI3iws38tWzphXWx5YaOjiybb8QfQfQzYz02fl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YL7lSwf/yk17uq3SkbXpqZfBMJW2OPXL8Vm7lYsBTtpUsVi4BvPM/k5Ki79rfZscg
	 WncoMY6GEbK0prfAVjETeiqnF0OHjLjsH3uXsl2phSD12p/qNrTjaSjTsJCGq1uLOW
	 CNscASMEjDxShlfegDEyP07OJ+RXN62Z73fQJ8DG8pvVTEX1BqjtiLWU5D9KtIXV+o
	 lSg6ExdG1W7HtbZBpxLB6YfZnEubJDfBp10fTulK1KIZodZBLvg58dLieb8vU09M7E
	 Gl/ZUWnc7DnNfoNg49YIZLtlaDWr2Y1iMpmjFATs4qfpFTvVSx2jP7X0cmfI5qv2z+
	 XPMGIQ+lGV61w==
Date: Mon, 6 Apr 2026 23:43:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 02/16] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
Message-ID: <adSnjABSDeeg-9O8@z2>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-3-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-3-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:46AM +0000, Tengda Wu wrote:
> The jump and adrp instructions parsed by libcapstone currently lack
> symbolic representation and use a '#' prefix for addresses. This
> format is inconsistent with objdump's output, which causes subsequent
> parsing in jump__parse() and arm64_mov__parse() to fail.
> 
> Example mismatch:
>   Current: b #0xffff8000800114c8
>   Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>
> 
>   Current: adrp x18, #0xffff800081f5f000
>   Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
> 
> Fix this by implementing extended formatting for these arm64
> instructions during symbol__disassemble_capstone(). This ensures
> the output matches objdump's expected style, including the raw
> address and the associated <symbol+offset> suffix.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/capstone.c | 107 ++++++++++++++++++++++++++++++++-----
>  tools/perf/util/disasm.c   |   5 ++
>  tools/perf/util/disasm.h   |   1 +
>  3 files changed, 101 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 25cf6e15ec27..1d8421d2d98c 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -255,10 +255,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  	struct map *map = args->ms->map;
>  	struct symbol *sym;
>  
> -	/* TODO: support more architectures */
> -	if (!arch__is_x86(args->arch))
> -		return;
> -
>  	if (insn->detail == NULL)
>  		return;
>  
> @@ -305,6 +301,98 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  	}
>  }
>  
> +static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
> +				     size_t len, struct annotate_args *args,
> +				     u64 addr)
> +{
> +	int printed;
> +
> +	printed = scnprintf(buf, len, "       %-7s %s",
> +			    insn->mnemonic, insn->op_str);
> +	buf += printed;
> +	len -= printed;
> +
> +	print_capstone_detail(insn, buf, len, args, addr);
> +}
> +
> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> +				       size_t len, struct annotate_args *args,
> +				       u64 addr)
> +{
> +	struct map *map = args->ms->map;
> +	struct symbol *sym;
> +	char *last_imm, *endptr;
> +	u64 orig_addr;
> +
> +	scnprintf(buf, len, "       %-7s %s",
> +		  insn->mnemonic, insn->op_str);
> +	/*
> +	 * Adjust instructions to keep the existing behavior with objdump.
> +	 *
> +	 * Example conversion:
> +	 * From: b #0xffff8000800114c8
> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
> +	 */
> +	switch (insn->id) {
> +	case ARM64_INS_B:
> +	case ARM64_INS_BL:
> +	case ARM64_INS_CBNZ:
> +	case ARM64_INS_CBZ:
> +	case ARM64_INS_TBNZ:
> +	case ARM64_INS_TBZ:
> +	case ARM64_INS_ADRP:
> +		/* Extract last immediate value as address */
> +		last_imm = strrchr(buf, '#');
> +		if (!last_imm)
> +			return;
> +
> +		orig_addr = strtoull(last_imm + 1, &endptr, 16);
> +		if (endptr == last_imm + 1)
> +			return;
> +
> +		/* Relocate map that contains the address */
> +		if (dso__kernel(map__dso(map))) {
> +			map = maps__find(map__kmaps(map), orig_addr);
> +			if (map == NULL)
> +				return;

I know you copied the logic from x86, but I've realized that it leaks a
refcount for the new kernel map returned from maps__find().  This needs
to be fixed separately.

Thanks,
Namhyung


> +		}
> +
> +		/* Convert it to map-relative address for search */
> +		addr = map__map_ip(map, orig_addr);
> +
> +		sym = map__find_symbol(map, addr);
> +		if (sym == NULL)
> +			return;
> +
> +		/* Symbolize the resolved address */
> +		len = len - (last_imm - buf);
> +		if (addr == sym->start) {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
> +				  orig_addr, sym->name);
> +		} else {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
> +				  orig_addr, sym->name, addr - sym->start);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void format_capstone_insn(struct cs_insn *insn, char *buf, size_t len,
> +				 struct annotate_args *args, u64 addr)
> +{
> +	/* TODO: support more architectures */
> +	if (arch__is_x86(args->arch))
> +		format_capstone_insn_x86(insn, buf, len, args, addr);
> +	else if (arch__is_arm64(args->arch))
> +		format_capstone_insn_arm64(insn, buf, len, args, addr);
> +	else {
> +		scnprintf(buf, len, "       %-7s %s",
> +			  insn->mnemonic, insn->op_str);
> +	}
> +}
> +
>  struct find_file_offset_data {
>  	u64 ip;
>  	u64 offset;
> @@ -381,14 +469,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>  
>  	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
>  	for (i = 0, offset = 0; i < count; i++) {
> -		int printed;
> -
> -		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
> -				    "       %-7s %s",
> -				    insn[i].mnemonic, insn[i].op_str);
> -		print_capstone_detail(&insn[i], disasm_buf + printed,
> -				      sizeof(disasm_buf) - printed, args,
> -				      start + offset);
> +		format_capstone_insn(&insn[i], disasm_buf,
> +				     sizeof(disasm_buf), args,
> +				     start + offset);
>  
>  		args->offset = offset;
>  		args->line = disasm_buf;
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 40fcaed5d0b1..988b2b748e11 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -202,6 +202,11 @@ bool arch__is_powerpc(const struct arch *arch)
>  	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
>  }
>  
> +bool arch__is_arm64(const struct arch *arch)
> +{
> +	return arch->id.e_machine == EM_AARCH64;
> +}
> +
>  static void ins_ops__delete(struct ins_operands *ops)
>  {
>  	if (ops == NULL)
> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> index a6e478caf61a..d3730ed86dba 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -111,6 +111,7 @@ struct annotate_args {
>  const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
>  bool arch__is_x86(const struct arch *arch);
>  bool arch__is_powerpc(const struct arch *arch);
> +bool arch__is_arm64(const struct arch *arch);
>  
>  extern const struct ins_ops call_ops;
>  extern const struct ins_ops dec_ops;
> -- 
> 2.34.1
> 
