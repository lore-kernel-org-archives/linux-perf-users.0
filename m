Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B802C86D;
	Mon, 10 Nov 2025 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762734247; cv=none; b=sRb7K70dBW/wTZw8yX1zwZBkA5dY3ImgyA98rXZl0bd2Gl69CH7HCZRBd8gJ/o2YgJQqjAeTbZz5Wv4dSI2W2h365+w6VLo5V4WRoyFfqnk5CwD0SoFjVIblShuqcFWvTW7lU/XsbxLCJ6jQ3ihPs0Y67qvRLqrymgDCOkboxTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762734247; c=relaxed/simple;
	bh=KkDnBbXv7Xzquei05MBYy6DLvjm0FU+z4O3Tyv4gLfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwPhkyviMhV5M2iREgkW/Zpe5TowYQ/AKCXAjXZYhAt4foCOvBL9PUjVBh1ZcLzeTj2GBDlgnC62bT/mwP24aLMxcf855a3G9sPI+0RHlk/JSUo2qEzjKR1UBGeOaRfAAcbvHLm/G4eRPvbT3+ONGMD2iD96a/5y8iNm3mwSJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAffnJJF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAffnJJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762734246; x=1794270246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KkDnBbXv7Xzquei05MBYy6DLvjm0FU+z4O3Tyv4gLfk=;
  b=gAffnJJFjRUZQXBCorU38l14WkPBeSluFQ6WABFCj/hHdBUEGUZGKwYQ
   kL8p0V1y0v0kDP/ueYsBmDBPKfq32GEfnxRObYNjylcAQD/XmhU/usaVc
   8qX5cEr4PxqqQCvLZmOfDnroDkY1vnk1hsPe3wBjUYCsC1Wh1I8VD2QxQ
   Wqqn+ortcdTchU9zLX9ToQI8APVEXPPN66ka17fotkKEFFU5h1m/CdEql
   EuhJFS+RinQRDIXZ0+G6tPRisjvpNNYAvs04WFLibCpNM+iKgpdG/S+hG
   TmCCvCY4t1pCQEBfmgD0ZyjXdQZJenKwtkIgNueJK6j73ZJ7AV6Z1qWBW
   g==;
X-CSE-ConnectionGUID: IOSI/SOGRM2ZefWYTuK7pA==
X-CSE-MsgGUID: FpR1VsUlR0asfXa8rGNtXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64487326"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64487326"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 16:24:05 -0800
X-CSE-ConnectionGUID: 55pjYh34QuiITY6QpAG7Vg==
X-CSE-MsgGUID: 1VNSmtqtR5aK7EOpmKsiyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="187838831"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 16:23:57 -0800
Message-ID: <a0416429-23d4-4f4f-af73-bcd87b4e773c@linux.intel.com>
Date: Mon, 10 Nov 2025 08:23:55 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
 <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/7/2025 9:05 PM, Peter Zijlstra wrote:
> On Fri, Nov 07, 2025 at 02:11:09PM +0800, Mi, Dapeng wrote:
>> On 11/6/2025 10:52 PM, Peter Zijlstra wrote:
>>> On Wed, Oct 29, 2025 at 06:21:34PM +0800, Dapeng Mi wrote:
>>>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>>>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>>>> should be dynamically configured base on these counter and precise
>>>> distribution bitmap instead of defining them statically.
>>>>
>>>> Update event dyn_constraint base on PEBS event precise level.
>>> What happened to this:
>>>
>>>   https://lore.kernel.org/all/e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com/
>> About the issue, Kan ever posted a patch to mitigate the risk, but it seems
>> the patch is not merged yet.
>>
>> https://lore.kernel.org/all/20250512175542.2000708-1-kan.liang@linux.intel.com/
> IIUC the below is what is required handle this new dynamic case, right?
>
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5423,6 +5423,8 @@ enum dyn_constr_type {
>  	DYN_CONSTR_BR_CNTR,
>  	DYN_CONSTR_ACR_CNTR,
>  	DYN_CONSTR_ACR_CAUSE,
> +	DYN_CONSTR_PEBS,
> +	DYN_CONSTR_PDIST,
>  
>  	DYN_CONSTR_MAX,
>  };
> @@ -5432,6 +5434,8 @@ static const char * const dyn_constr_typ
>  	[DYN_CONSTR_BR_CNTR] = "a branch counter logging event",
>  	[DYN_CONSTR_ACR_CNTR] = "an auto-counter reload event",
>  	[DYN_CONSTR_ACR_CAUSE] = "an auto-counter reload cause event",
> +	[DYN_CONSTR_PEBS] = "a PEBS event",
> +	[DYN_CONSTR_PDIST] = "a PEBS PDIST event",
>  };
>  
>  static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
> @@ -5536,6 +5540,14 @@ static void intel_pmu_check_dyn_constr(s
>  				continue;
>  			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
>  			break;
> +		case DYN_CONSTR_PEBS:
> +			if (x86_pmu.arch_pebs)
> +				mask = hybrid(pmu, arch_pebs_cap).counters;
> +			break;
> +		case DYN_CONSTR_PDIST:
> +			if (x86_pmu.arch_pebs)
> +				mask = hybrid(pmu, arch_pebs_cap).pdists;
> +			break;
>  		default:
>  			pr_warn("Unsupported dynamic constraint type %d\n", i);
>  		}

Yes, exactly. Thanks.


