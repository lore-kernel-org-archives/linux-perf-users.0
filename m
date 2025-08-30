Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE316F0FE;
	Sat, 30 Aug 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539291; cv=none; b=BIwmKsICQel0nAnnKmlqa+3Fvf3xQfbZV8/FYzbl5hsx2zjKGMTLs7g32Mr7Z4gjnFBGPOJFMgXfq2cMwx/E3Z9Zym07yFxTklEXZG0aYUafYWF3uwoNHxgWSDRKrWDJGedreXdaSBqzihtvJUWEcrjAZdRSBJiCCq7zc2YkZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539291; c=relaxed/simple;
	bh=XQinxe+32uWr6L7opPVVU/qk5TPK+QCCBj+QR/vJEFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4zLakK44D9SSqXgnAPP4klYSYQJkkjAPddn+20/UCzVOChF+27Dnlf9h3jQcrzcLlHU87opiXBADzUJEvffjthl8sDnoEUuhvY4Xhl2Pft9kHqTgkAJJ1VW/dcCfVa0d2PZrVIrR9n0Y15fN2pnYymLyQxRvGcZiuvZPb3Sotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrxLOM0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrxLOM0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDC9C4CEEB;
	Sat, 30 Aug 2025 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756539291;
	bh=XQinxe+32uWr6L7opPVVU/qk5TPK+QCCBj+QR/vJEFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrxLOM0eAR8QjY9ql9D9QVNyS7eZaYkMinVTOy4rtVuvbimxqje9MDdu7Q4fQq0L9
	 vYKKNgovUtwIehtnRg1Qde5w5UKp5QWrcqi1TxKTVB9f7zCYw4j1Gb0iwfUlRJPxvn
	 qio55gOeO0Yd0PuvwfAvKFyEysNTw+JzV4kyzRues+Ag0Q14HJxhHx4eo3E/xD8nzj
	 LybgWUxm4gyI+g2UyT8uFja0V8ELMMb06cD9HuXmJ96F8dOCoRReSz6yLbIM855+Cm
	 kHFHKz3fb43OFfAPe5C0FnL+IrCYxV+8yL8B1wkeCqYH+5qDqWaYd9qd9hxfXjJK6p
	 3QCiTgyscqO0A==
Date: Sat, 30 Aug 2025 00:34:49 -0700
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
Subject: Re: [PATCH v2 10/10] perf dwarf-aux: support DW_OP_piece expressions
Message-ID: <aLKpmcHtdyaqzunq@google.com>
References: <20250825195833.226839-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195833.226839-1-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:58:33PM +0000, Zecheng Li wrote:
> Support variables split across multiple registers or stack locations by
> handling DW_OP_piece in DWARF expressions. This enables correct matching
> of such variables by iterating over all pieces in the expression.

Can you show me a real world example of these variables?

Thanks,
Namhyung

