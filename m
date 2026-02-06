Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E330ACE3;
	Fri,  6 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368788; cv=none; b=kVaSwX3nMXQd9+QUyeg0BAlGzANhhjF6YjANKxQxqIySm6dmimcZ6+AJYA9DdkQdABK5C/Pti0xXvZVi6Lt/vjHZJVStM2NoKPw7r3RzXG4Ps9YHZuDtVp49cnK93qFLoM4LgBpBrPUjwPL4M18MGToAlR84EjvjPFoOqfZj6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368788; c=relaxed/simple;
	bh=ivr5frnqE2VWAG1KxsVtRBbip0HfA2g9wEpUmDVbGDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhdKJPDKZYgMLLNvlP7k1GeE/GqYwXUojQGmL1UNQ2zWKaQCsMJgUN6bIdewUYGJQv9NcFZoWg43jNOadOD3MJTTln7q65bmEbfL8q10IgYY5utYzRZno/w90kKyzD3FPB3B6G+aMFMegcI/tivn6G+DIJTdnsrTvI3ydjkJbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ec13F7Nm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ec13F7Nm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+xD2drg373e07/WL5BzJZ+maQJBVK6ROtA7Y7bxb9lk=; b=Ec13F7NmUGRMj/iqloFuE+x/RX
	RMl4dPjC1jKo2MU0CJK7+ZGtq7q4ST7uoxESKxX1Vxm+hGK1r3pQWUWiXECod0IOMBS1tiRhP39hF
	UNCYSuub/KYR61CClK0jWxWz8sQNsFQ5PcCXSwqrOR8fWpgJzQqieWmzPm0/dE1zLcbtL8QR1SiqS
	Sn2+o5eQEJHiMaxRXLiNQgaQLpHm3aV2ZZeoqPy8byodwIwYaBVgtmYjysbF8UhEbGuaMLpE3Prdx
	doJS60MJ7PdOAPWeZJjpQwO8dnJPut9giD2w/ZEkQ0y6E9bXqPYNIaOzGXqWkEwl8a1vrRfxiqvk8
	LiTtlRig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voHnE-00000004wGZ-3SWc;
	Fri, 06 Feb 2026 09:06:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CEAA302DA9; Fri, 06 Feb 2026 10:06:24 +0100 (CET)
Date: Fri, 6 Feb 2026 10:06:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: yuhaocheng035@gmail.com
Cc: acme@kernel.org, security@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260206090624.GQ1282955@noisy.programming.kicks-ass.net>
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
 <20260202162057.7237-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202162057.7237-1-yuhaocheng035@gmail.com>

On Tue, Feb 03, 2026 at 12:20:56AM +0800, yuhaocheng035@gmail.com wrote:
> From: Haocheng Yu <yuhaocheng035@gmail.com>
> 
> Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> in perf_mmap.
> 
> The issue is caused by a race condition between a failing mmap() setup
> and a concurrent mmap() on a dependent event (e.g., using output
> redirection).
> 
> In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> event->rb with the mmap_mutex held. The mutex is then released to
> perform map_range().
> 
> If map_range() fails, perf_mmap_close() is called to clean up.
> However, since the mutex was dropped, another thread attaching to
> this event (via inherited events or output redirection) can acquire
> the mutex, observe the valid event->rb pointer, and attempt to
> increment its reference count. If the cleanup path has already
> dropped the reference count to zero, this results in a
> use-after-free or refcount saturation warning.
> 
> Fix this by extending the scope of mmap_mutex to cover the
> map_range() call. This ensures that the ring buffer initialization
> and mapping (or cleanup on failure) happens atomically effectively,
> preventing other threads from accessing a half-initialized or
> dying ring buffer.

And you're sure this time? To me it feels bit like talking to an LLM.

I suppose there is nothing wrong with having an LLM process syzkaller
output and even have it propose patches, but before you send it out an
actual human should get involved and apply critical thinking skills.

Just throwing stuff at a maintainer and hoping he does the thinking for
you is not appreciated.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> ---
>  kernel/events/core.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2c35acc2722b..abefd1213582 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  			ret = perf_mmap_aux(vma, event, nr_pages);
>  		if (ret)
>  			return ret;
> -	}
>  
> -	/*
> -	 * Since pinned accounting is per vm we cannot allow fork() to copy our
> -	 * vma.
> -	 */
> -	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &perf_mmap_vmops;
> +		/*
> +		 * Since pinned accounting is per vm we cannot allow fork() to copy our
> +		 * vma.
> +		 */
> +		vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> +		vma->vm_ops = &perf_mmap_vmops;
>  
> -	mapped = get_mapped(event, event_mapped);
> -	if (mapped)
> -		mapped(event, vma->vm_mm);
> +		mapped = get_mapped(event, event_mapped);
> +		if (mapped)
> +			mapped(event, vma->vm_mm);
>  
> -	/*
> -	 * Try to map it into the page table. On fail, invoke
> -	 * perf_mmap_close() to undo the above, as the callsite expects
> -	 * full cleanup in this case and therefore does not invoke
> -	 * vmops::close().
> -	 */
> -	ret = map_range(event->rb, vma);
> -	if (ret)
> -		perf_mmap_close(vma);
> +		/*
> +		 * Try to map it into the page table. On fail, invoke
> +		 * perf_mmap_close() to undo the above, as the callsite expects
> +		 * full cleanup in this case and therefore does not invoke
> +		 * vmops::close().
> +		 */
> +		ret = map_range(event->rb, vma);
> +		if (ret)
> +			perf_mmap_close(vma);
> +	}
>  
>  	return ret;
>  }
> 
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> -- 
> 2.51.0
> 
