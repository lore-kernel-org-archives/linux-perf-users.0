Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E829D26C;
	Fri,  5 Dec 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933932; cv=none; b=Gz3AeBBF813UkDmKfINQXtUAhz/282x6Mj1WJlvC4xDGZXFa+NWEr119Uo9L/P31b1JYv9stnJ9sygXYt8ID7Vh/9H+F+7bjtiH2LprUdfHH6wlhxbBPTbO7m55qJs1FYCJSQdScE8L8m7vLSH6HDotrsWqj340I2coEFPzEQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933932; c=relaxed/simple;
	bh=nCAR78f9bIxdQYAkmXO0JLhY7dqd1t5QKHUAuomMX9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJLq0fbDbJYeldx/HQ8bp7ksAFLfVtJVh48Fe3LgPHZ/YDfULXPPnsHyAwpt/v5/3t84uOUn/edl3txce43VH/+Mwrf7rFC1/QbXosvDZRJODpS3SWj14jM1qslxsFwzDlC/5PsYRl60qClRJhMnRtV4QMvILVq2ExRc53qGDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWd/WOjV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWd/WOjV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xixygPZc16a0XN2JaaXL1J66d9bxT8M1Lz2+0X6mbv0=; b=gWd/WOjVxpVqIQf+dFTQMya0h4
	1bMIC5532W+1HO803jcCz7mrUmR0n5isEv3qp7ZAovJjXq0peFmdMbEsHD51bwqatIVR0mTDvhAU6
	k18ecSZtyqRpgv4XP1BVbl7wnx1zJXFvg4gwC4mJ0c6BYDQBd2ks4awAMMWxU44uKpSTMJC8+ePjF
	sHXbNSB8pSFH5OANUNfnI8h6Cj4vWBsBqZ9/iWVop3ytDla8dab16x0kJdvB+dpt56pNdXOuedRMG
	02hcxHL+q3Gigf3Wt7wjUz6erSsMYoTrC14SoFfOzCAv4kvMxP2ij4WM0tuCIfIfPn8xGeyw8T87U
	JzX9cQPQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRTw5-00000005coC-1eS1;
	Fri, 05 Dec 2025 11:25:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 470D330027B; Fri, 05 Dec 2025 12:25:16 +0100 (CET)
Date: Fri, 5 Dec 2025 12:25:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v5 08/19] perf/x86: Enable XMM sampling using
 sample_simd_vec_reg_* fields
Message-ID: <20251205112516.GU2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-9-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203065500.2597594-9-dapeng1.mi@linux.intel.com>

On Wed, Dec 03, 2025 at 02:54:49PM +0800, Dapeng Mi wrote:

> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index 7c9d2bb3833b..c3862e5fdd6d 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -55,4 +55,21 @@ enum perf_event_x86_regs {
>  
>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
>  
> +enum {
> +	PERF_REG_X86_XMM,
> +	PERF_REG_X86_MAX_SIMD_REGS,
> +};
> +
> +enum {
> +	PERF_X86_SIMD_XMM_REGS      = 16,
> +	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
> +};
> +
> +#define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
> +
> +enum {
> +	PERF_X86_XMM_QWORDS      = 2,
> +	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
> +};
> +
>  #endif /* _ASM_X86_PERF_REGS_H */

I don't understand this bit -- the next few patches add to it for YMM
and ZMM, but what's the point? I don't see why this is needed at all,
let alone why it needs to be UABI.
