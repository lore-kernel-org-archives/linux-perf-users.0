Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948100;
	b=TRXfi8IkJMfX7axhI/MbVzFGS1xkmrJe6kkqKKLZwEUkIS4M3X/3QaZNlypQFg4ySJRC
	 A/VxC7E9UHBACitzh/YZo0mvEe1NLEvsjW7q9h/hW4g6hsOTCMdMTam7NnnsN9fRPDHL/
	 OVDH9Ccn3H1NwxC0y0xODkemHJRc7qnWL9aSKHd5oM59tRVmZuURf17l79SCH2rQdUvPW
	 bhertEXMlJuKLcxZgqqdhHNUTZjcSaXYZ7Aye50oTJYwVQgLqJcm5A/s9kZFSjxtirrAl
	 ycKn/asL08RNjazwUV4PtSwR2oMxNIvtWenDBh8YTOF750rdUP1fwz5IHSLhMnOi60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948100;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=89ztf1QspzwbdI0Yl3I1NQo9ZYO+f/B9kHEuTlNonXM=;
	b=qRnCIzmcnjMmhQlzLe83eozji2doofRP+Ira646PHJP9m8IMIYal5xX9jKD3yz7MTk7v
	 8d/gINmvNpR8fUXkLJtyKmfm+N24MHrYcUm5k3lqr//05L/d8A0yoEKzS9KMpUgBco+w+
	 tRXU1vUhPuPevIYYhjwmqS5pmoCmWg5p6FeXZgQ/Y2mj2XgoOMQpc6+X7khl9LxGJcWBT
	 TQ+w+YhZwWEhxdRH419RclruY6M4rUsEjIUDpS4T91rmjFpZEjYgC3gKDa1CDD2nPkn5g
	 valqqtYLJrGn3IWvHf9mStVdYCEA83eJ9HzzzDI6ofw6tmMgnoA1SLdhTlELOVFMklw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="nBUzD/ZA";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64670606A328;
	Fri,  6 Nov 2026 06:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64670606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBUzD/ZA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793948100; x=1825484100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tgiJ8zt44SycNMvoZwwc3qyc73NEoniS0Q6OLUYE/og=;
  b=nBUzD/ZAzmEM4mn4R7YO0p707qbmO8GFQ70TDxXNVCdtPwIqlULsx1fV
   DmXUsmFhdySs7bxjyMgBRv3FgZG8D24bUX2x+AgKfQ9QEn2PFtSGgCVUO
   BwZ5NfcPd1x9RLSwKWBoApcWYR39mMs45zSec3MoYm3FIKpJI0cluBGkU
   /x2cNMqdqSLLfuExQy1i7izw5MmtHRGktLEHylRlNeLJS6oFmqVCl9jh9
   TA9P6Wm/MPyrSkBxTri1HAV6fOC9WdnODzRuaUGcz33Dufk/YTdhzJ2lS
   typmz4k5RgpU9OnEGtvZKGx2yAECoeNwXwMdjzWm74A6cZ+rud8j2nlEg
   g==;
X-CSE-ConnectionGUID: ErCIiWIaSGixS0OQng6Llw==
X-CSE-MsgGUID: bH4YRep9ThCWoONc0vp+IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2845220"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2845220"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 22:54:59 -0800
X-CSE-ConnectionGUID: 15Hp34ScQkinF9rVcQwWZw==
X-CSE-MsgGUID: JAVnKBK+Q02f/K5cpYU6Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7097769"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 22:54:58 -0800
Message-ID: <b564fb2e-4208-4c35-9cd0-a554d3645217@linux.intel.com>
Date: Fri, 6 Nov 2026 14:54:55 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 15/20] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events when needed
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-16-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-200872@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-200872@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/2026 1:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] perf/x86/intel: unrefreshed or clobbered LBR stack on
>   indirect PEBS drain
> --
>
> commit f13e61130af8b47007c91f048b386359760f05ad
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed
>
> This commit tracks whether the shared LBR stack has been refreshed during PMI
> handling with a lbr_refreshed flag and removes the unconditional LBR read at
> PMI entry so the live LBR state is read on demand for non-PEBS LBR events and
> re-read if PEBS draining overwrites it.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index fbde874af6182..b267c68f94676 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -4003,8 +4013,19 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  		 *
>>  		 * The PEBS buffer has to be drained before handling the A-PMI
>>  		 */
>> -		if (is_pebs_counter_event_group(event))
>> +		if (is_pebs_counter_event_group(event)) {
>> +			/*
>> +			 * PEBS counter sampling is only supported on adaptive PEBS
>> +			 * and arch-PEBS, both of which snapshot the LBR stack.
>> +			 * No explicit LBR refresh is needed here.
>> +			 */
>>  			static_call(x86_pmu_drain_pebs)(regs, &data);
>> +			/*
>> +			 * Draining the PEBS buffer can overwrite the shared
>> +			 * LBR stack, so mark lbr_refreshed as false.
>> +			 */
>> +			lbr_refreshed = false;
>> +		}
>>  
>>  		last_period = event->hw.last_period;
>>  
>> @@ -4013,8 +4034,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  
>>  		perf_sample_data_init(&data, 0, last_period);
>>  
>> -		if (has_branch_stack(event))
>> +		if (has_branch_stack(event)) {
>> +			if (!lbr_refreshed) {
>> +				intel_pmu_lbr_read(cpu_lbr_stack(cpuc),
>> +						   cpuc->lbr_counters);
>> +				lbr_refreshed = true;
>> +			}
>>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
>> +		}
>>  
>>  		x86_pmu_clear_perf_regs(regs);
>>  		x86_pmu_update_perf_regs(event, &data, regs, false);
> [Severity: Medium]
> Can perf_event_overflow() still drain the PEBS buffer and clobber
> cpu_lbr_stack(cpuc) when is_pebs_counter_event_group(event) is false?
>
> When a non-PEBS event using PERF_SAMPLE_READ | PERF_FORMAT_GROUP is grouped
> with a PERF_X86_EVENT_AUTO_RELOAD PEBS LBR sibling (without
> PERF_X86_EVENT_PEBS_CNTR set on the leader), perf_event_overflow() ->
> perf_output_sample() -> perf_output_read_group() -> intel_pmu_read_event()
> calls intel_pmu_drain_pebs_buffer() before PERF_SAMPLE_BRANCH_STACK is
> written.  Draining pending PEBS records calls intel_pmu_store_pebs_lbrs(),
> which overwrites cpu_lbr_stack(cpuc) before the current non-PEBS sample
> copies data.br_stack and leaves lbr_refreshed set to true for any subsequent
> non-PEBS LBR events in the same PMI.
>
> In addition, because the unconditional intel_pmu_lbr_read() at PMI entry is
> removed, an indirect PEBS drain on pre-adaptive PEBS
> (!x86_pmu.intel_cap.pebs_baseline) when GLOBAL_STATUS_BUFFER_OVF_BIT is clear
> will run intel_pmu_pebs_fixup_ip() against an unrefreshed
> cpu_lbr_stack(cpuc).

Sigh, Sashiko can always give surprise. :)

It's a real issue. It looks a new version has to be posted to fix this issue.


>
