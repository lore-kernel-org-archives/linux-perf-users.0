Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EE2C21FD;
	Sat, 19 Sep 2026 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801428; cv=none; b=k+ka1CVGpmPYBc0JyBL6uGul3PUkznyJyq4A3DG8Va/T70LJ4/iRmSt3o64p1Nvfetm6Z7yJ2ACnDO8z+YdXo8KUvwom2Fh6WRJO73tF0jMmVRvWeTpBR2tiI1xWbd8hSKx6T0L0hb5zRd25ntM9Dm5jIUI4RXHYBVMz1uGOya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801428; c=relaxed/simple;
	bh=LWRyaZ44XljSR9jxQv3acIBnOOGAgp2Vi33pxZ4cD0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyWgYfqdAj++MB9btXfNZaJnQ215X6VQvZ55GIEDB+zFWOERnulfqsRTcJzCeHqe05d6sI+G56P7pTFbpFJ8SNi+ObJI0ZiazVs/KHgqC655nez28oM95/PEZbkihzxiNaLFYAtTV4H7Qr7bf4dIHBsuqp3C4vgfGtBR5/Rpwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeCuMhWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeCuMhWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3471F000FF;
	Sat, 19 Sep 2026 07:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789801426;
	bh=ZjI8IPAelepUjiCCM+OPeA1jrtf3VHP4NxfAAMWbDW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NeCuMhWkTtNpuj93/Mf8LSBBWxiiyErqaWb05sh3vdSINboLcrs53uDF0LIHcFYYY
	 cUskVbNQ1h5cvQMBd9ZTSqKG+jPPwtRxuwj4M8q3cgPRcXm4zBdrP2tzd3peQLiR0e
	 BwQBjknaNE7pcSflIBI+MwDEKD7+Wp0yVDkoMlRwboMPel6vRLhfFrNAgeDgGIgPfs
	 kfp7y/xqyhzcBmWob7QwPllrvulsDkbJTUZ5usIPiZOk6To7CbRRqPTh8YfWoU4mVA
	 lGBmvdc3jAtioRU8CVqlqmRgHApVdqG9d0jUC2CB3TAEpYFH7MKTly23WgbrCTdfm+
	 hL6fb+785aI8g==
Date: Sat, 19 Sep 2026 00:03:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 01/26] perf capstone: Symbolize address operands to
 match objdump on arm64
Message-ID: <aq4z0DB-qNYt19OI@z2>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <6055eabaa63f43fffb67e7e5ca6f70d997a3faa9.1789521520.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6055eabaa63f43fffb67e7e5ca6f70d997a3faa9.1789521520.git.wutengda@huaweicloud.com>

