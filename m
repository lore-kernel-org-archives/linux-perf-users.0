Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7136403C;
	Thu,  5 Feb 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289937; cv=none; b=QEoC26mKZq7pjQrSA2P7ueypYdzYaYmd9V+4+EKCc8UjU1/+vLbu7BZzhKi3+5n7pjR1O0KWeNNz1J25MNcAricyoxZRTp+XKKY4msfthHMNHiJPLrO16T3o1tr7btUu60h3e+2Y1kK1YmZ3PNgdAa9RZEuClkDOHEG2tlVOzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289937; c=relaxed/simple;
	bh=lMERKrA9f3KGVWmy99XaNMxgdqlQA5Wi4Qq4CD7YVVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzZjphhzjUcFwh7rHwl2AncPgQmuwZj+jUhWFGgxaC2o2w72ckh4rfZVsE1GAOeIC77b2pFEuHUUSr+YKFkj5Pa6QexixtxW8Z3YRhX96OAu8fW1gQ20JVse3ftyRIhYwFWk3LEugzWPMdC6puFF8uF7rp1UHdQ4VkZN98HQ7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HND0avhC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HND0avhC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=a62NaDchmNolr46mg9fk31y1C9I0rDLZ5Mi3QgshveM=; b=HND0avhC9w3zYHP4P9BvSeJVcN
	VIDSta45yFI0Q/oOr7Rc9d7aFa5b0eQQtXIs8IPwvjZYtlcqdeo2lM3CAbij96rpFs6mAMUhHDkmc
	Xkzd8XPoOQKSRDVxh2EnSGKQTSKkgd0pfd/WlJNQXdrf2yuj3RGhKKiC3f3jYBhOzWaPp2oT3L6rz
	VGDCcroG2GBd6NRX8CIiGdaAx2aR1WoUHgrlK8kU4HZjU/c47yFXBRoOMNaWDbiWzrx8RaXZTBxo2
	/FNF0sw6ho1JBz9i8gMzwgG7daWVgTz5Mn+JvL/lO0szwUfVGbr6JxIGFYZpu3RFfDscIvkmq0mhr
	e5sA8twg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnxHN-0000000215K-1DTF;
	Thu, 05 Feb 2026 11:12:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CBBB9300BD2; Thu, 05 Feb 2026 12:12:08 +0100 (CET)
Date: Thu, 5 Feb 2026 12:12:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:UPROBES" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uprobes: replace deprecated kmap_atomic() with
 kmap_local_page()
Message-ID: <20260205111208.GK232055@noisy.programming.kicks-ass.net>
References: <20260205105725.298340-1-clopez@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205105725.298340-1-clopez@suse.de>

On Thu, Feb 05, 2026 at 11:57:25AM +0100, Carlos López wrote:
> kmap_atomic() has been deprecated for a few years, and kmap_local_page()
> should be used instead, so replace it. Since the uprobes code relied on
> kmap_atomic() disabling page faults to access user pages, add the
> required calls to keep the existing behavior.

Are those pagefault_disable()s really needed here, or is this just
cargo-culting?

> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>  kernel/events/uprobes.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index d546d32390a8..38898435acfe 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -179,16 +179,24 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
>  
>  void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
>  {
> -	void *kaddr = kmap_atomic(page);
> +	void *kaddr = kmap_local_page(page);
> +
> +	pagefault_disable();
>  	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> -	kunmap_atomic(kaddr);
> +	pagefault_enable();
> +
> +	kunmap_local(kaddr);
>  }
>  
>  static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
>  {
> -	void *kaddr = kmap_atomic(page);
> +	void *kaddr = kmap_local_page(page);
> +
> +	pagefault_disable();
>  	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> -	kunmap_atomic(kaddr);
> +	pagefault_enable();
> +
> +	kunmap_local(kaddr);
>  }
>  
>  static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
> @@ -323,9 +331,10 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>  		return ret == 0 ? -EBUSY : ret;
>  	}
>  
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	ptr = kaddr + (vaddr & ~PAGE_MASK);
>  
> +	pagefault_disable();
>  	if (unlikely(*ptr + d < 0)) {
>  		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>  			"curr val: %d, delta: %d\n", vaddr, *ptr, d);
> @@ -336,7 +345,8 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>  	*ptr += d;
>  	ret = 0;
>  out:
> -	kunmap_atomic(kaddr);
> +	pagefault_enable();
> +	kunmap_local(kaddr);
>  	put_page(page);
>  	return ret;
>  }
> 
> base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
> -- 
> 2.51.0
> 
