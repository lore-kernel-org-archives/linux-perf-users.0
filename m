Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C23403E4
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306946; cv=none; b=WI9ZE8to0+4nONzQOUZFazbJpEre6ZfWngBBOjEUm3f/hjJ2Rrm935y0cjXg9s1NTnEYDAN+c74U+3TtrNgNsLG2E/qU1S0cU80ifCJEvbcY/5cIGzzHdd6WQVwYDPEklcvoTWmo0ymGBdJKoQkhCurcTmf52F+VHDhHYKzgY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306946; c=relaxed/simple;
	bh=R5f6OCTfY9/jkZvLviNOkJhnTj5TltiT4CMC981kjYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMbZihLNpfZ1NW0EUwYGjo34H7KqrvIPCmDtBYUslANeZ+q1NtOjGX9cjV53Z3xORKJkil3Xl6+E9ySjLIYQj9q12vlPds4DCspbcX999l14Ny4z6N/K0KOL8qtaAGJQqg5MMLjXuCCYWrkVM3dv/t6svtjjhR+I6Dyre07t3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX93AhUm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX93AhUm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780306944; x=1811842944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R5f6OCTfY9/jkZvLviNOkJhnTj5TltiT4CMC981kjYE=;
  b=QX93AhUmE2nthFKDwqIaX5Ulm0SdHqR7fQ6NJT1o26R9zOL4/cvLCjmx
   yK/SoBIH9a4sSVFI3xWW0w0KFfdMA46vnrFNQOCmNyHaiujtCMik+KZxS
   LcYXJA+Nuvtav/E6JL1WdmthmTwqZCh+9b5o8dQTozucASWukjxE+NzIp
   3GCQdTmsXsn1j6yQGATy86/nPrat5tVWsJGo/sjw0c5vv1IqCSoNvts+Y
   PVLcGt6gK27FQaSnZQp8nrN1RvySFqJCWJIgxcFrx1NCqvlwTiFbOD4Uf
   Q98v9lOlcPgYkCj4VjXRRQqSr7aeBBGZ70un4V+HARTzk9ojnexcOAXEJ
   A==;
X-CSE-ConnectionGUID: ykqDiJ3UTM+120KpkfpWaQ==
X-CSE-MsgGUID: yw4AhBy8QVq+KUxbFRFCdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84920719"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84920719"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:42:24 -0700
X-CSE-ConnectionGUID: gB3Y8YujTGy/sUpdlGeaEw==
X-CSE-MsgGUID: qJE8UUWUS+2+xjN09JGjug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="237191132"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:42:23 -0700
Message-ID: <5c622426-78d3-40f8-a6a2-a14e7858cf24@linux.intel.com>
Date: Mon, 1 Jun 2026 17:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 23/23] perf/x86/intel: Add sanity check for PEBS
 fragment size
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-24-dapeng1.mi@linux.intel.com>
 <20260529095442.966DB1F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529095442.966DB1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 5:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Skipping setup_sample on corrupted PEBS records leaves fields in perf_sample_data uninitialized, causing a kernel stack memory leak when the dummy sample is emitted.
>
> Pre-existing issues:
> - [High] A pre-existing infinite loop vulnerability for corrupted PEBS records with a size of 0 was missed in intel_pmu_drain_pebs_icl().
> - [High] Incomplete validation of corrupted PEBS fragment sizes allows out-of-bounds memory accesses.
> --
>
> commit 68a663ba619b4d0d98aedabd45c1aa50b4acbe81
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Add sanity check for PEBS fragment size
>     
> Prevent potential infinite loops by adding a sanity check for the
> corrupted PEBS fragment sizes which could happen in theory.
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index e0d3076277026..3e100cb206a84 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2675,6 +2675,9 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>>  
>>  again:
>>  	header = at;
>> +	if (!header->size)
>> +		return;
>> +
> [Severity: High]
> This is a pre-existing issue, but does checking only that header->size is
> non-zero leave us vulnerable to out-of-bounds memory accesses?
>
> If a corrupted fragment has a small non-zero size (e.g., 2 bytes) but has
> multiple capability flags set (like header->basic, header->lbr), wouldn't
> setup_arch_pebs_sample_data() blindly increment its next_record pointer
> to parse those structures? Could this allow it to read past the declared
> fragment size and potentially beyond the mapped bounds of the PEBS buffer
> memory page?

