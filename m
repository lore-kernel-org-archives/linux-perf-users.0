Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688C4A64F3;
	Wed,  2 Sep 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366923; cv=none; b=mNChG9LnwKpAMtqBEW+T5F0+C5p6pGYg9EEDuKxxPzYhcrMwLP9xkuaVWJ2gH5v9iUn57/FBUqdcgcmYAiDOoUWIC4KfCzHQvFQ2VLDd1zh08xOeu+KjBmJtuaSz4pn203cHvteYQxC7hDmvDaIUjA0hvDftpPH7JQTwn4gaUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366923; c=relaxed/simple;
	bh=+mGoBUjOc7qxjm7k+aG8gmb8Z8yRWM/XDq/y9sGvqwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbvOJCeFPcgoPimURj6agvfBDfk94YGo8oX0qYoHe5ZsXfk73615FdxZhvkIIwVoX5lyAocAK3gIDI72mAXmtgXhZzF1PwrGCjXH6Mw6+n8orNH2S4NwuI4e7oMgwjX6Zs2P1betxruD0bnhfbDCe9pnWsNMHno0BC22gS+6k7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOyuiW8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOyuiW8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D629E1F00A3A;
	Wed,  2 Sep 2026 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366920;
	bh=kkmCkGQoBwObvFsWtVaeZrrvGJoH7pMiQKGIGSPX6j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOyuiW8IwiVEkGP807+ml6TXm/aCJd4TganQRnpA1ceEYciYwJ6GKuTTZVys37HQX
	 zqF6CpIRW3BHrawDfRVPleLiYRBRv8257VJH0i0f837V5e3qLhiGV9QQ/y+krUy5hA
	 jq3/fsK4kpT+zmPAT61++4EGqjeysme+w4OTY7iqOG7nqQF0cvUzC/PP4elIoX5DAX
	 EyOGKGdMUZ7ad3DXL6ouFLBDcwnzglI0yIoLGsnr2N8kqHnQbFH3zsQaRopzZLKyNB
	 r5wzflfUG8sHuXyfEXm0IL5ZIgjDyOjQ0pQBMqF3no6GuIALE9clFdDaGJ4G9kgTYv
	 v8MH6XcFFaaug==
Date: Wed, 2 Sep 2026 17:35:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andi Kleen <ak@kernel.org>
Cc: linux-kernel@vger.kernel.org, mhiramat@kernel.org, oleg@redhat.com, 
	peterz@infradead.org, tglx@kernel.org, x86@kernel.org, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [RFC v1 05/19] ptwrite uprobes: Add minimal low level support
 for x86
Message-ID: <aphN94PIAfM3s4vy@gremlin>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-6-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831150651.1134594-6-ak@kernel.org>

NAK.

This is broken as described in [0] and causes use-after-frees.

[0]:https://lore.kernel.org/all/aphJ7olxr-_VhDKt@gremlin/

On Mon, Aug 31, 2026 at 08:04:41AM -0700, Andi Kleen wrote:
> Add more data structures and the x86 machinery to generate the PTWRITE
> instructions for a ptwrite uprobe. The probe executes PTWRITEs and then
> jumps back to the original code. In this variant only patching
> 5 byte nops is supported.
>
> The instructions are pre-generated to templates and then patched when
> setting up the final user page.
>
> The patching code uses 3 phase patching similar to int3_update.
>
> The ptwrite stub emits a header with a magic value and the number of
> arguments, and then the actual probed values.
>
> There is no separate config option for ptwrite uprobes, it is just tied
> to the main uprobes config.
>
> Some limitations in the current implementation:
> - The probed 5 byte area cannot cross a page.
> - The allocated stubs in the user program are only freed on exit.
>
> Assisted-by: omp:gpt-5.6-luna

I suggest looking into a model more suited to complex kernel
development. Googling it, Luna is described thusly:

'GPT-5.6 Luna is OpenAI's fastest and most budget-friendly AI model tier,
built specifically for high-volume, latency-sensitive tasks'

Which doesn't strike me as ideal for this kind of work, especially when you
are submitting things to the mailing list and asking people to dedicate
their own time (and better models) to assessing it.

> Signed-off-by: Andi Kleen <ak@kernel.org>
> ---
>  arch/x86/include/asm/uprobes.h |  24 ++
>  arch/x86/kernel/uprobes.c      | 623 +++++++++++++++++++++++++++++++++
>  2 files changed, 647 insertions(+)

(That's a huge diffstat for one patch and your cover letter is missing a
full diffstat also...)

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..df652c56414b 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -15,11 +15,15 @@
>  #include <linux/syscalls.h>

...

> +static struct uprobe_ptwrite_page *
> +create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
> +{
> +	struct uprobe_ptwrite_page *ptw;
> +	struct vm_area_struct *vma;
> +	unsigned long area;
> +
> +	area = find_ptwrite_page_area(mm, vaddr);
> +	if (IS_ERR_VALUE(area))
> +		return NULL;
> +
> +	mmap_assert_write_locked(mm);
> +
> +	ptw = kzalloc_obj(*ptw);
> +	if (!ptw)
> +		return NULL;
> +
> +	ptw->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> +	if (!ptw->page) {
> +		kfree(ptw);
> +		return NULL;
> +	}
> +	ptw->vaddr = area;
> +
> +	vma = _install_special_mapping(mm, area, PAGE_SIZE,
> +			VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> +			&ptwrite_mapping);

You need to trampoline this (as the existing code does...) to avoid the
issue described in [0].

--
Cheers, Lorenzo