On Wed, Sep 16, 2026 at 01:29:15AM +0000, Tengda Wu wrote:
> Capstone currently outputs address-bearing instructions with a raw hex
> value prefixed by '#', without symbolic resolution. This differs from
> objdump output and leads to parse failures in jump__parse() and
> arm64_mov__parse() on arm64.
> 
> Example of the mismatch:
>   Current: b #0xffff8000800114c8
>   Objdump: b ffff8000800114c8 <el0t_64_sync+0x108>
> 
>   Current: adrp x18, #0xffff800081f5f000
>   Objdump: adrp x18, ffff800081f5f000 <this_cpu_vector>
> 
> Fix this by extending symbol__disassemble_capstone() to:
> - Enable CS_OPT_DETAIL for arm64 to access instruction group info.
> - Detect instructions with address operands requiring symbolization
>   (jump/call/branch/adr/adrp) via opcode or Capstone group ID.
> - Resolve target addresses to symbols via find_symbol_from_addr().
> - Format output to match objdump's style (strip '#' prefix, add
>   symbol and offset).
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/capstone.c | 186 ++++++++++++++++++++++++++++++-------
>  tools/perf/util/disasm.c   |   5 +
>  tools/perf/util/disasm.h   |   1 +
>  3 files changed, 157 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 74213daf8786..95881f15324a 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -3,6 +3,7 @@
>  
>  #include <errno.h>
>  #include <inttypes.h>
> +#include <stdlib.h>
>  #include <string.h>
>  
>  #include <dlfcn.h>
> @@ -31,6 +32,10 @@
>  #define CS_MODE_RISCVC   4
>  #endif
>  
> +#if CS_VERSION_MAJOR < 4
> +#define ARM64_GRP_BRANCH_RELATIVE  7  /* = CS_GRP_BRANCH_RELATIVE */
> +#endif
> +
>  #ifdef LIBCAPSTONE_DLOPEN
>  static void *perf_cs_dll_handle(void)
>  {
> @@ -225,6 +230,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
>  		 * on x86 by investigating instruction details.
>  		 */
>  		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> +	} else if (arch == CS_ARCH_ARM64) {
> +		/*
> +		 * Same as x86: arm64 needs instruction details to resolve
> +		 * symbolic addresses.
> +		 */
> +		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>  	}
>  
>  	return 0;
> @@ -292,6 +303,40 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *threa
>  	return printed;
>  }
>  
> +static struct symbol *find_symbol_from_addr(struct map *map, u64 addr,
> +					    struct map **found_map, u64 *sym_offset)
> +{
> +	struct symbol *sym;
> +	u64 al_addr;
> +	u64 ip = map__objdump_2mem(map, addr);
> +
> +	*found_map = NULL;
> +	if (dso__kernel(map__dso(map))) {
> +		/*
> +		 * The kernel maps can be split into sections, let's
> +		 * find the map first and then search the symbol.
> +		 */
> +		*found_map = maps__find(map__kmaps(map), ip);
> +		if (*found_map == NULL)
> +			return NULL;
> +		map = *found_map;
> +	}
> +
> +	/* convert it to map-relative address for search */
> +	al_addr = map__map_ip(map, ip);
> +
> +	sym = map__find_symbol(map, al_addr);
> +
> +	if (sym == NULL) {
> +		map__put(*found_map);
> +		*found_map = NULL;
> +		return NULL;
> +	}
> +
> +	*sym_offset = al_addr - sym->start;
> +	return sym;
> +}
> +
>  static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  				  struct annotate_args *args, u64 addr)
>  {
> @@ -299,17 +344,14 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
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
>  	for (i = 0; i < insn->detail->x86.op_count; i++) {
>  		struct cs_x86_op *op = &insn->detail->x86.operands[i];
>  		u64 orig_addr;
> -		struct map *found_map = NULL;
> +		struct map *found_map;
> +		u64 sym_offset;
>  
>  		if (op->type != X86_OP_MEM)
>  			continue;
> @@ -320,40 +362,119 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  
>  		/* get the target address */
>  		orig_addr = addr + insn->size + op->mem.disp;
> -		addr = map__objdump_2mem(map, orig_addr);
> -
> -		if (dso__kernel(map__dso(map))) {
> -			/*
> -			 * The kernel maps can be split into sections, let's
> -			 * find the map first and then search the symbol.
> -			 */
> -			found_map = maps__find(map__kmaps(map), addr);
> -			if (found_map == NULL)
> -				continue;
> -			map = found_map;
> -		}
> -
> -		/* convert it to map-relative address for search */
> -		addr = map__map_ip(map, addr);
> -
> -		sym = map__find_symbol(map, addr);
> -		if (sym == NULL) {
> -			map__put(found_map);
> +		sym = find_symbol_from_addr(map, orig_addr, &found_map, &sym_offset);
> +		if (sym == NULL)
>  			continue;
> -		}
>  
> -		if (addr == sym->start) {
> +		if (sym_offset == 0) {
>  			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
>  				  orig_addr, sym->name);
>  		} else {
>  			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
> -				  orig_addr, sym->name, addr - sym->start);
> +				  orig_addr, sym->name, sym_offset);
>  		}
>  		map__put(found_map);
>  		break;
>  	}
>  }
>  
> +static int print_default_format(struct cs_insn *insn, char *buf, size_t len)
> +{
> +	return scnprintf(buf, len, "       %-7s %s",
> +			 insn->mnemonic, insn->op_str);
> +}
> +
> +static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
> +				     size_t len, struct annotate_args *args,
> +				     u64 addr)
> +{
> +	int printed;
> +
> +	printed = print_default_format(insn, buf, len);
> +	buf += printed;
> +	len -= printed;
> +
> +	print_capstone_detail(insn, buf, len, args, addr);
> +}
> +
> +static bool needs_symbolic_address(struct cs_insn *insn)
> +{
> +	int i;
> +
> +	if (insn->id == ARM64_INS_ADR || insn->id == ARM64_INS_ADRP)
> +		return true;
> +
> +	if (insn->detail == NULL)
> +		return false;
> +
> +	for (i = 0; i < insn->detail->groups_count; i++) {
> +		if (insn->detail->groups[i] == ARM64_GRP_JUMP ||
> +		    insn->detail->groups[i] == ARM64_GRP_CALL ||
> +		    insn->detail->groups[i] == ARM64_GRP_BRANCH_RELATIVE)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> +				       size_t len, struct annotate_args *args)
> +{
> +	struct map *map = args->ms->map;
> +	char *last_imm, *endptr;
> +	u64 addr;
> +
> +	print_default_format(insn, buf, len);
> +	/*
> +	 * Adjust instructions to keep the existing behavior with objdump.
> +	 *
> +	 * Example conversion:
> +	 * From: b #0xffff8000800114c8
> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
> +	 */
> +	if (needs_symbolic_address(insn)) {
> +		struct symbol *sym;
> +		struct map *found_map;
> +		u64 sym_offset;
> +
> +		/* Extract last immediate value as address */
> +		last_imm = strrchr(buf, '#');
> +		if (!last_imm)
> +			return;
> +
> +		addr = strtoull(last_imm + 1, &endptr, 16);
> +		if (endptr == last_imm + 1)
> +			return;
> +
> +		sym = find_symbol_from_addr(map, addr, &found_map, &sym_offset);
> +		if (sym == NULL)
> +			return;
> +
> +		/* Symbolize the resolved address */
> +		len = len - (last_imm - buf);
> +		if (sym_offset == 0) {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
> +				  addr, sym->name);
> +		} else {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
> +				  addr, sym->name, sym_offset);
> +		}
> +		map__put(found_map);
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
> +		format_capstone_insn_arm64(insn, buf, len, args);
> +	else
> +		print_default_format(insn, buf, len);
> +}
> +
>  struct find_file_offset_data {
>  	u64 ip;
>  	u64 offset;
> @@ -446,14 +567,9 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
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
> index 49c206a88eec..b39636ec35c1 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -214,6 +214,11 @@ bool arch__is_powerpc(const struct arch *arch)
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
> index adbdbf8f1f35..3a42166f7f49 100644
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
