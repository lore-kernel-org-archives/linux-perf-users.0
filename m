Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1823D7EC;
	Thu,  4 Sep 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967937; cv=none; b=s2hLqEZv21Xpk3nJn3ScOWH825aBoJUgFw169UoEA/pTCZ/L91GqBpml9j6h0Iq0hcHEicZH8Pzc3wi0wAd0GXkzCXUvnZX7J1JtiLutDP0JCxW7XT8Xyxsuvtdh/diJUqtOb6rrqXzulvZWYS0Fl7sVawROclqAsztct4hmD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967937; c=relaxed/simple;
	bh=mpimo695aXQfzG5brAJcrTJCFlxU223RcVt2D69ZLV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhfxQKEEIKemBUKfRo2+dkD0ThqehUZ5gJp4yW9jOUJus/oOdp/g9/B0KAgpKKp9RUYy4COCBuoxyVK2lYJwE6md8R0SZ5Vvc+1Y/tOktAtfs1syrCWMt9YuSwOVGiHEYg2P8lx6i9yczqkD8T27AJKfplvtWvjN9yOOyDDiL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TEEa2VkP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TEEa2VkP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V2XVkscTs+i5+vJ4MKvvhrBrD/Sub/SqyCqSzizvVaI=; b=TEEa2VkPTiHLXKQrgzL4vG3QGH
	gaGelYhttVsACG0Oxs7GvaX1pKbt9vf/ogJSTh7jCe67bdXmvGAHLL6R4TFru0IQdfxzjaygKBkoi
	cPZ/vInmWvN9w3pJ7k8u6s/D9pCM4SgicC975q5p7GW+kKYCn2g3HuN7TjzB9wiTFrIuprW0p9JKE
	vo0OLncH+axpSmIImS0pJdSIq220xc0FDW/rXZ4IYrNblbUOwgFe4ZP3sgP80fEJPUsTceVC+OXPK
	bV2LTSSXu4+XsieyC/CIOaJ03D7WvHybOtbqZfsRXxZl628Yys0i72q+o17rgodLPRr6Cro4dYAtt
	b/sNSGRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3c9-0000000EDik-0fUS;
	Thu, 04 Sep 2025 06:38:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E43A63002BF; Thu, 04 Sep 2025 08:38:32 +0200 (CEST)
Date: Thu, 4 Sep 2025 08:38:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Message-ID: <20250904063832.GT4067720@noisy.programming.kicks-ass.net>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-6-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-6-wangjinchao600@gmail.com>

On Thu, Sep 04, 2025 at 08:21:02AM +0800, Jinchao Wang wrote:
> Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
> parameters (address, length, type) without freeing and reallocating the
> debug register slot.
> 
> This allows atomic updates in contexts where memory allocation is not
> permitted, such as kprobe handlers.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  arch/x86/include/asm/hw_breakpoint.h |  1 +
>  arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index 0bc931cd0698..bb7c70ad22fe 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>  
>  
>  int arch_install_hw_breakpoint(struct perf_event *bp);
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>  void hw_breakpoint_pmu_read(struct perf_event *bp);
>  void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index b01644c949b2..89135229ed21 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return 0;
>  }
>  
> +/*
> + * Reinstall a hardware breakpoint on the current CPU.
> + *
> + * This function is used to re-establish a perf counter hardware breakpoint.
> + * It finds the debug address register slot previously allocated for the
> + * breakpoint and re-enables it by writing the address to the debug register
> + * and setting the corresponding bits in the debug control register (DR7).
> + *
> + * It is expected that the breakpoint's event context lock is already held
> + * and interrupts are disabled, ensuring atomicity and safety from other
> + * event handlers.
> + */
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	unsigned long *dr7;
> +	int i;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	for (i = 0; i < HBP_NUM; i++) {
> +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> +
> +		if (*slot == bp)
> +			break;
> +	}
> +
> +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
> +		return -EINVAL;
> +
> +	set_debugreg(info->address, i);
> +	__this_cpu_write(cpu_debugreg[i], info->address);
> +
> +	dr7 = this_cpu_ptr(&cpu_dr7);
> +	*dr7 |= encode_dr7(i, info->len, info->type);
> +
> +	/*
> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	barrier();
> +
> +	set_debugreg(*dr7, 7);
> +	if (info->mask)
> +		amd_set_dr_addr_mask(info->mask, i);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);

Yeah, I think not. For one this is an almost verbatim copy of
arch_install_hw_breakpoint() with zero re-use. Surely you've been taught
better?

And why would we want to export guts like this?
