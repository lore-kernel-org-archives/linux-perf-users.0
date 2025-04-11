Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F942A9E
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407946; cv=none; b=n2P+hPGElXlb9RgOvnylUE68M/mJMwfBofHr1rJRHnaIwJDymfD/1rnaXOzwfVhiy7sjpxAnX6/vcWhYNQ9d+Ih+U/rLp75i4dSxUos9ZOpM17B56DH18PUvb0f9BDQXApQQi/WUa+jLDCjK3onZK2VMX7tqxfUFUOG1DNtFRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407946; c=relaxed/simple;
	bh=APPgbBoZOqh7B9rNw9/yY5pjTymX65H/0stiLxdw4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAkY+sl/cE9k11BFRYEh/FD5i/v0v+8ufdDjJYexciY9zLslAY0vfGwi6jOSB7wp7kZ/hlaN1vP7pwN+ECWhQ78+KMe2GxhRulVHXFe1Qp+kURoKRijS6SgwvxPp2IDzxF8wDmc5QTvsSwsIfybpELus61i1+FNkt+uq5g38Lbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n71eeQfc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n71eeQfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1908C4CEE2;
	Fri, 11 Apr 2025 21:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744407945;
	bh=APPgbBoZOqh7B9rNw9/yY5pjTymX65H/0stiLxdw4Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n71eeQfcGsA1SjYOXx1mMHz/zuIU/sSVq1mUXDfvTWaOFIIR1OBOMEfL5Rce/cNQU
	 HsLGdnZZ6t9sGsoKOG9ickdGdi7B/zNIEVAElW/BTOlSPb+KKQPHN5jLVNDKrTveGQ
	 S3jVcjQQTNPUJhuQQGowGM3q9JPr9V5rqhFp/yMdAkiB2hVj2Kj+DW+w2tGiNMt2dg
	 Y1FUj+TdH83snPjj1SmcNUV0qfn1+4pISeN4qMWhTRDGfYTe/M3MIPq2UWG/BYcPXp
	 YqyZURH75qX8s32KRfXWQu1hX20HIW9AfSKPSRlJQs5mLFgpkw+Vo8WC3zrtPxenlz
	 mXLkiJ7tMVB3w==
Date: Fri, 11 Apr 2025 14:45:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix BUG_ON in basic block processing
Message-ID: <Z_mNiOA_Rm9Jl6kX@z2>
References: <20250410183852.872311-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410183852.872311-1-ak@linux.intel.com>

On Thu, Apr 10, 2025 at 11:38:52AM -0700, Andi Kleen wrote:
> Hit with perf annotate --code-with-type --stdio
> 
> perf: util/annotate-data.c:1299: find_data_type_insn: Assertion
> `!(bb->begin->al.offset == -1 || bb->end->al.offset == -1)' failed.
> 
> This makes sure to skip non instruction disasm lines in all cases that
> add basic blocks. Also added some extra BUG_ONs for this case.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/annotate-data.c | 10 +++++++++-
>  tools/perf/util/annotate.c      |  4 +++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index c3ffb8cad4fc..51ca86ef2677 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -986,7 +986,15 @@ static void prepend_basic_blocks(struct list_head *this_blocks,
>  	}
>  
>  	/* Point to the insn before the last when adding this block to full_blocks */
> -	last_bb->end = list_prev_entry(last_bb->end, al.node);
> +	do {
> +		/* Nothing useful found */
> +		if (last_bb->end == last_bb->begin) {
> +			list_del(&last_bb->list);
> +			free(last_bb);
> +			goto out;
> +		}
> +		last_bb->end = list_prev_entry(last_bb->end, al.node);
> +	} while (last_bb->end->al.offset == -1);
>  
>  out:
>  	list_splice(this_blocks, full_blocks);
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 18ce9f37053e..1c226f257245 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2966,6 +2966,7 @@ static int add_basic_block(struct basic_block_data *bb_data,
>  
>  	if (dl == NULL)
>  		return -1;
> +	BUG_ON(dl->al.offset == -1);
>  
>  	if (!is_new_basic_block(bb_data, dl))
>  		return 0;
> @@ -3006,7 +3007,7 @@ static bool process_basic_block(struct basic_block_data *bb_data,
>  
>  	last_dl = list_last_entry(&notes->src->source,
>  				  struct disasm_line, al.node);
> -	if (last_dl->al.offset == -1)
> +	while (last_dl && last_dl->al.offset == -1)
>  		last_dl = annotation__prev_asm_line(notes, last_dl);
>  
>  	if (last_dl == NULL)
> @@ -3052,6 +3053,7 @@ static bool process_basic_block(struct basic_block_data *bb_data,
>  		break;
>  
>  	}
> +	BUG_ON(dl->al.offset == -1);
>  	link->bb->end = dl;
>  	return found;
>  }
> -- 
> 2.49.0
> 
