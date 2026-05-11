Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930D1CD2C;
	Mon, 11 May 2026 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473989; cv=none; b=hsie92q9hkjkzdR5MfKlOGgwGJkE5gvWHUJGFgTFAN4XB3seCAc8Bw88Tvlt+st9iquQQgvGQHicE642Xp0yWeFrK5SbGYbuVb8lHwbaDogWKE8bf+gjaYtk3mJRnt6Q+QLqsKKOCodG6RR4acs0KYoyODD+peuzrAknQnPanUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473989; c=relaxed/simple;
	bh=FLU7F5Bb50Rvv3TAU9zye7uQoYONAv9s0CPanfSgBa0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TjPBcNFbeJtaCQP4fvvdBHbW6TP/OgDXa7S5oqhRhecY/CYsU53fEdIXaCDs+gbcrjRb1Y7vYDQy3ovN4EfSWB2mlp1dgwyg5QYJiyudJdnbFqKXP/PlCu/XSFHUyiI5z+NO2XTJWoPTxxC4igqmfVWrifnltSp+nD6pZTMcup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPUYQq4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPUYQq4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E8C2BCB0;
	Mon, 11 May 2026 04:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778473988;
	bh=FLU7F5Bb50Rvv3TAU9zye7uQoYONAv9s0CPanfSgBa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bPUYQq4ve51qLCxmJHwocrPOjlzM87Kxz80ER+WtUHxO0VfEAyAvE28vQp6UZ24eu
	 lRtcgtL3CweZeaP9AhCwj7Pqkr3RTgcewGv9H+unuxREZOiReGkTzLnksHBO3cpWgP
	 hXZCvrEMXPXlfCmOlkmUqeP/f0uIlUgYvYnfv074HgUY5TF1RGXvJ5wUKEFe7w7Lzr
	 bJEM115yPr9oCxbTuJmgdE+sSoiLRnviW0Wnbfhr62GWOoVVFJ80Oz6EV3cdRdX3X9
	 Q5iPbcBSJmmSLAOT4mlDDWyL+velidWJXcg+oO3S4PQfCIWxS5rEl+KcDhbE+DbUsk
	 Ghnbk16JOBqUw==
Date: Mon, 11 May 2026 13:33:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org (open
 list:UPROBES), linux-perf-users@vger.kernel.org (open list:PERFORMANCE
 EVENTS SUBSYSTEM)
Subject: Re: [PATCH] uprobes: Use flexible array for xol_area bitmap
Message-Id: <20260511133305.2cf908fb471af52aa96046a8@kernel.org>
In-Reply-To: <20260510214118.41926-1-rosenp@gmail.com>
References: <20260510214118.41926-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 14:41:18 -0700
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

You also have to update uprobe_clear_state(), because area->bitmap
is no longer allocated separately.

Thank you,


> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  kernel/events/uprobes.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e284..9ef74c2ad390 100644
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
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
