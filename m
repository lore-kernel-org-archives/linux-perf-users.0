Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1770A12F585;
	Wed, 11 Feb 2026 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776255; cv=none; b=d2KT8aSTXw1DebrKL0wwFQwZpirrsrwowgpN86ZuumapeeEhCG3+kOQV+UZYin5qxsEDAo3M0iVHkEn6S83eqA/P3xWyOO35FBmpktwCFA1NszILfg5LaUpIZ9hsIQOH4rwriq/zRxegZ1qDgF+noZd9aJGOPJgVqDOW2vae8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776255; c=relaxed/simple;
	bh=MX/rpXOAtEjZuAQXXD3gYEvKZJnfY3ZANy3baFvEn/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI3re5uvQ6RfDxUnTq1QyhZ8AMi02qfmieOfTP7q48oGkFqnYEFDg7CYJk/QxlM7gsuQsl/tuFXpSnWd7/tncntC0Y2sYiqTa4aoa3GVii4nI1DeZT46ah4lYFlgUNq1YkuOWMD1XU2uhRPPchE1PwqBsp8HfrhddErnlKD/e7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egE1E5gl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egE1E5gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333DAC116C6;
	Wed, 11 Feb 2026 02:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770776254;
	bh=MX/rpXOAtEjZuAQXXD3gYEvKZJnfY3ZANy3baFvEn/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egE1E5glVHw7VY6OMEbU7Uyd9KhEOXkdRGH2YPxiFrZy7SKCw7rLBCzgtFDxCSdVV
	 raFVa0Ew8oYbNNc17k01D7CGbOAiFrSIC6ximHpZhnpv27YaO+rRVc4vyhtTs25EjI
	 9lHOEKpHNM9WIJKghJ4Pds1HDDY7QOIF+rFUqsW0+O6lmqhPpClCLLof42J1ja7AG+
	 Mb+F5O6l+AVX8/JXyo+RIdHVNn7yR6GI8rgMzsziUQrZHfgmnTS8ZfIRamSBd5tP5l
	 dMtYgLbne3ZM6lGnfWPoB6nBcXb50waidoDHQrQPfaArTeppZY3DcasUaCCctsZOiv
	 4UQ/jZJCnPI0Q==
Date: Tue, 10 Feb 2026 18:17:32 -0800
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
Subject: Re: [PATCH v1 02/11] perf dwarf-aux: Add die_get_pointer_type to get
 pointer types
Message-ID: <aYvmvNUcoXpNOBW0@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-3-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-3-zli94@ncsu.edu>

