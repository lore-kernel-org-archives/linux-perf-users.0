Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77149285CBA;
	Wed, 11 Feb 2026 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770777533; cv=none; b=izJ+jhA3bB7FYfzq9KNxb8A1Qke6DZd+Hy95UDVKQXf+rzZcSiEqmCC6YlEW5MzPap3GvlxLBWGdcS3m3kmh1+RGd0GHojlFAELS1jpv2j67JHN6wabJ451jVrwchHHpDj0HZdUklOc+XBc9lzfikej5/SBKi3Ycdkyo8n/Wkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770777533; c=relaxed/simple;
	bh=PHLJDNEQFO5vcpi6AmfsHxM3tQvzp7JIkMxGC0mzxyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXinzYNwt+eD93zvdb9Blvh6pa0sAQoNvN52/CMG//DgByDkhaqTIKoRWvgdldhgjD/3FjqwYYifTyc0ezqTd419LhJpM3iD3oam8YTS++9ZsxzO2Jilc7/rrTtsF2tRkmhaxxNTu+U7GFhcWMvY13adcjIEb7i6npnV4o+vQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8evlw95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8evlw95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AD4C116C6;
	Wed, 11 Feb 2026 02:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770777533;
	bh=PHLJDNEQFO5vcpi6AmfsHxM3tQvzp7JIkMxGC0mzxyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8evlw95i5huU3069zQgoaHrnFZQex56Q3xZ4tcrQ1nMLR0gXdPqRuwNE894ix0fq
	 wc1mJ31b5MWdxeYAzZMncJSj1As/DGaDE5+dr6WVJ3HaCDiYj8QmPBzVLLKQX2hFBC
	 RtZ9Ww6ZZ638ZnaPO+BAHi3LTYkTmi+y7Wfx4XAK1JaQi+ELsHER+nX5VViJcolBmu
	 tTnuyoPkfCIcRMVuylYqIB4rcRiPAcQipjXZsbP+XWvjsQK2A1qvRnMO/qiK6y4gTj
	 jGO3hmL9GHzICjgeVYaJSFbid14sdfzqS/GgmtFEJ5SdaYTv+FWHHYw4jBeGwIpeKd
	 3MZvXu+TtJySw==
Date: Tue, 10 Feb 2026 18:38:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/11] perf annotate-data: Add invalidate_reg_state()
 helper for x86
Message-ID: <aYvruzvtA5lVam24@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-9-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-9-zli94@ncsu.edu>

On Mon, Jan 26, 2026 at 09:05:01PM -0500, Zecheng Li wrote:
> Add a helper function to consistently invalidate register state instead
> of field assignments. This ensures kind, ok, and copied_from are all
> properly cleared when a register becomes invalid.
> 
> The helper sets:
> - kind = TSR_KIND_INVALID
> - ok = false
> - copied_from = -1
> 
> Replace all invalidation patterns with calls to this helper. No
> functional change and this removes some incorrect annotations that were
> caused by incomplete invalidation (e.g. a obsolete copied_from from an
> invalidated register).

It doesn't apply cleanly from here.  Please rebase onto the current
perf-tools-next.  Maybe we want to wait for v7.0-rc1.

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 29 ++++++++++++---------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 803f9351a3fb..e033abb0667b 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -209,6 +209,13 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
>  }
>  
>  #ifdef HAVE_LIBDW_SUPPORT
> +static void invalidate_reg_state(struct type_state_reg *reg)
> +{
> +	reg->kind = TSR_KIND_INVALID;
> +	reg->ok = false;
> +	reg->copied_from = -1;
> +}
> +
>  static void update_insn_state_x86(struct type_state *state,
>  				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
>  				  struct disasm_line *dl)
> @@ -240,7 +247,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		/* Otherwise invalidate caller-saved registers after call */
>  		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
>  			if (state->regs[i].caller_saved)
> -				state->regs[i].ok = false;
> +				invalidate_reg_state(&state->regs[i]);
>  		}
>  
>  		/* Update register with the return type (if any) */
> @@ -369,8 +376,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		src_tsr = state->regs[sreg];
>  		tsr = &state->regs[dst->reg1];
>  
> -		tsr->copied_from = -1;
> -		tsr->ok = false;
> +		invalidate_reg_state(tsr);
>  
>  		/* Case 1: Based on stack pointer or frame pointer */
>  		if (sreg == fbreg || sreg == state->stack_reg) {
> @@ -438,8 +444,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
>  			pr_debug_dtp("%s [%x] invalidate reg%d\n",
>  						dl->ins.name, insn_offset, dst->reg1);
> -			state->regs[dst->reg1].ok = false;
> -			state->regs[dst->reg1].copied_from = -1;
> +			invalidate_reg_state(&state->regs[dst->reg1]);
>  			return;
>  		}
>  
> @@ -501,7 +506,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			if (!get_global_var_type(cu_die, dloc, ip, var_addr,
>  						 &offset, &type_die) ||
>  			    !die_get_member_type(&type_die, offset, &type_die)) {
> -				tsr->ok = false;
> +				invalidate_reg_state(tsr);
>  				return;
>  			}
>  
> @@ -529,7 +534,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  		if (!has_reg_type(state, src->reg1) ||
>  		    !state->regs[src->reg1].ok) {
> -			tsr->ok = false;
> +			invalidate_reg_state(tsr);
>  			return;
>  		}
>  
> @@ -565,7 +570,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			stack = find_stack_state(state, offset);
>  			if (stack == NULL) {
> -				tsr->ok = false;
> +				invalidate_reg_state(tsr);
>  				return;
>  			} else if (!stack->compound) {
>  				tsr->type = stack->type;
> @@ -580,7 +585,7 @@ static void update_insn_state_x86(struct type_state *state,
>  				tsr->offset = 0;
>  				tsr->ok = true;
>  			} else {
> -				tsr->ok = false;
> +				invalidate_reg_state(tsr);
>  				return;
>  			}
>  
> @@ -633,7 +638,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
>  						 &type_die) ||
>  			    !die_get_member_type(&type_die, offset, &type_die)) {
> -				tsr->ok = false;
> +				invalidate_reg_state(tsr);
>  				return;
>  			}
>  
> @@ -684,7 +689,7 @@ static void update_insn_state_x86(struct type_state *state,
>  				}
>  				pr_debug_type_name(&tsr->type, tsr->kind);
>  			} else {
> -				tsr->ok = false;
> +				invalidate_reg_state(tsr);
>  			}
>  		}
>  		/* And then dereference the calculated pointer if it has one */
> @@ -726,7 +731,7 @@ static void update_insn_state_x86(struct type_state *state,
>  				}
>  			}
>  
> -			tsr->ok = false;
> +			invalidate_reg_state(tsr);
>  		}
>  	}
>  	/* Case 3. register to memory transfers */
> -- 
> 2.52.0
> 
