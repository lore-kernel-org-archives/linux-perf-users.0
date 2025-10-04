Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEB1F0991;
	Sat,  4 Oct 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759564770; cv=none; b=Slo2PQNyPBOnTKsv/tP1vUhRVin5qKcH4oGzNaM6o7Bke8AI7HMbvlY8GbAsXVUFkxoqwc1WkIdM2C3wEGAImXqXapsfWCYBg99auXFEuot183nM41VVdr+aUmLAL39hXmKA2GPeFvvlB6fua+ZA7OqfEUrPau9MlOEAMHJeXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759564770; c=relaxed/simple;
	bh=yKyy0scNkiJnqPV9WLqsXEux2u3lsUbat9XsVLC6e9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP7lzJ1WwUUDltkuzI/CnWyiHSLYcJc4ZftDnXqxLd/54YeS8++G+zFB2CBSNTK6/iebvvDMGkaFBmXGS/XwKS2kvwmxVcfJnTk0fxepiJ/NgPX+sxam7jwSvhmoBknYSR9s/EXywaajYJ5gyG6mj55rKNE5WAlvFrGaDS/sJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m41aR5AJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m41aR5AJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0652FC4CEF1;
	Sat,  4 Oct 2025 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759564769;
	bh=yKyy0scNkiJnqPV9WLqsXEux2u3lsUbat9XsVLC6e9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m41aR5AJxzv8KmbEWdSX2nGRVNOVrC9TNBJOLVxt03sbuXJaR53miaiSqiyCj2A0k
	 IqWbIKzB2tqsBnGSEjPuAeODgZoTNMzJu2JKfkUM4oMvAB/wPw193iYrXpNZq6spUW
	 ePMFv25gSUKJ7Ycw6LxQ/BQMRMWCHWQQ/G4UOAQRvJnzrqNZHyuCk7w5Ms4seNvcd/
	 scR14eyIR4YkQzf1qYXYwvQ1sxGmVczCkDd6z4/1XppgBshY+8Z6dhnWYGopWITxhN
	 PbaFvYMN3XXaSKmtKmv5pI9RouUFQNNWtuPIFlDTzjgR9K5HyRFAKEqOcaq1XmiYor
	 BP8I0enQcTIpQ==
Date: Sat, 4 Oct 2025 16:59:24 +0900
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
Subject: Re: [PATCH v3 05/10] perf annotate: Save pointer offset in stack
 state
Message-ID: <aODT3BM5055oxTio@google.com>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-6-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917195808.2514277-6-zecheng@google.com>

On Wed, Sep 17, 2025 at 07:58:03PM +0000, Zecheng Li wrote:
> The tracked pointer offset was not being preserved in the stack state,
> which could lead to incorrect type analysis. This change adds a
> ptr_offset field to the type_state_stack struct and passes it to
> set_stack_state and findnew_stack_state to ensure the offset is
> preserved after the pointer is loaded from a stack location. It improves
> the type annotation coverage and quality.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/arch/x86/annotate/instructions.c |  8 ++++----
>  tools/perf/util/annotate-data.c             | 12 +++++++-----
>  tools/perf/util/annotate-data.h             |  7 +++++--
>  3 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index cfb07cff8fc8..709c6f7efe82 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -525,12 +525,12 @@ static void update_insn_state_x86(struct type_state *state,
>  			} else if (stack->kind == TSR_KIND_POINTER) {
>  				tsr->type = stack->type;
>  				tsr->kind = stack->kind;
> -				tsr->offset = 0;
> +				tsr->offset = stack->ptr_offset;
>  				tsr->ok = true;
>  			} else if (!stack->compound) {
>  				tsr->type = stack->type;
>  				tsr->kind = stack->kind;
> -				tsr->offset = 0;
> +				tsr->offset = stack->ptr_offset;
>  				tsr->ok = true;
>  			} else if (die_get_member_type(&stack->type,
>  						       offset - stack->offset,
> @@ -713,10 +713,10 @@ static void update_insn_state_x86(struct type_state *state,
>  				 */
>  				if (!stack->compound)
>  					set_stack_state(stack, offset, tsr->kind,
> -							&tsr->type);
> +							&tsr->type, tsr->offset);
>  			} else {
>  				findnew_stack_state(state, offset, tsr->kind,
> -						    &tsr->type);
> +						    &tsr->type, tsr->offset);
>  			}
>  
>  			if (dst->reg1 == fbreg) {
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 6ca5489f3c4c..68c69d343bff 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -577,7 +577,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
>  }
>  
>  void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
> -			    Dwarf_Die *type_die)
> +			    Dwarf_Die *type_die, int ptr_offset)
>  {
>  	int tag;
>  	Dwarf_Word size;
> @@ -592,6 +592,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>  	stack->type = *type_die;
>  	stack->size = size;
>  	stack->offset = offset;
> +	stack->ptr_offset = ptr_offset;
>  	stack->kind = kind;
>  
>  	switch (tag) {
> @@ -607,18 +608,19 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>  
>  struct type_state_stack *findnew_stack_state(struct type_state *state,
>  						    int offset, u8 kind,
> -						    Dwarf_Die *type_die)
> +						    Dwarf_Die *type_die,
> +						    int ptr_offset)
>  {
>  	struct type_state_stack *stack = find_stack_state(state, offset);
>  
>  	if (stack) {
> -		set_stack_state(stack, offset, kind, type_die);
> +		set_stack_state(stack, offset, kind, type_die, ptr_offset);
>  		return stack;
>  	}
>  
>  	stack = malloc(sizeof(*stack));
>  	if (stack) {
> -		set_stack_state(stack, offset, kind, type_die);
> +		set_stack_state(stack, offset, kind, type_die, ptr_offset);
>  		list_add(&stack->list, &state->stack_vars);
>  	}
>  	return stack;
> @@ -888,7 +890,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  				continue;
>  
>  			findnew_stack_state(state, offset, TSR_KIND_TYPE,
> -					    &mem_die);
> +					    &mem_die, /*ptr_offset=*/0);
>  
>  			if (var->reg == state->stack_reg) {
>  				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 20237e7e4e2f..e1e9c5f6915a 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -191,6 +191,8 @@ struct type_state_stack {
>  	struct list_head list;
>  	Dwarf_Die type;
>  	int offset;
> +	/* pointer offset, saves tsr->offset on the stack state */
> +	int ptr_offset;
>  	int size;
>  	bool compound;
>  	u8 kind;
> @@ -244,9 +246,10 @@ int annotated_data_type__get_member_name(struct annotated_data_type *adt,
>  bool has_reg_type(struct type_state *state, int reg);
>  struct type_state_stack *findnew_stack_state(struct type_state *state,
>  						int offset, u8 kind,
> -						Dwarf_Die *type_die);
> +						Dwarf_Die *type_die,
> +						int ptr_offset);
>  void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
> -				Dwarf_Die *type_die);
> +				Dwarf_Die *type_die, int ptr_offset);
>  struct type_state_stack *find_stack_state(struct type_state *state,
>  						int offset);
>  bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
