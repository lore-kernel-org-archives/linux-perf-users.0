Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB72E6CB8;
	Tue, 11 Nov 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888403; cv=none; b=Mx+rysbOZjvVDtXJia0fYZXXtXlDXqhBbYb0uZFO3xCgOQswJy33UQr9ynwg6J+xYwqk2c+j3WoYTmwovW+GxYieH8LZbdJByhs8jco2CHYXva9Cb9fO8ezdhK0AHtdGdvmATS7ixbt/tnsGPyBEZd5p87mgbWAYxYpsWrqRowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888403; c=relaxed/simple;
	bh=b7t7I5XDD3gowEsFftLfMyOl72dkisSO+vfoQr9K2jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5r7X0ZfXXqM5SV19y/5yFUA08wb8VpBPFzcPTitvOBn+rlKDQ5XVd8RuE6LwpWnZy7/DglI0i/EuhxKzEUGixHODK4VNWNDpcdO5xKIBhQ7qlpl5wuYO+/GKDrp7nnsKyE31lynR3QaRTkklOk5k3YQMpBryVD4Ce0pjNo9+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYaSYMgI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYaSYMgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762888403; x=1794424403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b7t7I5XDD3gowEsFftLfMyOl72dkisSO+vfoQr9K2jo=;
  b=VYaSYMgIs4bX2UAVXyoqjxF0oXyMGTyaGC/bZaG4VMy1asLknCphBzDR
   xJbK2Y5l56/TwSKN4trIq87LUCDfatCs/jycRl0iO20E2DK6TyUjInyB2
   KeQtDGp673JfvJgxc+dqyOM1VZteMdnXr3p2/bwzV+z77rM3PSR7Mdk/c
   zgNRFwqaTSAOUmMKU11llaOBCk7d0Bshy+dkcIDdGzmMyVcSWfl+4BZOE
   qo5SGdhIs/GC8O9bHLMHJQMH1tLLT6waDrOPBWzuGm5vGUj6FD3d2DPfB
   MnRV4ZcPrWGk9qRCjFiGapW1N0TY40u2Z+efkaRN5stc25ZiykJHnNhoO
   w==;
X-CSE-ConnectionGUID: kJwccaXkTmqTKkkfTmtFkQ==
X-CSE-MsgGUID: 52tirqCFRKe4gPh9IkBa2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="82352554"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="82352554"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 11:13:22 -0800
X-CSE-ConnectionGUID: /gDl9x7ESBi8msTxn+sZ2Q==
X-CSE-MsgGUID: Cso6vTjQSw6Pu0fpTDO30w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="189758661"
Received: from aksajnan-mobl1.amr.corp.intel.com (HELO [10.125.50.87]) ([10.125.50.87])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 11:13:20 -0800
Message-ID: <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>
Date: Tue, 11 Nov 2025 11:13:20 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit +
 SAMPLE_READ
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20251111075944.2328021-1-namhyung@kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251111075944.2328021-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/2025 11:59 PM, Namhyung Kim wrote:
> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
> on recent kernels.  Not having _TID makes the feature check wrongly detect
> the inherit and _READ support.
> 
> It was reported that the following command failed due to the error in
> the missing feature check on Intel SPR machines.
> 
>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>   Error:
>   Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
>   Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.
> 
> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
> Reported-by: "Chen, Zide" <zide.chen@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 67a898cda86ab559..989c56d4a23f74f4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
>  	/* Please add new feature detection here. */
>  
>  	attr.inherit = true;
> -	attr.sample_type = PERF_SAMPLE_READ;
> +	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;


Seems this could have some unintended side effects. For example,
consider a :ppp event with PERF_SAMPLE_READ and inherit attributes
running on a system where the maximum precise_ip is 2:

- It fails to open the event on the first attempt;
- It goes through the inherit_sample_read detection and fails again
after removing inherit;
- Finally, it succeeds after falling back to precision 2 — but the
inherit attribute has been unexpectedly removed.

I may have missed something, but I don’t quite understand why commit
3b193a57baf15 ("perf tools: Detect missing kernel features properly")
performs the check on a dummy evsel instead of the original one. In this
way, it might incorrectly fall back an attribute that doesn’t actually help.

This means evsel__detect_missing_features() could theoretically roll
back a feature that might not actually work. Given that it cannot
restore the original evsel state after a failed attempt, side effects
may occur.


>  	if (has_attr_feature(&attr, /*flags=*/0))
>  		goto found;
>  	perf_missing_features.inherit_sample_read = true;

