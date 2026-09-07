Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E413A7193;
	Mon,  7 Sep 2026 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762302; cv=none; b=mtGpH8GVaCzhIWKayeyHF5j6AWKBPtpVzm/eeCftuU60yuKSxN/GAdqyrwEET+8bYG79cepF/lDWZW7K8inpaULCJk7+5MPtJSfQxaR9TfCZVpneu7AcOP3GQv2Jbwwqt42hFnf4W0yqMmKcI20olJv2COeFify6xJJ8ULV9yBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762302; c=relaxed/simple;
	bh=CmxHwiGY44Ct/DwK/K2mbNhd/0rIQlcqBYb/wuafWwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCSADn8Rd1t6+TRQmpOrs1yi+1x1AKhKR8rgG2Lt6I2xo/9aINMSpH7X1ZERixe2LOOUyeLpYWOVQw49Cl3ytxk7UZLaknk0cxZ44On78mGdOPbXhWD2vwlJUizu/+QXWMu6JawEP8jK/rVyniCpGnGp+DiW2MUbi5SPNVN1yVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNaYLp8s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNaYLp8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788762297; x=1820298297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CmxHwiGY44Ct/DwK/K2mbNhd/0rIQlcqBYb/wuafWwk=;
  b=KNaYLp8s1sfZ942pDkH9/UTxX4EM1eUBS7LN4IjSm7B4MpD3LqPvPiuv
   UyQNrFWK8bpjLKTwDLxga7hPQV/bosQw+/7UXjjDc+qEDjhn22QG2x84F
   lACzNYlL2jSCEY7h8bH6Z0Vl2EoVIyH35GiM5L1e7pwsQA1ANjWkiv0NU
   vxNLp00YwT7qQEoxWM813yMDO0V5Bfe6z/E7/X2HHvLnDIxWwa+oBrMFa
   07Jw3B3plIWZSyOrKyMk/aIDQmzSejUj2acbOJg3VULMAOuRkz9JalLPp
   nfCAi2qZpPEhfqBUZNRI08JcOReLjaaRBQSgiLD9pfRbmn1x4kJCk9HTm
   w==;
X-CSE-ConnectionGUID: 4DlhooHpTCeBdSelZ/QirA==
X-CSE-MsgGUID: iz+msFfAQpCkrGmHqvQ/fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89006516"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89006516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:24:54 -0700
X-CSE-ConnectionGUID: bFKwFv7KTVO4D/oT8f7t0w==
X-CSE-MsgGUID: UjEGOFZRTbGg5Q4Hjl2BkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268885079"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:24:51 -0700
Message-ID: <cf756325-e7a3-4e8e-8bb8-6b2b820e584c@linux.intel.com>
Date: Mon, 7 Sep 2026 14:24:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: Fix null pointer access in
 is_include_guest_event()
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 9/5/2026 2:16 AM, Vinay Belgaumkar wrote:
> A typical module unload occurring event when there is an active perf
> connection leads to freeing of the pmu pointer. The call log is something
> like:
>  ..
>  __pmu_detach_event
>  pmu_detach_event
>  pmu_detach_events
>  perf_pmu_unregister
>  ..
>
> __pmu_detach_event() sets event->pmu to null. When the perf connection
> finally is closed, the following stack trace is observed:
>
>  Oops: general protection fault, kernel NULL pointer dereference
>  ...
>  RIP: 0010:_free_event+0x3e/0x370
>  ...
>  Call Trace:
>  ...
>  perf_event_release_kernel+0x260/0x2d0
>  perf_release+0x12/0x20
>
> A call to mediated_pmu_unaccount_event() inside _free_event() is the root
> cause of this crash. Adding a check inside is_include_guest_event() ensures
> we don't accidentally access a null pmu ptr. In addition to this, we will
> now call mediated_pmu_unaccount_event() before clearing the pmu ptr so that
> nr_include_guest_events counts are maintained correctly.
>
> Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
> Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Assisted-by: Claude:Claude-Sonnet-5
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a3110..7777e82aad5e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6350,6 +6350,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
>  /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
>  static inline bool is_include_guest_event(struct perf_event *event)
>  {
> +	if (!event->pmu)
> +		return false;
> +
>  	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
>  	    !event->attr.exclude_guest)
>  		return true;
> @@ -13002,6 +13005,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
>  	exclusive_event_destroy(event);
>  	module_put(pmu->module);
>  
> +	mediated_pmu_unaccount_event(event);
>  	event->pmu = NULL; /* force fault instead of UAF */
>  }
>  
