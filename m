Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB0EEDE;
	Sun, 18 May 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747605488; cv=none; b=NVa0woOmdIqY+z6ZanZXdn9nGhZpH63UUGVpKd0QDipzSOODcmVOmXidAYqa5PmtjlLv9SXF6qlxc4RJeFI2Aa8lGDoqkylp1dEGpZ3tS0c459/o1zT578Ja35RtiNNAzH1Sta8cxCO4NHaSgTlxb/SQIBc7J0BPgAsNm7RMXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747605488; c=relaxed/simple;
	bh=JSbrJ9wGpbanvFoNCJ5/IWVBUzZlZ6E6rupdyUm9PIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYuth7ZES1ZEibwuyvL93J9ndOBe7Os8oh+ST23bzL560fKW2+UpXki0D7oaFSMgq8tzRJCsRdOdc2zpr2lYNV141gIrU13WSCQYgZwhBmaakwSXQ2n0OWcgwLIG/LZguQl/u6olvoT/8njAwpWTqCk+MZhijCY8/Aoh6/csbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urMOlBhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urMOlBhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63047C4CEE7;
	Sun, 18 May 2025 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747605487;
	bh=JSbrJ9wGpbanvFoNCJ5/IWVBUzZlZ6E6rupdyUm9PIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=urMOlBhY1pnR/pIQXb/88LCMfrdSq5HKPSRyUFycRg7yDxaiqCkEBmE+Gfr0kwfI3
	 YBYtAisU4GiLz58laz9us+WbQV0031kBxyg9X/R6xvaHW0lzILswZ3t2+y/oKb9saB
	 V8mZrWx6a+hi2WcoN7du4eSK99gdvq5ic1kBPKOgh9fb6PvLZ7+fq1z5sJ2Lz0/vKr
	 aUsY255NImn78wNYvYGA9/FJL/5tYPnjCYnDe/o38v3/BP2icMw8H6i/t/GHcG1Yup
	 pUYjwjvfKZw43ghfFJVejS+9c6j3/r73yENM7yYiGLLaDhgf03UgNhEpJ8tp7+LMs9
	 0z26xd6JfWMbg==
Message-ID: <c3fa9e90-a94b-47f7-b911-ed7c97fd1d6f@kernel.org>
Date: Sun, 18 May 2025 14:58:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/16] arc/perf: Remove driver-specific throttle
 support
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, irogers@google.com, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
 leo.yan@arm.com, linux-snps-arc@lists.infradead.org
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
 <20250516182853.2610284-12-kan.liang@linux.intel.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20250516182853.2610284-12-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/16/25 11:28, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
>
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Vineet Gupta <vgupta@ikernel.org>
> Cc: linux-snps-arc@lists.infradead.org
Acked-by: Vineet Gupta <vgupta@kernel.org>

Please let me know if you wane to take it via ARC tree.

Thx,
-Vineet

> ---
>  arch/arc/kernel/perf_event.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
> index 6e5a651cd75c..ed6d4f0cd621 100644
> --- a/arch/arc/kernel/perf_event.c
> +++ b/arch/arc/kernel/perf_event.c
> @@ -599,10 +599,8 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
>  
>  		arc_perf_event_update(event, &event->hw, event->hw.idx);
>  		perf_sample_data_init(&data, 0, hwc->last_period);
> -		if (arc_pmu_event_set_period(event)) {
> -			if (perf_event_overflow(event, &data, regs))
> -				arc_pmu_stop(event, 0);
> -		}
> +		if (arc_pmu_event_set_period(event))
> +			perf_event_overflow(event, &data, regs);
>  
>  		active_ints &= ~BIT(idx);
>  	} while (active_ints);

