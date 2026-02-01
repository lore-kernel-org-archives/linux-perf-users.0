Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198922FAFD;
	Sun,  1 Feb 2026 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769946554; cv=none; b=ImamZKnWWznTOWmtQwO2rDU4PWafhgibt7Y03vkwB3UaUpy67xqL4JbsA9L8Bp3j08ex2bZYpDZWEhHG0/M7Jvo/tk2H2sBS/vQY97rLy7TMZx75tGtJ1b5QRlrcyvTy0d67P/LscOqJG/NGqw6+agrMaA2/N0g7zfganVz8i9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769946554; c=relaxed/simple;
	bh=2+JDkH1X2vUmZi+ksx0KkPooGZE1eicOnw1ak2k10og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQdSk5ln3R9yPvAiqg83Smeaeb7YEIpvtcAYhCI3C1+CwIFzGFHCdozaDA/l1VYSy4UT3GpRyPOjZWYz1ACsKH3fcEYtjmSAORYGIy7lhnOab2eKjqHQy56xutaP5Gs6H6m7pCzT4j/EGYqjUyalWjb94RTWX58IlLo5xy3WuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fb57DYgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fb57DYgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E4C4CEF7;
	Sun,  1 Feb 2026 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769946554;
	bh=2+JDkH1X2vUmZi+ksx0KkPooGZE1eicOnw1ak2k10og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb57DYgoUB+pfrQmvSquJsFilbV3CQp4cGD6Ds1n11hSxtXXrah72HXDEAs4MaOzR
	 tlqykrgl6gLIhcXqAT/vBxvm6EEiZ1K8ESQJOcbNYI8S2BDKgtJnouE/0pt1Egcsjf
	 nQu46f3PrOxlKxTPhr4bg2eHf+qKjOTyFmK6nfog=
Date: Sun, 1 Feb 2026 12:49:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haocheng Yu <yuhaocheng035@gmail.com>
Cc: acme@kernel.org, security@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <2026020157-crayfish-distract-7da1@gregkh>
References: <2026020124-flashbulb-stumble-f24a@gregkh>
 <20260201113446.4328-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201113446.4328-1-yuhaocheng035@gmail.com>

On Sun, Feb 01, 2026 at 07:34:36PM +0800, Haocheng Yu wrote:
> The issue is caused by a race condition between mmap() and event
> teardown. In perf_mmap(), the ring_buffer (rb) is accessed via
> map_range() after the mmap_mutex is released. If another thread
> closes the event or detaches the buffer during this window, the
> reference count of rb can drop to zero, leading to a UAF or
> refcount saturation when map_range() or subsequent logic attempts
> to use it.
> 
> Fix this by extending the scope of mmap_mutex to cover the entire
> setup process, including map_range(), ensuring the buffer remains
> valid until the mapping is complete.
> 
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> ---
>  kernel/events/core.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2c35acc2722b..7c93f7d057cb 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  			ret = perf_mmap_aux(vma, event, nr_pages);
>  		if (ret)
>  			return ret;
> -	}
> -
> -	/*
> -	 * Since pinned accounting is per vm we cannot allow fork() to copy our
> -	 * vma.
> -	 */
> -	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &perf_mmap_vmops;
>  
> -	mapped = get_mapped(event, event_mapped);
> -	if (mapped)
> -		mapped(event, vma->vm_mm);
> -
> -	/*
> -	 * Try to map it into the page table. On fail, invoke
> -	 * perf_mmap_close() to undo the above, as the callsite expects
> -	 * full cleanup in this case and therefore does not invoke
> -	 * vmops::close().
> -	 */
> -	ret = map_range(event->rb, vma);
> -	if (ret)
> -		perf_mmap_close(vma);
> +	/*
> +	 * Since pinned accounting is per vm we cannot allow fork() to copy our
> +	 * vma.
> +	 */
> +	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> +	vma->vm_ops = &perf_mmap_vmops;
> +
> +	mapped = get_mapped(event, event_mapped);
> +	if (mapped)
> +		mapped(event, vma->vm_mm);
> +
> +	/*
> +	 * Try to map it into the page table. On fail, invoke
> +	 * perf_mmap_close() to undo the above, as the callsite expects
> +	 * full cleanup in this case and therefore does not invoke
> +	 * vmops::close().
> +	 */
> +	ret = map_range(event->rb, vma);
> +	if (ret)
> +		perf_mmap_close(vma);
> +	}


This indentation looks very odd, are you sure it is correct?

thanks,

greg k-h
