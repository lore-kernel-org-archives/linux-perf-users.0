Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6433A6E2;
	Fri, 18 Sep 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693639; cv=none; b=P3L6f7gWD0nSmjpKOy6ZryyJg6xv5g3KwO7/qGTjIIJT6K8Yy17yFF9NNebUuV0SQykqBECGnHop/8HOkAXdKgfLCwShdUWoqg2HZ41xvXTWN41u/wcpWYl7Fc2QSMNwr8KVAu2IyvJckRXFhyo1jAyFpruNXHBdEilgHZGtQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693639; c=relaxed/simple;
	bh=jEy1qsPKGpZ3QCoInn+hoo5zhrDBOFfC/hMzI3kUBRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQKPZssPx/omLgRl2wmg9+fyQL7Hzlhi1bAv3ViLtPeTgTZr+n3+/jE2qyVTj7HgVuwYVXx3G91C3t+loq1P5ftH39HhywjcsaOwP57GG3wLsocFPSDM8LMDJVyK2FgM6lcq5Ir3hjklgMQ4Rhquq8RN/y4pCw5SdJnNUoCu7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NG6/LZ0f; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NG6/LZ0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789693638; x=1821229638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jEy1qsPKGpZ3QCoInn+hoo5zhrDBOFfC/hMzI3kUBRo=;
  b=NG6/LZ0f4iTd/8DTaXjRKKcsOgvtUVqgpApFkNC8cYPo8+21DdzBTS6/
   6mwAdtVM67CSWb+AM847ZZ99Tyub27+8VQidywLoRTTUHQ9+KtYUSmlaZ
   AHE2HFUNcsTbXL8xfCli8zZvns+PWpPm0OdU8ulRVMciFu6LEQZpRLxcK
   /19tUMNNWFRAXD+R2hM+zZ5fY19BiykLeULopJBMH6rxE4yVICfN8Jf99
   PTXB5O++AKlxw0WxpqPN94jefVRJFUdYBp+iMo8CjiSzqTN+g22Dlc6k7
   cKoAXyttQs0Mgz7k0mDxKtGzFzwN1WUk6JZ1GIKXJicV61Z3s5J9lceF7
   A==;
X-CSE-ConnectionGUID: TK+sV2JVQzqDDH3VhIqslA==
X-CSE-MsgGUID: wgdp4s/kR8qAFVgYQcD/YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="686641"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="686641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 18:07:17 -0700
X-CSE-ConnectionGUID: tDanl5A8QESGzcV9CZFbgw==
X-CSE-MsgGUID: 1nE6uy8aR1agCFq2vQTZ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269834914"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 18:07:13 -0700
Message-ID: <f06759d7-3090-4dd5-a46d-32de96c7d95e@linux.intel.com>
Date: Fri, 18 Sep 2026 09:07:11 +0800
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

Better update the prefix of short log to "perf/core:", other looks good to
me. Thanks.

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
