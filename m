Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA021D1739;
	Fri,  6 Sep 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636088; cv=none; b=X3YdtiLT2Xv9vgQI2i/LyVSTC4Bb7NJ17hdXkDASuGUe/L7yDkQQ0FNfPDR2nAL+BP13dqr9MjCxofeoQ+klkoIMZLhs2AKBl1d8GKrB3FqL0fWiD2CwDD3bZebnP1hTCWrfGvuUEgjxNyiR0QZYBwbvYrLZsH8DWWTlZY2BDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636088; c=relaxed/simple;
	bh=oUSjs1MMOxspywHp1oG7MWq+ySDSFas4rJEQB36sgpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0zPt28vV7E+NSfy33gWQZ94aTR8Y/RxQv2CoOBGPkMAecP/t42jQxn6gh8aOrHMTUQseDAZprG0VW+xV5BS38aXAGSZRPzqkhQMSy3O0A7LIF+V+Huj3Ikdyotgqv4rEhTo3HeCDHzUtWyW5LtneDo+3D4has+Il0imO9aT9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQlgJg94; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQlgJg94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725636087; x=1757172087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oUSjs1MMOxspywHp1oG7MWq+ySDSFas4rJEQB36sgpw=;
  b=TQlgJg94MwEG4kII6SqP2/7ETxL4sFTifC6vczMirjp4fcBxKA+M4k7o
   fuASyKB4LJ0tQghJ2G+R0mtX8uqKs88geWV1+VQAJi3tylKvO4FBr+W23
   bySJAkAiN6GWaY1+8QzHXT5n6KXbifKl6XTpCvvZYzAyLaZ1qNi5bOZfj
   y59qciWWXmf73E21J+vzBTq05ggkWJDgTJ5a49GncDxjLKFAkKVIqknZH
   bLL/yPdt3hdK2kmGsZfOyYHkHgZ7YY8i7GW7YPH4MxD/zzJ7Pihm/DMHt
   hYDLM/tWWURb9Rwk8tUWQ9cHf+0sXMkX51ocH8VyQGhabubgj/8whQJBf
   g==;
X-CSE-ConnectionGUID: VYh4zCH2TW6sto2VCpWJsw==
X-CSE-MsgGUID: 7OlrPE65RxyUUTyr2oX+1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35750007"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="35750007"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:21:26 -0700
X-CSE-ConnectionGUID: iWX56I1eTTCTgjLcSy8sDQ==
X-CSE-MsgGUID: Psce5VTTQyqfgwPEv9VTOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66222829"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:21:25 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2152A20B5782;
	Fri,  6 Sep 2024 08:21:23 -0700 (PDT)
Message-ID: <8b9d3cbb-99bd-4474-8daf-e9ab36e42a77@linux.intel.com>
Date: Fri, 6 Sep 2024 11:21:21 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] perf tools: Separate exclude_hv fallback
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-8-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240905202426.2690105-8-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> The exclude_hv was added in the evsel__fallback() in the commit
> 4ec8d984895fef43a ("perf record: Fix priv level with branch sampling
> for paranoid=2") to address branch stack samples on Intel PMUs.
> As some other PMUs might not support that, let's separate the bit from
> exclude_kernel to make sure it can add the bit only if required.
> 
> Technically it should change the modifier string at the end of the
> event name.  ":u" is for exclude_kernel + exclude_hv, so it should be
> ":uh" if it has exclude_kernel only.  That means the default events for
> regular users will looks like "cycles:Puh" (for perf record) or
> "instructions:uh" (for perf stat).  But I'm not sure if it's worth the
> trouble so I didn't touch the name in this patch.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1a4f52767942e5ad..c5df45bb74dfc1b5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3389,10 +3389,20 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
>  		free(evsel->name);
>  		evsel->name = new_name;
>  		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> -			  "to fall back to excluding kernel and hypervisor "
> -			  " samples", paranoid);
> +			  "to fall back to excluding kernel samples", paranoid);
>  		evsel->core.attr.exclude_kernel = 1;
> -		evsel->core.attr.exclude_hv     = 1;
> +
> +		return true;
> +	} else if (err == EACCES && !evsel->core.attr.exclude_hv &&
> +		   (paranoid = perf_event_paranoid()) > 1) {
> +		/* If event has exclude user then don't exclude hv. */
> +		if (evsel->core.attr.exclude_user)
> +			return false;
> +
> +		/* Intel branch stack requires exclude_hv */

I don't think it's an requirement for Intel branch stack. The HV is
ignored for all X86.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/core.c#n542

I think it's a generic request for branch on all arch.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n366

Thanks,
Kan

> +		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> +			  "to fall back to excluding hypervisor samples", paranoid);
> +		evsel->core.attr.exclude_hv = 1;
>  
>  		return true;
>  	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
