Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A0330B20;
	Thu, 13 Nov 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021724; cv=none; b=u+77wZOjR5l6NERYp2uLtJjaR4bZqWwouimXYlsVXA2WgWTippcKyzYAotp/cv+tY2nsPVeKfC7B6/i+kjAH4lVn+HsUhgWxGB4zRobGoCMWLbq6PNgXpuzKv74yP4BytESRUyAnlAwgxKMd9x9fGJHbW9nqWgYtk924OaQWm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021724; c=relaxed/simple;
	bh=IrWt0GBFAOLmbRb2yzvFom08GooaWbZxyndP31v3F4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHcp0cabvOGEOCbFmGCcQGDJ+SFWuJyJayRgFpTrTP9/8OOnSpG7ngfQQeDt+1fCLNyEgEHz+VpHTzzqTF+mX4W42/OYKEx+rs7bZ/92U717/95y6AfLjwgrnSUVYXMp+rWoKdvTmd2xGqYZ22lKDhANNdCiJkQTl1nI5sV0pZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQBNX9ms; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQBNX9ms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763021722; x=1794557722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IrWt0GBFAOLmbRb2yzvFom08GooaWbZxyndP31v3F4g=;
  b=FQBNX9mslx+xElV6ou4jK4ER2YmIQiBx1QzhLBM5gQsfLUhUsagrwUNU
   QRUBAO2G/uhJF5E4yeUvTZOjClmKkhZuyGnJXXHdiM6yF8WaUHCBd8PyC
   SKPh4eDI9Jtth7glNOlwt3KMuXgIkyc2Xyd/qtrr/FaI7+WCr4K5Frali
   MukzyX2DI+LRrefP+8HKQmNr71fCTv1QjOeXcCuAuweMXC5k6ZyRfIJ5q
   i08HzqpPygp41WmWgwZRvf47XsdSQ34BR2cNac6UQtj2KnM5QlNb5s7FM
   lkMkNZ7nGZ8khNhe8FBot3oq0XN1BC//P74YsBdL51nSptxTDsB4z7bq4
   Q==;
X-CSE-ConnectionGUID: r2S0w1IGSq2uqvPyeNDv/w==
X-CSE-MsgGUID: M/9rFgUMSYOpe8xiq9NXLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76441264"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="76441264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:15:21 -0800
X-CSE-ConnectionGUID: PnJ6MBGxSXaVAr+HrhgLVg==
X-CSE-MsgGUID: FcFThzYFTsyuDmwXzSjmXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="193558781"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:15:18 -0800
Message-ID: <8dd3659d-8395-49da-94c0-3f18880ead1f@linux.intel.com>
Date: Thu, 13 Nov 2025 16:15:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Fix lockdep warning in perf_event_throttle_group
To: Jianhui Zhou <jianhuizz@qq.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, jonaszhou@zhaoxin.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
References: <tencent_5A81C3E27E416B65341A899C62ADD6FF0D0A@qq.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <tencent_5A81C3E27E416B65341A899C62ADD6FF0D0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/12/2025 8:34 PM, Jianhui Zhou wrote:
> When perf samples a tracepoint like trace_lock_acquire with high
> frequency, it can trigger a WARN_ON in perf_event_throttle_group()
> due to lockdep assertion failure in for_each_sibling_event().
>
> The issue is that for_each_sibling_event() requires either:
> 1. Holding ctx->mutex, OR
> 2. Having IRQs disabled (since ctx->lock is IRQ-safe)
>
> The call trace shows the problematic path:
> futex_wake
>   lock_acquire
>     trace_lock_acquire
>       perf_trace_lock_acquire
>         perf_tp_event
>           perf_swevent_event
>             __perf_event_overflow
>               __perf_event_account_interrupt
>                 perf_event_throttle_group
>                   for_each_sibling_event [WARN]
>
> In this tracepoint path, IRQs may be enabled and neither ctx->lock
> nor ctx->mutex is held.
>
> The fix adds guard(irqsave)() protection around the sibling list
> iteration in perf_event_throttle_group().
>
> Reported-by: syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69122cb3.a70a0220.22f260.00ff.GAE@google.com/T/
> Signed-off-by: Jianhui Zhou <jianhuizz@qq.com>
> ---
>  kernel/events/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1fd347da9026..253c514e9452 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2700,6 +2700,11 @@ static void perf_event_throttle_group(struct perf_event *event)
>  	struct perf_event *sibling, *leader = event->group_leader;
>  
>  	perf_event_throttle(leader);
> +    /*
> +     * Disable IRQs to protect sibling iteration; for_each_sibling_event()
> +     * needs ctx->mutex or IRQs off.
> +     */
> +	guard(irqsave)();

This seems the simplest way to fix the issue although it may bring a slight
overhead if hard irq is already disabled. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  	for_each_sibling_event(sibling, leader)
>  		perf_event_throttle(sibling);
>  }
