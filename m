Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0B15E5C1;
	Thu, 11 Jul 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696461; cv=none; b=HxgAnyk09FbtQ8yN4Qt1G3VnRxH4oXcL1AH7IAFLoHhDZYwXXlpyWA8jysWN3Hnxfdp7aVYvmCwUJCeCh8kzKWkPF2BUjFJLIFp62paDmqRrf6ZvBgl4W5Vck3iYVISixvpcHvQToQJyREeDeAKV55XHgc/5NVPZZXLVUFZDUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696461; c=relaxed/simple;
	bh=g/j92WUZ9piMWN4g3zgDSxu2Gsz1VimMCRArM/ck5e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcnXJfWr1BdGwJimzarAggfFGr84bp4NyxGaZ/qfsmklnVqRS3IVgVJzR2Lwf6Gmy5Qip8eKnFD7VmYcUvlyDzXskA+NgdjRetVpTrp6aprsuhHv+GkdC01Zh7ns2yk+u2zkNi5g5pgxwOSwk7LVesxjnJFFilugZ7YKTUF67Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vn5xnIJR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vn5xnIJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720696460; x=1752232460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g/j92WUZ9piMWN4g3zgDSxu2Gsz1VimMCRArM/ck5e0=;
  b=Vn5xnIJRRLL9rKdsckJD+IFY8bKqC/Y1WgOqeWVTf38lHuj2MJRwM+eR
   AeLD6TpQvFuxnL0yUOV0bKVQL2bGC+0+MpMroaKAveOmrwi08b2YRB3Cg
   Vr4KPOYe9IXEeDx2qnHNRf7fTNXSvYGXsnnkcOk49ZLirpiw3EcpVcQnK
   xM6gVAjca56Y/dXm1//YKS6Leu4xyHL4gJETGK47QaiaZWVWOD87yyxkD
   S56H8j+0poAtLarSEQYaIp4NSzuegS9/Y9F8gSxIF5Oa3SvX4yhzJRQxw
   KQHjQiTZW4xpjqOKx5brHCNA/9EONtTP/DYY8eKHrZKIBuwue99psyDiC
   A==;
X-CSE-ConnectionGUID: aZ0wjzlxSYiyowR87YSIKQ==
X-CSE-MsgGUID: iwOPZLQwTM2BZgDHGaiX8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18175547"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18175547"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:14:19 -0700
X-CSE-ConnectionGUID: OwRhu2uGT6S0MGTgLNOT8w==
X-CSE-MsgGUID: s/DcEcCTR1+9EVqQXY2YYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48407763"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:14:12 -0700
Message-ID: <79fb8618-de7c-4a37-a7ec-d93b6f3d7012@intel.com>
Date: Thu, 11 Jul 2024 14:14:07 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240628065111.59718-1-adrian.hunter@intel.com>
 <20240628065111.59718-2-adrian.hunter@intel.com>
 <20240701105238.GC20127@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240701105238.GC20127@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/07/24 13:52, Peter Zijlstra wrote:
> On Fri, Jun 28, 2024 at 09:51:00AM +0300, Adrian Hunter wrote:
> 
>> +	union {
>> +		__u32	aux_action;
>> +		struct {
>> +			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
>> +				aux_pause        :  1, /* on overflow, pause AUX area tracing */
>> +				aux_resume       :  1, /* on overflow, resume AUX area tracing */
>> +				__reserved_3     : 29;
>> +		};
>> +	};
> 
>> @@ -12860,7 +12930,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
>>  	 * Grouping is not supported for kernel events, neither is 'AUX',
>>  	 * make sure the caller's intentions are adjusted.
>>  	 */
>> -	if (attr->aux_output)
>> +	if (attr->aux_output || attr->aux_action)
>>  		return ERR_PTR(-EINVAL);
>>  
> 
> AFAICT this is the only usage of aux_action. But in a few patches time
> you'll introduce a helper along the lines of has_aux_action() that tests
> all the individual bits.
> 
> Combined with perf_copy_attr() ensuring __reserved_3 is actually 0, I'm
> thinking that should all be enough to render this aux_action field
> surplus to requirement, and we can simplify all this somewhat, no?

It is used in tool's patches and will be used more when additional
fields are added for Intel PT Trigger Tracing.  See the information
in the cover letter about that:

[PATCH V8 00/12] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
https://lore.kernel.org/lkml/20240628065111.59718-1-adrian.hunter@intel.com/

In general, without aux_action there is no way to pass all the
related fields together except by using struct perf_event_attr
itself.

