Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9841DF27D;
	Mon,  3 Feb 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582999; cv=none; b=gK4dGNbETZqTQnpU/IvN1Zdsv7KCRdHOihJBRACCKFfkhwVkMLYxaCAxvgrDnmrTfnz0WoDh4RV/2rhaaGrGLwSF9Un1BVYGPxHm/mrLB4u0m/es+xLorLYZ3xz0M8I+cpN4GwNHOhPRunfMAllI3N81ETIAOUBOEMZ8sY5zGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582999; c=relaxed/simple;
	bh=LxtA9+OyABAgOu4Ko+tn7o4gfdQ2ERBebHBgYT/EBX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYmKGK8Txz1otRvLSQn3IjVWgEgw8Pl0Zx/6AwhcvyJugH2HkJrn0NdC+ixZWSW4Mu8R8gQGyqcCnzzH29VVOu0VM+uQFc+HQ+JU7y4UDFkBi9GOXmHZGcNmgdNEAc49PsVtosAjAiB29l+wHEqbm7ons4QSUK2buVIBmGIhQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M0ifH9fI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M0ifH9fI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=btXXAPOazkj5DVi+1L404K6Uyxw16gswkuGE52yhV0o=; b=M0ifH9fITMzADf34o4YPQNJdHp
	6X3eJAjlJiputSGI+Vsv/oTXw7axc6T8dl/2Ue10pZEVDpNe9qBupAlqffD0kE5EoOXx733Ffzuuw
	xKObyxDGAom/pCU89PRq09baaeibRFD4ZkEaAH3pbz8ltKPvAzoV4qhJUodeIs2Dy4gQWJVvJAPrD
	0c7g9Ic6sQrkeyicDZhRZ+VI51J3OkpplkZ6jy/Nrb2LxbuuiPcapYLbmyis9qMZg1ovSe/bu/bzC
	SrAPxjITpYNZNjfKp+tplNmanQT7yAe7+iGvvmztSa+P2Hnwahirk0/K3Ce9r4flcaF62ua3N5W5t
	V51nRMEg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teur8-00000000yxa-3Io8;
	Mon, 03 Feb 2025 11:43:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62B1930035F; Mon,  3 Feb 2025 12:43:10 +0100 (CET)
Date: Mon, 3 Feb 2025 12:43:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Ensure LBRs are disabled when a CPU is
 starting
Message-ID: <20250203114310.GF505@noisy.programming.kicks-ass.net>
References: <20250131010721.470503-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131010721.470503-1-seanjc@google.com>

On Thu, Jan 30, 2025 at 05:07:21PM -0800, Sean Christopherson wrote:
> Explicitly clear DEBUGCTL.LBR when a CPU is starting, prior to purging the
> LBR MSRs themselves, as at least one system has been found to transfer
> control to the kernel with LBRs enabled (it's unclear whether it's a BIOS
> flaw or a CPU goof).  Because the kernel preserves the original DEBUGCTL,
> even when toggling LBRs, leaving DEBUGCTL.LBR as is results in running
> with LBRs enabled at all times.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Closes: https://lore.kernel.org/all/c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c     | 5 ++++-
>  arch/x86/include/asm/msr-index.h | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e76e892f44cd..efd069bc9c28 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5038,8 +5038,11 @@ static void intel_pmu_cpu_starting(int cpu)
>  
>  	init_debug_store_on_cpu(cpu);
>  	/*
> -	 * Deal with CPUs that don't clear their LBRs on power-up.
> +	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
> +	 * even boot with LBRs enabled.
>  	 */
> +	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && x86_pmu.lbr_nr)
> +		msr_clear_bit(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR_BIT);
>  	intel_pmu_lbr_reset();

Gotta love this stuff.

Thanks!
