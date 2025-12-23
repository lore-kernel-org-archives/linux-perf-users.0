Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503671E2858;
	Tue, 23 Dec 2025 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461204; cv=none; b=JSzo6ebiHw1G2pZcVF2WlMbuYPRqtw3NLEdRHjwkR4v9s6OY16fSIJu1tkrrjMa+d0JRG3NpOY/yWWzF03FhK0gFt5RC9P+xAfK8XUBWxPVpdrdic2F/jsgEUHr+txBXBUOjpIYTbi71wSQHVEtdnk5ZZucrVl4JdwMwuU6zm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461204; c=relaxed/simple;
	bh=MZ6NLN7wSqCMjBmIJIS3WG4UQ/5fs7Nl0EGLgEpEY04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsI5fricrFXQYCcxF7SLZbydJ9oJsrUlPluisvGDV62CpOSORYEI4nfsYDDUz4UqZ8TgZOotrQAOgywuc4xP25m50hHVLL8qa09tViZmFZuBPJqQD8OOK5cVA/i5ILHK9Ki411JW869bh9ACDG/CdI3GhWR2o/FfQl6ZeC+A2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjwDgG0Y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjwDgG0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766461202; x=1797997202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MZ6NLN7wSqCMjBmIJIS3WG4UQ/5fs7Nl0EGLgEpEY04=;
  b=fjwDgG0YHbxVqXbFSR//ZMhTLkJXyOQPjRFbiAoqW6QXxtA3JjrjfykL
   audBIlsb3bLfGxBPYYc50Nyhky88Z5KdcRM6pP0HSTNoElUkDRpJyDJ2C
   Wf5KLyu6uAR4S1Kt7ObWoJ3VmfTVRek0tzOZtSmxwK50z9uUKSWqAKaWL
   1RdVJkJpQiSrFeSrXPRKgq9UbTVQuYi1ZjYSPyw4un6NKBJDiXSWcAD3S
   SahQKPfGwSqnzPYJX0RL7GKMIULC/OVjojongPpRCa6MV8hdZaBwV3Blx
   9F1t1VDPulihdzDFYjHsUM+5/Bm8rdZEEr0sCYqsuzpnjGc/p/0Gl8Tqr
   g==;
X-CSE-ConnectionGUID: KQLo7envR6mRGlWhZ6YT/A==
X-CSE-MsgGUID: pTrhCDeETFKj4T9bbBmpmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68206765"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68206765"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:40:02 -0800
X-CSE-ConnectionGUID: NQLXIrS2RCq9WPqZiSWV6Q==
X-CSE-MsgGUID: 03d9nmkKR5K1GzFMc/fJ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199445345"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:39:58 -0800
Message-ID: <1a42689e-1b4d-4634-901a-f18edd7f8a74@linux.intel.com>
Date: Tue, 23 Dec 2025 11:39:55 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] perf/x86/intel/uncore: Add freerunning event
 descriptor helper macro
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212210007.13986-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/13/2025 5:00 AM, Zide Chen wrote:
> Freerunning counter events are repetitive: the event code is fixed to
> 0xff, the unit is always "MiB", and the scale is identical across all
> counters on a given PMON unit.
>
> Introduce a new helper macro, INTEL_UNCORE_FR_EVENT_DESC(), to populate
> the event, scale, and unit descriptor triplet. This reduces duplicated
> lines and improves readability.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 95 ++++++++--------------------
>  1 file changed, 28 insertions(+), 67 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index bd1569876640..56c6ac86f28e 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4068,34 +4068,24 @@ static struct freerunning_counters skx_iio_freerunning[] = {
>  	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
>  };
>  
> +#define INTEL_UNCORE_FR_EVENT_DESC(name, umask, scl)		\
> +	INTEL_UNCORE_EVENT_DESC(name,				\
> +		"event=0xff,umask=" __stringify(umask)),	\
> +	INTEL_UNCORE_EVENT_DESC(name.scale, __stringify(scl)),	\
> +	INTEL_UNCORE_EVENT_DESC(name.unit, "MiB")
> +
>  static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
>  	/* Free-Running IO CLOCKS Counter */
>  	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
>  	/* Free-Running IIO BANDWIDTH Counters */
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x24"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x25"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x26"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x27"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
> -	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x24, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x25, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x26, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x27, 3.814697266e-6),
>  	/* Free-running IIO UTILIZATION Counters */
>  	INTEL_UNCORE_EVENT_DESC(util_in_port0,		"event=0xff,umask=0x30"),
>  	INTEL_UNCORE_EVENT_DESC(util_out_port0,		"event=0xff,umask=0x31"),
> @@ -4910,30 +4900,14 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
>  	/* Free-Running IIO CLOCKS Counter */
>  	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
>  	/* Free-Running IIO BANDWIDTH IN Counters */
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
> -	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, 3.0517578125e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, 3.0517578125e-5),
>  	{ /* end: all zeroes */ },
>  };
>  
> @@ -5266,12 +5240,8 @@ static struct freerunning_counters snr_imc_freerunning[] = {
>  static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
>  	INTEL_UNCORE_EVENT_DESC(dclk,		"event=0xff,umask=0x10"),
>  
> -	INTEL_UNCORE_EVENT_DESC(read,		"event=0xff,umask=0x20"),
> -	INTEL_UNCORE_EVENT_DESC(read.scale,	"6.103515625e-5"),
> -	INTEL_UNCORE_EVENT_DESC(read.unit,	"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
> -	INTEL_UNCORE_EVENT_DESC(write.scale,	"6.103515625e-5"),
> -	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
> +	INTEL_UNCORE_FR_EVENT_DESC(read, 0x20, 6.103515625e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(write, 0x21, 6.103515625e-5),
>  	{ /* end: all zeroes */ },
>  };
>  
> @@ -5836,19 +5806,10 @@ static struct freerunning_counters icx_imc_freerunning[] = {
>  static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
>  	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
>  
> -	INTEL_UNCORE_EVENT_DESC(read,			"event=0xff,umask=0x20"),
> -	INTEL_UNCORE_EVENT_DESC(read.scale,		"6.103515625e-5"),
> -	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(write,			"event=0xff,umask=0x21"),
> -	INTEL_UNCORE_EVENT_DESC(write.scale,		"6.103515625e-5"),
> -	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
> -
> -	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=0xff,umask=0x30"),
> -	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"6.103515625e-5"),
> -	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
> -	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=0xff,umask=0x31"),
> -	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"6.103515625e-5"),
> -	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
> +	INTEL_UNCORE_FR_EVENT_DESC(read, 0x20, 6.103515625e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(write, 0x21, 6.103515625e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(ddrt_read, 0x30, 6.103515625e-5),
> +	INTEL_UNCORE_FR_EVENT_DESC(ddrt_write, 0x31, 6.103515625e-5),
>  	{ /* end: all zeroes */ },
>  };
>  

Nice cleanup. 

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


