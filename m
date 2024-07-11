Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF1157A74;
	Thu, 11 Jul 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694568; cv=none; b=FEhDIrUHpPFLrbaYPufmoL1mnMpz2Ov4htUWtHMGrJYKOQe0EZuV2S0VrkoDgaX6swiQh5LbwCOls9M3Iw9/dvHqFG2bP5YwPBdTO9YYpQIdcd48b/5zBBHGIeDRFuudlYz3y0SFZ5bXAcWOMN0Rx7MpKN7eEt3D1S4a9uQTYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694568; c=relaxed/simple;
	bh=t58zTv9k1wCt+G1ma/dgsP26I7BJP4mhNUq6tFhXl7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbWZESWazFzgnwR06cE4wx7GsJQbEl5fD+sXBLNYQomgWkbeC0afCUc8HmVeUI0C4x18H26SO3+3qLbUf2I16k+3x9Y7xdoMAR+/xJ3BLgAwzypU0Qj68vcKVcZKBtUfQvN1rAzh3vc/aZOZVwWVnZDUW+rLGxuikZ/RmkLXPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYCMypzf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYCMypzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720694567; x=1752230567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t58zTv9k1wCt+G1ma/dgsP26I7BJP4mhNUq6tFhXl7E=;
  b=jYCMypzfXwXpZjLne6FR5zT2ktWkoQvBx89DEEeD+krbkR8Fgs4x3geF
   xiLexwDq/sf1UuFDcXJpq8luqGGOnBbB+VmjXgNzMv+7wI44RslLtnNqy
   tdoY7fUsVtV/IKCLYItRTApeBmN7YB9naNwpDg9rWr6q8hE/zmQ0Eevg+
   hAcmw9EGc7WZV6QODr4tsOc5YgJRv3sLKBrhcSy3ieTspNVF/MxDzPPFf
   FJaIObI2+UpvRAff5SYzFKDvuYJ34eyv9x7fdEg4WbyC7QT6jDFhC1fKb
   JZp66SVZWITxfRjPOAdh1liIewXRxJt1Dg+smm9KRg3yrt521Hjeqoh2P
   A==;
X-CSE-ConnectionGUID: OC362ItRQtCluwJCV3WZOA==
X-CSE-MsgGUID: /+K3ZCaZTZCjhsO05BrL4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29469117"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="29469117"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:42:46 -0700
X-CSE-ConnectionGUID: nkTtbMhnQlSTs28b3ePhsw==
X-CSE-MsgGUID: 0osA4EkPSiG+1+4Xlzi4Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="49273414"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:42:40 -0700
Message-ID: <68796741-f49f-447f-b707-fe4f8391fc17@intel.com>
Date: Thu, 11 Jul 2024 13:42:33 +0300
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
 <20240701102644.GA20127@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240701102644.GA20127@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/07/24 13:26, Peter Zijlstra wrote:
> On Fri, Jun 28, 2024 at 09:51:00AM +0300, Adrian Hunter wrote:
> 
>> Add aux_paused to struct perf_event for AUX area events to keep track of
>> the "paused" state. aux_paused is initialized to aux_start_paused.
> 	
>> @@ -798,6 +810,9 @@ struct perf_event {
>>  	/* for aux_output events */
>>  	struct perf_event		*aux_event;
>>  
>> +	/* for AUX area events */
>> +	unsigned int			aux_paused;
>> +
>>  	void (*destroy)(struct perf_event *);
>>  	struct rcu_head			rcu_head;
>>  
> 
> Should this not be part of struct hw_perf_event for whatever hw event
> implements this AUX stuff?
> 
> In fact, I would expect PERF_HES_PAUSED or something to go in
> perf_event::hw::state.

Sorry for the slow reply due to vacation.

There doesn't seem to be anything preventing pause/resume from
"racing" (PMI vs task context) with changes in the aux event state,
so aux_paused must be separate from perf_event::hw::state.

But putting it in perf_event::hw should be fine.
