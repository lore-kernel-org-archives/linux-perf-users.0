Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4FF219ED;
	Wed, 18 Dec 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533528; cv=none; b=qmcu3gOnOB6k7dskPcpsRJ94Hykd8C+qz0ElR3ZRRaL8/cQ9vC/nzXB06v2M4J3DVqjVzCclKrYDBXiEvinBeRqQsuw6ojbkSSrIBnr0QfZEPImH0qY5lO9c/sz/JBPjw58H/UbXAkknqNxcc7sxy9XweXZajkXZb6k5c50OIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533528; c=relaxed/simple;
	bh=PYXl40Sh+4EhJTGFNcucy4K6OHwW+t7wKQgqwfx9634=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3iptVpQrBGJDUI9q4nNyVkskSJPb/f/in/5mQwAaqHZ0MpivgYIujOOwFYkvkwRP7ZNRTepZ3zQaVbvtTAXnkK+deSKM/Y6geDExbXZvkSP4YkxOa2BOHpKTVuEuTwD9F+i2tph6jRkYlugaSJUTCL+5fzW9+35RCJX7bQXphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQV+4uWO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQV+4uWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734533527; x=1766069527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PYXl40Sh+4EhJTGFNcucy4K6OHwW+t7wKQgqwfx9634=;
  b=WQV+4uWOo/JAfVH+4nBK5jiigSdTcEWp2cl8mHJY1jLGBBSXY0/ViGid
   qgbX1OTRy8kpS5Opwm7r1Exi/y/QDMgS/fVKnNOiSOiZGz8cYDqs545U9
   hlClwaffQrP0Pm8FHgjOiZ0dhfumqu/MKDfAyMvgkd/3AphFDSBWtJuqG
   HQqTiFiPdanja0GQsPOJlSVohCzrVt3Cf27GRd3jqk0IiGuwjnNNhbMj0
   rMEqjwo0KDgP3Gw32HrtPpp8rkiQsiqxhvAfzSCRLd349ZE51qpg6UerL
   7J5n+yRrqdGD84yWEdx0hHMZdcCRi5Le0hPxqsjGhSRAJbfuDuT3KgxQR
   A==;
X-CSE-ConnectionGUID: nXmHuIV1Sya3ATDCA1vGuA==
X-CSE-MsgGUID: LdEGliRDTleInzM/n0DsBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35170527"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35170527"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:52:06 -0800
X-CSE-ConnectionGUID: a/dvNZnaQrefqXUDgxh/MQ==
X-CSE-MsgGUID: QhFlHpjeTz+QZXahlkbrIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102887216"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:52:05 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5717920B5713;
	Wed, 18 Dec 2024 06:52:04 -0800 (PST)
Message-ID: <5a4ab06e-8628-4e1d-addb-2af920deffad@linux.intel.com>
Date: Wed, 18 Dec 2024 09:52:03 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
 <20241216204505.748363-4-kan.liang@linux.intel.com>
 <20241217133707.GB2354@noisy.programming.kicks-ass.net>
 <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>
 <20241218082404.GI11133@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241218082404.GI11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-18 3:24 a.m., Peter Zijlstra wrote:
> On Tue, Dec 17, 2024 at 12:45:56PM -0500, Liang, Kan wrote:
>>
>>
>> On 2024-12-17 8:37 a.m., Peter Zijlstra wrote:
>>> On Mon, Dec 16, 2024 at 12:45:05PM -0800, kan.liang@linux.intel.com wrote:
>>>
>>>> @@ -2049,6 +2102,40 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>>>>  		}
>>>>  	}
>>>>  
>>>> +	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
>>>> +		struct pebs_cntr_header *cntr = next_record;
>>>> +		int bit;
>>>> +
>>>> +		next_record += sizeof(struct pebs_cntr_header);
>>>> +
>>>> +		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
>>>> +			x86_perf_event_update(cpuc->events[bit], (u64 *)next_record);
>>>> +			next_record += sizeof(u64);
>>>> +		}
>>>
>>> I still don't much like any of this -- the next_record value might be in
>>> the past relative to what is already in the event.
>>>
>>
>> I forgot to handle the read case. With the below patch, the next_record
>> value should not contain a previous value, unless there is a HW bug.
>> Because no matter it's read/pmi/context switch, perf always stop the
>> PMU, drains the buffer, and the value is always from the PEBS record.
> 
> Consider this 3 counter case:
> 
>  A is our regular counter
>  B is a PEBS event which reads A
>  C is a PEBS event
> 
> For convencience, let A count the lines in our example (anything
> incrementing at a faster rate will get the same result after all).
> 
> Then, afaict, the following can happen:
> 
>   B-assist			A=1
>   C				A=2
>   B-assist			A=3
>   A-overflow-PMI		A=4
>   C-assist-PMI (DS buffer)	A=5
> 
> So the A-PMI will update A->count to 4.
> Then the C-PMI will process the DS buffer, which will:
> 
>   - adjust A->count to 1
>   - adjust A->count to 3

The patch should have addressed the case. I will update the changelog to
point to the case in the next version.

The below is the code to address the issue in this patch.
Perf will drain the PEBS buffer before handling the non-PEBS overflow.

So the A-PMI will
   - Process the DS. adjust A->count to 3
   - adjust A->count to 4
The C-PMI will no touch the A->count since there is no record from B.

@@ -3115,6 +3115,14 @@ static int handle_pmi_common(struct pt_regs
*regs, u64 status)
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;

+		/*
+		 * There may be unprocessed PEBS records in the PEBS buffer,
+		 * which still stores the previous values.
+		 * Process those records first before handling the latest value.
+		 */
+		if (is_pebs_counter_event(event))
+			x86_pmu.drain_pebs(regs, &data);
+
 		if (!intel_pmu_save_and_restart(event))
 			continue;

Thanks,
Kan

> 
> Leaving us, in the end, with A going backwards.
> 
> How is that not a problem?
> 
> IIRC I've raised this point before, and your Changelog does not mention
> anything about this issue at all :-(
> 

