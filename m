Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00C23C4F2;
	Tue, 12 May 2026 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546919; cv=none; b=uY0HzUE022rn/bYyvUSYKUmwhUKWOpy9mn5HYyN0phk1zwjHGEWdjXD1zLFzXirH35dNyUIPo4DJB2LU7q0+btWNYSFcGakHXr7xqr1Kzo+wGvBV38eJPTDaWL0tmCox6m4vFNuHz4l3Uk1JE3S83oE/7gXY9MT96Q0xNk72bYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546919; c=relaxed/simple;
	bh=eMXySDvhjew9UrtBOZ2OWg9MoRIgp8KXUfPbp1kcPQQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lFihTjo1AI2rc+tQy3c5QKfbEowHGxNx0s/o3/bnp9f75j6AJygIlf7FQAJRKcM7JtcyqQHg++JYRN41m7UsI/4tY07QBnoShDNc9qP0wu+RqbWYFDxDqASZlszOK15ts/TYAopq4C3dH5K+pwv3tIj1lKx/tAdOXWKnNKJSaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+06pYYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+06pYYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F351C2BCB0;
	Tue, 12 May 2026 00:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546919;
	bh=eMXySDvhjew9UrtBOZ2OWg9MoRIgp8KXUfPbp1kcPQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j+06pYYnu4yyp6FgUpL1Q2SakdTyjGv7vJnVDPntrp94mAqfXByEagGSwTo8PXsvX
	 Lg1/8y1HLs8GjJL2LHMocNTprQ+UD+hrRRBQETgub7qMHkwzY55wXRAtU6Px1N+gGW
	 JjNKcDevhve+Br95FGo4KBj3r1/GLRHYab4IDA4IWEbnJ5WVBaBPWySyFqLoaxpvfi
	 c3XbZZraui6yc2y0y08M1ug03qpSfrvfeP895gQ5hx/jGMUzs2XMY2EaMkjeQaGH89
	 p9IHcT6GagtP5s+kO0bTUmzsZ91EQjpV5xmFUlWTCglOrnC0bp/0V3gLag1V/RM2sU
	 dkWPiC/nyEIAg==
Date: Tue, 12 May 2026 09:48:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
 linux-trace-kernel@vger.kernel.org (open list:UPROBES)
Subject: Re: [PATCHv2] uprobes: Use flexible array for xol_area bitmap
Message-Id: <20260512094832.8ffe6fe2787ed5d22261d20f@kernel.org>
In-Reply-To: <20260511225648.27886-1-rosenp@gmail.com>
References: <20260511225648.27886-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 15:56:48 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> The XOL slot bitmap has the same lifetime as struct xol_area, but it
> is currently allocated separately.  That adds another allocation
> failure path and a matching cleanup branch without buying any extra
> flexibility.
> 
> Store the bitmap as a flexible array member and allocate it together
> with the xol_area using kzalloc_flex().  The bitmap remains
> zero-initialized, while the allocation and error handling become
> simpler.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

OK, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  v2: add missing kfree
>  kernel/events/uprobes.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e284..eba71700667e 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -108,7 +108,6 @@ static LIST_HEAD(delayed_uprobe_list);
>   */
>  struct xol_area {
>  	wait_queue_head_t		wq;		/* if all slots are busy */
> -	unsigned long			*bitmap;	/* 0 = free slot */
>  
>  	struct page			*page;
>  	/*
> @@ -117,6 +116,7 @@ struct xol_area {
>  	 * the vma go away, and we must handle that reasonably gracefully.
>  	 */
>  	unsigned long			vaddr;		/* Page(s) of instruction slots */
> +	unsigned long			bitmap[];	/* 0 = free slot */
>  };
>  
>  static void uprobe_warn(struct task_struct *t, const char *msg)
> @@ -1755,18 +1755,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	struct xol_area *area;
>  	void *insns;
>  
> -	area = kzalloc_obj(*area);
> +	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));
>  	if (unlikely(!area))
>  		goto out;
>  
> -	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
> -			       GFP_KERNEL);
> -	if (!area->bitmap)
> -		goto free_area;
> -
>  	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
>  	if (!area->page)
> -		goto free_bitmap;
> +		goto free_area;
>  
>  	area->vaddr = vaddr;
>  	init_waitqueue_head(&area->wq);
> @@ -1779,8 +1774,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  		return area;
>  
>  	__free_page(area->page);
> - free_bitmap:
> -	kfree(area->bitmap);
>   free_area:
>  	kfree(area);
>   out:
> @@ -1831,7 +1824,6 @@ void uprobe_clear_state(struct mm_struct *mm)
>  		return;
>  
>  	put_page(area->page);
> -	kfree(area->bitmap);
>  	kfree(area);
>  }
>  
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
