Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707F1FDE31;
	Fri, 16 Jan 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577232; cv=none; b=SdCNAFNvrIN6ma49tG/xmIAswYgDwLUKmJ+sG+ynOHb5K80+IteBes+3skg9nN5MWmXX9hBdr+Ban1JxlFGRPgeWynyDRjcn6LL01C2AD7lxDP/raK9NgyFWo7Tmg/9XR7H2Uze2qdgamTEzea3qpYd/7esawYdyjuyhOS2WaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577232; c=relaxed/simple;
	bh=GHdKe6MrN+POgw8s+p42M8nBMB8sTHKWSIMRgJcnVC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGNdHoXgGDVVKV9P/dE4OGxLlIxsHBvUUkv6qIcsvzfOVVHsjh3QswYglehFVhg6GtbI5TEPulnkoMA5fBVUAyNNMSWcz7sP+HeEpD/X9OB3OOA50NQ8tCZjaoINtw7vRtQU4x7qGeNT5pDcC23W5pGKWR/a+sAyTzWo1luVDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C9E1515;
	Fri, 16 Jan 2026 07:26:58 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66AE3F59E;
	Fri, 16 Jan 2026 07:27:04 -0800 (PST)
Date: Fri, 16 Jan 2026 15:27:02 +0000
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 2/8] tools/include: Sync uapi/linux/perf.h with
 the kernel sources
Message-ID: <20260116152702.GC1286628@e132581.arm.com>
References: <20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com>
 <20260106-perf_support_arm_spev1-3-v4-2-b887bb999f6e@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-perf_support_arm_spev1-3-v4-2-b887bb999f6e@arm.com>

On Tue, Jan 06, 2026 at 12:07:52PM +0000, Leo Yan wrote:
> Sync for extended memory operation bit fields.

Hi Peter, Ingo,

This patch is important for enabling the Arm SPE feature, I appreciate
if you could give a review; otherwise, the changes in the perf cannot
proceed.

Thanks a lot!

> Reviewed-by: James Clark <james.clark@linaro.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index c44a8fb3e4181c91a1e6e3a40e23fcf1de421af3..3d2c5ee9282efc4a2310f554443082f1d0027889 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1330,14 +1330,32 @@ union perf_mem_data_src {
>  			mem_snoopx  :  2, /* Snoop mode, ext */
>  			mem_blk     :  3, /* Access blocked */
>  			mem_hops    :  3, /* Hop level */
> -			mem_rsvd    : 18;
> +			mem_op_ext  :  4, /* Extended type of opcode */
> +			mem_dp      :  1, /* Data processing */
> +			mem_fp      :  1, /* Floating-point */
> +			mem_pred    :  1, /* Predicated */
> +			mem_atomic  :  1, /* Atomic operation */
> +			mem_excl    :  1, /* Exclusive */
> +			mem_ar      :  1, /* Acquire/release */
> +			mem_sg      :  1, /* Scatter/Gather */
> +			mem_cond    :  1, /* Conditional */
> +			mem_rsvd    :  6;
>  	};
>  };
>  #elif defined(__BIG_ENDIAN_BITFIELD)
>  union perf_mem_data_src {
>  	__u64 val;
>  	struct {
> -		__u64	mem_rsvd    : 18,
> +		__u64	mem_rsvd    :  6,
> +			mem_cond    :  1, /* Conditional */
> +			mem_sg      :  1, /* Scatter/Gather */
> +			mem_ar      :  1, /* Acquire/release */
> +			mem_excl    :  1, /* Exclusive */
> +			mem_atomic  :  1, /* Atomic operation */
> +			mem_pred    :  1, /* Predicated */
> +			mem_fp      :  1, /* Floating-point */
> +			mem_dp      :  1, /* Data processing */
> +			mem_op_ext  :  4, /* Extended type of opcode */
>  			mem_hops    :  3, /* Hop level */
>  			mem_blk     :  3, /* Access blocked */
>  			mem_snoopx  :  2, /* Snoop mode, ext */
> @@ -1447,6 +1465,16 @@ union perf_mem_data_src {
>  /* 5-7 available */
>  #define PERF_MEM_HOPS_SHIFT			43
>  
> +/* Extended type of memory opcode: */
> +#define PERF_MEM_EXT_OP_NA			0x0    /* Not available */
> +#define PERF_MEM_EXT_OP_MTE_TAG			0x1    /* MTE tag */
> +#define PERF_MEM_EXT_OP_NESTED_VIRT		0x2    /* Nested virtualization */
> +#define PERF_MEM_EXT_OP_MEMCPY			0x3    /* Memory copy */
> +#define PERF_MEM_EXT_OP_MEMSET			0x4    /* Memory set */
> +#define PERF_MEM_EXT_OP_SIMD			0x5    /* SIMD */
> +#define PERF_MEM_EXT_OP_GCS			0x6    /* Guarded Control Stack */
> +#define PERF_MEM_EXT_OP_SHIFT			46
> +
>  #define PERF_MEM_S(a, s) \
>  	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>  
> 
> -- 
> 2.34.1
> 
