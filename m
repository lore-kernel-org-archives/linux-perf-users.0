Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D51C861A;
	Mon,  9 Feb 2026 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770597699; cv=none; b=DXeCMIZ9+dDaKO7ngeC2U66OeM2NSo8D5+iPUlk4wZjohNsaEK/IQbMUsMRnErra/AbKrX201XiNlJ41VlmPTk4324HZFeEP63SryJ4PFAuUDWa1kNXVyOwYmjFCr6iQL5qIoy3T+/hxoITG4vYIh/g74yVdjSxkVy9W3vXDsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770597699; c=relaxed/simple;
	bh=uwmBy8IOtLmDViaIZqWFEOwMcI3u+2Y7TPYkfCKwPfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swipp13S1n7dsW3aceqhFfe9Bv4ydrz5ikjmK6BPXhrNxtuOskX0NAvXUafqcCbnV0fYE7itlLUi57saXbVBYNNZDlGhxOvV+70xm4yiH3yia+xTHjs9Ot/uz3lugMTJhOiuCQ2n9sy7U1l9/bdFom2agoRIjl4bmgfjEwFpKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGLrC64+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGLrC64+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770597699; x=1802133699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uwmBy8IOtLmDViaIZqWFEOwMcI3u+2Y7TPYkfCKwPfE=;
  b=FGLrC64+/E2eHZ9VtDzjxf/sdpUYiNoOXPWlOTvMPhG2YGLNX+xRsflp
   cB/wWc55gG6AclSbRXGmII0bersrjIF1kTJDrLX9LNCvFq0uS8khIAque
   nk6pEWUvnx7LPpi7rS5I/I9hbz7i8ZTvCF3OMyE/RZ5Mpf5Jo/djN6ANm
   AWDCt7NICY7u2wAOVzI3TVEMS2p/lIFcHvl2JgNtlvuev0bjISbFfu3Iw
   EGTbwDz9zxke5YZS7iG2duL3JgvLJY9zwwZ3z4Jfh3rjQxm2Dy/AE/C+I
   QAx1m1SxvXXZjmyX1aVMqOf/zJNhJ8JZZvJR8OQ2VCuBhM2TtlZYkta4K
   A==;
X-CSE-ConnectionGUID: 9BrpUrwORH+Pey1M+p3vCA==
X-CSE-MsgGUID: P91C6eFzQASqD7eM1vnOFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75328316"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75328316"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 16:41:39 -0800
X-CSE-ConnectionGUID: KgN0oLVTQoi3FzfO6xz1NQ==
X-CSE-MsgGUID: gFpBn04eQDK7sX54+UwjmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211225158"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 16:41:34 -0800
Message-ID: <1f89dde0-6c81-4127-9dfb-0be1ca685b65@linux.intel.com>
Date: Mon, 9 Feb 2026 08:41:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Remove extra double quote mark
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Markus Elfring <Markus.Elfring@web.de>, Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20260206231203.11760-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260206231203.11760-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/7/2026 7:12 AM, Zide Chen wrote:
> The third argument in INTEL_UNCORE_FR_EVENT_DESC() is subject to
> __stringify(), and the extra double quote marks can result in the
> expansion "3.814697266e-6" in the sysfs knobs, instead of
> 3.814697266e-6.
>
> This is incorrect, though it may still work for perf, e.g.
> perf stat -e uncore_iio_free_running_0/bw_in_port0/
>
> Fixes: d8987048f665 ("perf/x86/intel/uncore: Support IIO free-running counters on DMR")
> Reported-by: Chun-Tse Shao <ctshao@google.com>
> Closes: https://lore.kernel.org/all/20251231224233.113839-1-zide.chen@intel.com/
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 7ca0429c4004..3b6b4bd4793a 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6909,34 +6909,34 @@ static struct freerunning_counters dmr_iio_freerunning[] = {
>  
>  static struct uncore_event_desc dmr_uncore_iio_freerunning_events[] = {
>  	/*  ITC Free Running Data BW counter for inbound traffic */
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, "3.814697266e-6"),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, 3.814697266e-6),
>  
>  	/*  ITC Free Running BW IN counters */
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, "3.814697266e-6"),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, 3.814697266e-6),
>  
>  	/*  ITC Free Running BW OUT counters */
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, "3.814697266e-6"),
> -	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, "3.814697266e-6"),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, 3.814697266e-6),
> +	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, 3.814697266e-6),
>  
>  	/* Free Running Clock Counter */
>  	INTEL_UNCORE_EVENT_DESC(clockticks, "event=0xff,umask=0x40"),

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


