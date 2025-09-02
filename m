Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5162877FC;
	Tue,  2 Sep 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830617; cv=none; b=pMuNB2rZrcGDC8LYJyASFe/pDLtBzL1OjPLoqLdAuqVyQ+PA/p/MdduqgW4Wjh9OvKObWbSAT32SF0DC4tVoISYhX/ulX+Vxy4ATSgiaDt+lpbmvNsAIeHmC2Y5hwpKa7NZZrAnpw5xy7pNI1PvXc4spqKA/urElNAvooVpSRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830617; c=relaxed/simple;
	bh=ePPhgnwG1aMMLJ9Fft3twN/Us3mRP4Sj3xrRv+OcCKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m96QgHV0HWv+awRT2cIPfdZZrOdY1Bp2fYUbLmDdICnkGIMs4/i5m0XxYGptLGdlmNAO43M8aixzRqlwvdNUY6pmBeC9WTn9FBGQ6q5caIVKGJ8sqnezjaBYAE+9cOweFUchrDDlMkGLpFh/Am56Vj2m92bIVu++tAHtxkzPGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU8aYzDP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU8aYzDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756830616; x=1788366616;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ePPhgnwG1aMMLJ9Fft3twN/Us3mRP4Sj3xrRv+OcCKY=;
  b=AU8aYzDPiEsLAA1Go0Wx14VVEehmVIfmp0UZks1h4h1oxZtZZib7vhJA
   QWcPZd+3JPm8jlboAFDDdDxzEleU52Qq0e7diGeCDxG2/lUNI5X0pXZ6u
   dZB99M/2EMkjqOxbmpLGmZNHSZ6GM+5IeUBeTUVyTxdpVh6uYG8Zmcz2W
   e3KbwK0WhIYmteKN+TLRYbxbcajkvQ8n2yk5jw0pxHnyJNlB3zOusL7FF
   kDlVtY8EZeAwDUaj0dCCAClSq8O4TCkaaIS1WlMkfyzrlV1Fra70O0nSl
   lMptMICISr7Eo8nspHXa6CAaqEVpzpM8oJDlrRcOZtHNaWTf6+WxjAT4J
   Q==;
X-CSE-ConnectionGUID: UGhe9dLKQTaO7qWoUcVxrQ==
X-CSE-MsgGUID: 9XwCTn9gQzuNOkTPuFW2vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81699804"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81699804"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:30:10 -0700
X-CSE-ConnectionGUID: YJ+aRZJ/QbG08bl58SRE3A==
X-CSE-MsgGUID: zaqIkppCQE6JZbtxDMQquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170885210"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:30:09 -0700
Received: from [10.246.166.96] (unknown [10.246.166.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D67EF20B571C;
	Tue,  2 Sep 2025 09:30:07 -0700 (PDT)
Message-ID: <3599c0c7-d385-45fa-9ffa-f20737165827@linux.intel.com>
Date: Tue, 2 Sep 2025 09:30:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Use guard(mutex) instead of mutex_lock() to
 simplify code
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
References: <20250829114816.650576-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250829114816.650576-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-29 4:48 a.m., Liao Yuanhong wrote:
> Using guard(mutex) and scoped_guard() instead of mutex_lock/mutex_unlock
> pair. Simplifies the error handling to just return in case of error. No
> need for the fail_unlock: label anymore so remove it.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  arch/x86/events/core.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 745caa6c15a3..107bed5c9d71 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -411,7 +411,7 @@ int x86_reserve_hardware(void)
>  	int err = 0;
>  
>  	if (!atomic_inc_not_zero(&pmc_refcount)) {
> -		mutex_lock(&pmc_reserve_mutex);
> +		guard(mutex)(&pmc_reserve_mutex);

Shouldn't it be a scoped_guard() as well?

Thanks,
Kan

>  		if (atomic_read(&pmc_refcount) == 0) {
>  			if (!reserve_pmc_hardware()) {
>  				err = -EBUSY;
> @@ -422,7 +422,6 @@ int x86_reserve_hardware(void)
>  		}
>  		if (!err)
>  			atomic_inc(&pmc_refcount);
> -		mutex_unlock(&pmc_reserve_mutex);
>  	}
>  
>  	return err;
> @@ -444,8 +443,6 @@ void x86_release_hardware(void)
>   */
>  int x86_add_exclusive(unsigned int what)
>  {
> -	int i;
> -
>  	/*
>  	 * When lbr_pt_coexist we allow PT to coexist with either LBR or BTS.
>  	 * LBR and BTS are still mutually exclusive.
> @@ -454,22 +451,18 @@ int x86_add_exclusive(unsigned int what)
>  		goto out;
>  
>  	if (!atomic_inc_not_zero(&x86_pmu.lbr_exclusive[what])) {
> -		mutex_lock(&pmc_reserve_mutex);
> -		for (i = 0; i < ARRAY_SIZE(x86_pmu.lbr_exclusive); i++) {
> -			if (i != what && atomic_read(&x86_pmu.lbr_exclusive[i]))
> -				goto fail_unlock;
> +		scoped_guard(mutex, &pmc_reserve_mutex) {
> +			for (int i = 0; i < ARRAY_SIZE(x86_pmu.lbr_exclusive); i++) {
> +				if (i != what && atomic_read(&x86_pmu.lbr_exclusive[i]))
> +					return -EBUSY;
> +			}
> +			atomic_inc(&x86_pmu.lbr_exclusive[what]);
>  		}
> -		atomic_inc(&x86_pmu.lbr_exclusive[what]);
> -		mutex_unlock(&pmc_reserve_mutex);
>  	}
>  
>  out:
>  	atomic_inc(&active_events);
>  	return 0;
> -
> -fail_unlock:
> -	mutex_unlock(&pmc_reserve_mutex);
> -	return -EBUSY;
>  }
>  
>  void x86_del_exclusive(unsigned int what)

