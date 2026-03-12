Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7233F383;
	Thu, 12 Mar 2026 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284050; cv=none; b=t5p1e6jPRaYHkAkFrW95kc6awjA5uYuLYWfGgf7m0+GdrbC3NC1UomH6VrpnO3sfXUxDzMhffDu/xQRYD0LayYQ7tLD6w/pL9BGM/lJxBkIjBXDdQppTPojJjnBYpgICdpr9FQbKlqnPr/utfzR77pgsQo0qmYdvxvCcxoIdEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284050; c=relaxed/simple;
	bh=S14+HlXvFyKt+KWODrn2nZSgbAcORPruDb8xmY3GPk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmkXLKLYX9DmJrFi+93KjjRr6F3RUj4WgaoHQFIRTB329KUZUTLV8/KCjltTy0C4eORg5gjLZLKMAThmWlMbqkuwp7soco7WOLp5dtbDrbXO9yer2PLUxu/xCVnrt9rD9mpGToGLvlw8J6SLV8sC5mPwMRGlk8gW4LJcmFEJMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzXeWllu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzXeWllu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773284048; x=1804820048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S14+HlXvFyKt+KWODrn2nZSgbAcORPruDb8xmY3GPk0=;
  b=LzXeWlluyOzdJj2qFTudteiNCy0CKfANlGY+BCO/5x3LL2gP4phkfWj1
   WPNdnltwBrNOWE4DEwLCdIHImMmmRkT5fPvcZ0/PpU9zZFFXSjqHNtWO0
   h5k+DeqjnAlWKTE6JhJvu5bie0S+DJ1UGyGYumlwK7MgrZ4G0Lm6Kl9Qp
   sHL2Ev+NmWD88vjaGNrRxEGTlFdT6M88r3BxCxae8QmHrw5C9nNWukFAw
   kf9Pl1AnGqEg9Mr/8mX5FZd5Zcqa8heQlTXNrTYpSb/A63RKp9C/EN4Um
   4c2TLv8Q3BlQwKDD2DO6RSz+UN9aD+O/cRUVqjoe/MF5tDoZqw3YEqomE
   Q==;
X-CSE-ConnectionGUID: HaT/kCrTRP+8bxJM7Ad6vw==
X-CSE-MsgGUID: gyuhXWwQS+utGfr4UZ7/aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="84685099"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="84685099"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:54:07 -0700
X-CSE-ConnectionGUID: SAfzNZmwSAqsHSVQzxdJqA==
X-CSE-MsgGUID: Ehq+LDaSRkGOshJNxgltfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="258575343"
Received: from unknown (HELO [10.238.3.214]) ([10.238.3.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:54:02 -0700
Message-ID: <9e0e04e9-7421-4dfb-a017-c31741a8d500@linux.intel.com>
Date: Thu, 12 Mar 2026 10:53:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
To: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
 <20260311173509.GR606826@noisy.programming.kicks-ass.net>
 <20260311204035.GX606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260311204035.GX606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/12/2026 4:40 AM, Peter Zijlstra wrote:
> On Wed, Mar 11, 2026 at 06:35:09PM +0100, Peter Zijlstra wrote:
>>> Additionally, does this change leave the unthrottled event's hardware
>>> counter uninitialized?
>> Also yes.
> Something like so on top of things I suppose.
>
> ---
> Subject: x86/perf: Make sure to program the counter value for stopped events on migration
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Mar 11 21:29:14 CET 2026
>
> Both Mi Dapeng and Ian Rogers noted that not everything that sets HES_STOPPED
> is required to EF_UPDATE. Specifically the 'step 1' loop of rescheduling
> explicitly does EF_UPDATE to ensure the counter value is read.
>
> However, then 'step 2' simply leaves the new counter uninitialized when
> HES_STOPPED, even though, as noted above, the thing that stopped them might not
> be aware it needs to EF_RELOAD -- since it didn't EF_UPDATE on stop.
>
> One such location that is affected is throttling, throttle does pmu->stop(, 0);
> and unthrottle does pmu->start(, 0); possibly restarting an uninitialized counter.
>
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1374,8 +1374,10 @@ static void x86_pmu_enable(struct pmu *p
>  
>  			cpuc->events[hwc->idx] = event;
>  
> -			if (hwc->state & PERF_HES_ARCH)
> +			if (hwc->state & PERF_HES_ARCH) {
> +				static_call(x86_pmu_set_period)(event);
>  				continue;
> +			}
>  
>  			/*
>  			 * if cpuc->enabled = 0, then no wrmsr as

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>
