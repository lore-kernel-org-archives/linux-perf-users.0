Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5728136F;
	Tue, 23 Dec 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526843; cv=none; b=si7bTLOWEhtHDhk9V/MvfxodowVW8ESPf0NPKEPccw1ntWykGMcqjiM2HKquyhlO4yPx7mRE0PhP0ZXPH3TQVnTAYgc9R0kpY+OvzP6b3R/mgq9VzAHc7E4Dudpr1l7oJx6E4mJSgGPLURoUP9Ki1LsKvZn0R+R6R63MdJ73tRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526843; c=relaxed/simple;
	bh=MO7tTJ2pAS0meCVVfe5cbI3Ayg1GSmwiNzC5QyWivGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDKJlJDGSuF46FXP2gaYQeubiMSjGpJZDN9vkiD1Tz/t04a3Sze6EMqjqrLejrchFItoiG0rpGzg/nEDy5alhWmW3413QIfmd2rzeBsRZheXrqydTgYMweesiAlfAsB9JdeOf2mg51LspZXIC9ZiLLLimEFYc5nn0a/7GO9e7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/4EC4LJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/4EC4LJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766526841; x=1798062841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MO7tTJ2pAS0meCVVfe5cbI3Ayg1GSmwiNzC5QyWivGc=;
  b=m/4EC4LJOK1aISxWb6waELxtIVuOW6vjftbNzjlD3YpFbyB4LBx4o251
   4aPmM++nctvKjVvSh5ux7xhzkDip2zrWsc31TMYOHwpRQ0nlEhvsPwnfB
   VrFPLIfn9u6KNBMV3eQevLKqpdMkEplelsaGN8fSwAWOYgMy4cYY0wKlA
   9W2vdrO+51Ygd8m7KX/r+JTlOZShgY9nYa/tVku/QUzwcuBVJPPHYnJUD
   p0+ExxsoniCGDfO0gT2a3hpSW8qKxpDUQpeGteQSnr7GLOcE5o7HuL+za
   cn3OdYpPLoQEqP6OaJj5yZvlsNecFYITJZ+puLZ485UrGKIrLH62dMMg+
   A==;
X-CSE-ConnectionGUID: Fm0BzBt0QJmFvZYHCnS0Jg==
X-CSE-MsgGUID: G9h/acoySROFsvzLMVVKfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="70955619"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="70955619"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 13:54:00 -0800
X-CSE-ConnectionGUID: WwRzN8ilTLWa1hFqCybMzg==
X-CSE-MsgGUID: XS4K8rpYQm6a0xjl7/bpDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="223358335"
Received: from unknown (HELO [10.241.240.141]) ([10.241.240.141])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 13:53:59 -0800
Message-ID: <252fe00c-e0d2-4e36-a1b8-da2ce799a26c@intel.com>
Date: Tue, 23 Dec 2025 13:53:58 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/intel/uncore: Update DMR uncore constraints
 preliminarily
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-7-zide.chen@intel.com>
 <7f151e4e-7fcf-4007-9c7d-a90af1c05f84@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <7f151e4e-7fcf-4007-9c7d-a90af1c05f84@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/22/2025 9:52 PM, Mi, Dapeng wrote:
> 
> On 12/13/2025 5:00 AM, Zide Chen wrote:
>> Update event constraints base on the latest DMR uncore event list.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore_snbep.c | 81 ++++++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index e5b95fa75313..8068b9404ecb 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -6760,10 +6760,72 @@ static const struct attribute_group dmr_cxlcm_uncore_format_group = {
>>  	.attrs = dmr_cxlcm_uncore_formats_attr,
>>  };
>>  
>> +static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
>> +	UNCORE_EVENT_CONSTRAINT(0x1, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x2, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x3, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x4, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x5, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x6, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x7, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x8, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x9, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0xa, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0xb, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0xc, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0xd, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0xe, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0xf, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x10, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x11, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x12, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x14, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x1d, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x1e, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x1f, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x20, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x21, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x22, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x23, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x24, 0x0f),
>> +	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x44, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x45, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x46, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x47, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x48, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x49, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x4a, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x4c, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x4e, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x50, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x51, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x53, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x54, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x55, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x56, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x57, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x58, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x59, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x5a, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x5b, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x5c, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x5d, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x5e, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x60, 0xf0),
>> +	UNCORE_EVENT_CONSTRAINT(0x61, 0xf0),
> 
> Could we define a "UNCORE_EVENT_CONSTRAINT_RANGE()" macro just like what
> core PMU does (refer INTEL_EVENT_CONSTRAINT_RANGE macro)? Then we don't
> need to add so many lines.
> 
> Maybe like this,
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 698bcd7fe5a0..bc4367a6628e 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -437,7 +437,7 @@ uncore_get_event_constraint(struct intel_uncore_box
> *box, struct perf_event *eve
> 
>         if (type->constraints) {
>                 for_each_event_constraint(c, type->constraints) {
> -                       if ((event->hw.config & c->cmask) == c->code)
> +                       if (constraint_match(c, event->hw.config))
>                                 return c;
>                 }
>         }
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 338713cd7a7d..f6fcee2a505e 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -32,7 +32,8 @@
>  #define UNCORE_EXTRA_PCI_DEV           0xff
>  #define UNCORE_EXTRA_PCI_DEV_MAX       4
> 
> -#define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
> +#define UNCORE_EVENT_CONSTRAINT(c, n)          EVENT_CONSTRAINT(c, n, 0xff)
> +#define UNCORE_EVENT_CONSTRAINT_RANGE(c, e, n) EVENT_CONSTRAINT_RANGE(c,
> e, n, 0xff)
> 
>  #define UNCORE_IGNORE_END              -1

Agreed, this is the right way to go.

