Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A63D75C7;
	Fri, 29 May 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054350; cv=none; b=M5fUam8jfwD8acHDArFOOUOi6nCrhWvvODOTBAj3360Jin2/ZWDgg4hJj8JOLf3XUhZUfCPIky1zNHisc0wehqvVlKIykmdiZoB+hu4hSRcVdgV5Q1tqTApV+CF+1OJcRlsoA/igHw3QE184FJdDSGXfpS1tqcTXM9HbLAye7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054350; c=relaxed/simple;
	bh=nr7rhdeyG3LJD9e7/h1FV5+6v3pPDE5HjPSHeOZG2Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEfqCfEfHL3wWX0j3Ris1HfHhZ2QjHbV4xI60BEgTmZNm+rCeNJrRiu2+4WTnvwgvdgTZ7hcC/NtBv8LEuN5PGx0h+1yHCGop0Okj3H1i6Wyu7HsWs7n8rAP08j9lvNNPcYdelc0yfaR/LKEAWK9H0UE5dF81EcWphz3H5aFPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f8aDqoN1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f8aDqoN1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kxTIYV2ChupEytU4zCZURN+O2Mt+fI5Q/J7ZDzICX+k=; b=f8aDqoN1HjkC5EnLN7Fh3tLI4j
	2oqJQ4tPL9RoTVadMv7MyOblPseRZy1YTv9PA5ufiAgI60DLYE8neVOCLax1p+boCqhfFsGkS8eGi
	ENHue4GNK74oZD+14y3NYhPo3YEiFQ+NNwrGcoFK7PgLaOD7JPuBdAdEm3g3xP22RAiHUsbJyb7TN
	pDVfQNu2UE/S/S6bz6qJ4HfsptpLRDTgmVH5yWyzupjb1Y5Iot8S+oJerjZOcocueF7NnJZtH/S9g
	80rNKC8OIL+qLoZnudypnGABfdV6TWFzfFY8AZAc+/LzjXKz0sA9BdZ5MTKIzKG5Nt06WjoWBWq06
	BpArsb7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSvRq-00000001Apx-3tl7;
	Fri, 29 May 2026 11:32:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7DB130036F; Fri, 29 May 2026 13:32:18 +0200 (CEST)
Date: Fri, 29 May 2026 13:32:18 +0200
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
Subject: Re: [Patch v8 07/23] x86/fpu/xstate: Add xsaves_nmi() helper
Message-ID: <20260529113218.GJ3493090@noisy.programming.kicks-ass.net>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529075645.580362-8-dapeng1.mi@linux.intel.com>

On Fri, May 29, 2026 at 03:56:29PM +0800, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add xsaves_nmi() to save supported xsave states in NMI handler.
> 
> This function is similar to xsaves(), but should only be called within
> a NMI handler. This function returns the actual register contents at
> the moment the NMI occurs.
> 
> Currently the perf subsystem is the sole user of this helper. It uses
> this function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers
> which would be added in subsequent patches.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/include/asm/fpu/xstate.h |  1 +
>  arch/x86/kernel/fpu/xstate.c      | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 7a7dc9d56027..38fa8ff26559 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -110,6 +110,7 @@ int xfeature_size(int xfeature_nr);
>  
>  void xsaves(struct xregs_state *xsave, u64 mask);
>  void xrstors(struct xregs_state *xsave, u64 mask);
> +void xsaves_nmi(struct xregs_state *xsave, u64 mask);
>  
>  int xfd_enable_feature(u64 xfd_err);
>  
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a7b6524a9dea..4394091c4791 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1474,6 +1474,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
>  	WARN_ON_ONCE(err);
>  }
>  
> +/**
> + * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
> + * @xstate:	Pointer to the buffer
> + * @mask:	Feature mask to select the components to save
> + *
> + * This function is similar to xsaves(), but should only be called within
> + * a NMI handler. This function returns the actual register contents at
> + * the moment the NMI occurs.
> + *
> + * Currently, the perf subsystem is the sole user of this helper. It uses
> + * the function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers.
> + */
> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
> +{
> +	int err;
> +
> +	if (!in_nmi())
> +		return;
> +
> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
> +	WARN_ON_ONCE(err);
> +}

Sashiko raises a fun point vs skid; if an exclude_kernel=1 event trips
inside the kernel this can potentially leak a whole pile of kernel regs.

But of course the same thing is true for the existing setup. So perhaps
that doesn't need to concern us now.

There used to be discussions about this case, and I think we had generic
code to sanitize such boundary events, but I can't seem to find that in
the current tree.

Mark, ISTR you were involved at some point, any idea what happened?
