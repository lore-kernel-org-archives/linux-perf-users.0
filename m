Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE0335C7;
	Sat, 30 Aug 2025 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756516956; cv=none; b=Lvte3qjnHw8ntD8OapJO7yL8oXT6gAe0a9sfg8i7WF0zA0LbF0UcOW3JWQtx2oNYIcAActACNp0Ngl5xpCo26EF2E4DeZGKGb2QNUuFyYXkz3RpExweZn4bS+ouXUBITPVHT5D1+RlGH182hekIoz/YpjkI/oR9+eVrp2k5HIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756516956; c=relaxed/simple;
	bh=qOurC+VJB+2ixWBbyJM/u92wS1KcJxbfjFpqm3Cc684=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2bf1JlVhby3aSuMwnXuei0/JHrixpjtIEbV2sDCyqXVllqHNaJ0Kld31a16zNQtMkaEMcQHd2y+++K6a+mBrF7R+lboQKYt6RRebJlxgIdDwuUdae8PJFwWrgxWmUQ2LVckbePwePIUpJpE3PR7Of/l+ro4AS5t+/y19r6Ies0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNJQ2H3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNJQ2H3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C35C4CEF0;
	Sat, 30 Aug 2025 01:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756516955;
	bh=qOurC+VJB+2ixWBbyJM/u92wS1KcJxbfjFpqm3Cc684=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNJQ2H3R3QrjSLAOUimiwD/yquKQrJ4yqY4Zj/axKpRUHhtDtpNTdxNZADyV6jMf0
	 atSLurelIpS6rRfjmaUSfR12FyJPJX/1rw6Qb3/QhiVHpU/VliDrhle3EHg83Cv60G
	 w3KRtgUq+O97/L3b1j9vfFgfbetdnMG36Ii92F1BZiyJBNUQjS/dWkB6VjMpgSKWzu
	 edVuM/jHpiCqFsyMcznjZ8drBtDX6CC70BWergPKMRpY/KgmRWR01YbAntc37W/DLK
	 7KnozHrBaKYrHIJ5nhH3wuzh97psDgCWQbCmkzlar+et+H6Ucj7UoJYv89E09yjqzk
	 iO/N58XzvJDEw==
Date: Fri, 29 Aug 2025 18:22:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] perf dwarf-aux: Better variable collection for
 insn tracking
Message-ID: <aLJSWXAUVBqSFYPL@google.com>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-4-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195412.223077-4-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:54:05PM +0000, Zecheng Li wrote:
> Utilizes the previous is_breg_access_indirect function to determine if
> the register + offset stores the variable itself or the struct it points
> to, save the information in die_var_type.is_reg_var_addr.
> 
> Since we are storing the real types in the stack state, we need to do a
> type dereference when is_reg_var_addr is set to false for stack/frame
> registers.
> 
> For other gp registers, skip the variable when the register is a pointer
> to the type. If we want to accept these variables, we might also utilize
> is_reg_var_addr in a different way, we need to mark that register as a
> pointer to the type.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/annotate-data.c |  9 +++++++++
>  tools/perf/util/dwarf-aux.c     | 11 ++++++++++-
>  tools/perf/util/dwarf-aux.h     |  2 ++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 1ef2edbc71d9..258157cc43c2 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -868,6 +868,11 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  			int offset = var->offset;
>  			struct type_state_stack *stack;
>  
> +			/* If the reg location holds the pointer value, dereference the type */
> +			if (!var->is_reg_var_addr && is_pointer_type(&mem_die) &&
> +				__die_get_real_type(&mem_die, &mem_die) == NULL)
> +				continue;
> +
>  			if (var->reg != DWARF_REG_FB)
>  				offset -= fb_offset;
>  
> @@ -893,6 +898,10 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  
>  			reg = &state->regs[var->reg];
>  
> +			/* For gp registers, skip the address registers for now */
> +			if (var->is_reg_var_addr)
> +				continue;
> +
>  			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
>  			    !is_better_type(&reg->type, &mem_die))
>  				continue;
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 449bc9ad7aff..6fd2db5d9381 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1627,13 +1627,22 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	if (!check_allowed_ops(ops, nops))
>  		return DIE_FIND_CB_SIBLING;
>  
> -	if (die_get_real_type(die_mem, &type_die) == NULL)
> +	if (__die_get_real_type(die_mem, &type_die) == NULL)
>  		return DIE_FIND_CB_SIBLING;
>  
>  	vt = malloc(sizeof(*vt));
>  	if (vt == NULL)
>  		return DIE_FIND_CB_END;
>  
> +	/* Usually a register holds the value of a variable */
> +	vt->is_reg_var_addr = false;
> +
> +	if (((ops->atom >= DW_OP_breg0 && ops->atom <= DW_OP_breg31) ||
> +	      ops->atom == DW_OP_bregx || ops->atom == DW_OP_fbreg) &&
> +	      !is_breg_access_indirect(ops, nops))
> +		/* The register contains an address of the variable. */
> +		vt->is_reg_var_addr = true;
> +
>  	vt->die_off = dwarf_dieoffset(&type_die);
>  	vt->addr = start;
>  	vt->reg = reg_from_dwarf_op(ops);
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 892c8c5c23fc..cd481ec9c5a1 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -148,6 +148,8 @@ struct die_var_type {
>  	u64 addr;
>  	int reg;
>  	int offset;
> +	/* Whether the register holds a address to the type */
> +	bool is_reg_var_addr;
>  };
>  
>  /* Return type info of a member at offset */
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