> 
> There are two cases for matching memory access on the target register:
> 
> 1. Accessing a struct member:
>    - The type is the original variable's type.
>    - The offset is the sum of the piece's offset and the operand's
>      offset.
> 
> 2. Dereferencing a member:
>    - The type is the member of the original variable (the member must be
>      a pointer).
>    - The size must match the piece size.
>    - The access offset is the operand's offset.
> 
> This change improves support for piece-wise variable locations in DWARF
> expressions.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 244 +++++++++++++++++++++++++++---------
>  1 file changed, 187 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 013862ea8924..f42fc6f6e9df 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1390,21 +1390,44 @@ struct find_var_data {
>  #define DWARF_OP_DIRECT_REGS  32
>  
>  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
> -			     s64 addr_offset, s64 addr_type, bool is_pointer)
> +					s64 addr_offset, s64 addr_type, s64 piece_offset,
> +					s64 piece_size, bool is_pointer)
>  {
> -	Dwarf_Word size;
> +	Dwarf_Word size = 0;
>  	s64 offset = addr_offset - addr_type;
>  
> -	if (offset < 0)
> +	if (piece_size > 0 && !is_pointer) {
> +		offset += piece_offset;
> +		size = piece_offset + piece_size;
> +	}
> +
> +	if (piece_size == 0 || offset < 0)
>  		return false;
>  
>  	if (__die_get_real_type(die_mem, &data->type) == NULL)
>  		return false;
>  
> -	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
> -		/* Get the target type of the pointer */
> -		if (__die_get_real_type(&data->type, &data->type) == NULL)
> -			return false;
> +	if (is_pointer) {
> +		if (piece_size < 0 && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
> +			/* Get the target type of the pointer */
> +			if (__die_get_real_type(&data->type, &data->type) == NULL)
> +				return false;
> +		}
> +
> +		if (piece_size > 0) {
> +			Dwarf_Die member_die;
> +
> +			if (die_get_member_type(&data->type, piece_offset, &member_die) == NULL)
> +				return false;
> +
> +			if (dwarf_aggregate_size(&member_die, &size) < 0)
> +				return false;
> +
> +			if (size == (u64)piece_size &&
> +			    dwarf_tag(&data->type) == DW_TAG_pointer_type)
> +				if (__die_get_real_type(&member_die, &data->type) == NULL)
> +					return false;
> +		}
>  	}
>  
>  	if (offset == 0) {
> @@ -1413,7 +1436,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  		return true;
>  	}
>  
> -	if (dwarf_aggregate_size(&data->type, &size) < 0)
> +	if (size == 0 && dwarf_aggregate_size(&data->type, &size) < 0)
>  		return false;
>  
>  	if ((u64)offset >= size)
> @@ -1452,6 +1475,67 @@ static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
>  	return false;
>  }
>  
> +struct op_piece_iter {
> +	/* Pointer to the beginning of the op array */
> +	Dwarf_Op *ops;
> +	size_t nops;
> +	/* The index where the next search will begin */
> +	size_t current_idx;
> +	size_t next_offset;
> +
> +	/* Pointer to the start of the current piece's ops */
> +	Dwarf_Op *piece_ops;
> +	/* The number of ops in the current piece */
> +	size_t num_piece_ops;
> +	size_t piece_offset;
> +};
> +
> +static void op_piece_iter_init(struct op_piece_iter *it, Dwarf_Op *ops, size_t nops)
> +{
> +	it->ops = ops;
> +	it->nops = nops;
> +	it->current_idx = 0;
> +	it->next_offset = 0;
> +	it->piece_ops = NULL;
> +	it->num_piece_ops = 0;
> +	it->piece_offset = 0;
> +}
> +
> +/* Finds the next non-empty piece segment. */
> +static bool op_piece_iter_next(struct op_piece_iter *it)
> +{
> +	/* Loop until a non-empty piece is found */
> +	while (it->current_idx < it->nops) {
> +		size_t start;
> +		size_t end;
> +
> +		start = it->current_idx;
> +		end = start;
> +
> +		while (end < it->nops && it->ops[end].atom != DW_OP_piece)
> +			end++;
> +
> +		/* The number of ops in this segment, including DW_OP_piece */
> +		it->num_piece_ops = min(end - start + 1, it->nops - start);
> +		it->piece_ops = &it->ops[start];
> +		it->piece_offset = it->next_offset;
> +
> +		it->current_idx = end;
> +		if (it->current_idx < it->nops) {
> +			const Dwarf_Op *piece_op = &it->ops[it->current_idx];
> +			size_t piece_size = (size_t)piece_op->number;
> +
> +			it->next_offset += piece_size;
> +			it->current_idx++;
> +		}
> +
> +		if (end > start)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Only checks direct child DIEs in the given scope. */
>  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  {
> @@ -1470,48 +1554,65 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  		return DIE_FIND_CB_SIBLING;
>  
>  	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
> +		struct op_piece_iter piece_iter;
>  		/* Assuming the location list is sorted by address */
>  		if (end <= data->pc)
>  			continue;
>  		if (start > data->pc)
>  			break;
>  
> -		/* Local variables accessed using frame base register */
> -		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
> -		    check_allowed_ops(ops, nops) &&
> -		    match_var_offset(die_mem, data, data->offset, ops->number,
> -				     is_breg_access_indirect(ops, nops)))
> -			return DIE_FIND_CB_END;
> +		op_piece_iter_init(&piece_iter, ops, nops);
> +		while (op_piece_iter_next(&piece_iter)) {
> +			Dwarf_Op *pops = piece_iter.piece_ops;
> +			size_t pnops = piece_iter.num_piece_ops;
> +			size_t piece_offset = piece_iter.piece_offset;
> +			int piece_size = -1;
> +			bool is_pointer = true;
> +			int access_offset = data->offset;
>  
> -		/* Only match with a simple case */
> -		if (data->reg < DWARF_OP_DIRECT_REGS) {
> -			/* pointer variables saved in a register 0 to 31 */
> -			if (ops->atom == (DW_OP_reg0 + data->reg) &&
> -			    check_allowed_ops(ops, nops) &&
> -			    match_var_offset(die_mem, data, data->offset, 0,
> -					     /*is_pointer=*/true))
> -				return DIE_FIND_CB_END;
> +			if (pops[pnops - 1].atom == DW_OP_piece)
> +				piece_size = (int)pops[pnops - 1].number;
>  
> -			/* variables accessed by a register + offset */
> -			if (ops->atom == (DW_OP_breg0 + data->reg) &&
> -			    check_allowed_ops(ops, nops) &&
> -			    match_var_offset(die_mem, data, data->offset, ops->number,
> -					     is_breg_access_indirect(ops, nops)))
> -				return DIE_FIND_CB_END;
> -		} else {
> -			/* pointer variables saved in a register 32 or above */
> -			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
> -			    check_allowed_ops(ops, nops) &&
> -			    match_var_offset(die_mem, data, data->offset, 0,
> -					     /*is_pointer=*/true))
> -				return DIE_FIND_CB_END;
> +			if (!check_allowed_ops(pops, pnops))
> +				continue;
>  
> -			/* variables accessed by a register + offset */
> -			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
> -			    check_allowed_ops(ops, nops) &&
> -			    match_var_offset(die_mem, data, data->offset, ops->number2,
> -					     is_breg_access_indirect(ops, nops)))
> +			if ((data->is_fbreg && pops->atom == DW_OP_fbreg) ||
> +			    (pops->atom == DW_OP_breg0 + data->reg) ||
> +			    (pops->atom == DW_OP_bregx && data->reg == pops->number))
> +				is_pointer = is_breg_access_indirect(pops, pnops);
> +
> +			/* Local variables accessed using frame base register */
> +			if (data->is_fbreg && pops->atom == DW_OP_fbreg &&
> +				match_var_offset(die_mem, data, access_offset,
> +					pops->number, piece_offset, piece_size, is_pointer))
>  				return DIE_FIND_CB_END;
> +
> +			/* Only match with a simple case */
> +			if (data->reg < DWARF_OP_DIRECT_REGS) {
> +				/* pointer variables saved in a register 0 to 31 */
> +				if (pops->atom == (DW_OP_reg0 + data->reg) &&
> +					match_var_offset(die_mem, data, access_offset,
> +					    0, piece_offset, piece_size, is_pointer))
> +					return DIE_FIND_CB_END;
> +
> +				/* variables accessed by a register + offset */
> +				if (pops->atom == (DW_OP_breg0 + data->reg) &&
> +					match_var_offset(die_mem, data, access_offset,
> +					    pops->number, piece_offset, piece_size, is_pointer))
> +					return DIE_FIND_CB_END;
> +			} else {
> +				/* pointer variables saved in a register 32 or above */
> +				if (pops->atom == DW_OP_regx && pops->number == data->reg &&
> +					match_var_offset(die_mem, data, access_offset,
> +					    0, piece_offset, piece_size, is_pointer))
> +					return DIE_FIND_CB_END;
> +
> +				/* variables accessed by a register + offset */
> +				if (pops->atom == DW_OP_bregx && data->reg == pops->number &&
> +					match_var_offset(die_mem, data, access_offset,
> +					    pops->number2, piece_offset, piece_size, is_pointer))
> +					return DIE_FIND_CB_END;
> +			}
>  		}
>  	}
>  	return DIE_FIND_CB_SIBLING;
> @@ -1572,7 +1673,7 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
>  			continue;
>  
>  		if (check_allowed_ops(ops, nops) &&
> -		    match_var_offset(die_mem, data, data->addr, ops->number,
> +		    match_var_offset(die_mem, data, data->addr, ops->number, 0, -1,
>  				     /*is_pointer=*/false))
>  			return DIE_FIND_CB_END;
>  	}
> @@ -1613,6 +1714,7 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	Dwarf_Op *ops;
>  	size_t nops;
>  	struct die_var_type *vt;
> +	struct op_piece_iter piece_iter;
>  
>  	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
>  		return DIE_FIND_CB_SIBLING;
> @@ -1634,25 +1736,53 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	if (__die_get_real_type(die_mem, &type_die) == NULL)
>  		return DIE_FIND_CB_SIBLING;
>  
> -	vt = malloc(sizeof(*vt));
> -	if (vt == NULL)
> -		return DIE_FIND_CB_END;
> +	op_piece_iter_init(&piece_iter, ops, nops);
> +	while (op_piece_iter_next(&piece_iter)) {
> +		Dwarf_Op *pops = piece_iter.ops;
> +		size_t pnops = piece_iter.num_piece_ops;
> +		size_t piece_offset = piece_iter.piece_offset;
> +		size_t offset = offset_from_dwarf_op(pops);
> +		s64 piece_size = -1;
> +		/* Usually a register holds the value of the variable */
> +		bool is_reg_var_addr = false;
> +
> +		if (((pops->atom >= DW_OP_breg0 && pops->atom <= DW_OP_breg31) ||
> +		      pops->atom == DW_OP_bregx || pops->atom == DW_OP_fbreg) &&
> +		      !is_breg_access_indirect(pops, pnops))
> +			/* The register holds the address of the variable. */
> +			is_reg_var_addr = true;
> +
> +		if (pops[pnops - 1].atom == DW_OP_piece)
> +			piece_size = (s64)pops[pnops - 1].number;
> +
> +		if (piece_size > 0) {
> +			if (!is_reg_var_addr) {
> +				size_t size;
> +
> +				if (die_get_member_type(&type_die, piece_offset, &type_die) == NULL)
> +					continue;
>  
> -	/* Usually a register holds the value of a variable */
> -	vt->is_reg_var_addr = false;
> +				if (dwarf_aggregate_size(&type_die, &size) < 0)
> +					continue;
>  
> -	if (((ops->atom >= DW_OP_breg0 && ops->atom <= DW_OP_breg31) ||
> -	      ops->atom == DW_OP_bregx || ops->atom == DW_OP_fbreg) &&
> -	      !is_breg_access_indirect(ops, nops))
> -		/* The register contains an address of the variable. */
> -		vt->is_reg_var_addr = true;
> +				if (size != (u64)piece_size)
> +					continue;
> +			} else
> +				offset += piece_offset;
> +		}
>  
> -	vt->die_off = dwarf_dieoffset(&type_die);
> -	vt->addr = start;
> -	vt->reg = reg_from_dwarf_op(ops);
> -	vt->offset = offset_from_dwarf_op(ops);
> -	vt->next = *var_types;
> -	*var_types = vt;
> +		vt = malloc(sizeof(*vt));
> +		if (vt == NULL)
> +			return DIE_FIND_CB_END;
> +
> +		vt->is_reg_var_addr = is_reg_var_addr;
> +		vt->die_off = dwarf_dieoffset(&type_die);
> +		vt->addr = start;
> +		vt->reg = reg_from_dwarf_op(pops);
> +		vt->offset = offset;
> +		vt->next = *var_types;
> +		*var_types = vt;
> +	}
>  
>  	return DIE_FIND_CB_SIBLING;
>  }
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
