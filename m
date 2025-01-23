Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82314BF87;
	Thu, 23 Jan 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658488; cv=none; b=jBXQIQdRH4hTrVSA6UDxBj3AqaLmwKUO+7daN8rACvEpLW668OI8Rhj795GAAHB2wffbueIN1qJXt/HO5K4QCeoCZ+CDF18OYIE3GDaqzFZM4b3nESXE8VnudVxR2Qwf03KXYOojUJxDKJI+pSLbRdsuOjRzcq4jpIHIeIkhbA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658488; c=relaxed/simple;
	bh=ZORAjs33t0FXUvit5WKiAPSwvfjRupnYOISwrG9Lay4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ab6+0dJtyogJanwYOrV/LNJ9vMzj1+TQ+BXzDM8+dd4E45gA9KIoBEpmIdLKfnozJLyDzzm74KN9321wHHuW4zPR0Qxv2MOy0cnFe5tQ1ukIHARmVILQ2foINAjQqNHe0k/362rQNeIvRCgqXnzuDsotuUpR9m9lU3kt8NThUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYi6lEVY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYi6lEVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737658487; x=1769194487;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZORAjs33t0FXUvit5WKiAPSwvfjRupnYOISwrG9Lay4=;
  b=hYi6lEVYlfeD3RA1vE9fUakY3fAbyVyzvqQfmC1/7xWEy69EM989AVcl
   jQX2z7vKdAvCF+w2nKpGGeuB/tGG3BYu1G3DkbF0thh+Q22iztapUH6vN
   8qsrwTdiiYn+0+9xTzEjehzGDjyHqO2rDCqilASGxgvohOWVCX2+h52ib
   l9UR+TptX4eKbr471hE9IVT4WKskLs2WnPgSaE/xFoZdXxRYpJJnD4rR6
   +MimspnD1kKDxN8NwglM5ob7H4+QkSmZFj9Ni+fqWnW8u3W27jUbfPFDb
   sDXDxi8Y7RhbO8rz4Zt3gOlKUiUVPKnsDJlCUnVuUkUBZ5K3irFG3fHMv
   w==;
X-CSE-ConnectionGUID: wG12ZhmFRBG2ITdYpgGpXw==
X-CSE-MsgGUID: eKZ/bMJFSraOzBfTR38XZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41936137"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="41936137"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:54:46 -0800
X-CSE-ConnectionGUID: JDf9C+h6ShSfj8NzklSsZA==
X-CSE-MsgGUID: ihTVyCjrRWuT3KTUeN1A4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130837146"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:54:45 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 555C020B5713;
	Thu, 23 Jan 2025 10:54:43 -0800 (PST)
Message-ID: <1f213692-197e-4f14-a0e8-3d825beabfa3@linux.intel.com>
Date: Thu, 23 Jan 2025 13:54:42 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
To: lirongqing <lirongqing@baidu.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122074103.3091-1-lirongqing@baidu.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250122074103.3091-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-22 2:41 a.m., lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
> this can save 12K memory for each CPU
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/bts.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 8f78b0c..8e09319 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -36,7 +36,7 @@ enum {
>  	BTS_STATE_ACTIVE,
>  };
>  
> -static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
> +static struct bts_ctx __percpu *bts_ctx;
>  
>  #define BTS_RECORD_SIZE		24
>  #define BTS_SAFETY_MARGIN	4080
> @@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
>  
>  static void __bts_event_start(struct perf_event *event)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf = perf_get_aux(&bts->handle);
>  	u64 config = 0;
>  
> @@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
>  static void bts_event_start(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf;
>  
>  	buf = perf_aux_output_begin(&bts->handle, event);
> @@ -290,7 +290,7 @@ static void bts_event_start(struct perf_event *event, int flags)
>  
>  static void __bts_event_stop(struct perf_event *event, int state)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  
>  	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
>  	WRITE_ONCE(bts->state, state);
> @@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
>  static void bts_event_stop(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf = NULL;
>  	int state = READ_ONCE(bts->state);
>  
> @@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
>  
>  void intel_bts_enable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	int state = READ_ONCE(bts->state);
>  
>  	/*
> @@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
>  
>  void intel_bts_disable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  
>  	/*
>  	 * Here we transition from ACTIVE to INACTIVE;
> @@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
>  int intel_bts_interrupt(void)
>  {
>  	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct perf_event *event = bts->handle.event;
>  	struct bts_buffer *buf;
>  	s64 old_head;
> @@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
>  
>  static int bts_event_add(struct perf_event *event, int mode)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
>  
> @@ -605,6 +605,10 @@ static __init int bts_init(void)
>  		return -ENODEV;
>  	}
>  
> +	bts_ctx = alloc_percpu(struct bts_ctx);
> +	if (!bts_ctx)
> +		return -ENOMEM;
> +
>  	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
>  				  PERF_PMU_CAP_EXCLUSIVE;
>  	bts_pmu.task_ctx_nr	= perf_sw_context;