The software has no way to detect and report all kinds of corruptions. This
patch only detects and recovers 2 kinds of the most severe corruptions, 0
size which could lead to infinite loop and extreme large size which leads
to the out of boundary memory access.


>
> [ ... ]
>
>> @@ -2956,13 +2959,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
>>  			    struct pt_regs *iregs,
>>  			    struct pt_regs *regs,
>>  			    struct perf_sample_data *data,
>> -			    void *at,
>> -			    int count,
>> +			    void *at, int count, bool corrupted,
>>  			    setup_fn setup_sample)
>>  {
>>  	struct hw_perf_event *hwc = &event->hw;
>>  
>> -	setup_sample(event, iregs, at, data, regs);
>> +	/* Skip parsing corrupted PEBS record. */
>> +	if (corrupted) {
>> +		/* Clear stale register states in previous records. */
>> +		memset(regs, 0, sizeof(*regs));
>> +		x86_pmu_clear_perf_regs(regs);
>> +		perf_sample_data_init(data, 0, event->hw.last_period);
>> +	} else {
>> +		setup_sample(event, iregs, at, data, regs);
>> +	}
>> +
> [Severity: High]
> If setup_sample() is skipped when corrupted is true, perf_sample_data_init()
> will initialize generic fields like period and sample_flags, but what
> about PMU-specific fields such as data->weight, data->data_src, and
> data->txn?
>
> Since the perf_sample_data struct is allocated on the kernel stack and not
> zeroed upon initialization, could this leave those fields containing stale
> kernel stack data? When perf_event_output() or perf_event_overflow() are
> subsequently called, would this result in a kernel stack memory leak to
> userspace?

Yes, this is true. would initialize the perf_sample_data to 0, like this,

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4546b20429ba..f65c7cc6c38c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3798,7 +3798,7 @@ static int x86_pmu_handle_guest_pebs(struct pt_regs
*regs,

 static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
-       struct perf_sample_data data;
+       struct perf_sample_data data = {0};
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
        int bit;
        int handled = 0;

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3e100cb206a8..df8ca5b12e02 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1245,7 +1245,7 @@ int intel_pmu_drain_bts_buffer(void)

 void intel_pmu_drain_pebs_buffer(void)
 {
-       struct perf_sample_data data;
+       struct perf_sample_data data = {0};

        static_call(x86_pmu_drain_pebs)(NULL, &data);
 }


>
> [ ... ]
>
>> @@ -3327,7 +3345,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
>>  	}
>>  
>>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
>> -					    setup_pebs_adaptive_sample_data);
>> +					    false, setup_pebs_adaptive_sample_data);
>>  
>>  	return hweight64(events_bitmap);
>>  }
> [Severity: High]
> This is a pre-existing issue, but does intel_pmu_drain_pebs_icl() have a
> similar infinite loop vulnerability for corrupted records with a size of 0?
>
> Looking at the loop just above this code:
>
>     for (at = base; at < top; at += basic->format_size) {
>         u64 pebs_status;
>
>         basic = at;
>         if (basic->format_size != cpuc->pebs_record_size)
>             continue;
>     }
>
> If a corrupted hardware record has basic->format_size == 0, the loop
> condition evaluates to true, the continue statement executes, and the loop
> attempts to advance at by 0. Wouldn't this result in at remaining
> unchanged, creating an infinite loop in NMI context?

Yes, it's a potential risk, would break the loop if 0 size is detected.

@@ -3334,6 +3334,8 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs
*iregs, struct perf_sample_da
                u64 pebs_status;

                basic = at;
+               if (WARN_ON_ONCE(!basic->format_size))
+                       break;
                if (basic->format_size != cpuc->pebs_record_size)
                        continue;

>