On Mon, Jan 26, 2026 at 09:04:55PM -0500, Zecheng Li wrote:
> When a variable type is wrapped in typedef/qualifiers, callers may need
> to first resolve it to the underlying DW_TAG_pointer_type or
> DW_TAG_array_type. A simple tag check is not enough and directly calling
> __die_get_real_type() can stop at the pointer type (e.g. typedef ->
> pointer) instead of the pointee type.
> 
> Add die_get_pointer_type() helper that follows typedef/qualifier chains
> and returns the underlying pointer DIE. Use it in annotate-data.c so
> pointer checks and dereference work correctly for typedef'd pointers.
> 
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/annotate-data.c | 39 +++++++++++++++++++--------------
>  tools/perf/util/dwarf-aux.c     | 27 +++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h     |  2 ++
>  3 files changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 99ffc6d70565..8ff1972981b7 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -455,13 +455,6 @@ static const char *match_result_str(enum type_match_result tmr)
>  	}
>  }
>  
> -static bool is_pointer_type(Dwarf_Die *type_die)
> -{
> -	int tag = dwarf_tag(type_die);
> -
> -	return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
> -}
> -
>  static bool is_compound_type(Dwarf_Die *type_die)
>  {
>  	int tag = dwarf_tag(type_die);
> @@ -474,19 +467,24 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
>  {
>  	Dwarf_Word size_a, size_b;
>  	Dwarf_Die die_a, die_b;
> +	Dwarf_Die ptr_a, ptr_b;
> +	Dwarf_Die *ptr_type_a, *ptr_type_b;
> +
> +	ptr_type_a = die_get_pointer_type(type_a, &ptr_a);
> +	ptr_type_b = die_get_pointer_type(type_b, &ptr_b);
>  
>  	/* pointer type is preferred */
> -	if (is_pointer_type(type_a) != is_pointer_type(type_b))
> -		return is_pointer_type(type_b);
> +	if ((ptr_type_a != NULL) != (ptr_type_b != NULL))
> +		return ptr_type_b != NULL;
>  
> -	if (is_pointer_type(type_b)) {
> +	if (ptr_type_b) {
>  		/*
>  		 * We want to compare the target type, but 'void *' can fail to
>  		 * get the target type.
>  		 */
> -		if (die_get_real_type(type_a, &die_a) == NULL)
> +		if (die_get_real_type(ptr_type_a, &die_a) == NULL)
>  			return true;
> -		if (die_get_real_type(type_b, &die_b) == NULL)
> +		if (die_get_real_type(ptr_type_b, &die_b) == NULL)
>  			return false;
>  
>  		type_a = &die_a;
> @@ -539,7 +537,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
>  	 * and local variables are accessed directly without a pointer.
>  	 */
>  	if (needs_pointer) {
> -		if (!is_pointer_type(type_die) ||
> +		if (die_get_pointer_type(type_die, type_die) == NULL ||
>  		    __die_get_real_type(type_die, type_die) == NULL)
>  			return PERF_TMR_NO_POINTER;
>  	}
> @@ -880,12 +878,16 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  			continue;
>  
>  		if (var->reg == DWARF_REG_FB || var->reg == fbreg || var->reg == state->stack_reg) {
> +			Dwarf_Die ptr_die;
> +			Dwarf_Die *ptr_type;
>  			int offset = var->offset;
>  			struct type_state_stack *stack;
>  
> +			ptr_type = die_get_pointer_type(&mem_die, &ptr_die);
> +
>  			/* If the reg location holds the pointer value, dereference the type */
> -			if (!var->is_reg_var_addr && is_pointer_type(&mem_die) &&
> -				__die_get_real_type(&mem_die, &mem_die) == NULL)
> +			if (!var->is_reg_var_addr && ptr_type &&
> +			    __die_get_real_type(ptr_type, &mem_die) == NULL)
>  				continue;
>  
>  			if (var->reg != DWARF_REG_FB)
> @@ -1110,7 +1112,9 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		goto check_non_register;
>  
>  	if (state->regs[reg].kind == TSR_KIND_TYPE) {
> +		Dwarf_Die ptr_die;
>  		Dwarf_Die sized_type;
> +		Dwarf_Die *ptr_type;
>  		struct strbuf sb;
>  
>  		strbuf_init(&sb, 32);
> @@ -1122,7 +1126,8 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		 * Normal registers should hold a pointer (or array) to
>  		 * dereference a memory location.
>  		 */
> -		if (!is_pointer_type(&state->regs[reg].type)) {
> +		ptr_type = die_get_pointer_type(&state->regs[reg].type, &ptr_die);
> +		if (!ptr_type) {
>  			if (dloc->op->offset < 0 && reg != state->stack_reg)
>  				goto check_kernel;
>  
> @@ -1130,7 +1135,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		}
>  
>  		/* Remove the pointer and get the target type */
> -		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
> +		if (__die_get_real_type(ptr_type, type_die) == NULL)
>  			return PERF_TMR_NO_POINTER;
>  
>  		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index b57cdc8860f0..96cfcbd40c45 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -303,6 +303,33 @@ Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>  	return vr_die;
>  }
>  
> +/**
> + * die_get_pointer_type - Get a pointer/array type die
> + * @type_die: a DIE of a type
> + * @die_mem: where to store a type DIE
> + *
> + * Get a pointer/array type DIE from @type_die. If the type is a typedef or
> + * qualifier (const, volatile, etc.), follow the chain to find the underlying
> + * pointer type.
> + */
> +Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
> +{
> +	int tag;
> +
> +	do {
> +		tag = dwarf_tag(type_die);
> +		if (tag == DW_TAG_pointer_type || tag == DW_TAG_array_type)
> +			return type_die;
> +		if (tag != DW_TAG_typedef && tag != DW_TAG_const_type &&
> +		    tag != DW_TAG_restrict_type && tag != DW_TAG_volatile_type &&
> +		    tag != DW_TAG_shared_type)
> +			return NULL;
> +		type_die = die_get_type(type_die, die_mem);
> +	} while (type_die);
> +
> +	return NULL;
> +}
> +
>  /* Get attribute and translate it as a udata */
>  static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
>  			      Dwarf_Word *result)
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index b3ee5df0b6be..8045281f219c 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -60,6 +60,8 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
>  Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
>  /* Get a type die, but skip qualifiers and typedef */
>  Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
> +/* Get a pointer/array type, following typedefs/qualifiers */
> +Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem);
>  
>  /* Check whether the DIE is signed or not */
>  bool die_is_signed_type(Dwarf_Die *tp_die);
> -- 
> 2.52.0
> 
