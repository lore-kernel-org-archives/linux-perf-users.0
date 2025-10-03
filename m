Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43D1A5BA2;
	Fri,  3 Oct 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759469838; cv=none; b=dq4pzvnWdAAUcdk0Sc7fYEz+hyst3tafCxfgyavLIasfO3dzRmgpRMuPjTasxo67JAzJ9ydXc/85MDgZjRgA2+ioZwgNF+8jQcHBZhHjxT/aDbuqpnSS1tW26LgbTjXBj1PlqfWOKdQn0A6S3lusLripPRBdCfLNQClxVlsSNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759469838; c=relaxed/simple;
	bh=fw5yY+AgwElqq2jHTlcr/t6GWNbcBGqskybH5Eqz+bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0M8kfjESUytzRZ3pPJhtMv5tkdJ151gTFnMHCXp0SlXvnFbrOKm3IPOsE3OUOhZd4u4/tQy6zwaClqyhk25ihgqqA6lHFg4hki6cEkORKZaQZ+AKriG1zhHsvmJlgXxYj6x9yWO/iRBa0iJ/mi6RIDeHvdZ83jcnjMClPqcpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P976rFmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P976rFmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277B8C4CEF5;
	Fri,  3 Oct 2025 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759469838;
	bh=fw5yY+AgwElqq2jHTlcr/t6GWNbcBGqskybH5Eqz+bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P976rFmygi8weU4QOhfQf3dAEVThAgO09+d03OgttYbIFfpEkVYYepgqSpauxI0Cd
	 3tAUz9cspA2uMZvOyF8ry3osTDMkkeCa2FcVP4gr2Y5TdglRKIgZElENWvcKNb8nQR
	 QJVFWDMtXRNsVxR5stSeJbIBF5AddT1aWEzGFYoNr1x+Sw1m5mjbuIJGdqiz66obV1
	 jMLL9eV6QNjIuVDh5DHuGMI0kwRhnmwtILBugT5VoShqyEMlxFHdFblecrQxTVc3O/
	 YqeKYzvknzDDMku9zY0R4YZqdBpsCvBnHbXeMO0yk1maIJEMsDIbruxB5KAwY0Czy0
	 vr+pnPvrUwchw==
Date: Fri, 3 Oct 2025 14:37:11 +0900
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
Subject: Re: [PATCH v3 02/10] perf annotate: Rename TSR_KIND_POINTER to
 TSR_KIND_PERCPU_POINTER
Message-ID: <aN9hByQIxqdefC8k@google.com>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-3-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917195808.2514277-3-zecheng@google.com>

On Wed, Sep 17, 2025 at 07:58:00PM +0000, Zecheng Li wrote:
> TSR_KIND_POINTER only represents percpu pointers currently. Rename it to
> TSR_KIND_PERCPU_POINTER so we can use the TSR_KIND_POINTER to represent
> pointer to a type.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/arch/x86/annotate/instructions.c | 4 ++--
>  tools/perf/util/annotate-data.c             | 6 +++---
>  tools/perf/util/annotate-data.h             | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index c6d403eae744..da98a4e3c52c 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -301,7 +301,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			 * as a pointer.
>  			 */
>  			tsr->type = type_die;
> -			tsr->kind = TSR_KIND_POINTER;
> +			tsr->kind = TSR_KIND_PERCPU_POINTER;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
> @@ -521,7 +521,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		}
>  		/* And then dereference the calculated pointer if it has one */
>  		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
> -			 state->regs[sreg].kind == TSR_KIND_POINTER &&
> +			 state->regs[sreg].kind == TSR_KIND_PERCPU_POINTER &&
>  			 die_get_member_type(&state->regs[sreg].type,
>  					     src->offset, &type_die)) {
>  			tsr->type = type_die;
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 258157cc43c2..903027a6fb7d 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -58,7 +58,7 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
>  	case TSR_KIND_CONST:
>  		pr_info(" constant\n");
>  		return;
> -	case TSR_KIND_POINTER:
> +	case TSR_KIND_PERCPU_POINTER:
>  		pr_info(" pointer");
>  		/* it also prints the type info */
>  		break;
> @@ -591,7 +591,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>  	switch (tag) {
>  	case DW_TAG_structure_type:
>  	case DW_TAG_union_type:
> -		stack->compound = (kind != TSR_KIND_POINTER);
> +		stack->compound = (kind != TSR_KIND_PERCPU_POINTER);
>  		break;
>  	default:
>  		stack->compound = false;
> @@ -1116,7 +1116,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		return PERF_TMR_OK;
>  	}
>  
> -	if (state->regs[reg].kind == TSR_KIND_POINTER) {
> +	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
>  		pr_debug_dtp("percpu ptr");
>  
>  		/*
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 541fee1a5f0a..dd3807b55208 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -34,7 +34,7 @@ enum type_state_kind {
>  	TSR_KIND_TYPE,
>  	TSR_KIND_PERCPU_BASE,
>  	TSR_KIND_CONST,
> -	TSR_KIND_POINTER,
> +	TSR_KIND_PERCPU_POINTER,
>  	TSR_KIND_CANARY,
>  };
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
