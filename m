Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0F136E;
	Sun, 27 Jul 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753575264; cv=none; b=ZywGG7UzRaiPl3Ss859pXwxRx5Qa43Iu3oDMgqS51X2BotZ8/qeOKps1Sfv3gUR4YFDouw2YFfFEVyo1LWqrQiseT34vik6l310pcgDebHWOGvF423WsvTVZPfCeM7SoUjrvmNYSqSZE0KIMAXm1tXbJyoNbiY5w6ALnmAlNiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753575264; c=relaxed/simple;
	bh=ukscT8AwrK2UiPF5DnhJllXp6Kkrtbm1HKAOqueD3IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2D33FGe0ed7sEEBM4sKIbN7Mnr+a39g5Anh3OJBf/l9Cvtpfd/ec09+243L9TdrMEs2jWhTuj59QbURhI8sn4mzdpttos7jx8q9hZgpBtbynJQuoCHft3UafcbJ+VBFFC84KH2Z7aQ6gkxo3vOPX+nrMyQk8VlCFkSglCHKq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM7GRd4R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM7GRd4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB35C4CEED;
	Sun, 27 Jul 2025 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753575263;
	bh=ukscT8AwrK2UiPF5DnhJllXp6Kkrtbm1HKAOqueD3IA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM7GRd4ROpAc8Wn3jZt5VavXRh9CxGbESF9JwFs/G6WaoxJbFCiX6+x71GdIHRazp
	 GgZEjlxSWEElW6Vd+ouxkb0gSfai/ky8kxhW0XcIiWUpDVjjhx+dGbqvJvB/4UNN8u
	 kNZ7W9CA2LWyFDbfLTn3us4XMWVNA5t7XX+nIOb/+DIVk8whObolmsj4maQwV+dZHw
	 N4TjUx6duDajScHYlfQYYzc9XYB80cMny9NLgXDJOCE2GFC6LVeuwvmogRgKLkL/6R
	 ZnkB09wtWp6E6nwge5fI3MYxqDI2Rk16hzL3uOWo7d2dx+nop6Q6cyN/c2AXoGqh5x
	 u5O2hgh7n4qIw==
Date: Sat, 26 Jul 2025 17:14:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] perf dwarf-aux: More accurate variable type match
 for breg
Message-ID: <aIVvXUMKjDBR3kxs@google.com>
References: <20250725202809.1230085-1-zecheng@google.com>
 <20250725202809.1230085-3-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725202809.1230085-3-zecheng@google.com>

On Fri, Jul 25, 2025 at 08:28:05PM +0000, Zecheng Li wrote:
> Introduces the function is_breg_access_indirect to determine whether a
> memory access involving a DW_OP_breg* operation refers to the variable's
> value directly or requires dereferencing the variable's type as a
> pointer based on the DWARF expression. Previously, all breg based
> accesses were assumed to directly access the variable's value
> (is_pointer = false).
> 
> The is_breg_access_indirect function handles three main cases:
> 
> 1. Base register + offset only: (e.g., DW_OP_breg7 RSP+88) The
>    calculated address is the location of the variable. The access is
>    direct, so no type dereference is needed. Returns false.

This is the common case.  Either basic type is store in the stack or
pointer type is spilled into the stack.

> 
> 2. Base register + offset, followed by other operations ending in
>    DW_OP_stack_value, including DW_OP_deref: (e.g., DW_OP_breg7 RSP+96,
>    DW_OP_deref, DW_OP_plus_uconst 0x64, DW_OP_stack_value) The DWARF
>    expression computes the variable's value, but that value requires a
>    dereference. The memory access is fetching that value, so no type
>    dereference is needed. Returns false.

This is a complex case: the variable needs a pointer calculation.  We
don't support those (complex) expressions for now.

> 
> 3. Base register + offset, followed only by DW_OP_stack_value: (e.g.,
>    DW_OP_breg7 RSP+176, DW_OP_stack_value) This indicates the value at
>    the base + offset is the variable's value. Since this value is being
>    used as an address in the memory access, the variable's type is
>    treated as a pointer and requires a type dereference. Returns true.

The value has a value.  But I guess the type dereference is only
required if the base register points to the stack.

> 
> The is_pointer argument passed to match_var_offset is now set by
> is_breg_access_indirect for breg accesses.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 42 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index bf906dff9ef0..814c96ea509f 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1424,6 +1424,38 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  	return true;
>  }
>  
> +/**
> + * is_breg_access_indirect - Check if breg based access implies type dereference
> + * @ops: DWARF operations array
> + * @nops: Number of operations in @ops
> + *
> + * Returns true if the DWARF expression indicates the variable's value is
> + * a pointer that the memory access dereferences.
> + * Returns false if the expression evaluates to the variable's value directly.
> + * This is called after check_allowed_ops.
> + */
> +static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
> +{
> +	ops++;
> +	nops--;
> +
> +	/* only the base register */
> +	if (nops == 0)
> +		return false;
> +
> +	switch (ops->atom) {
> +	case DW_OP_stack_value:
> +		return true;

As I said, I think it also need to check if the base is the stack.


> +	case DW_OP_deref_size:
> +	case DW_OP_deref:
> +	case DW_OP_piece:
> +		return false;

I'm not sure if it's always false.  I sometimes see this pattern

  DW_OP_bregN, DW_OP_deref*, DW_OP_stack_value

which I believe it's almost same as just

  DW_OP_bregN

No?

> +	default:
> +		/* unreachable, OP not supported */
> +		return false;
> +	}
> +}
> +
>  /* Only checks direct child DIEs in the given scope. */
>  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  {
> @@ -1452,7 +1484,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
>  		    check_allowed_ops(ops, nops) &&
>  		    match_var_offset(die_mem, data, data->offset, ops->number,
> -				     /*is_pointer=*/false))
> +				     /*is_pointer=*/is_breg_access_indirect(ops, nops)))

The annotate like /*is_pointer=*/ is used for constant arguments.
You can delete here and below.

Thanks,
Namhyung

>  			return DIE_FIND_CB_END;
>  
>  		/* Only match with a simple case */
> @@ -1464,11 +1496,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  					     /*is_pointer=*/true))
>  				return DIE_FIND_CB_END;
>  
> -			/* Local variables accessed by a register + offset */
> +			/* variables accessed by a register + offset */
>  			if (ops->atom == (DW_OP_breg0 + data->reg) &&
>  			    check_allowed_ops(ops, nops) &&
>  			    match_var_offset(die_mem, data, data->offset, ops->number,
> -					     /*is_pointer=*/false))
> +					     /*is_pointer=*/is_breg_access_indirect(ops, nops)))
>  				return DIE_FIND_CB_END;
>  		} else {
>  			/* pointer variables saved in a register 32 or above */
> @@ -1478,11 +1510,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  					     /*is_pointer=*/true))
>  				return DIE_FIND_CB_END;
>  
> -			/* Local variables accessed by a register + offset */
> +			/* variables accessed by a register + offset */
>  			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
>  			    check_allowed_ops(ops, nops) &&
>  			    match_var_offset(die_mem, data, data->offset, ops->number2,
> -					     /*is_poitner=*/false))
> +					     /*is_pointer=*/is_breg_access_indirect(ops, nops)))
>  				return DIE_FIND_CB_END;
>  		}
>  	}
> -- 
> 2.50.1.470.g6ba607880d-goog
> 
