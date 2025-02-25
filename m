Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5B20E713;
	Tue, 25 Feb 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515554; cv=none; b=Xqk9Rl142ga6xog93vkasrl5ETGq/JQ6ztZHWqv03PCHPBz3qgu2O8VlimEH2/eDjkCf2UIHDqTQLHFvPSRUDs3qCCw3dHW9qXOGxJCRqHuUBee/uQl9Umyj6vGD9ERKeWwOaWAUzDt9qfJQIYZHyo/79apl2dBQHMyPaCWz1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515554; c=relaxed/simple;
	bh=HrY16MuKJ0t/yC+/pOKrWXInfKwieWik7OdUcGsbnGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQU/84aCP0HT6WnWZYs3OTYBAVFHbsil8VBQWTe1Vfe3EYDiP8U8vOadYBTNbcbaON+DfoX4td2PlE7Q9DZV9AGDBueNGsV0zUHqCYcuRO+JrSUoC1+Ik2tI5QG7+tTC6vUIf2UM0SI+I0W5W4fH8E3jo9Sxo2lMfWj5Jws7QZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hnEW1imu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnEW1imu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QkEbOEhQdJwQDtDmCT8g7OJdt6uh2XSoL9PZrCV3FY8=; b=hnEW1imuKDKm1OsC9ijMsjBqoZ
	JtpHm9eGXzdKJ8pHI8pzp0msaSpUQC2O6IVgVi1dQqz5L1Y+c10+f6WtSAJq+YycW5dqRniIUVWR+
	tcMDX6/sD583kE8VPlC6AtQQYRNB4d0reU55z93FrbY7xgjZp/1yVbwkhvQasGyTMRT5lvOxrHIQh
	Mnlmk19XKw+oAbaOXmm3z+eTVQfZ032G0od3VGnVIXZaF/e9SFk48mNrnmtqDY3FkH1sCXVzaswYY
	fjtAl9lCM2l7lSJ9htl7XIH2q9zRKUr1iGr2eRsPWe/YLKu2MyHJ4ivEWeBIWQXI2Qhoi46tuVScb
	VzI9piRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1bM-0000000CYL0-47sC;
	Tue, 25 Feb 2025 20:32:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8EB5F300472; Tue, 25 Feb 2025 21:32:24 +0100 (CET)
Date: Tue, 25 Feb 2025 21:32:24 +0100
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
Subject: Re: [Patch v2 17/24] perf/core: Support to capture higher width
 vector registers
