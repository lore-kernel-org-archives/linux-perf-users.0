Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F2233714;
	Tue, 25 Feb 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479976; cv=none; b=hamIzINLn++6iYv3oB3Y6S+8feIM5KA1LplFpwN3cWWECWR/KIpWqcmypLhxmUvtpKLnBBzz2c8J+QaM96fJR8u4I5uLQWGvEMKqLd5uNGhU+PEDHb8fkfyOtZxmNxShJv8Lq4kdLE1P7HZxS8AL8jOqhJoam0GHMFLaS5U8CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479976; c=relaxed/simple;
	bh=MhjAz31PsJOsLKQr8sgETsJKw7agLYNxVGwsA2xKZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIhMbOP/e0NfPU8gR2WtVRYKTE66kJYq/hDm8/pSl64XI7313Y1HGgIohCcwEzarauj7OqZzKZ4w5GiXArCmasdkFUtxQZdcUDae7o6w1zfqtWUdVqBu0Pipa6Lxc/dzmlHjEw4fmvNShOM85Pr2bplm++KMWUWl5fmQAXRs0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=omal9GZO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omal9GZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g+WLa7oq92+Y1jtkH3aP1QgXuaL7EynzcbvItzceDKo=; b=omal9GZOkZH/FOir3XQMAaosPo
	ENwJ3uWKRGsthcPiwbx5r5F6Oz9r/0QxFCEQbY7/9Ny3iIqlEygp3SssNPnDpWdA/1xl6dykVsHa9
	9Z2v0WBega/3r84U5nDLHgc4YiEB6gYgk1nRdNJR6SVz6qV7E3hD6xJ9A8xOC+sg6Cb4lKbmyp9jl
	ki0nPUuKuesvuqVtjjef2tZXCI0Cv3pPE4caIisrQGfnvEzvFQRyA+b7iXKiB/45HRwitlb+gmT/X
	NF3LS65ND08fShYBeJjkmP+tDTTbCDUTK55whAcVjqwiC6Y86xUS9LUgeRK2afKH2q2HwN808NKnz
	wFFec3Cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmsLY-0000000Ay5X-2lXI;
	Tue, 25 Feb 2025 10:39:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B45E13006E6; Tue, 25 Feb 2025 11:39:27 +0100 (CET)
Date: Tue, 25 Feb 2025 11:39:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
Message-ID: <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-11-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:04PM +0000, Dapeng Mi wrote:
> A significant difference with adaptive PEBS is that arch-PEBS record
> supports fragments which means an arch-PEBS record could be split into
> several independent fragments which have its own arch-PEBS header in
> each fragment.
> 
> This patch defines architectural PEBS record layout structures and add
> helpers to process arch-PEBS records or fragments. Only legacy PEBS
> groups like basic, GPR, XMM and LBR groups are supported in this patch,
> the new added YMM/ZMM/OPMASK vector registers capturing would be
> supported in subsequent patches.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c      |   9 ++
>  arch/x86/events/intel/ds.c        | 219 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/msr-index.h  |   6 +
>  arch/x86/include/asm/perf_event.h | 100 ++++++++++++++
>  4 files changed, 334 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 37540eb80029..184f69afde08 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3124,6 +3124,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>  	}
>  
> +	/*
> +	 * Arch PEBS sets bit 54 in the global status register
> +	 */
> +	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
> +				 (unsigned long *)&status)) {

Will arch_pebs hardware ever toggle bit 62?

> +		handled++;
> +		x86_pmu.drain_pebs(regs, &data);

		static_call(x86_pmu_drain_pebs)(regs, &data);

> +	}

