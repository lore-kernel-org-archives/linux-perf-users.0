Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925B1F542A;
	Tue, 15 Apr 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727795; cv=none; b=pEMjAFi0zLZjajjZU0mFz2jXm877GMCMY/AXuqCUbYomSH5ChxAIMuWSYUkEOvc58RbpUZWb04BNXnDPvpGIxtYHxMkXRESK7hnTqzct3HomUApWVmUVmVamROFdsg7VQasKL/rLoH3oUYUf0FoPvi8WVq9ACUah+VoXY+cL1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727795; c=relaxed/simple;
	bh=5OloNItBXeNaQrrBR7BYSocSDERn1by4G6m4Cq6pkSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC14lgg8gjDHsq6c3jbksTvCrXMxm7tj6P8wC7RDAr7g83dlPolK6IOnJrNG5hZmkcwF8T7nrAXKGyYWMSeUCV+SMmG/OxsyHeAfUbOm16swK0+3XCc4/y6qLL55O40EybhQIzQqqkbYLfvpvoNVbzpcth+XN7lrkMDZZmez60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aeW3httJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeW3httJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F33+DEQZj1fporr7X07uf5/8kkoGaT+CFGg3GXQR2js=; b=aeW3httJ5mUFvFNnUhv/7A9R6W
	8QN7VxRWtsqfShuAR2Q5ohht/RFelviP+kxFvRNU3bzy9CRyiKbquzhUV24PyQbh/kgv1jKAxxjP0
	gIhGyy+V8lVimcZwWwL1PCyOdV7t7bW9nq37E3kkkvN4/iQopCw4LU4FUcNB5oX4KeqKbOaeVwuNW
	FZu7aRF+wA9tTED+1PPcH6cAiqsb1F/QpbfYVLi5/ZzU5cUkBBfwQ8Qd1jJ5faHERnFry4xXNdiyV
	Jf6NlobtV6FLHqzEIJP3VPhSuYt0o7Tn0+IQTsW2STy169ir1SF9BM75SwZRFEJVSQ6ZsskVL6o0D
	Rw+PEWCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4hOl-00000009uYb-0P9M;
	Tue, 15 Apr 2025 14:36:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 59852300619; Tue, 15 Apr 2025 16:36:26 +0200 (CEST)
Date: Tue, 15 Apr 2025 16:36:26 +0200
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
Subject: Re: [Patch v3 16/22] perf/core: Support to capture higher width
 vector registers
Message-ID: <20250415143626.GF4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-17-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114428.341182-17-dapeng1.mi@linux.intel.com>

On Tue, Apr 15, 2025 at 11:44:22AM +0000, Dapeng Mi wrote:
>  extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index f9c5b16b1882..5e2d9796b2cc 100644
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
> @@ -53,6 +53,83 @@ enum perf_event_x86_regs {
>  
>  	/* These include both GPRs and XMMX registers */
>  	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
> +
> +	/* Leave bits[127:64] for other GP registers, like R16 ~ R31.*/
> +
> +	/*
> +	 * Each YMM register need 4 bits to represent because they are 256 bits.
> +	 * PERF_REG_X86_YMMH0 = 128
> +	 */
> +	PERF_REG_X86_YMM0	= 128,
> +	PERF_REG_X86_YMM1	= PERF_REG_X86_YMM0 + 4,
> +	PERF_REG_X86_YMM2	= PERF_REG_X86_YMM1 + 4,
> +	PERF_REG_X86_YMM3	= PERF_REG_X86_YMM2 + 4,
> +	PERF_REG_X86_YMM4	= PERF_REG_X86_YMM3 + 4,
> +	PERF_REG_X86_YMM5	= PERF_REG_X86_YMM4 + 4,
> +	PERF_REG_X86_YMM6	= PERF_REG_X86_YMM5 + 4,
> +	PERF_REG_X86_YMM7	= PERF_REG_X86_YMM6 + 4,
> +	PERF_REG_X86_YMM8	= PERF_REG_X86_YMM7 + 4,
> +	PERF_REG_X86_YMM9	= PERF_REG_X86_YMM8 + 4,
> +	PERF_REG_X86_YMM10	= PERF_REG_X86_YMM9 + 4,
> +	PERF_REG_X86_YMM11	= PERF_REG_X86_YMM10 + 4,
> +	PERF_REG_X86_YMM12	= PERF_REG_X86_YMM11 + 4,
> +	PERF_REG_X86_YMM13	= PERF_REG_X86_YMM12 + 4,
> +	PERF_REG_X86_YMM14	= PERF_REG_X86_YMM13 + 4,
> +	PERF_REG_X86_YMM15	= PERF_REG_X86_YMM14 + 4,
> +	PERF_REG_X86_YMM_MAX	= PERF_REG_X86_YMM15 + 4,
> +
> +	/*
> +	 * Each ZMM register needs 8 bits to represent because they are 512 bits
> +	 * PERF_REG_X86_ZMMH0 = 192
> +	 */
> +	PERF_REG_X86_ZMM0	= PERF_REG_X86_YMM_MAX,
> +	PERF_REG_X86_ZMM1	= PERF_REG_X86_ZMM0 + 8,
> +	PERF_REG_X86_ZMM2	= PERF_REG_X86_ZMM1 + 8,
> +	PERF_REG_X86_ZMM3	= PERF_REG_X86_ZMM2 + 8,
> +	PERF_REG_X86_ZMM4	= PERF_REG_X86_ZMM3 + 8,
> +	PERF_REG_X86_ZMM5	= PERF_REG_X86_ZMM4 + 8,
> +	PERF_REG_X86_ZMM6	= PERF_REG_X86_ZMM5 + 8,
> +	PERF_REG_X86_ZMM7	= PERF_REG_X86_ZMM6 + 8,
> +	PERF_REG_X86_ZMM8	= PERF_REG_X86_ZMM7 + 8,
> +	PERF_REG_X86_ZMM9	= PERF_REG_X86_ZMM8 + 8,
> +	PERF_REG_X86_ZMM10	= PERF_REG_X86_ZMM9 + 8,
> +	PERF_REG_X86_ZMM11	= PERF_REG_X86_ZMM10 + 8,
> +	PERF_REG_X86_ZMM12	= PERF_REG_X86_ZMM11 + 8,
> +	PERF_REG_X86_ZMM13	= PERF_REG_X86_ZMM12 + 8,
> +	PERF_REG_X86_ZMM14	= PERF_REG_X86_ZMM13 + 8,
> +	PERF_REG_X86_ZMM15	= PERF_REG_X86_ZMM14 + 8,
> +	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMM15 + 8,
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
> +	 * PERF_REG_X86_OPMASK0 = 448
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

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 5fc753c23734..78aae0464a54 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -379,6 +379,10 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
> +#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
> +
> +#define PERF_EXT_REGS_ARRAY_SIZE	7
> +#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -533,6 +537,13 @@ struct perf_event_attr {
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

I still utterly hate this interface. This is a giant waste of bits.

What makes it even worse is that XMMn is the lower half of YMMn which in
turn is the lower half of ZMMn.

So by exposing only ZMMn you already expose all of them. The interface
explicitly allows asking for sub-words.

But most importantly of all, last time I asked if there are users that
actually care about the whole per-register thing and I don't see an
answer here.

Can we please find a better interface? Ideally one that scales up to
1024 and 2048 bit vector width, because I'd hate to have to rev this
again.

Perhaps add sample_vec_regs_*[] with a saner format, and if that is !0
then the XMM regs dissapear from sample_regs_*[] and we get to use that
space to extended GPs.