Message-ID: <20250225203224.GB1278@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-18-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-18-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:11PM +0000, Dapeng Mi wrote:
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index 9ee9e55aed09..3851f627ca60 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -33,7 +33,7 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>  	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
>  
> -	/* These all need two bits set because they are 128bit */
> +	/* These all need two bits set because they are 128 bits */
>  	PERF_REG_X86_XMM0  = 32,
>  	PERF_REG_X86_XMM1  = 34,
>  	PERF_REG_X86_XMM2  = 36,
> @@ -53,6 +53,87 @@ enum perf_event_x86_regs {
>  
>  	/* These include both GPRs and XMMX registers */
>  	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
> +
> +	/*
> +	 * YMM upper bits need two bits set because they are 128 bits.
> +	 * PERF_REG_X86_YMMH0 = 64
> +	 */
> +	PERF_REG_X86_YMMH0	= PERF_REG_X86_XMM_MAX,
> +	PERF_REG_X86_YMMH1	= PERF_REG_X86_YMMH0 + 2,
> +	PERF_REG_X86_YMMH2	= PERF_REG_X86_YMMH1 + 2,
> +	PERF_REG_X86_YMMH3	= PERF_REG_X86_YMMH2 + 2,
> +	PERF_REG_X86_YMMH4	= PERF_REG_X86_YMMH3 + 2,
> +	PERF_REG_X86_YMMH5	= PERF_REG_X86_YMMH4 + 2,
> +	PERF_REG_X86_YMMH6	= PERF_REG_X86_YMMH5 + 2,
> +	PERF_REG_X86_YMMH7	= PERF_REG_X86_YMMH6 + 2,
> +	PERF_REG_X86_YMMH8	= PERF_REG_X86_YMMH7 + 2,
> +	PERF_REG_X86_YMMH9	= PERF_REG_X86_YMMH8 + 2,
> +	PERF_REG_X86_YMMH10	= PERF_REG_X86_YMMH9 + 2,
> +	PERF_REG_X86_YMMH11	= PERF_REG_X86_YMMH10 + 2,
> +	PERF_REG_X86_YMMH12	= PERF_REG_X86_YMMH11 + 2,
> +	PERF_REG_X86_YMMH13	= PERF_REG_X86_YMMH12 + 2,
> +	PERF_REG_X86_YMMH14	= PERF_REG_X86_YMMH13 + 2,
> +	PERF_REG_X86_YMMH15	= PERF_REG_X86_YMMH14 + 2,
> +	PERF_REG_X86_YMMH_MAX	= PERF_REG_X86_YMMH15 + 2,
> +
> +	/*
> +	 * ZMM0-15 upper bits need four bits set because they are 256 bits
> +	 * PERF_REG_X86_ZMMH0 = 96
> +	 */
> +	PERF_REG_X86_ZMMH0	= PERF_REG_X86_YMMH_MAX,
> +	PERF_REG_X86_ZMMH1	= PERF_REG_X86_ZMMH0 + 4,
> +	PERF_REG_X86_ZMMH2	= PERF_REG_X86_ZMMH1 + 4,
> +	PERF_REG_X86_ZMMH3	= PERF_REG_X86_ZMMH2 + 4,
> +	PERF_REG_X86_ZMMH4	= PERF_REG_X86_ZMMH3 + 4,
> +	PERF_REG_X86_ZMMH5	= PERF_REG_X86_ZMMH4 + 4,
> +	PERF_REG_X86_ZMMH6	= PERF_REG_X86_ZMMH5 + 4,
> +	PERF_REG_X86_ZMMH7	= PERF_REG_X86_ZMMH6 + 4,
> +	PERF_REG_X86_ZMMH8	= PERF_REG_X86_ZMMH7 + 4,
> +	PERF_REG_X86_ZMMH9	= PERF_REG_X86_ZMMH8 + 4,
> +	PERF_REG_X86_ZMMH10	= PERF_REG_X86_ZMMH9 + 4,
> +	PERF_REG_X86_ZMMH11	= PERF_REG_X86_ZMMH10 + 4,
> +	PERF_REG_X86_ZMMH12	= PERF_REG_X86_ZMMH11 + 4,
> +	PERF_REG_X86_ZMMH13	= PERF_REG_X86_ZMMH12 + 4,
> +	PERF_REG_X86_ZMMH14	= PERF_REG_X86_ZMMH13 + 4,
> +	PERF_REG_X86_ZMMH15	= PERF_REG_X86_ZMMH14 + 4,
> +	PERF_REG_X86_ZMMH_MAX	= PERF_REG_X86_ZMMH15 + 4,
> +
> +	/*
> +	 * ZMM16-31 need eight bits set because they are 512 bits
> +	 * PERF_REG_X86_ZMM16 = 160
> +	 */
> +	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMMH_MAX,
> +	PERF_REG_X86_ZMM17	= PERF_REG_X86_ZMM16 + 8,
> +	PERF_REG_X86_ZMM18	= PERF_REG_X86_ZMM17 + 8,
> +	PERF_REG_X86_ZMM19	= PERF_REG_X86_ZMM18 + 8,
> +	PERF_REG_X86_ZMM20	= PERF_REG_X86_ZMM19 + 8,
> +	PERF_REG_X86_ZMM21	= PERF_REG_X86_ZMM20 + 8,
> +	PERF_REG_X86_ZMM22	= PERF_REG_X86_ZMM21 + 8,
> +	PERF_REG_X86_ZMM23	= PERF_REG_X86_ZMM22 + 8,
> +	PERF_REG_X86_ZMM24	= PERF_REG_X86_ZMM23 + 8,
> +	PERF_REG_X86_ZMM25	= PERF_REG_X86_ZMM24 + 8,
> +	PERF_REG_X86_ZMM26	= PERF_REG_X86_ZMM25 + 8,
> +	PERF_REG_X86_ZMM27	= PERF_REG_X86_ZMM26 + 8,
> +	PERF_REG_X86_ZMM28	= PERF_REG_X86_ZMM27 + 8,
> +	PERF_REG_X86_ZMM29	= PERF_REG_X86_ZMM28 + 8,
> +	PERF_REG_X86_ZMM30	= PERF_REG_X86_ZMM29 + 8,
> +	PERF_REG_X86_ZMM31	= PERF_REG_X86_ZMM30 + 8,
> +	PERF_REG_X86_ZMM_MAX	= PERF_REG_X86_ZMM31 + 8,
> +
> +	/*
> +	 * OPMASK Registers
> +	 * PERF_REG_X86_OPMASK0 = 288
> +	 */
> +	PERF_REG_X86_OPMASK0	= PERF_REG_X86_ZMM_MAX,
> +	PERF_REG_X86_OPMASK1	= PERF_REG_X86_OPMASK0 + 1,
> +	PERF_REG_X86_OPMASK2	= PERF_REG_X86_OPMASK1 + 1,
> +	PERF_REG_X86_OPMASK3	= PERF_REG_X86_OPMASK2 + 1,
> +	PERF_REG_X86_OPMASK4	= PERF_REG_X86_OPMASK3 + 1,
> +	PERF_REG_X86_OPMASK5	= PERF_REG_X86_OPMASK4 + 1,
> +	PERF_REG_X86_OPMASK6	= PERF_REG_X86_OPMASK5 + 1,
> +	PERF_REG_X86_OPMASK7	= PERF_REG_X86_OPMASK6 + 1,
> +
> +	PERF_REG_X86_VEC_MAX	= PERF_REG_X86_OPMASK7 + 1,
>  };
>  
>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 0524d541d4e3..8a17d696d78c 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -379,6 +379,10 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
> +#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
> +
> +#define PERF_EXT_REGS_ARRAY_SIZE	4
> +#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -531,6 +535,13 @@ struct perf_event_attr {
>  	__u64	sig_data;
>  
>  	__u64	config3; /* extension of config2 */
> +
> +	/*
> +	 * Extension sets of regs to dump for each sample.
> +	 * See asm/perf_regs.h for details.
> +	 */
> +	__u64	sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE];
> +	__u64   sample_regs_user_ext[PERF_EXT_REGS_ARRAY_SIZE];
>  };
>  
>  /*

*groan*... so do people really need per-register (or even partial
register) masks for all this?

Or can we perhaps -- like XSAVE/PEBS -- do it per register group?

Also, we're going to be getting EGPRs, which I think just about fit in
this 320 bit mask we now have, but it is quite insane.
