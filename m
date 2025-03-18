Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B01E50E;
	Tue, 18 Mar 2025 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263563; cv=none; b=pOCHtLRp2huKm4onIkfeE8mkl9ICEKsC1LcyVLdgX4hyLnR5fhPd7McUopcvx4SWnqGBViv4dy9d1JXkO6DSrbtihVBdYekXag7lXVkHQR+ul0HAqlKmQtiyPzmfEZxLl1AkpiL8c0ILuQ1W8DkhBeV4KotmXEmBlB9HxZF+ZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263563; c=relaxed/simple;
	bh=BFd5y4dCY4Ff+fqcyWeon768yNTKhEyKUZxgJVN+Sdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKjvDvu87RSy94hhQqj4bAXVLNQv4TykIxrNRWUejVbKmQNuKYMOp2iqNrctOc9fV1MER0M7kOE3UEZrXjAMX6xgpzpZTdXs86BHikXbRDoDpxqPhwmyGVq4NMBUT5O0mtn/1w8JIDuqqxO2xmmEQn26ZMtnB2STDSrQDMCf2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyicySzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyicySzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF97DC4CEE3;
	Tue, 18 Mar 2025 02:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742263562;
	bh=BFd5y4dCY4Ff+fqcyWeon768yNTKhEyKUZxgJVN+Sdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyicySzusAnWspPQVmrJaNQnfrFX4Cc73KxxMdzEb7bmB04T1a+7rkp2R75pihYd8
	 NB0qHbLE2S+BtlnPtVk8UJeDyxJvZkwcz6Byspr4qD/xSgDSeyV+keJ4xmjixvuYh4
	 YVHixhvuyzVI3vuQ6AUWNwujUO3FsOTDFAP4+OHn1YYfA+oYmxl/K1owrfE/8XFNwA
	 V/FVU5gD8twtUFS3RwCa6vtXg/75Hu22+ipM/IVXtlAtN8w+ZA4sFm0vyY4QCZpbAb
	 LB++xWYqizbrpevR7isVbFLZw94WWOAgC9fJSXQv5tjNgevoWLB66CQZBCG5AAe3vg
	 BaRsJAnQRVzxA==
Date: Mon, 17 Mar 2025 19:06:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: acme@kernel.org, leo.yan@linux.dev, james.clark@linaro.org,
	mark.rutland@arm.com, john.g.garry@oracle.com, will@kernel.org,
	irogers@google.com, mike.leach@linaro.org, peterz@infradead.org,
	mingo@redhat.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, kjain@linux.ibm.com, mhiramat@kernel.org,
	atrajeev@linux.vnet.ibm.com, sesse@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 7/7] perf annotate-data: Handle the access to the
 'current' pointer on arm64
Message-ID: <Z9jVCFwf7Gbs6u22@google.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
 <20250314162137.528204-8-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314162137.528204-8-lihuafei1@huawei.com>

On Sat, Mar 15, 2025 at 12:21:37AM +0800, Li Huafei wrote:
> According to the implementation of the 'current' macro on ARM64, the
> sp_el0 register stores the pointer to the current task's task_struct.
> For example:
> 
>  mrs x1, sp_el0
>  ldr x2, [x1, #1896]

Same here.  It'd be great if you could share a real example where it
found the current for x1 in the second instruction.

> 
> We can infer that the ldr instruction is accessing a member of the
> task_struct structure at an offset of 1896. The key is to construct the
> data type for x1. The instruction 'mrs x1, sp_el0' belongs to the inline
> function get_current(). By finding the DIE of the inline function
> through its instruction address, and then obtaining the DIE for its
> return type, which should be 'struct task_struct *'. Then, we update the
> register state of x1 with this type information.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/arch/arm64/annotate/instructions.c | 71 +++++++++++++++----
>  1 file changed, 57 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
> index f2053e7f60a8..c5a0a6381547 100644
> --- a/tools/perf/arch/arm64/annotate/instructions.c
> +++ b/tools/perf/arch/arm64/annotate/instructions.c
> @@ -263,6 +263,20 @@ update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
>  	Dwarf_Die type_die;
>  	int sreg, dreg;
>  	u32 insn_offset = dl->al.offset;
> +	static regex_t add_regex, mrs_regex;
> +	static bool regex_compiled;
> +
> +	if (!regex_compiled) {
> +		/*
> +		 * Matching the operand assembly syntax of the add instruction:
> +		 *
> +		 *  <Xd|SP>, <Xn|SP>, #<imm>
> +		 */
> +		regcomp(&add_regex, "^([xw][0-9]{1,2}|sp), ([xw][0-9]{1,2}|sp), #(0x[0-9a-f]+)",
> +			REG_EXTENDED);
> +		regcomp(&mrs_regex, "^(x[0-9]{1,2}), sp_el0", REG_EXTENDED);
> +		regex_compiled = true;
> +	}
>  
>  	/* Access global variables via PC relative addressing, for example:
>  	 *
> @@ -296,20 +310,6 @@ update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
>  		regmatch_t match[4];
>  		char *ops = strdup(dl->ops.raw);
>  		u64 offset;
> -		static regex_t add_regex;
> -		static bool regex_compiled;
> -
> -		/*
> -		 * Matching the operand assembly syntax of the add instruction:
> -		 *
> -		 *  <Xd|SP>, <Xn|SP>, #<imm>
> -		 */
> -		if (!regex_compiled) {
> -			regcomp(&add_regex,
> -				"^([xw][0-9]{1,2}|sp), ([xw][0-9]{1,2}|sp), #(0x[0-9a-f]+)",
> -				REG_EXTENDED);
> -			regex_compiled = true;
> -		}
>  
>  		if (!ops)
>  			return;
> @@ -351,6 +351,49 @@ update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
>  		return;
>  	}
>  
> +	if (!strncmp(dl->ins.name, "mrs", 3)) {

It should be kernel specific, you may want to add a check for it like
__map__is_kernel(dloc->ms->map).

Thanks,
Namhyung


> +		regmatch_t match[2];
> +		char *ops = strdup(dl->ops.raw);
> +		Dwarf_Die func_die;
> +		Dwarf_Attribute attr;
> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (!ops)
> +			return;
> +
> +		if (regexec(&mrs_regex, dl->ops.raw, 2, match, 0))
> +			return;
> +
> +		ops[match[1].rm_eo] = '\0';
> +		sreg = get_arm64_regnum(ops + match[1].rm_so);
> +		if (sreg < 0 || !has_reg_type(state, sreg)) {
> +			free(ops);
> +			return;
> +		}
> +
> +		/*
> +		 * Find the inline function 'get_current()' Dwarf_Die and
> +		 * obtain its return value data type, which should be
> +		 * 'struct task_struct *'.
> +		 */
> +		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
> +		    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
> +		    !dwarf_formref_die(&attr, &type_die)) {
> +			free(ops);
> +			return;
> +		}
> +
> +		tsr = &state->regs[sreg];
> +		tsr->type = type_die;
> +		tsr->kind = TSR_KIND_TYPE;
> +		tsr->ok = true;
> +
> +		pr_debug_dtp("mrs sp_el0 [%x] -> reg%d", insn_offset, sreg);
> +		free(ops);
> +		return;
> +	}
> +
>  	if (strncmp(dl->ins.name, "ld", 2))
>  		return;
>  
> -- 
> 2.25.1
> 
