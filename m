Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5F17C9B3;
	Tue,  3 Sep 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358029; cv=none; b=slT7Mnjfsfcq+waa8xzSekhjIRJ2s1Fk6UWX2dbsNwd7DcAyb40Hdckz1dhhRCZ9jAUZ9mTau9Dwri6RHcYdSBAnCvf2nAhE8e8iUsVmdunO8j6bGtwXaxM4X9I/3gMAb0OBCwqFFzXSYd/czb8fqsWN26EsvXbJWNRbkklnGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358029; c=relaxed/simple;
	bh=8KOhIo4507EuwcvtkBjOPT1UdLYvJ4MkGgnucRoMW7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RUO/zj/bDUVy9Uz3dmCPK/YxWZZjFmN3d4npNYCBOBnPL6Wo4zl/z8cQazS2USt6G4eKw0s9+ffrI9Ojaly8qbY+5JsvDZu4Ss+LbLtv2KLGbLjubBxEeS4H3tFAeQqxqWleiI2FJ18LT2xZrS9BunfPTe0L18mgeHk9IDF3ZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPQzhnot; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPQzhnot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725358028; x=1756894028;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8KOhIo4507EuwcvtkBjOPT1UdLYvJ4MkGgnucRoMW7c=;
  b=SPQzhnotv02GRNUUuJCTUHpXGQb5dhP6Hs/ydui4G3riw9a9qtuJkjCQ
   2JhtQTUfbOZGDLdbXX+17mrSiOjOku6vof2mOxjBjjeEwKx3e+q999rIh
   HmXvZ2n3yoDZKP2ifnQSdfo2yqd2LE2RjHgqJF12mQpIyIjHiH4+0VVNN
   b9NpsUsNPYF1I7xiXKDNZis/Ok2BJFT3AK2fprKC3UKw1Z6ka0OKThk3I
   ywRvPmBnktiwzEneN1UyXPu1Jj9lIo2i6m5RYB03NJGw0JiSY4tEfiXIh
   0ndb1PGa/34SuttiPaS617CnKXQQ0U6Xk5fHy8/7ZP1kn8h06Ey20a1rX
   Q==;
X-CSE-ConnectionGUID: 5Pjj7k/nTH+F9t+AR7wdgA==
X-CSE-MsgGUID: VB96WCz5Q3+8A4Ji6jivRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23754184"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="23754184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 03:07:07 -0700
X-CSE-ConnectionGUID: qNRwZHUqSNugyq2z4HfgpQ==
X-CSE-MsgGUID: MqkRV2ThTZucNuoB0EAmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="64494453"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 03:07:02 -0700
Message-ID: <70a58dca-01dc-408b-a2f7-a854718a405b@intel.com>
Date: Tue, 3 Sep 2024 13:06:55 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] perf/core: Allow multiple AUX PMU events with the
 same module
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240823113306.2310957-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/24 14:32, Leo Yan wrote:
> This commit changes the condition from checking the same PMU instance to
> checking the same .setup_aux() callback pointer. If PMU events have the
> same callback pointer, it means they share the same PMU driver module.
> This allows support for multiple PMU events with the same driver module.
> 
> As a result, more than one AUX event (e.g. arm_spe_0 and arm_spe_1)
> can record trace into the AUX ring buffer.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  kernel/events/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c973e3c11e03..883c457911a3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12345,9 +12345,16 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>  
>  	/*
>  	 * If both events generate aux data, they must be on the same PMU
> +	 * module but can be with different PMU instances.
> +	 *
> +	 * For a built-in PMU module, the 'pmu->module' pointer is NULL,
> +	 * thus it is not feasible to compare the module pointers when
> +	 * AUX PMU drivers are built into the kernel image. Instead,
> +	 * comparing the .setup_aux() callback pointer can determine if
> +	 * the two PMU events come from the same PMU driver.
>  	 */
>  	if (has_aux(event) && has_aux(output_event) &&
> -	    event->pmu != output_event->pmu)
> +	    event->pmu->setup_aux != output_event->pmu->setup_aux)

It is not very flexible and risks someone adding aux PMUs that
do not want that rule but accidentally support it.  Another
option is to add a PMU callback, but really you need to Peter's
feedback.

